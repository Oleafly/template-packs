#let declaration(title: "Erklärung", layoutConfig: none, author, location, submissionDate) = {
  show: layoutConfig

  heading(numbering: none, outlined: false, bookmarked: true, title)

  v(1em)

  text()[
    Ich versichere hiermit, dass ich die vorliegende Arbeit selbstständig verfasst und keine anderen als die im Literaturverzeichnis angegebenen Quellen benutzt habe. \
    #v(0.1em)
    Alle Stellen, die wörtlich oder sinngemäß aus veröffentlichten oder noch nicht veröffentlichten Quellen entnommen sind, sind als solche kenntlich gemacht. \
    #v(0.1em)
    Die Zeichnungen oder Abbildungen in dieser Arbeit sind von mir selbst erstellt worden oder mit einem entsprechenden Quellennachweis versehen. \
    #v(0.1em)
    Diese Arbeit ist in gleicher oder ähnlicher Form noch bei keiner anderen Prüfungsbehörde eingereicht worden. \
  ]

  v(5mm)

  grid(
      columns: (2fr, 1fr, 2fr),
      rows: (50pt, 10pt, 15pt),
      align(left, text(style: "italic", location + ", " + submissionDate)), "", align(bottom, align(center, image("../figures/signature.png", height: 60%))),
      "", "", line(length: 140pt),
      "", "", align(center, author)
  )
}
