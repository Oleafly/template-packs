#import "../tokens.typ": *

#let badge(label) = {
  box(
    fill: ink,
    inset: (x: 7pt, y: 3.5pt),
    radius: 0pt,
    stroke: none,
  )[
    #text(font: font-mono, size: 7.75pt, weight: "regular", fill: white)[#label]
  ]
}

#let badges(..labels) = {
  par(leading: 0.75em, spacing: 0.6em)[
    #for label in labels.pos() [#badge(label)#h(0.4em)]
  ]
  v(0.5em)
}
