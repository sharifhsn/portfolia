# Whole-project design review — October 2, 2026

Scope: source, content organization, public page templates, progressive
enhancement, Hornet controls, browser-chat presentation, static export, local
development, canonical routing, accessibility and responsive behavior. No
publishing, new biography, article rewriting, or pricing-engine changes.

## Findings and recommendations

| Priority | Finding in the previous design | Implemented recommendation |
| --- | --- | --- |
| High | Dark/copper styling is applied uniformly to portfolio, reading and worksheet; homepage gives little visual distinction to the actual person and work. | Establish one light, cool editorial system, with a larger identity area and a quiet reading measure. |
| High | A 30M-parameter experimental chat has a top-level navigation slot equal to Writing and Projects. | Put the experiment under Projects; name its purpose rather than imply a portfolio assistant. |
| High | Writing's desktop topic rail and large group list occupy substantial space; filters reset on page navigation. | Use a compact search/disclosure toolbar and restore/share query, topic and archive state through the URL. |
| High | Article pages repeat the title in a breadcrumb and show “Article N of 153,” which does not help someone read the article. | Use a simple writing link, author/date/read-time metadata, serif title and comfortable prose. Remove duplicate breadcrumbs on section landing pages; tools link back to Projects. |
| High | Authored writing's related recommendations and previous/next navigation can lead directly back into the large study-note archive. | Keep navigation within the current collection; prefer authored pieces when reading authored work. Preserve direct note URLs. |
| High | Hornet steppers and help targets are 12–19 pixels, tooltips can sit below the viewport, and nine market values form an undifferentiated strip. | Group inputs by market/smile/strikes, enlarge intentional controls, preserve the accounting grid and pin row identity. |
| Medium | Three templates duplicate global header and footer; `site.html` contains every tool and section. | Extract shared chrome and page partials; maintain one stylesheet with named sections and tokens. |
| Medium | Runtime and static exporter carry variant routing and alias rewrites for abandoned layouts. | Remove `/v/*`, `/designs`, and their redirect generation/tests. Retain normal canonical URL handling. |
| Medium | The article loader retains Markdown and KaTeX assets even though all 153 current article sources are Typst. | Simplify article loading and API schema to Typst; remove 25 unused KaTeX assets (562,344 bytes). Keep the real Markdown resume renderer and native MathML. |
| Medium | One article cross-reference lost its heading ID during sanitization. | Preserve heading IDs and check every exported local link and fragment. |
| Medium | Word counts count Typst syntax rather than rendered words. | Derive article word count from rendered text and use it for a modest estimated reading time. |
| Medium | Local preview depends on `npm ci`, chat-runtime copying, model fetching, and Hornet compilation every time. | Make asset preparation explicit; ordinary build/test/preview should use prepared assets. |
| Medium | CSS asset versions differ between templates; static 404 page still carries the old theme. | Use one shared versioned stylesheet link and update error-page presentation. |
| Keep | Semantic tables, yellow input cells, text numeric input, exact display caps, combined unrounded risk totals, static-first archive, sources, MathML, feeds and discovery APIs already serve real purposes. | Preserve and verify them; do not replace them with decorative cards or a frontend framework. |

## Research used

These sources guide decisions; they do not certify that a visual style is
objectively best.

- [web.dev: Typography](https://web.dev/learn/design/typography): relative
  sizing, bounded fluid type, readable line measure and line height. Applied to
  titles and article reading width; system stacks avoid a new font download.
- [W3C: Tables tutorial](https://www.w3.org/WAI/tutorials/tables/): retain real
  headers, captions and table relationships. Hornet stays a table rather than
  becoming disconnected mobile cards.
- [W3C: Reflow](https://www.w3.org/WAI/WCAG22/Understanding/reflow.html): prose
  reflows at narrow widths; the intrinsically two-dimensional risk grid scrolls
  inside its own labeled region. No page-wide horizontal scrolling.
- [W3C: Target size](https://www.w3.org/WAI/WCAG22/Understanding/target-size-minimum.html):
  use deliberate target dimensions and spacing; enlarge the tiny step/help
  controls. This is a practical improvement, not a claim of full WCAG conformance.
- [NN/g: Information scent](https://www.nngroup.com/articles/information-scent/):
  descriptive navigation, summaries and contextual links help readers choose
  where to go. Applied to demo entry points and collection-aware reading links.
- [Impeccable](https://github.com/pbakaus/impeccable): its shape/critique/audit/
  polish split informed the review process. No CLI, detector, extension or new
  skill was installed; the installed frontend design and visual QA skills are
  used directly.

## Design decision

See [DESIGN.md](../DESIGN.md). Boldness goes into the personal identity and
page hierarchy. Everything around them is quieter. Public articles and dates
remain untouched; study notes remain an opt-in archive at the bottom.

## Validation

Completed locally with the installed Typst **0.15.0** CLI; deployment remains
pinned to **0.15.1**. No dependency upgrade or new frontend framework was added.

| Check | Result |
| --- | --- |
| Locked Rust build with two jobs | Pass, no compiler warnings. |
| Rust tests | 10 pass: rendering/export/discovery, dates, collection-aware reading links across all 153 articles, heading sanitization. |
| Frontend behavior fixtures | 6 pass: URL filters/history/archive/empty recovery; source precision, explicit steps, invalid inputs/expiry, real WASM pricing, cancellation of all nine metrics, removal, TSV copy and tooltip positioning. |
| Full static export | 153 articles and six main pages rendered. |
| Runtime versus export | All 159 HTML pages match; four missing/retired routes return styled 404. |
| Local links, fragments and images | No broken local targets/fragments or missing image alt attributes across the export. One previously broken cross-reference was repaired. |
| Article math and discovery | 94 articles contain native MathML; both feeds, article API index and per-article documents retain 153 pieces. |
| Tool/download assets | HEAD requests confirm the pricing/model/runtime assets, PDF and DOCX are served; Hornet WASM has the correct MIME type. Chat inference was not exercised. |
| Formatting/syntax | Rust formatting and JavaScript syntax checks pass; diff whitespace checks pass. |
| Desktop/mobile visual and native browser interaction QA | Unverified: automatic approval review rejected selecting the in-app preview tab because its URL protocol was disallowed. No alternate browser surface or automation bypass was used. DOM fixtures do not establish rendered layout, native input behavior, clipboard permissions or accessibility conformance. |

Audit outputs and before/after HTML are in ignored `target/design-review/`.
The October 2 review used local files. That review produced the export in
`dist/`. Article drafts and their images remain separate from the public site.

## Publication checks — October 4, 2026

The user authorized publication of the website redesign. The current checkout
passes these checks:

- The frontend gate reports zero warnings across all six selected files.
- All 10 Rust tests pass.
- All six frontend behavior tests pass.
- All 14 frontend gate tests pass.
- The Rust format check passes.

The Hornet loader examines the WebAssembly export descriptor before it uses
`hornet_metric`. The export must be a function. This check replaces the previous
`typeof` check. The corrected source also includes the gate's spacing fixes.

The publication commit excludes the separate tooling changes and article drafts.
Browser visual QA remains unverified for the reason in the validation table.

## Recommendations for the next pass

1. Complete browser QA at 1440×900 and 390×844, then at 200% zoom: long titles,
   article figures/math, keyboard focus, search/topics/archive combinations,
   horizontal worksheet scrolling, hover/focus help and clipboard copy. Exercise
   the browser model separately; its assets being available does not establish
   successful inference.
2. Add project evidence when available: a real capture, repository or relevant
   write-up next to each case note. The current demo previews show the tool's
   structure without inventing market figures or research results.
3. Generate appropriately sized portrait variants through an image asset
   pipeline for smaller screens. The current authentic portrait is reused.
4. Treat multi-day current-book persistence as a separate product change. The
   scratch grid now has the appropriate row/total structure; booking, cash,
   rolling dates and P&L require a separately specified state model.
