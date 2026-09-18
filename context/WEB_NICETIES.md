# Web niceties

This record describes the standards-backed affordances layered onto the
personal site on 2026-09-18. They are intentionally static, cacheable, and
read-only.

## Discovery and sharing

- `manifest.webmanifest` follows the W3C Web App Manifest shape and advertises
  the site's language, scope, theme colors, and 192/512px icons.
- Every HTML page links a favicon, Apple touch icon, manifest, canonical URL,
  English language alternate, Open Graph image metadata, and Twitter summary
  metadata.
- Home/profile JSON-LD now uses `ProfilePage.mainEntity` and an image; article
  JSON-LD includes a `BreadcrumbList`. Sitemap `lastmod` uses an explicit post
  update timestamp when one exists.
- Blog listings and articles expose the small microformats2 vocabulary that is
  useful to independent readers: `h-entry`, `p-name`, `p-summary`,
  `dt-published`, `e-content`, and `u-syndication`.

## Security and transport

- The Cloudflare Pages `_headers` file sends same-origin CSP, HSTS, clickjacking
  protection, Permissions Policy, COOP, and cross-domain policy headers.
- The math initializer is an external same-origin script, so CSP does not need
  an inline-script exception.
- `/.well-known/security.txt` follows RFC 9116 and points to the repository's
  private-reporting guidance in [`SECURITY.md`](../SECURITY.md).
- Feed JSON is served as `application/feed+json`; the manifest is served as
  `application/manifest+json`.

## Source guidance

The implementation follows the [W3C Web App Manifest](https://www.w3.org/TR/appmanifest/),
[RFC 9116 security.txt](https://www.rfc-editor.org/rfc/rfc9116.html),
[Google's ProfilePage guidance](https://developers.google.com/search/docs/appearance/structured-data/profile-page),
[Google's Article guidance](https://developers.google.com/search/docs/appearance/structured-data/article),
the [Open Graph protocol](https://ogp.me/), and the browser security guidance
for [Content-Security-Policy](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Content-Security-Policy)
and [Strict-Transport-Security](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/Strict-Transport-Security).

These signals improve interoperability and discovery; they do not guarantee a
search rich result or that any particular AI system will retrieve a page.
