#set heading(numbering: "1.1.")
#set text(
  font: "Times New Roman",  // oder z.B. "Libertinus Serif"
    size: 12pt
 )
#set par(leading: 0.5em)
#set page(numbering: none)
#set page(
  paper: "a4",
  margin: (left: 3cm, right: 2.5cm, top: 2.5cm, bottom: 2.5cm),
)
#show heading: set text(
  size: 13pt,
  weight: "regular",
)

#show heading: set block(
    below: 2em
)


#include "titlePage.typ"
#pagebreak()

#outline(title: "Inhaltsverzeichnis")
#pagebreak()
#set page(numbering: "1")
#counter(page).update(1)

/*
########################################
####### Hier beginnt der Inhalt ########
########################################
*/

#include "content.typ"

/*
########################################
####### Hier endet der Inhalt ########
########################################
*/

#pagebreak()
#bibliography("bibliography.bib", title: "Quellenverzeichnis")