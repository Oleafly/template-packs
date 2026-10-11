#set page(paper: "a4", margin: (x: 2.5cm, y: 2.5cm))
#set text(size: 12pt, font: "New Computer Modern")
#set par(justify: true, leading: 0.85em, spacing: 0em)
#set block(spacing: 0em)
#set heading(numbering: "1.1.a.")

#let spacing = 1.2em
#show math.equation.where(block: true): set block(spacing: spacing)
#show list: set block(above: spacing, below: spacing)
#show enum: set block(above: spacing, below: spacing)
#show table: set block(spacing: spacing)

#include "metadata/title.typ"

#set text(size: 14pt, font: "New Computer Modern")
#set par(spacing: 0.85em)

#align(center + horizon)[
  #text(size: 20pt)[
    _Dedicated to my Parents_
  ]
]
#pagebreak()
#include "metadata/certificate.typ"
#include "metadata/declaration.typ"
#include "metadata/acknowledgments.typ"
#include "metadata/abstract.typ"

#outline()
#pagebreak()
#outline(
  title: [List of Figures],
  target: figure.where(kind: image),
)
#pagebreak()
#outline(
  title: [List of Tables],
  target: figure.where(kind: table),
)


#set page(footer: context [
  #h(1fr)
  #counter(page).display()
])

#counter(page).update(1)

#include "chapters/01_introduction.typ"
#include "chapters/02_background.typ"
#include "chapters/03_literature_review.typ"
#include "chapters/04_materials_methodology.typ"
#include "chapters/05_implementation.typ"
#include "chapters/06_results_discussion.typ"
#include "chapters/07_conclusion.typ"
#include "chapters/08_future_work.typ"
#include "chapters/09_appendices.typ"

#show bibliography: set heading(outlined: false)
#bibliography("cites.bib", title: auto)
