# Experiments section

The local draft contains `/experiments/` and 17 detail pages.
The October 10 selection removes nine entries without sufficient evidence of substantial development work.
[The selection notes](EXPERIMENT-SELECTION.md) record the retained work and each removal.
The removed drafts remain in `archived-experiments.toml`, outside the active catalog.

Each detail page starts with a short interest paragraph and a progress paragraph.
The examples follow those writeups.
Implementation scope and source credit remain in a disclosure.
The selected upstream entries describe local contribution work and retain upstream authorship.

## Result types

| Type | Pages | Meaning |
| --- | --- | --- |
| Try now | 1 | The Hornet browser worksheet runs its Rust engine. |
| Recorded result | 6 | Native tools supplied fixed outputs for inspection. |
| Interactive study | 10 | A bounded example illustrates one behavior from a larger project or contribution. |

The small website example does not establish the full project's acceptance state.
Progress paragraphs keep those states separate.

## Implementation

Rust, Axum, and Askama supply the pages, calculations, source selection, and SVG views.
Native radio controls and CSS select fixed cases without new JavaScript.
A browser without CSS `:has()` shows all cases in sequence.

`content/experiments.toml` contains the selected catalog and both writeup paragraphs.
`src/experiments.rs` supplies typed records and views.
The studies modules supply calculations and recorded fixtures.
The runtime and static export use the same render functions.
The catalog, detail routes, and sitemap use the same selected entries.

Hornet keeps its Rust WebAssembly engine.
Typst supplies the recorded math previews.
All fixture media uses the `/static/` route.

## Native results

| Experiment | Observed result | Limit |
| --- | --- | --- |
| Wedeo | Three synthetic H.264 frames equal FFmpeg's checksums and 4,608 raw bytes. | One input does not establish full decoder parity. |
| Volt | A native QR round trip recovers all 32 original bytes with the same digest. | Generated frames do not establish camera acceptance. |
| Rustlyn | An unresolved-name binder fixture retains byte range 8..19. | The fixture does not exercise a full editor or project loader. |
| Tylax | Three actual conversions produce Typst output and readable previews. | Each retains a Degraded grade for the amsmath package diagnostic. |
| ttfx | The native print effect produces 30 seeded frames. | The recording supplies no new performance comparison. |
| Rust to .NET | Four managed results equal the native Rust reference. | The installed SDK differs from the newer source checkout. |

[Fixture notes](experiments-proof/README.md) and [the result manifest](experiments-proof/results.json) retain the original capture details.
Their October 9 coverage describes the larger initial collection.
The current website uses only the selected catalog.

## History coverage

The saved Apt records supply project leads and historical source evidence.
This task reads no original chat transcript or prompt body.
No private history enters the website or static export.
The broader private history review remains incomplete.
The selected list is not a complete inventory of Sharif's development work.

## Validation

The route checks require HTTP 404 for all nine removed experiment slugs.
The static export omits their detail pages and sitemap entries.
The selected pages retain their writeups, example controls, and fixture links.
Browser review covers the changed catalog and a selected detail page at desktop and mobile widths.
The prior fixture checks remain separate from this selection review.

Publication and deployment need separate authorization.
This result remains a local draft.
