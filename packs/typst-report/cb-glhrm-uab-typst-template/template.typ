#set page(
  paper: "a4",
  margin: (top: 3cm, right: 2cm, bottom: 3cm, left: 3.5cm),
)

// Corpo do texto
#set text(
  font: "Times New Roman",
  size: 12pt,
  hyphenate: true,
  lang: "pt",
  region: "pt"
)
#set par(
  leading: 0.8em,
  spacing: 1.8em,
  linebreaks: "optimized",
)

#set heading(numbering: "1.")
#show heading: it => [
  #set text(font: "Arial")
  #block(it)
  ] 

#show heading.where(
  level: 1
): it => [
  #set text(15pt)
  #block(
    it,
    below: 4em
    )
]

#show heading.where(
  level: 2
): it => [
  #set text(11pt)
  #block(
    it,
    above: 1.8em,
    below: 1.8em
    )
]

// Equações
#set math.equation(numbering: it => {
    let count = counter(heading.where(level: 1)).at(here()).first()
    numbering("(1.1)", count, it)
})

#include "um-capítulo.typ"

#pagebreak()
#bibliography(
  "referencias.bib",
  full: true,
  title: auto,
  style: "apa"
)