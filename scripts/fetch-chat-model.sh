#!/usr/bin/env bash
set -euo pipefail

model_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/static/models"
model_name="stentor-30m-instruct-q4_k_m.gguf"
model_path="$model_dir/$model_name"
model_url="https://huggingface.co/mradermacher/Stentor-30M-Instruct-GGUF/resolve/843faf95a645f2775f20247b616011e79069d732/Stentor-30M-Instruct.Q4_K_M.gguf?download=true"
expected_sha256="9dcb3035dab347233f03c3e85d8235adadbfec5d6495acbd19b380002c1a4339"
expected_bytes="20913792"

mkdir -p "$model_dir"

if [[ -f "$model_path" ]]; then
  actual_sha256="$(shasum -a 256 "$model_path" | cut -d ' ' -f 1)"
  if [[ "$actual_sha256" == "$expected_sha256" ]]; then
    echo "Chat model already downloaded and verified."
    exit 0
  fi
fi

temporary_path="$model_path.tmp"
trap 'rm -f "$temporary_path"' EXIT
curl --fail --location --retry 3 --silent --show-error "$model_url" --output "$temporary_path"
actual_bytes="$(wc -c < "$temporary_path" | tr -d '[:space:]')"
actual_sha256="$(shasum -a 256 "$temporary_path" | cut -d ' ' -f 1)"

if [[ "$actual_bytes" != "$expected_bytes" || "$actual_sha256" != "$expected_sha256" ]]; then
  echo "Downloaded chat model did not match the pinned file size and SHA-256." >&2
  exit 1
fi

mv "$temporary_path" "$model_path"
echo "Downloaded and verified the 19.9 MiB chat model."
