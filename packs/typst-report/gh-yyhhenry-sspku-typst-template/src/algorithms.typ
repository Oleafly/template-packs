#import "@preview/lovelace:0.3.1": pseudocode, indent
#import "fonts.typ": cn-font-size

// The caller owns the figure and its label; this function only lays out its body.
#let algorithm-body(..lines) = block(width: 100%, inset: (y: 0.6em))[
  #set text(size: cn-font-size.五号)
  #set par(first-line-indent: 0em, leading: 0.25em, spacing: 0.3em)
  #set align(center)
  #pseudocode(
    line-numbering: "1",
    indentation: 1.2em,
    line-gap: 0.4em,
    stroke: 0.45pt + luma(70%),
    booktabs: true,
    ..lines.pos(),
  )
]
