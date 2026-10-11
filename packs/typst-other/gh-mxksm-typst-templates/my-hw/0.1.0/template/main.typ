#import "setup.typ": *
#import "@preview/equate:0.3.2": equate

// ===
// SET 
// ===
#set math.mat(delim: "[")
#set math.mat(row-gap: 0.5em)
#set math.mat(column-gap: 1em)

#set math.equation(
  numbering: (..nums) => numbering("(1)", ..nums),
  supplement: none,
)

#set enum(indent: 10pt)
#set heading(numbering: "1.")
#set table(
  stroke: (x, y) => {
    if y == 0 {
      (bottom: 1pt + black)
      (top: 1pt + black)
    }
  },
  align: (x, y) => (
    if x > 0 { center }
    else { left }
  ),
  inset: 7pt,
)

// ====
// SHOW
// ====
#show: project.with()
#show table: block.with(stroke: (y: 1pt))
#show ref: theoretic.show-ref
#show ref: link => text(blue, link)
#show link: set text(blue)
#show: equate.with(breakable: true, sub-numbering: false, number-mode: "label")

#show figure.caption.where(body: []): it => [
  #it.supplement #context it.counter.display(it.numbering)
]

#show sym.lt.eq: math.scripts

// =======
// CONTENT
// =======

