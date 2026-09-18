# Application structure

Portfolia is a server-rendered Rust portfolio that can also be exported as a
fully static Cloudflare Pages site. The settled reading-first design is the
only active implementation.

## Runtime and static export

- \`src/main.rs\` defines the Axum routes, blog metadata loading, Markdown
  rendering, structured data, and machine-readable discovery endpoints.
- Askama compiles the active templates in \`templates/site.html\`,
  \`templates/blog.html\`, and \`templates/article.html\`.
- \`src/static_export.rs\` renders the same pages into \`dist/\` for Pages.
- \`content/blog/*.md\` is the source of the writing archive; each post carries
  title/date/source/tags metadata and receives a fallback description when its
  front matter does not provide one.
- \`content/projects.toml\` is the structured source for the projects page and
  \`/api/projects.json\`.
- \`content/resume-current.md\` supplies the resume page. The PDF and DOCX
  downloads are served from \`static/resume/\`.

## Canonical routes

The public route tree is intentionally small. HTML page URLs use trailing
slashes because Cloudflare Pages serves directory indexes that way; file-like
machine endpoints retain their extensions without a trailing slash.

- \`GET /\` — profile/home page.
- \`GET /blog/\` — writing index with client-side search and topic filters.
- \`GET /blog/{slug}/\` — an individual article.
- \`GET /projects/\` — selected-projects page.
- \`GET /resume/\` — resume page and downloads.
- \`GET /robots.txt\` — crawler policy and sitemap location.
- \`GET /sitemap.xml\` — canonical page and article URLs.
- \`GET /llms.txt\` — concise, linked site map for AI agents and other text
  clients.
- \`GET /llms-full.txt\` — the complete public writing corpus as Markdown with
  canonical and structured-data links for every article.
- \`GET /feed.xml\` — Atom feed for the writing archive.
- \`GET /feed.json\` — JSON Feed 1.1 representation of the writing archive.
- \`GET /api/posts.json\` — stable JSON index of article metadata.
- \`GET /api/posts/{slug}.json\` — stable JSON document containing one article's
  metadata, Markdown source, and rendered HTML.
- \`GET /api/projects.json\` — structured project summaries and technologies.
- \`GET /api/profile.json\` — public profile and resume discovery metadata.
- \`GET /api/openapi.json\` — OpenAPI 3.1 description of the structured read
  endpoints.
- \`GET /.well-known/agent.json\` — compact public-read-only discovery manifest.
- \`GET /.well-known/security.txt\` — RFC 9116 vulnerability reporting policy.
- \`GET /manifest.webmanifest\` — web application metadata and icon information.
- \`GET /static/*\` — CSS, JavaScript, images, fonts, and downloads.

Former \`/v/*\` and \`/designs\` paths are not rendered implementations. The
runtime and static \`_redirects\` file retain permanent redirects so old links
resolve to the canonical routes.

## Agent-friendly publishing details

Canonical and language URLs, descriptive page titles/descriptions, author
metadata, Open Graph/Twitter fields, a web manifest, and Schema.org JSON-LD
are emitted on the home, section, and article pages. Article JSON-LD identifies
the author, publication date, topics, source attribution, and free
accessibility. Article listings and pages also expose microformats2 properties.
The site provides semantic headings, descriptive navigation, accessible labels,
a skip link, and an image alt description.

\`robots.txt\` permits normal public crawling. \`sitemap.xml\`, \`llms.txt\`,
\`llms-full.txt\`, both feeds, and the JSON article index expose the same
canonical URL tree without requiring JavaScript. Every article also links to
its structured JSON document, and the blog index includes a description for
each entry. The blog index remains usable without its filter script; the
script only improves local searching and topic filtering. The static export
allows cross-origin reads for machine endpoints and feeds.

The static exporter writes a Cloudflare Pages \`_headers\` file with immutable
caching for static fonts, short revalidation windows for other assets and
machine-readable endpoints, and browser hardening headers including CSP, HSTS,
clickjacking protection, a minimal Permissions Policy, and same-origin COOP.

## Local commands

    just build       # compile the server
    just test        # run Rust tests
    just preview     # serve the runtime site on 127.0.0.1:8095
    just static      # rebuild dist/ for static hosting
    just pages-preview

Hosting and DNS history is recorded separately in
[\`context/HOSTING.md\`](HOSTING.md), and the current Pages workflow is described
in [\`context/CLOUDFLARE_PAGES.md\`](CLOUDFLARE_PAGES.md). The standards-backed
metadata and security details are in [\`context/WEB_NICETIES.md\`](WEB_NICETIES.md).
