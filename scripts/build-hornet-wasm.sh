#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
export CARGO_TARGET_DIR="$repo_root/target"

cargo build \
  --manifest-path "$repo_root/wasm/hornet/Cargo.toml" \
  --target wasm32-unknown-unknown \
  --release \
  --locked

output_dir="$repo_root/static/js/vendor/hornet"
mkdir -p "$output_dir"
cp "$CARGO_TARGET_DIR/wasm32-unknown-unknown/release/hornet_wasm.wasm" \
  "$output_dir/hornet_core.wasm"
