// A self-contained avatar placeholder for public resume templates.
#let photo-placeholder(size: 28mm, label: "照片") = {
  block(
    width: size,
    height: size,
    radius: 50%,
    fill: luma(235),
    stroke: 0.5pt + luma(150),
    inset: 0pt,
  )[
    #align(center + horizon)[
      #text(size: 8pt, fill: luma(100))[#label]
    ]
  ]
}
