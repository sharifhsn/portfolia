const form = document.querySelector("#hornet-form");
const status = document.querySelector("#hornet-status");
const price = document.querySelector("#hornet-value");
const forwardOutput = document.querySelector("#hornet-forward");
const metricOutputs = [...document.querySelectorAll("[data-metric]")];
const numberFormat = new Intl.NumberFormat("en-US", {
  minimumFractionDigits: 2,
  maximumFractionDigits: 2,
});
const currencyFormat = new Intl.NumberFormat("en-US", {
  style: "currency",
  currency: "USD",
  minimumFractionDigits: 2,
  maximumFractionDigits: 2,
});

function setStatus(message, state = "ready") {
  status.textContent = message;
  status.dataset.state = state;
}

function clearResults() {
  price.textContent = "—";
  forwardOutput.textContent = "Forward —";
  for (const output of metricOutputs) output.textContent = "—";
}

async function loadPricingModule() {
  const response = await fetch("/static/js/vendor/hornet/hornet_core.wasm");
  if (!response.ok) throw new Error(`Pricing module returned HTTP ${response.status}.`);
  try {
    return await WebAssembly.instantiateStreaming(response.clone(), {});
  } catch {
    return WebAssembly.instantiate(await response.arrayBuffer(), {});
  }
}

function readInputs() {
  const formData = new FormData(form);
  return {
    kind: Number(formData.get("kind")),
    side: Number(formData.get("side")),
    spot: Number(formData.get("spot")),
    strike: Number(formData.get("strike")),
    maturity: Number(formData.get("maturity")),
    notional: Number(formData.get("notional")),
    usdRate: Number(formData.get("usdRate")) / 100,
    mxnRate: Number(formData.get("mxnRate")) / 100,
    atm: Number(formData.get("atm")) / 100,
    rr: Number(formData.get("rr")) / 100,
    fly: Number(formData.get("fly")) / 100,
  };
}

function displayMetrics(pricing) {
  if (!form.reportValidity()) {
    clearResults();
    setStatus("Check the highlighted fields and their allowed ranges.", "error");
    return;
  }

  const input = readInputs();
  const metric = (id) => pricing(
    id,
    input.kind,
    input.side,
    input.spot,
    input.strike,
    input.maturity,
    input.notional,
    input.usdRate,
    input.mxnRate,
    input.atm,
    input.rr,
    input.fly,
    19.45,
    25.69,
    30.35,
  );
  const modelValue = metric(0);
  const forward = metric(9);
  const risks = metricOutputs.map((output) => [output, metric(Number(output.dataset.metric))]);
  if (![modelValue, forward, ...risks.map(([, value]) => value)].every(Number.isFinite)) {
    clearResults();
    setStatus("This input combination falls outside the model’s valid smile. Adjust volatility or the position.", "error");
    return;
  }

  price.textContent = currencyFormat.format(modelValue);
  forwardOutput.textContent = `Forward ${numberFormat.format(forward)}`;
  for (const [output, value] of risks) output.textContent = numberFormat.format(value);
  setStatus(`Repriced locally · value ${currencyFormat.format(modelValue)}; model estimate, not a live market quote.`);
}

form.addEventListener("submit", (event) => event.preventDefault());
form.addEventListener("input", () => pricingFunction && displayMetrics(pricingFunction));
form.addEventListener("change", () => pricingFunction && displayMetrics(pricingFunction));

let pricingFunction;
loadPricingModule()
  .then(({ instance }) => {
    pricingFunction = instance.exports.hornet_metric;
    if (typeof pricingFunction !== "function") throw new Error("The pricing module is missing its calculation export.");
    displayMetrics(pricingFunction);
  })
  .catch((error) => {
    console.error("Could not load the Hornet pricing module:", error);
    clearResults();
    setStatus("The pricing module could not load. Refresh the page to try again.", "error");
  });
