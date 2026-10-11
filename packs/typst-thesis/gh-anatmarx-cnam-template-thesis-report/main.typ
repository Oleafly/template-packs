#import "masters_thesis_template.typ": *
#import "masters_report_template.typ": *

#let localization = json("resources/i18n/fr.json")

#show: masters-thesis-template.with(
  title: [Exemple de rapport d'ingénieur du CNAM démontrant ce que l'on peut obtenir avec ce modèle
],
  author: ("Prénom NOM",),
  defended-on: "dd/mm/aaa",
  jury-director:("Monsieur/Madame ..."),
  maitre-app:"Monsieur/Madame ...",
  tuteur:"Monsieur/Madame ...",
  rapporteur:"Monsieur/Madame ...",
  jury: (
         "Monsieur/Madame ...",
         "Monsieur/Madame ...",
         "Monsieur/Madame ...",
         "Monsieur/Madame ...",
         ),
  lang: "fr"
)

// #show: masters-report-template.with(
//   title: [Exemple de rapport d'ingénieur du CNAM démontrant ce que l'on peut obtenir avec ce modèle
// ],
//   author: ("Prénom NOM",),
//   defended-on: "dd/mm/aaa",
//   jury: (
//          "Monsieur/Madame ...",
//          "Monsieur/Madame ...",
//          "Monsieur/Madame ...",
//          "Monsieur/Madame ...",
//          ),
//   lang: "fr"
// )

// Petite règle pour afficher joliment le nom de l'entreprise
//#show "Entreprise": name => [#smallcaps(strong("Entreprise"))]

#show link: underline

// Remerciements
#heading(numbering:none, level: 1)[Remerciements]
#include "chapters/thanks.typ"
#pagebreak()

// Abbréviations
#heading(numbering:none, level: 1)[Abbréviations]
#include("chapters/abbreviations.typ")
#pagebreak()

// Glossaire
#heading(numbering:none, level: 1)[Glossaire]
#include("chapters/glossary.typ")
#pagebreak()

// Table des matières
#show outline.where(label:<toc>): it => {
  show outline.entry.where(level: 1): set text(weight: "bold")
//   show outline.entry.where(
//   level: 2
// ): set block(above: 1.5em)
  show outline.entry.where(level: 2): set text(style: "normal")
  show outline.entry.where(level: 3): set text(style: "italic")
  it
}

#context if query(<appendix-exists>).len() == 0 { 
  [#outline(title: localization.toc,
depth: 4)<toc>] } else {
    [#outline(title: localization.toc,
target: selector(heading).before(locate(<appendix-exists>)),
depth: 4)<toc>]
  }
// #outline(title: localization.toc,
// depth: 3)
#show outline: set heading(outlined: true)
#pagebreak()


//
// Corps du texte
// 
#set par(first-line-indent: 2em) // Alinéas



// Introduction
#include("chapters/introduction.typ")
#pagebreak()

// Partie 1
#include "chapters/part1.typ"
#pagebreak(weak: true)

// Partie 2
#include "chapters/part2.typ"
#pagebreak(weak: true)

// Partie 3
#include "chapters/part3.typ"
#pagebreak(weak: true)

// Conclusion
#include "chapters/conclusion.typ"
#pagebreak(weak: true)
#pagebreak()

#outline(title: "Liste des figures", target: figure.where(kind: image)) 
#pagebreak()

// Liste des tableaux
#outline(title: "Liste des tableaux", target: figure.where(kind: table)) 
#pagebreak()

// Bibliographie
#bibliography("doc/full.bib")
#pagebreak()

// Annexes
#outline(title: "Table des annexes",
  target:heading.where(supplement: [Annexe]))<outline_appendix>
#show: appendix
#pagebreak()
#include "chapters/appendix.typ"

// Résumés
#pagebreak()
#include "chapters/summary thesis.typ"
// #include "chapters/summary report.typ"