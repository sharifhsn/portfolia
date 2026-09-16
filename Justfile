build:
    cargo build

test:
    cargo test

preview:
    cargo run

static:
    cargo run --release -- --export-static

pages-preview: static
    npx --yes wrangler@4 pages dev dist --ip 127.0.0.1 --port 8097
