# Cloudflare Pages deployment

Portfolia can be built as static HTML and served without the Axum server. The Rust binary renders each route during export; Cloudflare serves the generated HTML, CSS, JavaScript, fonts, and images as static assets.

## Local build and preview

Run `just static` to replace `dist/` with the static site. Run `just pages-preview` to preview it with Wrangler on `127.0.0.1:8097`.

The settled design is the canonical site at `/`. The exporter writes the root page, `/blog`, `/projects`, `/resume`, every `/blog/{slug}` article, and the machine-readable `/robots.txt`, `/sitemap.xml`, `/llms.txt`, and `/feed.xml` endpoints. Older `/v/*` and `/designs` URLs are compatibility redirects only; new links and canonical tags never point to those paths. A root `404.html` prevents Pages from treating unknown routes as a single-page app.

The source-grounded hosting record, including the Cloudflare domain and DNS findings from the Hosting session, is in [`context/HOSTING.md`](HOSTING.md).

## First deployment

Create a Cloudflare Pages **Direct Upload** project named `portfolia` with `main` as its production branch. Do not connect Cloudflare's Git integration; the GitHub Actions workflow builds the Rust site and uploads `dist/` on each push to `main`. Add these repository secrets before enabling production deploys:

- `CLOUDFLARE_API_TOKEN`: an account token with `Pages Write` permission.
- `CLOUDFLARE_ACCOUNT_ID`: the account ID for the Pages project.

No Wrangler configuration file is checked in because there are no Pages Functions, and adding a `pages_build_output_dir` config would make that file the source of truth for an existing Pages project's settings. The deployment workflow already names `dist/` explicitly.

## Custom domain

Cloudflare Pages serves the project at `portfolia.pages.dev` without DNS changes. A custom apex domain such as `sharifhsn.dev` requires Cloudflare to host its DNS zone and nameservers. A custom subdomain can instead use a CNAME while the registrar remains the DNS provider. Review existing DNS records before moving nameservers.

## Future server-backed projects

The current portfolio and project pages are static, so they do not need a server. If a future project needs live compute, keep the articles and home page static and route only that project's path through a Pages Function or Worker to its server. No proxy route is configured until there is a live project origin to target.
