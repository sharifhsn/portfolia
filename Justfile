build:
    cargo build

test:
    cargo test

chat-assets:
    npm ci
    npm run build:chat-runtime
    ./scripts/fetch-chat-model.sh

preview: chat-assets
    cargo run

static: chat-assets
    cargo run --release -- --export-static

pages-preview: static
    npx --yes wrangler@4 pages dev dist --ip 127.0.0.1 --port 8097
