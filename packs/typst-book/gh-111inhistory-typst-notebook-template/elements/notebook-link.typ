#let notebook-link(
  it,
  text_color: black,
  underline_color: rgb("#14516e"),
  accent_background: rgb("#c4e7f0"),
) = {
  box(
    inset: (x: 0.08em, y: 0em),
    outset: (y: 0.02em),
    radius: 0.18em,
    fill: accent_background,
  )[
    #set text(fill: text_color, weight: "medium")
    #underline(
      stroke: underline_color,
      it,
    )
  ]
}
