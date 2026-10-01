const form = document.querySelector("#hornet-form");
const status = document.querySelector("#hornet-status");
const trades = document.querySelector("#hornet-trades");
const totals = [...document.querySelectorAll("[data-total]")];
const copyButton = document.querySelector("#hornet-copy");
const valuationDate = form.elements.valuationDate;
const dayMs = 86400000;
const wholeNumber = new Intl.NumberFormat("en-US", { maximumFractionDigits: 0 });
const specs = {
  spot: { decimals: 3, step: 0.01, min: 0.001, max: 1000, label: "Spot" },
  usdRate: { decimals: 2, step: 0.01, min: -20, max: 100, label: "USD rate" },
  mxnRate: { decimals: 2, step: 0.01, min: -20, max: 100, label: "MXN rate" },
  atm: { decimals: 2, step: 0.1, min: 0.01, max: 300, label: "ATM volatility" },
  rr: { decimals: 2, step: 0.1, min: -200, max: 200, label: "Risk reversal" },
  fly: { decimals: 2, step: 0.1, min: -200, max: 200, label: "Butterfly" },
  lowStrike: { decimals: 2, step: 0.01, min: 0.01, max: 1000, label: "Low strike" },
  atmStrike: { decimals: 2, step: 0.01, min: 0.01, max: 1000, label: "ATM strike" },
  highStrike: { decimals: 2, step: 0.01, min: 0.01, max: 1000, label: "High strike" },
  notional: { decimals: 0, step: 1000000, min: 1, max: 1000000000000, label: "Notional" },
  strike: { decimals: 2, step: 0.01, min: 0.01, max: 1000, label: "Strike" },
};
let pricingFunction;
let nextTradeId = 1;
let calculatedRows = [];
const today = new Intl.DateTimeFormat("en-CA", { timeZone: "America/New_York", year: "numeric", month: "2-digit", day: "2-digit" }).format(new Date());
valuationDate.value = today;
valuationDate.defaultValue = today;

function dateDays(value) {
  const result = Date.parse(`${value}T00:00:00Z`) / dayMs;
  return Number.isFinite(result) ? result : NaN;
}

function defaultExpiry() {
  return new Date((dateDays(valuationDate.value || today) + 1825) * dayMs).toISOString().slice(0, 10);
}

function setStatus(message = "", state = "ready") {
  status.textContent = message;
  status.dataset.state = state;
}

function readNumber(input) {
  const text = input.value.trim().replaceAll(",", "");
  return /^-?(?:\d+(?:\.\d*)?|\.\d+)$/.test(text) ? Number(text) : NaN;
}

function normalize(input, commit = false) {
  const spec = specs[input.dataset.number];
  const text = input.value;
  const decimal = text.indexOf(".");
  // Cap precision even while typing/pasting; preserve incomplete entry until blur.
  if (decimal >= 0 && text.length - decimal - 1 > spec.decimals) {
    input.value = spec.decimals ? text.slice(0, decimal + spec.decimals + 1) : text.slice(0, decimal);
  }
  const value = readNumber(input);
  if (commit && Number.isFinite(value)) input.value = spec.decimals === 0 ? wholeNumber.format(value) : value.toFixed(spec.decimals);
  const valid = Number.isFinite(value) && value >= spec.min && value <= spec.max;
  input.setCustomValidity(valid ? "" : `Enter ${spec.label.toLowerCase()} from ${spec.min} to ${spec.max}.`);
  input.setAttribute("aria-invalid", String(!valid));
  return valid;
}

function wireNumber(input, rowLabel = "") {
  const spec = specs[input.dataset.number];
  const step = spec.step === 1000000 ? "1m" : String(spec.step);
  const controls = document.createElement("span");
  controls.className = "hornet-stepper";
  for (const [symbol, direction] of [["+", 1], ["−", -1]]) {
    const button = document.createElement("button");
    button.type = "button";
    button.textContent = symbol;
    button.title = `${direction > 0 ? "Increase" : "Decrease"} by ${step}`;
    button.setAttribute("aria-label", `${direction > 0 ? "Increase" : "Decrease"} ${rowLabel}${spec.label} by ${step}`);
    button.addEventListener("click", () => {
      const current = readNumber(input);
      if (!Number.isFinite(current)) { input.focus(); return; }
      input.value = Math.min(spec.max, Math.max(spec.min, current + direction * spec.step)).toFixed(spec.decimals);
      normalize(input, true);
      reprice();
    });
    controls.append(button);
  }
  const hint = document.createElement("span");
  hint.className = "hornet-step-size";
  hint.textContent = `±${step}`;
  input.parentElement.append(controls, hint);
  normalize(input, true);
}

function addTrade(values = {}) {
  const id = nextTradeId++;
  const row = document.createElement("tr");
  row.dataset.trade = id;
  row.innerHTML = `<th scope="row">${id}</th>
    <td><select name="kind" aria-label="Trade ${id} instrument"><option value="0">USD call</option><option value="1">USD put</option><option value="2">Forward</option></select></td>
    <td><select name="side" aria-label="Trade ${id} side"><option value="1">Long</option><option value="-1">Short</option></select></td>
    <td><div class="hornet-number"><input name="notional" data-number="notional" type="text" inputmode="numeric" value="1000000" required aria-label="Trade ${id} notional" autocomplete="off"></div></td>
    <td><div class="hornet-number"><input name="strike" data-number="strike" type="text" inputmode="decimal" value="25.69" required aria-label="Trade ${id} strike" autocomplete="off"></div></td>
    <td><input class="hornet-expiry" name="expiry" type="date" required aria-label="Trade ${id} expiry"></td>
    ${Array.from({length: 9}, (_, metric) => `<td><output aria-live="off" data-metric="${metric}">—</output></td>`).join("")}
    <td><button class="hornet-remove" type="button" aria-label="Remove trade ${id}">×</button></td>`;
  row.querySelector('[name="expiry"]').value = defaultExpiry();
  for (const [key, value] of Object.entries(values)) row.querySelector(`[name="${key}"]`).value = value;
  for (const input of row.querySelectorAll("[data-number]")) wireNumber(input, `Trade ${id} `);
  trades.append(row);
  reprice();
  return row;
}

function writeOutput(output, value) {
  output.textContent = Number.isFinite(value) ? (value <= -0.5 ? `(${wholeNumber.format(-value)})` : wholeNumber.format(Math.abs(value) < 0.5 ? 0 : value)) : "—";
  output.dataset.negative = String(value <= -0.5);
}

function clearResults() {
  for (const output of form.querySelectorAll("output")) writeOutput(output, NaN);
  document.querySelector("[data-total-notional]").textContent = "—";
  copyButton.disabled = true;
  calculatedRows = [];
}

function reprice() {
  copyButton.textContent = "Copy table";
  if (!pricingFunction) return;
  for (const input of form.querySelectorAll("[data-number]")) normalize(input);
  if (!form.checkValidity()) {
    clearResults();
    setStatus("Check the marked input cells and dates.", "error");
    return;
  }
  const market = Object.fromEntries([...form.querySelectorAll(".hornet-market [data-number]")].map(input => [input.name, readNumber(input)]));
  const rows = [];
  for (const row of trades.children) {
    const field = name => row.querySelector(`[name="${name}"]`).value;
    const maturity = (dateDays(field("expiry")) - dateDays(valuationDate.value)) / 365;
    if (!Number.isFinite(maturity) || maturity < 0 || maturity > 50) {
      row.querySelector('[name="expiry"]').setAttribute("aria-invalid", "true");
      clearResults();
      setStatus(`Trade ${row.dataset.trade}: expiry must be on or after valuation date, within 50 years.`, "error");
      return;
    }
    row.querySelector('[name="expiry"]').setAttribute("aria-invalid", "false");
    const inputs = [Number(field("kind")), Number(field("side")), market.spot, readNumber(row.querySelector('[name="strike"]')), maturity, readNumber(row.querySelector('[name="notional"]')), market.usdRate / 100, market.mxnRate / 100, market.atm / 100, market.rr / 100, market.fly / 100, market.lowStrike, market.atmStrike, market.highStrike];
    const metrics = Array.from({length: 9}, (_, id) => pricingFunction(id, ...inputs));
    if (!metrics.every(Number.isFinite)) {
      clearResults();
      setStatus(`Trade ${row.dataset.trade}: this scenario falls outside the model’s valid smile. Check volatility and anchor strikes.`, "error");
      return;
    }
    rows.push({row, metrics, notional: inputs[1] * inputs[5]});
  }
  for (const {row, metrics} of rows) {
    for (const output of row.querySelectorAll("[data-metric]")) writeOutput(output, metrics[Number(output.dataset.metric)]);
  }
  for (const output of totals) writeOutput(output, rows.reduce((sum, row) => sum + row.metrics[Number(output.dataset.total)], 0));
  document.querySelector("[data-total-notional]").textContent = wholeNumber.format(rows.reduce((sum, row) => sum + row.notional, 0));
  calculatedRows = rows;
  copyButton.disabled = rows.length === 0;
  setStatus();
}

async function loadPricingModule() {
  const response = await fetch("/static/js/vendor/hornet/hornet_core.wasm");
  if (!response.ok) throw new Error(`Pricing module returned HTTP ${response.status}.`);
  try { return await WebAssembly.instantiateStreaming(response.clone(), {}); }
  catch { return WebAssembly.instantiate(await response.arrayBuffer(), {}); }
}

for (const button of form.querySelectorAll(".hornet-help")) {
  const place = () => {
    delete button.dataset.dismissed;
    const rect = button.getBoundingClientRect();
    const tip = button.querySelector('[role="tooltip"]');
    tip.style.left = `${Math.max(8, Math.min(rect.right - 200, window.innerWidth - 210))}px`;
    tip.style.top = `${rect.bottom + 8}px`;
  };
  button.addEventListener("mouseenter", place);
  button.addEventListener("focus", place);
  button.addEventListener("keydown", event => {
    if (event.key === "Escape") button.dataset.dismissed = "true";
  });
}
for (const input of form.querySelectorAll(".hornet-market [data-number]")) wireNumber(input);
form.addEventListener("submit", event => event.preventDefault());
form.addEventListener("input", event => {
  if (event.target.matches("[data-number]")) normalize(event.target);
  reprice();
});
form.addEventListener("change", event => {
  if (event.target.matches("[data-number]")) normalize(event.target, true);
  reprice();
});
form.addEventListener("focusout", event => {
  if (event.target.matches("[data-number]")) { normalize(event.target, true); reprice(); }
});
form.addEventListener("click", event => {
  const remove = event.target.closest(".hornet-remove");
  if (remove) {
    const row = remove.closest("tr");
    const next = row.nextElementSibling || row.previousElementSibling;
    row.remove();
    reprice();
    (next?.querySelector("select") || document.querySelector("#hornet-add")).focus();
  }
});
form.addEventListener("reset", () => requestAnimationFrame(() => {
  trades.replaceChildren();
  nextTradeId = 1;
  for (const input of form.querySelectorAll(".hornet-market [data-number]")) normalize(input, true);
  addTrade();
}));
document.querySelector("#hornet-add").addEventListener("click", () => {
  const row = addTrade();
  row.querySelector("select").focus();
});
copyButton.addEventListener("click", async () => {
  const headings = ["Trade", "Instrument", "Side", "Notional USD", "Strike MXN/USD", "Expiry", "MtM USD", "Delta USD", "Gamma USD", "ATM vega USD", "Rega USD", "Fly vega USD", "USD rho USD", "MXN rho USD", "Carry USD"];
  const lines = calculatedRows.map(({row, metrics}) => [row.dataset.trade, row.querySelector('[name="kind"]').selectedOptions[0].text, row.querySelector('[name="side"]').selectedOptions[0].text, ...["notional", "strike", "expiry"].map(name => row.querySelector(`[name="${name}"]`).value.replaceAll(",", "")), ...metrics.map(value => (Math.abs(value) < 0.5 ? "0" : value.toFixed(0)))]);
  lines.push(["Total", "", "", calculatedRows.reduce((sum, row) => sum + row.notional, 0), "", "", ...totals.map(output => calculatedRows.reduce((sum, row) => sum + row.metrics[Number(output.dataset.total)], 0)).map(value => Math.abs(value) < 0.5 ? "0" : value.toFixed(0))]);
  try { await navigator.clipboard.writeText([headings, ...lines].map(line => line.join("\t")).join("\n")); copyButton.textContent = "Copied"; }
  catch { setStatus("Could not copy the table. Select the cells to copy them manually.", "error"); }
});
addTrade();
loadPricingModule().then(({instance}) => {
  pricingFunction = instance.exports.hornet_metric;
  if (typeof pricingFunction !== "function") throw new Error("The pricing module is missing its calculation export.");
  reprice();
}).catch(error => {
  console.error("Could not load the Hornet pricing module:", error);
  clearResults();
  setStatus("The pricing module could not load. Refresh the page to try again.", "error");
});
