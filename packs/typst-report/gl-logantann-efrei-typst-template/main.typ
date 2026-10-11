  
#import "utils/template.typ": template
#import "utils/vars.typ": *

#set document(author: reportAuthor, title: reportTitle)
#set text(lang: "fr")
#show link: underline

#include "utils/pageGarde.typ"

#show: template.with(
  title: documentTitle,
  paper-type: paperType,
  publisher: image("assets/efrei_paris.png", height: 5em),
  authors: (
    (name: [  #authorSalutation #reportAuthor], affiliation: "Présenté par :\n", postal: "\n   En vue de l'obtention du titre d'Ingénieur diplômé d'EFREI Paris\n   Majeure Logiciels et Systèmes d'Information (LSI)"),
    (name: "", affiliation: "", postal: ""),
    (name: "  " + academicTutor, affiliation: "Jury:\n", postal: "Superivison académique"),
    (name: "  " + companyTutor, affiliation: "", postal: "Superivison professionelle"),
  ),
  keywords: (
    "Software engineering", "Salesforce application development", "Template", "Software components reuse", "Project management"
  ),
  abstract: [
    #lorem(20)
  ]
)
#pagebreak()
#include "0_toc.typ"
#pagebreak()
#set heading(numbering: "I.1.a.")
#include "1_body.typ"
#set heading(numbering: none)

= Table des figures
#v(-2.4em)
#outline(
  title: "",
  target: figure.where(kind: image),
)

= Liste des tableaux
#v(-2.4em)
#outline(
  title: "",
  target: figure.where(kind: table),
)

#pagebreak()
#bibliography("utils/bibliography.yml", style: "the-institution-of-engineering-and-technology")


#align(bottom, box(fill: luma(240), inset: (x:1em, y:1.5em), radius: 0.2em, stroke: luma(220), width: 100%)[
#heading(level: 1, outlined: true, numbering: none)[Historique des révisions]

#v(0.5em)
2. 18 juillet 2025 - Template. \
   Publié : https://logantann.gitlab.io/efrei-typst-template/
1. 01 juillet 2025 - Rapport final livré.
])

#emoji.copyright #reportAuthor, all rights reserved. 

The author formally opposes the use of works in its repertoire by artificial intelligence (AI) systems as part of the data mining exception provided for in Article 4 of Directive 2019/790 and transposed into French law in Article L. 122-5-3 of the Intellectual Property Code.
