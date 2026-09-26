const MODEL_URL = "/static/models/stentor-30m-instruct-q4_k_m.gguf";
const MODEL_WASM = "/static/js/vendor/wllama/wasm/wllama.wasm";
const COMPAT_WASM = "/static/js/vendor/wllama/compat/wllama.wasm";
const COMPAT_WORKER = "/static/js/vendor/wllama/compat/wllama.js";
const MODEL_BYTES = 20_913_792;

const loadButton = document.querySelector("#chat-load");
const progress = document.querySelector("#chat-progress");
const status = document.querySelector("#chat-status");
const log = document.querySelector("#chat-log");
const emptyState = document.querySelector("#chat-empty");
const form = document.querySelector("#chat-form");
const input = document.querySelector("#chat-input");
const sendButton = document.querySelector("#chat-send");
const stopButton = document.querySelector("#chat-stop");
const clearButton = document.querySelector("#chat-clear");

const systemPrompt = `You are a helpful assistant. Follow these rules:
1) Never provide instructions that facilitate self-harm, suicide, explicit sexual content, or harassment, hate, or bullying.
2) For self-harm intent, respond with empathy, encourage immediate support, and suggest local emergency services. If the user is in the US, mention 988.
3) Assume positive intent unless explicit red flags appear.
4) When refusing, briefly acknowledge the user's underlying need if it can be addressed safely, then redirect.
5) For benign educational requests, answer clearly and avoid over-refusal.`;

let model = null;
let loading = false;
let generating = false;
let controller = null;
let conversation = [];

function setStatus(message) {
  status.textContent = message;
}

function syncControls() {
  input.disabled = !model || generating;
  sendButton.disabled = !model || generating || input.value.trim() === "";
  clearButton.disabled = generating || conversation.length === 0;
  stopButton.hidden = !generating;
  stopButton.disabled = !generating;
}

function scrollToLatest() {
  log.scrollTop = log.scrollHeight;
}

function makeMessage(role, text = "") {
  const row = document.createElement("div");
  row.className = "chat-message";
  row.dataset.role = role;

  const label = document.createElement("span");
  label.className = "chat-message-label";
  label.textContent = role === "user" ? "you" : "stentor";

  const body = document.createElement("p");
  body.className = "chat-message-content";
  body.textContent = text;

  row.append(label, body);
  return { row, body };
}

function appendMessage(role, text) {
  emptyState.hidden = true;
  const message = makeMessage(role, text);
  log.append(message.row);
  scrollToLatest();
  return message;
}

function showEmptyState() {
  log.replaceChildren(emptyState);
  emptyState.hidden = false;
}

async function loadModel() {
  if (loading || model) return;

  loading = true;
  loadButton.disabled = true;
  progress.hidden = false;
  progress.value = 0;
  setStatus("Loading the local chat runtime…");

  try {
    const { Wllama, LoggerWithoutDebug } = await import("/static/js/vendor/wllama/index.js");
    model = new Wllama(
      { default: MODEL_WASM },
      { logger: LoggerWithoutDebug, suppressNativeLog: true },
    );
    model.setCompat({ wasm: COMPAT_WASM, worker: COMPAT_WORKER });

    setStatus("Downloading the model to your browser…");
    await model.loadModelFromUrl(MODEL_URL, {
      n_ctx: 512,
      n_batch: 64,
      jinja: true,
      progressCallback: ({ loaded, total }) => {
        const expectedTotal = total || MODEL_BYTES;
        progress.max = expectedTotal;
        progress.value = Math.min(loaded, expectedTotal);
      },
    });

    progress.hidden = true;
    input.disabled = false;
    loadButton.textContent = "Model ready";
    setStatus("Ready. The model remembers only a few recent messages.");
    syncControls();
    input.focus();
  } catch (error) {
    console.error("Could not load the local chat model", error);
    model = null;
    loadButton.disabled = false;
    loadButton.textContent = "Try loading again · 19.9 MiB";
    progress.hidden = true;
    setStatus("The model did not load. Check your connection and try again.");
  } finally {
    loading = false;
  }
}

async function sendMessage(event) {
  event.preventDefault();
  const text = input.value.trim();
  if (!model || !text || generating) return;

  input.value = "";
  conversation.push({ role: "user", content: text });
  appendMessage("user", text);
  const assistant = appendMessage("assistant", "");
  const activeConversation = conversation.slice(-5);
  const abortController = new AbortController();
  controller = abortController;
  generating = true;
  syncControls();
  setStatus("Thinking…");

  try {
    const stream = await model.createChatCompletion({
      messages: [
        { role: "system", content: systemPrompt },
        ...activeConversation,
      ],
      max_tokens: 64,
      temperature: 1.1,
      top_p: 0.6,
      penalty_repeat: 1.3,
      stream: true,
      abortSignal: abortController.signal,
    });

    let answer = "";
    for await (const chunk of stream) {
      const piece = chunk.choices?.[0]?.delta?.content;
      if (typeof piece === "string" && piece.length > 0) {
        answer += piece;
        assistant.body.textContent = answer;
        scrollToLatest();
      }
    }

    const finalAnswer = answer.trim() || "(No text generated.)";
    assistant.body.textContent = finalAnswer;
    conversation.push({ role: "assistant", content: finalAnswer });
    setStatus("Ready. The model remembers only a few recent messages.");
  } catch (error) {
    if (abortController.signal.aborted) {
      const finalAnswer = assistant.body.textContent.trim() || "(Response stopped.)";
      assistant.body.textContent = finalAnswer;
      conversation.push({ role: "assistant", content: finalAnswer });
      setStatus("Response stopped.");
    } else {
      console.error("The local chat model could not answer", error);
      assistant.body.textContent = "I couldn't finish that reply. Try a shorter message.";
      conversation.push({ role: "assistant", content: assistant.body.textContent });
      setStatus("Generation stopped. Try a shorter message.");
    }
  } finally {
    controller = null;
    generating = false;
    syncControls();
    input.focus();
  }
}

loadButton.addEventListener("click", loadModel);
form.addEventListener("submit", sendMessage);
input.addEventListener("input", syncControls);
input.addEventListener("keydown", (event) => {
  if (event.key === "Enter" && !event.shiftKey) {
    event.preventDefault();
    form.requestSubmit();
  }
});
stopButton.addEventListener("click", () => controller?.abort());
clearButton.addEventListener("click", () => {
  if (generating) return;
  conversation = [];
  showEmptyState();
  setStatus(model ? "Ready. The model remembers only a few recent messages." : "Conversation cleared.");
  syncControls();
});

syncControls();
