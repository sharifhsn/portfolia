= Documents that travel

Write the content once. Keep the structure when the document moves.

== One source, two conversations

A research brief needs headings, tables, and equations. A review deck needs a clear canvas with text people can edit.

#table(
  columns: (1fr, 1fr),
  inset: 9pt,
  stroke: .5pt + rgb("cbd5d5"),
  fill: (x, y) => if y == 0 { rgb("e4eeeb") },
  table.header([*Document*], [*What stays useful*]),
  [Word brief], [Headings and table cells],
  [PowerPoint deck], [Text and page geometry],
)

The equation stays part of the document:

$ Q = sum_(i=1)^n x_i / n $
