#let notebook-ref(
  it,
  text_color: rgb("#2f5568"),
  underline_stroke: (thickness: 0.5pt, paint: rgb("#88a6b4")),
  fill_color: rgb("#f1f4f6"),
  stroke_color: rgb("#d2dde3"),
) = context {
  let a = state("__bib").final()
  if it.element == none and (a == none or not a.keys().contains(str(it.target))) {
    box(
      inset: (x: 0.22em, y: 0.04em),
      radius: 0.22em,
      fill: rgb("#fff1e6"),
      stroke: (paint: rgb("#e3b388"), thickness: 0.45pt),
    )[
      #text(fill: rgb("#a85f22"), weight: "bold", "[? " + str(it.target) + "]")
    ]
  } else {
    box(
      inset: (x: 0.18em, y: 0.02em),
      radius: 0.22em,
      fill: fill_color,
      stroke: (paint: stroke_color, thickness: 0.4pt),
    )[
      #set text(fill: text_color, weight: "medium")
      #underline(offset: 1.6pt, stroke: underline_stroke, it)
    ]
  }
}
