You are a helpful assistant for coding in the Portfolia repository.

The active application is a Rust/Axum/Askama reading-first portfolio. The
canonical implementation is the root route and the only active branch is
`main`. Read `context/APPLICATION.md` and `context/AI_AGENTS.md` before making
architecture or publishing changes. Hosting and DNS history is in
`context/HOSTING.md`; the current deployment workflow is in
`.github/workflows/deploy-cloudflare-pages.yml`.

The active source of truth is:

- `src/main.rs` and `src/static_export.rs` for runtime/export behavior.
- `templates/site.html`, `templates/blog.html`, and `templates/article.html`
  for the public HTML.
- `content/blog/*.md` for article content and `content/resume-current.md` for
  the current resume.

Use the repository's `Justfile` for common commands. Do not treat the retired
Tailwind templates, old resume, or unrelated historical context notes as active
routes or sources. Verify current code and the live canonical endpoints before
making claims about behavior.
