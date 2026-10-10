# Portfolia

The canonical public site is [sharifhsn.dev](https://sharifhsn.dev/). It is a
reading-first Rust/Axum/Askama portfolio with a static Cloudflare Pages export.
The current checkout uses a light editorial design, shared page chrome, and
a compact worksheet for the Hornet calculator. See [the design review](context/DESIGN_REVIEW.md)
and [design direction](DESIGN.md) for decisions and verification.

## For people and agents

- [Writing index](https://sharifhsn.dev/blog/) — the complete article archive.
- Experiments — the collection at `/experiments/` contains six selected projects and contributions with substantial development work, short writeups, and visual examples. See [the selection notes](context/EXPERIMENT-SELECTION.md).
- [`llms.txt`](https://sharifhsn.dev/llms.txt) — concise site map and article
  descriptions.
- [`llms-full.txt`](https://sharifhsn.dev/llms-full.txt) — the public writing
  corpus with rendered article content and metadata.
- [`feed.json`](https://sharifhsn.dev/feed.json) and
  [`feed.xml`](https://sharifhsn.dev/feed.xml) — machine-readable feeds.
- [`api/posts.json`](https://sharifhsn.dev/api/posts.json) — stable article
  metadata index; each item links to its own JSON document.
- [`api/projects.json`](https://sharifhsn.dev/api/projects.json) — structured
  project summaries and technologies.
- [`api/profile.json`](https://sharifhsn.dev/api/profile.json) — public profile,
  social links, resume downloads, and discovery URLs.
- [`api/openapi.json`](https://sharifhsn.dev/api/openapi.json) — OpenAPI 3.1
  description of the structured read endpoints.
- [`/.well-known/agent.json`](https://sharifhsn.dev/.well-known/agent.json) —
  explicit read-only agent discovery manifest.
- [`manifest.webmanifest`](https://sharifhsn.dev/manifest.webmanifest) —
  browser-facing site metadata and icon information.
- [`/.well-known/security.txt`](https://sharifhsn.dev/.well-known/security.txt)
  — vulnerability reporting policy; the repository policy is in
  [`SECURITY.md`](SECURITY.md).
- [`sitemap.xml`](https://sharifhsn.dev/sitemap.xml) — canonical URL inventory.

The article archive is authored in Typst and rendered to HTML with MathML. Typst
HTML export is experimental upstream.

The machine-readable contract and source-of-truth rules are in
[`context/AI_AGENTS.md`](context/AI_AGENTS.md). The active architecture is in
[`context/APPLICATION.md`](context/APPLICATION.md), and the deployment record is
in [`context/HOSTING.md`](context/HOSTING.md). The standards-backed web
metadata and security niceties are recorded in
[`context/WEB_NICETIES.md`](context/WEB_NICETIES.md).

## Development

```sh
just build       # compile the Axum server
just test        # run Rust and frontend behavior tests
just prepare-assets  # first setup: chat runtime/model and Hornet WASM
just preview     # serve locally on 127.0.0.1:8095
just static      # export dist/ for Cloudflare Pages
just pages-preview
```

The experiment catalog is `content/experiments.toml`. Rust generates visual
pages for six selected projects and contributions. The runtime and static export share the
same page render functions. [Selection notes](context/EXPERIMENT-SELECTION.md)
record the implementation evidence. The local draft is not a deployment record.

The page templates are `templates/site.html`, `templates/blog.html`, and
`templates/article.html`, with shared chrome/styles and separate page partials.
Ordinary preview/export uses prepared assets; it does not reinstall or download
the browser model each time. Tests require Node 22 or newer and prepared Hornet
WASM (`just hornet-wasm` if only preparing for tests). Builds and local tests
use two Cargo jobs. Blog sources are `content/blog/*.typ`; Typst CLI 0.15.1 is required for preview and static export. GitHub Actions installs the
pinned CLI for deployment. The current resume source is
`content/resume-current.md`. Article loading is Typst-only; retired `/v/*` and
`/designs` routes return 404.
The real Markdown resume remains supported.
