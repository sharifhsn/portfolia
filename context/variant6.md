# Reading first

## References

- Matklad: https://matklad.github.io/
  A compact date-and-title archive gives the writing the visual weight.
- Andrew Gallant: https://burntsushi.net/
  Short article summaries and direct project links make technical writing easy to scan.
- fasterthanli.me: https://fasterthanli.me/
  A direct personal introduction and clear groups for work and writing make the site easy to understand.

These are structural references, not designs or copy to reproduce.

## Design

- Canvas: near-white #fcfdfe; text #202b35; muted text #596874; rule #d9e1e7; links #2458a6.
- Type: system sans for the page, system monospace only where code appears.
- Layout: wide, quiet site header; centered 48rem reading column; identity and a small portrait; LinkedIn and GitHub links below the introduction. Blog, Projects, and Resume remain in the top navigation.
- Principles: let the writing lead; use links and dates as navigation; don't simulate content that is not ready; no cards, shadows, decorative labels, or motion.

Sharif Haason                              Blog Projects Resume

Sharif Haason                                      [portrait]
Product engineer at Monark Markets.
Interests: Rust, compilers, research, practical tools.
LinkedIn   GitHub

## Routes

- /v/6
- /v/6/blog
- /v/6/projects
- /v/6/resume

## Verification

- `rtk cargo build`, `rtk cargo test`, and `rtk cargo fmt --check` pass.
- The gallery, four variant routes, stylesheet, and portrait asset return HTTP 200.
- Home inspected at 1440x900 and 390x844. No horizontal overflow; portrait loads.
- Blog, Projects, and Resume navigation works at phone width. Both resume downloads render.
- Resume top and bottom inspected; no console warnings or errors were captured.
