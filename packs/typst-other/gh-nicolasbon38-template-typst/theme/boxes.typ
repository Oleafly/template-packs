#import "colors.typ": *

#let genericbox(title, body, color) = block(
  width: 80%,
  breakable: false,
)[
  #block(
    width: 100%,
    above: 0pt,
    below: 0pt,
    stroke: 2pt + color,
    fill: color.transparentize(30%),
    inset: (x: 12pt, y: 8pt),
    radius: (top: 20pt),
  )[
    #set align(left)
    #set text(fill: white, weight: "bold", size:20pt)
    #title
  ]
  #block(
    width: 100%,
    above: 0pt,
    below: 0pt,
    fill: color.transparentize(95%),
    inset: 12pt,
    radius: (bottom: 20pt),
    stroke: 2pt + color,

  )[
    #set align(center+horizon)
    #set text(size: 20pt, fill: black)
    #body
  ]
]

#let questionbox(body) = genericbox("Question", body, secondary)
#let propertybox(title, body) = genericbox(title, body, tertiary)
#let alertbox(body) = genericbox(
  [#emoji.warning],
  body,
  red)
