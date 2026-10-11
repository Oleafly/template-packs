#set page(
  paper: "a4",
  margin: (left: 4cm, right: 2cm, top: 2cm, bottom: 2cm),
)

#set text(
  font: "New Computer Modern",
  size: 12pt
)

#set par(
  justify: true,
  leading: 1.5em,
)

#show heading: set text(font: "New Computer Modern Sans", weight: "bold")

#show heading.where(level: 1): set block(above: 3em, below: 2em)
#show heading.where(level: 2): set block(above: 2.5em, below: 1.75em)
#show heading.where(level: 3): set block(above: 2em, below: 1.5em)

#show figure: set block(above: 2em, below: 2.5em)
#show figure: set align(left)

#show figure.where(kind: image): set figure(supplement: "Abbildung")
#show figure.where(kind: table): set figure(supplement: "Tabelle")

#show figure.where(kind: table): set figure.caption(position: top)

#show figure.caption: c => [
  #set par(leading: 1em)
  #text(weight: "bold")[#c.supplement #context counter(figure.where(supplement: c.supplement)).display()#c.separator]#c.body
]

#include "titlepages/study_thesis.typ"

#include "outlines.typ"

#counter(page).update(1)
#set page(numbering: "1")
#set heading(numbering: "1.")

#include "chapters/example-chapters.typ"

#include "appendix.typ"