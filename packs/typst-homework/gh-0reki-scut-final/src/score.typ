#let score() = {
  rect(
    width: 1.8cm,
    height: 2.2cm,
    stroke: 1pt + red,
    [
      #align(left)[
        #v(0.2em)
        #h(0.2em)
        #text(size: 14pt, fill: red)[*得分*]
      ]
      #align(center)[#line(length: 125%, stroke: 1pt + red)]
    ]
  )
}