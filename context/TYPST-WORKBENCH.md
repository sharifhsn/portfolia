# Typst and Office page

Scope: `/experiments/tylax/`, the existing selected experiment. Keep the route,
the six-entry catalog, the order, and upstream author credits.

## Sources checked on October 10, 2026

- Typst fork: local revision `530ad1a0d`, branch `codex/office-export`.
  Read `README.md`, `docs/dev/office-export-architecture.md`,
  `docs/dev/docx-roundtrip.md`, the DOCX/PPTX import READMEs, the October 2
  validation record, and `docs/dev/test-audit.md`.
- Browser exporter: local and deployed revision
  `58d8a044c763acf66eda26eb22ec71a705edb355`. The successful Pages workflow is
  [30330497453](https://github.com/sharifhsn/typst-office/actions/runs/30330497453).
  Its Cargo dependencies pin the Office compiler to
  `22fd0c0d07777c989e006645e12bd2c16c679823`.
- Tylax: `docs/projects/architecture-review-2026-10-02.md`. Its local record
  reports 1,745 Rust tests. The retained website math examples use an earlier
  converter and keep their original artifact grades.
- Typst Studio: the local working project at
  `~/.codex/worktrees/xy-typst-bridge/typst/tools/xy-studio/`.
  Its README and native `library/plots.typ` establish the annotation,
  component, shared-data, provenance, and Lilaq paths. This source remains
  local working material. The website does not claim a public Studio release.

## Public artifacts

`static/experiments/tylax/office/` contains original public demonstration content.
It contains no company research or private documents.

The brief and deck include the same `content.typ`. The page formats differ.
The source ZIP contains both entrypoints, shared content, New Computer Modern
fonts, and their upstream NOTICE. The font source is `typst-assets` at `94dcb99`.

Downloaded the deployed WASM and its matching JS wrapper from
`https://sharifhsn.github.io/typst-office/pkg/`. Initialized the module in Node
with the WASM bytes. Called `export_project({main_path, files}, format)` with
the three Typst files and bundled font bytes. `record.json` records the compiler
hash, deployment, inputs, outputs, and package counts.

Parsed every XML and relationship part. Resolved each internal relationship
against the package inventory. Checked the shared title in the document/slide.
The DOCX contains 13 body/table paragraphs, one native table, and one OMML
equation. The PPTX contains six text shapes, 13 text runs, one DrawingML table,
and one OMML equation. These are package observations, not native Office
visual acceptance.

Typst 0.15.0 produced the SVG/PDF reference layouts. The page labels these
previews as Typst renders. It does not present them as Word or PowerPoint renders.

The Lilaq 0.6.0 example uses illustrative values. `final` supplies one value to
the metric, chart, and table. Two recorded builds use 8 and 11:

```sh
typst compile --input final=8 chart.typ chart-original.svg
typst compile --input final=11 chart.typ chart-edited.svg
```

Local builds used Studio's pinned package directory through `--package-path`
and the sample fonts through `--font-path`. These controls select recorded
renders. They do not run Studio or an Office compiler inside the portfolio page.

## Validation boundaries

The October 2 compiler/package figures retain their recorded date and revision.
They do not refresh corpus scores or native Office render, edit, and reopen
results. Pandoc remains incomplete and unsupported. The compiler performance
branches remain separate, with no new speed claim. The browser demo exposes
export only. CLI import and Word review are separate paths.

The page uses HTML radios, external CSS, native Typst SVGs, and the existing
Rust/Askama site. It adds no browser script or visualization dependency.

## Local page checks

All 27 site tests passed. Formatting, strict Clippy, the static export, and
`git diff --check` passed. The existing incremental frontend gate passed with
zero warnings. Its three changed JS files belong to the pre-existing gate
integration. This task adds or edits no JS/TS file and leaves that integration
unstaged.

Browser checks covered 1440×900 and 390×844. Each Office path selector changed
the visible section. Both Lilaq states showed the corresponding metric, bar,
and table value. Source evidence expanded. The retained Matrix selector worked.
The mobile progress caption now occupies the full table width. The page has
no horizontal overflow. No browser warning or error appeared in these flows.
