# Portfolia design direction

This is Sharif Haason's public portfolio and writing site. The primary visitor
wants to understand his financial-software work, inspect a real project, or read
his writing. The site is a Rust/Axum/Askama application and static export, not a
dashboard or a generic AI-product landing page.

## Visual direction

A cool, light technical journal. The name and portrait carry the homepage;
actual writing and usable project demos carry the rest. A broad outer frame
supports project tools, while prose stays on a deliberately narrower measure.

| Token | Value | Purpose |
| --- | --- | --- |
| Canvas | `#f3f6fa` | Cool outer page |
| Paper | `#ffffff` | Reading and form surfaces |
| Ink | `#1c2b3a` | Text and prominent headings |
| Secondary ink | `#536476` | Dates and supporting text |
| Link | `#234da2` | Links, selection, keyboard focus |
| Rule | `#d5dee8` | Boundaries where content changes role |

Georgia supplies expressive display headings; Iowan Old Style/Georgia supplies
article text; system sans supplies navigation and controls; monospace is reserved
for code. These are system font stacks: no new external font requests. Reading
text stays around 65 characters wide, with generous line height and relative
font sizing. Titles wrap naturally rather than truncate.

```
Home:      name + work / portrait
           recent writing / real project entry points
Writing:   title + brief
           search + collapsed topics
           chronological article rows
           collapsed study archive at the bottom
Article:   writing link / title / date + reading time
           narrow prose / related authored writing
Projects:  usable demos / selected project case notes
Hornet:    shared market inputs / contract + risk grid / totals
```

Keep alignment left. Use color to show interaction or workbook semantics. Avoid
decorative badges, arbitrary section numbers, animation, fake statistics,
stock illustrations, gradients, and repeated generic cards. A layout change
should expose a useful relationship rather than add visual activity.

## Plan critique before implementation

A cream/serif/copper theme would repeat a common generated design and the
incumbent copper accent; rejected. A neon terminal would overrepresent Rust
and make long reading and the light workbook compete; rejected. A newspaper
grid would overfragment the essays; rejected. The cool journal keeps one
expressive homepage identity and otherwise lets the real material do the work.

Primary navigation is Writing, Projects, Experiments, Resume. Browser chat is an experiment
reached through Projects. Article ordinals and repeated breadcrumb titles add
little information and are removed. The study archive stays below the writing
list, as requested. The worksheet keeps the source workbook's peach market,
green contract, blue risk, and yellow editable-cell conventions.

## Engineering rules

Shared navigation/footer markup has one source. Pages work as ordinary HTML;
JavaScript enhances search and powers the two actual interactive demos. Avoid
new frontend frameworks. Preserve public article content, canonical URLs,
feeds, structured data, source attribution, math, and source metadata. Remove
the retired `/v/*` and `/designs` implementation compatibility. Local preview
must not reinstall browser-model assets on every invocation.

See [the review](context/DESIGN_REVIEW.md) for research, findings, and verification.
