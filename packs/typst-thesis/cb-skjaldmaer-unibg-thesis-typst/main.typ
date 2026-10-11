#import "unibg.typ": *

#set text(lang: "en")

#show: unibg.with(
  title: "A Seclab Thesis",
  subtitle: "A Seclab Subtitle",
  authors: (
    (name: "John Doe", number: 177013),
  ),
  degree: (
    name: "Ingegneria Informatica",
    department: "Ingegneria Gestionale, dell'Informazione e della Produzione",
    class: "LM-32",
    type: "master",
    year: "2021/2022",
  ),
  advisor: "Chiar.mo Prof. John Smith",
  // coadvisors: ("Chiar.mo Prof. Ed Smith"),
  abstract: lorem(150),
  show-outline: (
    figures: true
  )
)

= First chapter

== Example
#lorem(150)

#lorem(150)

== Example
#lorem(150)

== Example
#lorem(150)

= Second chapter

== Example
#lorem(150)

== Example
#lorem(150)

== Example
#lorem(150)

#heading(tr("acks"), numbering: none)
I would like to thank the UniBG Seclab laboratory for freely providing the
template~@unibg-thesis-template during the writing of this thesis.

#bibliography("bibliography.bib", full: true)
