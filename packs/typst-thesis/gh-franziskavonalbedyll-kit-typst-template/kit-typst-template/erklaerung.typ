#let erklaerung(author, declaration-date, format-date) = [
  *Erklärung*

  #v(1em)

  Ich versichere hiermit, dass ich die Arbeit selbstständig verfasst habe, keine anderen als die angegebenen Quellen und Hilfsmittel benutzt habe, die wörtlich oder inhaltlich übernommenen Stellen als solche kenntlich gemacht habe und die Satzung des Karlsruher Instituts für Technologie zur Sicherung guter wissenschaftlicher Praxis beachtet zu haben.

  #v(2em)

  Karlsruhe, den #format-date(declaration-date, language: "de")
  #v(1cm)
  #align(right)[
    #box(width: 7cm)[
        #line(length: 70%, stroke: rgb("#3c3d3c"))
        #author
      ]
    ]
]
