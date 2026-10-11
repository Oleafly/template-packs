#import "lib/ulaval-thesis.typ": *

// Replace these values once; the template uses them throughout the document.
#show: thesis.with(
  title: "Titre de la thèse",
  subtitle: none,
  author: "Prénom Nom",
  document-type: "Thèse",
  supervisor: "Prénom Nom, directrice ou directeur de recherche",
  co-supervisors: (),
  language: "fr",
)

#front-matter[
  #part("Résumé")[
    #include "front-matter/resume.typ"
  ]

  #part("Abstract")[
    #include "front-matter/abstract.typ"
  ]

  #contents-list()

  #part("Liste des figures, tableaux, illustration")[
    #include "front-matter/media-lists.typ"
  ]

  #part("Listes des abréviations, sigles, acronymes")[
    #include "front-matter/abbreviations.typ"
  ]

  #dedication[< Texte de la dédicace. Optionnel >]

  #epigraph-page[< Texte de l’épigraphe. Optionnel >]

  #part("Remerciements")[
    #include "front-matter/acknowledgements.typ"
  ]

  #part("Avant-propos")[
    #include "front-matter/foreword.typ"
  ]
]

#main-matter[
  #part("Introduction")[
    #include "chapters/introduction.typ"
  ]

  #include "chapters/article-1.typ"

  #part("Conclusion")[
    #include "chapters/conclusion.typ"
  ]

  #bibliography(
    "references/references.bib",
    title: "Bibliographie",
    style: "apa",
    full: true,
  )

  #appendices[
    #include "appendices/appendix-a.typ"
  ]
]
