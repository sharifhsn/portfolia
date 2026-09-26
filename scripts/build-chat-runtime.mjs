import { copyFile, mkdir, rm } from "node:fs/promises";
import { fileURLToPath } from "node:url";
import path from "node:path";

const root = fileURLToPath(new URL("..", import.meta.url));
const mainPackage = path.join(root, "node_modules/@wllama/wllama");
const compatPackage = path.join(root, "node_modules/@wllama/wllama-compat");
const output = path.join(root, "static/js/vendor/wllama");

await rm(output, { recursive: true, force: true });
await mkdir(path.join(output, "wasm"), { recursive: true });
await mkdir(path.join(output, "compat"), { recursive: true });

await Promise.all([
  copyFile(path.join(mainPackage, "esm/index.js"), path.join(output, "index.js")),
  copyFile(path.join(mainPackage, "esm/wasm/wllama.wasm"), path.join(output, "wasm/wllama.wasm")),
  copyFile(path.join(mainPackage, "LICENCE"), path.join(output, "LICENSE.txt")),
  copyFile(path.join(compatPackage, "wasm/wllama.js"), path.join(output, "compat/wllama.js")),
  copyFile(path.join(compatPackage, "wasm/wllama.wasm"), path.join(output, "compat/wllama.wasm")),
]);

console.log("Prepared the self-hosted wllama browser runtime.");
