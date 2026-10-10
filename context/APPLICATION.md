# Application structure

Portfolia is a server-rendered Rust portfolio that can also be exported as a
fully static Cloudflare Pages site. The current design direction is documented
in [DESIGN.md](../DESIGN.md);
review findings and validation are in [DESIGN_REVIEW.md](DESIGN_REVIEW.md).

## Runtime and static export

- `src/main.rs` defines the Axum routes, blog metadata loading, Typst article
  rendering and Markdown resume rendering, structured data, and discovery endpoints.
- Askama compiles the active templates in `templates/site.html`,
  `templates/blog.html`, and `templates/article.html`. `chrome.html` and
  `styles.html` share navigation/footer and CSS versioning. Page-specific
  home/projects/resume/Hornet/chat markup lives in named partials.
- `src/static_export.rs` renders the same pages into `dist/` for Pages.
- `content/blog/*.typ` contains the current article archive; each post carries
  title/date/source/tags metadata and receives a fallback description when its
  front matter does not provide one. Article loading is Typst-only; the resume
  still uses Markdown. Word counts and estimated reading time use rendered text.
  Articles use Typst 0.15.1 HTML export and
  sanitized MathML. HTML export is experimental upstream.
- Typst CLI 0.15.1 must be on `PATH` for local preview and static export when
  Typst posts are present. The deployment workflow installs the pinned version.
- `content/projects.toml` is the structured source for the projects page and
  `/api/projects.json`.
- `content/experiments.toml` supplies the experiment catalog. `src/experiments.rs`
  supplies typed records and SVG diagrams. The selected projects use Rust examples,
  recorded native results, and native HTML controls. See [the selection notes](EXPERIMENT-SELECTION.md).
- `content/resume-current.md` supplies the resume page. The PDF and DOCX
  downloads are served from `static/resume/`.

## Canonical routes

The public route tree is intentionally small. HTML page URLs use trailing
slashes because Cloudflare Pages serves directory indexes that way; file-like
machine endpoints retain their extensions without a trailing slash.

- `GET /` — profile/home page.
- `GET /blog/` — writing index with client-side search and topic filters.
- `GET /blog/{slug}/` — an individual article.
- `GET /projects/` — selected-projects page.
- `GET /experiments/` — visual experiment catalog.
- `GET /experiments/{slug}/` — one experiment, its scope, and its next small demo.
- `GET /resume/` — resume page and downloads.
- `GET /projects/hornet/` — compact USD/MXN scenario worksheet.
- `GET /chat/` — browser language-model experiment, reached through Projects.
- `GET /robots.txt` — crawler policy and sitemap location.
- `GET /sitemap.xml` — canonical page and article URLs.
- `GET /llms.txt` — concise, linked site map for AI agents and other text
  clients.
- `GET /llms-full.txt` — the complete public writing corpus as rendered
  HTML/MathML with article metadata.
- `GET /feed.xml` — Atom feed for the writing archive.
- `GET /feed.json` — JSON Feed 1.1 representation of the writing archive.
- `GET /api/posts.json` — stable JSON index of article metadata.
- `GET /api/posts/{slug}.json` — stable JSON document containing one article's
  metadata, its source as `contentTypst`, `contentSourceFormat: "typst"`,
  and sanitized rendered HTML.
- `GET /api/projects.json` — structured project summaries and technologies.
- `GET /api/profile.json` — public profile and resume discovery metadata.
- `GET /api/openapi.json` — OpenAPI 3.1 description of the structured read
  endpoints.
- `GET /.well-known/agent.json` — compact public-read-only discovery manifest.
- `GET /.well-known/security.txt` — RFC 9116 vulnerability reporting policy.
- `GET /manifest.webmanifest` — web application metadata and icon information.
- `GET /static/*` — CSS, JavaScript, images, fonts, and downloads.

Retired `/v/*` and `/designs` paths return 404. The exporter no longer creates
compatibility redirects. Runtime fallback and static `404.html` use shared
site chrome; missing article pages also return the styled 404.

## Agent-friendly publishing details

Canonical and language URLs, descriptive page titles/descriptions, author
metadata, Open Graph/Twitter fields, a web manifest, and Schema.org JSON-LD
are emitted on the home, section, and article pages. Article JSON-LD identifies
the author, publication date, topics, source attribution, and free
accessibility. Article listings and pages also expose microformats2 properties.
The site provides semantic headings, descriptive navigation, accessible labels,
a skip link, and an image alt description.

`robots.txt` permits normal public crawling. `sitemap.xml`, `llms.txt`,
`llms-full.txt`, both feeds, and the JSON article index expose the same
canonical URL tree without requiring JavaScript. Every article also links to
its structured JSON document, and the blog index includes a description for
each entry. The blog index remains usable without its filter script; the
script only improves local searching and topic filtering. The static export
allows cross-origin reads for machine endpoints and feeds.

The static exporter writes a Cloudflare Pages `_headers` file with immutable
caching for static fonts, short revalidation windows for other assets and
machine-readable endpoints, and browser hardening headers including CSP, HSTS,
clickjacking protection, a minimal Permissions Policy, and same-origin COOP.

## Frontend design and review

The home page pairs a compact personal profile with the three newest articles
from the same loaded archive used by the blog and static exporter, plus a link
to the working Hornet FX calculator. Article dates and syndicated sources stay
visible. Use actual writing and working projects to establish the site's identity.

A cool light canvas, blue links, Georgia display headings and serif article
prose form the visual system. System sans supplies interface text, and monospace
is reserved for code. Primary navigation is Writing, Projects, Experiments, Resume. The
browser model is presented as an experiment under Projects. Topic filters use
a native disclosure that starts collapsed at every width, and technical site
resources live in a footer disclosure. The archive remains readable without JavaScript.

Writing defaults to authored essays and commentary. The explicit slug list in
`content/study-notes.toml` classifies course material and older subject notes;
these appear only when the collapsed Study archive option at the end of the
writing list is enabled. Search
and topic counts respect that choice, and homepage recent writing excludes
study notes. Query parameters `q`, `topic`, and `study=1` restore filter state
on reload and browser history navigation. Clearing filters restores authored
writing. Related and older/newer reading links remain in the article's collection. Article URLs, exports, and feeds retain every piece. Without
JavaScript the archive checkbox still works through CSS; search/topics are hidden.

The Hornet calculator uses a light worksheet inside the site shell. Its Arial
type and peach market / green contract / blue risk headings follow the recovered
MiniSystem workbook's `Apr-30` sheet. The local reference is
`/Users/sharif/Code/quant/data/research/fe635-daily-trades/source/latest-export.xlsx`.
Market, volatility smile and anchor-strike fieldsets sit above a compact accounting grid: each editable
contract row carries its MtM and eight risk values, with a summed footer. Add,
remove, reset, and TSV copy operate on session-only scratch trades. A valuation
date and expiry dates derive ACT/365 maturities. Multi-day book persistence is
future scope. Numeric entry uses text fields (no wheel increments), explicit
step buttons, and MiniSystem display caps: spot 3 decimals, strikes/rates/smile
2 decimals, notionals and risk results whole units. Totals sum unrounded values;
negative results use red parentheses. Risk definitions live in hover/focus
column tooltips with viewport-aware placement and Escape dismissal. Narrow screens scroll the table horizontally with identity
columns pinned. These presentation choices do not establish numerical parity
with the original VBA; the existing Rust pricing engine still applies. Its
Gamma tooltip describes the engine's actual 1 bp spot bump rather than the old,
inaccurate 1% label.

Research sources and the implemented recommendations are recorded in
[DESIGN_REVIEW.md](DESIGN_REVIEW.md). They guide judgment; no new frontend
framework, detector or font service is a site dependency.

Review the rendered site at desktop and mobile sizes, then check keyboard focus,
long titles, article math, topic/search combinations, empty-result recovery,
and the static export. Prefer a focused critique and another screenshot over
adding decoration or a new frontend framework.

## Local commands

    just build       # compile the server
    just test        # run Rust and frontend behavior tests
    just prepare-assets  # prepare model/runtime and Hornet WASM once
    just preview     # serve the runtime site on 127.0.0.1:8095
    just static      # rebuild dist/ for static hosting
    just pages-preview

Local Cargo commands use `--locked --jobs 2`; Typst compilation uses one job.
`preview` and `static` use already prepared assets. CI explicitly prepares them
before export. `scripts/frontend.test.mjs` runs the real enhancement scripts
in focused DOM fixtures and uses the prepared WASM pricing module. It verifies
behavior, not browser layout, native input behavior, or full accessibility.

Hosting and DNS history is recorded separately in
[`context/HOSTING.md`](HOSTING.md), and the current Pages workflow is described
in [`context/CLOUDFLARE_PAGES.md`](CLOUDFLARE_PAGES.md). The standards-backed
metadata and security details are in [`context/WEB_NICETIES.md`](WEB_NICETIES.md).
