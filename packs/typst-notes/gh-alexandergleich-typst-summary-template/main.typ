#import "template.typ" : *

#let gutter = 4mm

#set page(
  paper: "a4",
  flipped: true,
  margin: (
    top: 8mm,
    bottom: 5mm,
    left: 5mm,
    right: 5mm,
  ),
  columns: 4,
  header: [
    #block(
      width: 100%,
      height: 8mm,
      inset: (x: 1mm, y: 1mm),
      stroke: (bottom: 1pt),
    )[
      #grid(
        columns: (1fr, auto, 1fr),
        align(left)[Topic],
        align(center)[Material Summary],
        align(right)[Page #context counter(page).display("1 / 1", both: true)],
      )
    ]
  ],
  background: context [
    #let content-width = page.width - (5mm + 5mm)
    #let column-width = content-width / 3
    #place(
      horizon + left,
      dx: 5mm + column-width + gutter,
      dy: 6mm,
      line(
        angle: 90deg,
        length: 100%,
        stroke: 0.7pt,
      )
    )
    #place(
      horizon + left,
      dx: 5mm + 2*column-width + gutter*2.5,
      dy: 6mm,
      line(
        angle: 90deg,
        length: 100%,
        stroke: 0.7pt,
      )
    )
    #place(
      horizon + left,
      dx: 5mm + 3*column-width + gutter*4,
      dy: 6mm,
      line(
        angle: 90deg,
        length: 100%,
        stroke: 0.7pt,
      )
    )
  ],
)

#set columns(gutter: gutter)

#set text(
  size: 8pt,
)

#set par(
  leading: 0.3em,
)

#set table(
  inset: 1mm,
  stroke: (x, y) => if y == 1 {
    (top: 1pt, bottom: 0.5pt)
  } else {
    (bottom: 0.5pt)
  } 
)
#set heading(numbering: "1.1 -")

#show heading: it => block(
  above: 0.6em,
  below: 0.4em,
  text(weight: "bold", size: 10pt)[#it]
)

#show heading.where(level: 1): it => block(
  below: 0.8em,
  text(weight: "bold", size: 12pt)[#it]
)

//set math equation alignmeht to left by default 
#show math.equation.where(block: true): set align(left)

#include "chapters/first.typ"
#include "chapters/second.typ"
#todo-outline()