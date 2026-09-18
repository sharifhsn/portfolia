# AI-agent access contract

Portfolia is public, static-first, and intentionally readable without
JavaScript. Agents should start at the canonical origin
`https://sharifhsn.dev/`, use trailing-slash URLs for HTML pages, and treat
`/v/*` and `/designs` as compatibility redirects only.

The site is public-read-only: no endpoint accepts mutations or requires
authentication. `/.well-known/agent.json` is the compact discovery manifest;
`/api/openapi.json` describes the structured endpoint shapes.

## Discovery order

1. `GET /.well-known/agent.json` for the read-only discovery manifest. It
   identifies the canonical host, supported representations, and citation
   guidance without granting any mutation capability.
2. `GET /api/openapi.json` for the endpoint and schema description.
3. `GET /llms.txt` for a concise linked map of the site and all articles.
4. `GET /api/posts.json` for the stable article index.
5. `GET /api/posts/{slug}.json` for one article's metadata and full content.
6. `GET /api/projects.json` for the structured project summaries.
7. `GET /api/profile.json` for the public profile, canonical image, source
   repository, social links, resume downloads, and discovery URLs.
8. `GET /llms-full.txt` when a plain-Markdown corpus is more useful than JSON.
9. `GET /sitemap.xml`, `/feed.xml`, or `/feed.json` when a crawler/feed
   consumer needs the canonical URL inventory.
10. `GET /manifest.webmanifest` for browser-facing application metadata, or
    `GET /.well-known/security.txt` for the vulnerability reporting policy.

All of these endpoints are generated from the same `content/blog/*.md` source
files, so their article counts and canonical URLs should agree.

## JSON contract

`/api/posts.json` returns:

```json
{
  "version": "1",
  "site": "https://sharifhsn.dev",
  "indexUrl": "https://sharifhsn.dev/api/posts.json",
  "count": 153,
  "items": [{
    "slug": "circuits",
    "url": "https://sharifhsn.dev/blog/circuits/",
    "dataUrl": "https://sharifhsn.dev/api/posts/circuits.json",
    "title": "Circuits",
    "description": "…",
    "date": "2022-02-01",
    "datePublished": "2022-02-01",
    "tags": ["Physics"],
    "categories": ["Physics"],
    "source": "Archive",
    "sourceUrl": null,
    "wordCount": 1600
  }]
}
```

The per-article URL returns the same item fields plus `contentMarkdown` and
`contentHtml`, with `version` and `site` at the top level. `url` is the human
canonical page; `dataUrl` is its machine-readable companion. Consumers should
not infer a different page URL from the data endpoint.

`date` is the public calendar date used for display and ordering. `datePublished`
uses an exact public publication timestamp when the source provides one and
otherwise equals `date`. `dateModified`/`updatedAt` are omitted unless an
explicit update timestamp exists. Source names and public source links are
published; private collection notes and personal-calendar evidence are not.

## HTML and feed signals

HTML pages emit canonical and language links, author and sitemap links, Atom
and JSON Feed alternate links, Open Graph/Twitter metadata, a web manifest,
descriptive metadata, Schema.org JSON-LD, microformats2 article properties,
semantic headings, accessible navigation, article summaries, and
previous/next article links. The blog filter is progressive enhancement; every
article link and summary is present in the initial HTML.

The Atom and JSON feeds include the same canonical article URLs, dates, authors,
topics, summaries, and public source links. `llms-full.txt` contains the same
articles as Markdown with title, URL, date, topics, source, and source-link
metadata. `/projects/` is populated from `content/projects.toml`, and its JSON
endpoint and `CreativeWork`/`ItemList` JSON-LD use the same source. Machine
endpoints and feeds advertise `Access-Control-Allow-Origin: *` in the static
Cloudflare export for cross-origin read access. The export also sends a strict
but same-origin-compatible CSP, HSTS, clickjacking protection, and a minimal
Permissions Policy; the math renderer is an external same-origin script so it
does not require an inline-script exception.

## Repository source of truth

- Runtime and export: `src/main.rs`, `src/static_export.rs`
- Active templates: `templates/site.html`, `templates/blog.html`,
  `templates/article.html`
- Article source: `content/blog/*.md`
- Current resume: `content/resume-current.md`
- Public styling and progressive enhancement: `static/css/site.css`,
  `static/js/blog-filter.js`, `static/js/math-render.js`
- Security and reporting policy: `SECURITY.md`, `/.well-known/security.txt`
- Deployment: `.github/workflows/deploy-cloudflare-pages.yml`

Historical templates and notes remain only as context where they explain past
decisions; they are not active routes or sources. Verify current code and the
live canonical endpoints before making claims about behavior.
