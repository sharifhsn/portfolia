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
- \`content/resume-current.md\` supplies the resume page. The PDF and DOCX
  downloads are served from \`static/resume/\`.

## Canonical routes

The public route tree is intentionally small:

- \`GET /\` — profile/home page.
- \`GET /blog\` — writing index with client-side search and topic filters.
- \`GET /blog/{slug}\` — an individual article.
- \`GET /projects\` — selected-projects page.
- \`GET /resume\` — resume page and downloads.
- \`GET /robots.txt\` — crawler policy and sitemap location.
- \`GET /sitemap.xml\` — canonical page and article URLs.
- \`GET /llms.txt\` — concise, linked site map for AI agents and other text
  clients.
- \`GET /feed.xml\` — Atom feed for the writing archive.
- \`GET /static/*\` — CSS, JavaScript, images, fonts, and downloads.

Former \`/v/*\` and \`/designs\` paths are not rendered implementations. The
runtime and static \`_redirects\` file retain permanent redirects so old links
resolve to the canonical routes.

## Agent-friendly publishing details

Canonical URLs, descriptive page titles/descriptions, author metadata,
Open Graph fields, and Schema.org JSON-LD are emitted on the home, section,
and article pages. Article JSON-LD identifies the author, publication date,
topics, source attribution, and free accessibility. The site also provides
semantic headings, descriptive navigation, accessible labels, a skip link,
and an image alt description.

\`robots.txt\` permits normal public crawling. \`sitemap.xml\`, \`llms.txt\`, and
the Atom feed expose the same canonical URL tree without requiring JavaScript.
The blog index remains usable without its filter script; the script only
improves local searching and topic filtering.

## Local commands

    just build       # compile the server
    just test        # run Rust tests
    just preview     # serve the runtime site on 127.0.0.1:8095
    just static      # rebuild dist/ for static hosting
    just pages-preview

Hosting and DNS history is recorded separately in
[\`context/HOSTING.md\`](HOSTING.md), and the current Pages workflow is described
in [\`context/CLOUDFLARE_PAGES.md\`](CLOUDFLARE_PAGES.md).
