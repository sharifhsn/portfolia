# Portfolia hosting record

This is the durable record of the **Hosting** task (`01a0a6b2-7d8b-7210-850d-e0ab4c4dd9f1`), reviewed on 2026-09-15. It preserves what that session actually verified so future deployment work does not have to rediscover the hosting and DNS history. It is a snapshot, not a substitute for checking the live dashboard before changing production.

## Confirmed deployment model

- Portfolia is a Rust/Axum/Askama site that can render a complete static build with `cargo run --locked --release -- --export-static`.
- The Hosting session published a direct-upload build to the Cloudflare Pages project `portfolia`; the Pages preview hostname was `portfolia-8xn.pages.dev`.
- That upload was confirmed in the Cloudflare dashboard as 180 files in one deployment. The session's build snapshot was approximately 3.3 MB and contained 110 article routes; the repository has since grown, so those counts are historical.
- The custom domain `https://sharifhsn.dev` was verified in the session as active on Cloudflare Pages with SSL enabled. The homepage, the reading-first blog, and the Minneapolis housing article were visible through the domain at that time.
- The repository now treats GitHub Actions as the repeatable deployment path: `.github/workflows/deploy-cloudflare-pages.yml` builds `dist/` on pushes to `main` and runs `wrangler pages deploy dist --project-name=portfolia --branch=main`.

## DNS and domain findings

Cloudflare was the authoritative DNS provider in the Hosting session. The nameservers observed there were:

- `dell.ns.cloudflare.com`
- `rob.ns.cloudflare.com`

The apex domain pointed at `portfolia-8xn.pages.dev`; the session also observed existing wildcard and `www` records. Before the move, the Porkbun zone contained only the old apex A record (`52.0.200.63`) and a wildcard CNAME to Porkbun parking/forwarding. No MX, TXT, AAAA, or CAA records were observed, and no DNSSEC DS record was observed. These are session-time observations; inspect the current Cloudflare zone before editing records.

## Legacy infrastructure investigation

The session checked AWS account `270497617191` (`sharifhsn`) in `us-east-1`. The only running EC2 instance was `guphup-staging` (`i-00aa73dc7ff750044`, public IP/EIP `3.212.25.187`), tagged `Project=Guphup` and `Environment=staging`. No load balancers, Route 53 hosted zones, `portfolia` resources, or resources using `52.0.200.63` were found. The old address timed out over HTTP/HTTPS, so it was not evidence of the current site.

Git history shows that Shuttle support was added for an app named `portfolia` on 2025-08-28, then removed by commit `55876fd0` on 2026-01-26. This is historical hosting evidence, not a current deployment target. No repository deployment configuration for Leapcell was found in the session.

## Cost and architecture decision

For this text-first portfolio, the session recommended Cloudflare Pages Free: static CDN delivery with no application server to keep running. GitHub Pages was the other zero-cost static alternative; free Render was less suitable because of sleeping services. Keep the current Rust exporter and static Pages deployment. If a future project needs live compute, route only that project's path through a Pages Function or Worker rather than moving the whole portfolio to a server.

## Operational checklist

1. Keep `main` as the only development/deployment branch.
2. Set `CLOUDFLARE_API_TOKEN` (account-scoped `Cloudflare Pages: Edit`) and `CLOUDFLARE_ACCOUNT_ID` as repository secrets for the workflow.
3. Run `just static` locally when checking the generated tree; run `just pages-preview` for a Pages-like preview.
4. Before DNS or production changes, re-check the Cloudflare account, Pages project, custom-domain status, nameservers, and current DNS records. Do not reuse the old EC2 address.

## Deployment incident resolved 2026-09-18

The first post-consolidation GitHub Actions deployment built successfully but
Wrangler stopped in its non-interactive environment because the repository had
neither required Cloudflare secret. An account-scoped token with only
`Cloudflare Pages: Edit` access was created in the Cloudflare dashboard and
stored as `CLOUDFLARE_API_TOKEN`; the confirmed account ID was stored as
`CLOUDFLARE_ACCOUNT_ID`. The rerun of [workflow run 35368167563](https://github.com/sharifhsn/portfolia/actions/runs/35368167563)
completed successfully. The token value is intentionally not recorded in the
repository or this document.
