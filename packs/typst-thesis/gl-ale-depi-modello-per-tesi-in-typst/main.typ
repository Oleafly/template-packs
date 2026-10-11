#let author = "Nome Cognome"
#let title = [TITOLO DELLA TESI]
#let date = datetime.today()

#set document(
  author: author,
  title: title,
  date: date,
)
#set heading(numbering: "1.")
#set math.equation(numbering: "1.")
#set page(paper: "a4")

#show link: set text(blue)

#align(center)[
  // #image("figures/logo_universita", width: 75%)
  #rect(
    width: 80%,
    height: 4cm,
    fill: luma(230),
    stroke: 0.5pt,
  )[
    #align(center + horizon)[logo dell'università]
  ]
  #v(2cm)
]

#align(center)[
  #author
  #v(1cm)
  #title
  #v(1fr)
  2026-2027
]

#pagebreak()

#outline()

#pagebreak()

#include "chapters/writing.typ"
#pagebreak()
#include "chapters/links.typ"
#pagebreak()

#bibliography("bibliography.bib", full: true)
