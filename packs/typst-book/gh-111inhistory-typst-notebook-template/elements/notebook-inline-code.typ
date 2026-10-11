#let notebook-inline-code(
  it,
  text_color: rgb("#037aa9"),
  fill_color: luma(96%),
  stroke_color: luma(80%),
) = {
  set text(weight: "regular", fill: text_color, size: 1em - 1pt)
  [
    #box(
      fill: fill_color,
      radius: 0.4em,
      inset: (x: 2pt, y: 0em),
      outset: (y: 3pt),
      stroke: (paint: stroke_color, thickness: 0.75pt),
      // baseline: ,
    )[#it]
  ]
}
