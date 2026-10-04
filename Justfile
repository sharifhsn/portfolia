build:
    cargo build --locked --jobs 2

test:
    cargo test --locked --jobs 2 -- --test-threads=2
    node --test scripts/frontend.test.mjs

prepare-assets: chat-assets hornet-wasm

hornet-wasm:
    ./scripts/build-hornet-wasm.sh

chat-assets:
    npm ci
    npm run build:chat-runtime
    ./scripts/fetch-chat-model.sh

preview:
    cargo run --locked --jobs 2

static:
    cargo run --locked --jobs 2 -- --export-static

pages-preview: static
    npx --yes wrangler@4 pages dev dist --ip 127.0.0.1 --port 8097
