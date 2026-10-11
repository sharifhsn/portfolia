#import "@preview/lilaq:0.6.0" as lq
#set page(width: 420pt, height: auto, margin: 22pt)
#set text(font: "New Computer Modern", size: 12pt, fill: rgb("243732"))
#let final = int(sys.inputs.at("final", default: "8"))
#let values = (4, 6, 5, final)

#text(size: 20pt, fill: rgb("426557"))[One value, three views]

Illustrative data. The metric, chart, and table share the same value.

#text(size: 26pt, fill: rgb("426557"))[#final]
#h(8pt) Final sample value

#lq.diagram(
  width: 100%, height: 160pt,
  xaxis: (ticks: (1, 2, 3, 4), label: [Sample]),
  yaxis: (lim: (0, 12), label: [Value]),
  lq.bar((1, 2, 3, 4), values, fill: rgb("426557"), stroke: none),
)

#table(
  columns: 4,
  inset: 8pt,
  stroke: .5pt + rgb("cbd5d5"),
  table.header([Sample 1], [Sample 2], [Sample 3], [Sample 4]),
  ..values.map(value => [#value]),
)
