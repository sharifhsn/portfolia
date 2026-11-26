#!/usr/bin/env node
// Check the published responsive screenshots in a real Firefox process.
// Usage: node scripts/verify-rowla-responsive.mjs [site-origin]
// Requires Node with WebSocket support, Firefox, and the deployed static site.
import { createHash } from "node:crypto";
import { spawn } from "node:child_process";
import { mkdtemp, rm } from "node:fs/promises";
import { tmpdir } from "node:os";
import { join } from "node:path";

const origin = new URL(process.argv[2] || "https://sharifhsn.dev").origin;
const page = origin + "/experiments/rowla/";
const names = ["taskbar", "sort", "tabs", "stable-tile"];
const files = ["/experiments/rowla/", ...names.flatMap(name => [
  `/static/experiments/rowla/${name}.png`,
  `/static/experiments/rowla/${name}-640.png`,
  `/static/experiments/rowla/${name}.webp`,
  `/static/experiments/rowla/${name}-640.webp`,
])];
async function hashes() {
  const result = {};
  const deadline = AbortSignal.timeout(20000);
  for (const file of files) {
    const response = await fetch(origin + file, { signal: deadline });
    if (!response.ok) throw new Error(`${file}: HTTP ${response.status}`);
    result[file] = createHash("sha256").update(Buffer.from(await response.arrayBuffer())).digest("hex");
  }
  return result;
}

const initialHashes = await hashes();
const profile = await mkdtemp(join(tmpdir(), "rowla-firefox-"));
let firefox, socket;
const sleep = ms => new Promise(resolve => setTimeout(resolve, ms));
const timeout = setTimeout(() => {
  console.error("Timed out");
  process.exitCode = 1;
  socket?.close();
  firefox?.kill("SIGTERM");
}, 45000);

try {
  firefox = spawn(process.env.FIREFOX || "firefox", [
    "--headless", "--no-remote", "--profile", profile,
    "--remote-debugging-port", "0", "about:blank",
  ], { stdio: ["ignore", "pipe", "pipe"] });
  const endpoint = await new Promise((resolve, reject) => {
    let output = "";
    const timer = setTimeout(() => reject(new Error("Firefox startup timed out")), 10000);
    const receive = data => {
      output += data;
      const match = output.match(/WebDriver BiDi listening on (ws:\/\/127\.0\.0\.1:\d+)/);
      if (match) {
        clearTimeout(timer);
        resolve(match[1] + "/session");
      }
    };
    firefox.stdout.on("data", receive);
    firefox.stderr.on("data", receive);
    firefox.once("exit", () => reject(new Error("Firefox exited during startup")));
  });
  socket = new WebSocket(endpoint);
  await new Promise((resolve, reject) => { socket.onopen = resolve; socket.onerror = reject; });
  let nextId = 0;
  const pending = new Map();
  socket.onmessage = event => {
    const message = JSON.parse(event.data);
    if (!message.id || !pending.has(message.id)) return;
    const [resolve, reject] = pending.get(message.id);
    pending.delete(message.id);
    if (message.type === "error") reject(new Error(message.message));
    else resolve(message.result);
  };
  const call = (method, params) => new Promise((resolve, reject) => {
    const id = ++nextId;
    pending.set(id, [resolve, reject]);
    socket.send(JSON.stringify({ id, method, params }));
  });
  await call("session.new", { capabilities: { alwaysMatch: {} } });

  const checks = [];
  for (const [width, height, dpr] of [
    [1440, 900, 1], [1440, 900, 2], [1440, 900, 3],
    [390, 844, 1], [390, 844, 2], [390, 844, 3],
  ]) {
    const { context } = await call("browsingContext.create", { type: "tab" });
    await call("browsingContext.setViewport", { context, viewport: { width, height }, devicePixelRatio: dpr });
    await call("browsingContext.navigate", { context, url: page, wait: "complete" });
    const response = await call("script.evaluate", {
      target: { context },
      awaitPromise: true,
      expression: `(async () => {
        const images = [...document.querySelectorAll('img[src*="/rowla/"]')];
        const buttons = [...document.querySelectorAll('input[name="example"]')];
        const selected = [];
        for (let i = 0; i < images.length; i++) {
          buttons[i].click();
          images[i].scrollIntoView();
          await new Promise(r => requestAnimationFrame(() => requestAnimationFrame(r)));
          await images[i].decode();
          const webp = new URL(images[i].currentSrc).pathname;
          const source = images[i].parentElement.querySelector('source[type="image/webp"]');
          if (!source) throw new Error("Missing WebP source");
          source.type = "image/unsupported";
          for (let tries = 0; tries < 100 && !new URL(images[i].currentSrc).pathname.endsWith(".png"); tries++) {
            await new Promise(r => setTimeout(r, 20));
          }
          await images[i].decode();
          const fallback = new URL(images[i].currentSrc).pathname;
          selected.push({ path: webp, fallback, alt: images[i].alt });
        }
        return JSON.stringify({ width: innerWidth, dpr: devicePixelRatio, overflow: document.documentElement.scrollWidth > innerWidth, selected });
      })()`,
    });
    if (response.type !== "success") throw new Error(JSON.stringify(response));
    const result = JSON.parse(response.result.value);
    const small = width === 390 && dpr <= 2;
    if (result.width !== width || result.dpr !== dpr || result.overflow || result.selected.length !== 4) throw new Error(JSON.stringify(result));
    for (let i = 0; i < names.length; i++) {
      const base = `/static/experiments/rowla/${names[i]}${small ? "-640" : ""}`;
      const expected = base + ".webp";
      const fallback = base + ".png";
      if (result.selected[i].path !== expected || result.selected[i].fallback !== fallback || !result.selected[i].alt) throw new Error(JSON.stringify(result));
    }
    checks.push(result);
    await call("browsingContext.close", { context });
  }
  if (JSON.stringify(await hashes()) !== JSON.stringify(initialHashes)) throw new Error("Site assets changed during check");
  console.log(JSON.stringify({ status: "PASS", origin, checks, hashes: initialHashes }));
} finally {
  clearTimeout(timeout);
  socket?.close();
  firefox?.kill("SIGTERM");
  if (firefox && firefox.exitCode === null) await Promise.race([new Promise(resolve => firefox.once("exit", resolve)), sleep(1500)]);
  await rm(profile, { recursive: true, force: true });
}
