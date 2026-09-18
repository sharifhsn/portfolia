# Portfolia

The canonical public site is [sharifhsn.dev](https://sharifhsn.dev/). It is a
reading-first Rust/Axum/Askama portfolio with a static Cloudflare Pages export.
`main` is the only active branch and the root route is the settled design.

## For people and agents

- [Writing index](https://sharifhsn.dev/blog/) — the complete article archive.
- [`llms.txt`](https://sharifhsn.dev/llms.txt) — concise site map and article
  descriptions.
- [`llms-full.txt`](https://sharifhsn.dev/llms-full.txt) — the public writing
  corpus in Markdown.
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
- [`sitemap.xml`](https://sharifhsn.dev/sitemap.xml) — canonical URL inventory.

The machine-readable contract and source-of-truth rules are in
[`context/AI_AGENTS.md`](context/AI_AGENTS.md). The active architecture is in
[`context/APPLICATION.md`](context/APPLICATION.md), and the deployment record is
in [`context/HOSTING.md`](context/HOSTING.md).

## Development

```sh
just build       # compile the Axum server
just test        # run Rust tests
just preview     # serve locally on 127.0.0.1:8095
just static      # export dist/ for Cloudflare Pages
just pages-preview
```

The active page templates are `templates/site.html`, `templates/blog.html`,
and `templates/article.html`. Blog source is `content/blog/*.md`; the current
resume source is `content/resume-current.md`. Do not use the retired templates
or historical context files as runtime sources.
