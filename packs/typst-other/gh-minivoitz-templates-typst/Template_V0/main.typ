//----------------------------------------------------------//
//----------------------------------------------------------//
//Parameters to change
#let chemin_logo_entreprise = "Photos/Logos/logo_entreprise.png"
#let chemin_logo_ecole = "Photos/Logos/logo_ecole.png"
#let text_header = [_Rapport de stage : Titre du rapport_]
#let name_header = [NOM Prénom]
//----------------------------------------------------------//
//----------------------------------------------------------//

//General parameters for the template
#set page(margin: 25.4mm, paper: "a4")
#set par(leading: 0.55em, spacing: 0.55em, first-line-indent: 1.8em, justify: true)
#set text(font: "New Computer Modern")
#show raw: set text(font: "New Computer Modern Mono")
#show heading: set block(above: 1.4em, below: 1em)
//----------------------------------------------------------//
//----------------------------------------------------------//
#import "glossary.typ": make-glossary, register-glossary, print-glossary, gls, glspl, entry-list

//----------------------------------------------------------//
//----------------------------------------------------------//

#let raw_sv = f => raw(read(f), block: true, lang: "systemverilog")

//Title
#include "title.typ"
#pagebreak()

//Special pages (tables and thanks)
#context counter(page).update(1)
#set page(
  margin: (top: 30mm, bottom: 25.4mm, x: 15mm),  //To change margins in the whole doc
  paper: "a4",
  header-ascent: 40%,
  header: [
    #text_header
    #h(1fr)
    #name_header
    #line(length: 100%, stroke: 0.1em)
  ],
  footer: {
    set image(height: 4em)
    line(length: 100%, stroke: 0.1em)
    grid(columns: 3*(1fr,), align: (left, center + horizon, right),
      image(chemin_logo_entreprise),
      context counter(page).display("i"),
      image(chemin_logo_ecole)
    )
  }
)

//Remerciements
#include "remerciement.typ"
#pagebreak()

//Table of contents
#outline(
  title: [Sommaire],
) <sommaire>
#pagebreak()

//Table of images
#outline(
  title: [Liste des Figures],
  target: figure.where(kind: image),
)
#pagebreak()

//Table of tables
#outline(
  title: [Liste des Tableaux],
  target: figure.where(kind: table),
)

// Table of codes
#outline(
  title: [Liste des Codes],
  target: figure.where(kind:raw),
)
#pagebreak()

#include "glossary.typ"
#show : make-glossary
#register-glossary(entry-list)
#print-glossary(entry-list,disable-back-references: true)


//Sets the parameters for the core of the report
#set heading(numbering: "I.1.a.")
#set figure(numbering: "1 ")
#set page(
  footer: {
    set image(height: 4em)
    line(length: 100%, stroke: 0.1em)
    grid(columns: 3*(1fr,), align: (left, center + horizon, right),
      image(chemin_logo_entreprise),
      link(<sommaire>, context counter(page).display("1")),
      image(chemin_logo_ecole)
    )
  }
)
#context counter(page).update(1)

//----------------------------------------------------------//
//----------------------------------------------------------//
//Core of the report
#include "intro.typ"
#pagebreak()

#include "Template_tabs.typ"
#pagebreak()

#include "Template_images.typ"
#pagebreak()

#include "Template_Codly.typ"
#pagebreak()

#include "Template_text.typ"
#pagebreak()

#include "Template3.typ"
#pagebreak()
#include "Template2.typ"
#pagebreak()

#include "conclusion.typ"

#bibliography(
  "Biblio.bib",
  title: "Bibliographie",
  style : "ieee" 
)
//----------------------------------------------------------//
