#import "scripts/lib.typ": SVS-thesis
#import "scripts/utils.typ": import-pdf


#let jury-content = [
  #text(size: 1.3em)[*Rapporteurs avant soutenance :*]
  #v(-1em)
  #table(
    columns: 2,
    column-gutter: 1.5em,
    stroke: 0pt,
    inset: (x: 0pt, y: .2em),
    "Prénom Nom", "Fonction — établissement d’exercice",
    "Prénom Nom", "Fonction — établissement d’exercice",
  )

  #text(size: 1.3em)[*Composition du jury :*]
  #v(-1em)
  #table(
    columns: 3,
    
    column-gutter: 2em,
    stroke: 0pt,
    inset: (x: 0pt, y: .2em),
    "Président :", "Prénom Nom", "Fonction — établissement d’exercice",
    "Examinateurs :", "Prénom Nom", "Fonction — établissement d’exercice",
    "", "Prénom Nom", "Fonction — établissement d’exercice",
    "Dir. de thèse :", "Prénom Nom", "Fonction — établissement d’exercice",
    "Co-dir. de thèse :", "Prénom Nom", "Fonction — établissement d’exercice",
  )

  //#text(size: 1.3em)[*Invité(s) :*]
  #v(-1em)
  #table(
    columns: 2,
    column-gutter: 1.5em,
    stroke: 0pt,
    inset: (x: 0pt, y: .2em),
    //"Jean-René", "Au chômage",
  )
]

#show: SVS-thesis.with(
  author: "Prénom Nom",
  affiliation: "établissement d’exercice",
  jury-content: jury-content,
  acknowledgements: [
  ],
  defense-place: "Ville",
  defense-date: " DATE ",
  draft: false,
  title: "Titre",
  subtitle: "Thèse n°",
  // french info
  title-fr:"Titre - Français",
  keywords-fr: lorem(12),
  abstract-fr: lorem(80),
  // english info
  title-en: "Title - English",
  keywords-en: lorem(12),
  abstract-en: lorem(60),
)


//producing an empty page before starting a new level 1 heading
#let headings-on-odd-page(it) = {
  show heading.where(level: 1): it => {
    {
      set page(header: none, numbering: none)
      pagebreak(to: "odd")
    }
    it
  }
  it
}

#show: headings-on-odd-page

#set text(
  font: "DejaVu Sans",
  lang: "fr"
)

// Remerciements avant la table des matières
#heading(numbering: none, outlined: false)[Remerciements]

#lorem(200)


// table of contents
#outline(indent: auto)



// Begining of the doc
= Liste des abréviations

= Liste des illustrations
#outline(title: "Liste des figures", target: figure.where(kind: image))
#outline(title: "Liste des tableaux", target: figure.where(kind: table))

= Préambule
#lorem(200)
= Introduction
== Première partie
=== Première sous partie
#lorem(100)
#figure(
  image("figures/lab.jpg", width: 80%),
  caption: [
    A step in the molecular testing
    pipeline of our lab.
  ],
)<lab>

=== Deuxième sous partie
#lorem(100)

#figure(
  table(
    columns: 4,
    [t], [1], [2], [3],
    [y], [0.3s], [0.4s], [0.8s],
  ),
  caption: [Timing results],
)
== Deuxième partie
#lorem(200)
=== Première sous partie
#lorem(200)
=== Deuxième sous partie
#lorem(200)
= Hypothèse de travail et objectifs
= Résultats
== Papier publié
#import-pdf("../publications/shortest_paper.pdf")
= Discussion et perspectives
= Conclusion
= Bibliographie
= Annexes