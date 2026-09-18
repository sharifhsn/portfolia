# Cloudflare Pages deployment

Portfolia can be built as static HTML and served without the Axum server. The Rust binary renders each route during export; Cloudflare serves the generated HTML, CSS, JavaScript, fonts, and images as static assets.

## Local build and preview

Run `just static` to replace `dist/` with the static site. Run `just pages-preview` to preview it with Wrangler on `127.0.0.1:8097`.

The settled design is the canonical site at `/`. The exporter writes the root page, `/blog/`, `/projects/`, `/resume/`, every `/blog/{slug}/` article, and the machine-readable `/robots.txt`, `/sitemap.xml`, `/llms.txt`, `/llms-full.txt`, `/feed.xml`, `/feed.json`, `/api/posts*.json`, `/api/projects.json`, `/api/profile.json`, `/api/openapi.json`, and `/.well-known/agent.json` endpoints. Older `/v/*` and `/designs` URLs are compatibility redirects only; new links and canonical tags never point to those paths. A root `404.html` prevents Pages from treating unknown routes as a single-page app. The generated `_headers` file gives long-lived caching to static fonts, a short revalidation window to other static and machine-readable assets, and cross-origin read access to public machine endpoints.

The source-grounded hosting record, including the Cloudflare domain and DNS findings from the Hosting session, is in [`context/HOSTING.md`](HOSTING.md). The static export also writes a web app manifest, RFC 9116 security contact, and `_headers` security policy alongside the HTML.

## First deployment

Create a Cloudflare Pages **Direct Upload** project named `portfolia` with `main` as its production branch. Do not connect Cloudflare's Git integration; the GitHub Actions workflow builds the Rust site and uploads `dist/` on each push to `main`. Add these repository secrets before enabling production deploys:

- `CLOUDFLARE_API_TOKEN`: an account-scoped token with `Cloudflare Pages: Edit`
  permission (the token used by the current workflow).
- `CLOUDFLARE_ACCOUNT_ID`: the account ID for the Pages project.

No Wrangler configuration file is checked in because there are no Pages Functions, and adding a `pages_build_output_dir` config would make that file the source of truth for an existing Pages project's settings. The deployment workflow already names `dist/` explicitly.

## Custom domain

Cloudflare Pages serves this project at `portfolia-8xn.pages.dev` without DNS
changes. A custom apex domain such as `sharifhsn.dev` requires Cloudflare to
host its DNS zone and nameservers. A custom subdomain can instead use a CNAME
while the registrar remains the DNS provider. Review existing DNS records
before moving nameservers.

For this project, the live Pages hostname is `portfolia-8xn.pages.dev` and both
`sharifhsn.dev` and `www.sharifhsn.dev` are active custom domains with SSL
enabled. The `www` hostname must remain a proxied CNAME to
`portfolia-8xn.pages.dev`; the 2026-09-18 TLS incident was caused by a stale
DNS-only CNAME to Porkbun parking. See [`context/HOSTING.md`](HOSTING.md) for
the incident evidence and verification commands.

## Future server-backed projects

The current portfolio and project pages are static, so they do not need a server. If a future project needs live compute, keep the articles and home page static and route only that project's path through a Pages Function or Worker to its server. No proxy route is configured until there is a live project origin to target.
