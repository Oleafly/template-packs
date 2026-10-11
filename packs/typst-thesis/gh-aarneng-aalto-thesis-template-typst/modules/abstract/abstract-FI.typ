#let abstract-FI(
  author: none,
  title: none,
  subtitle: none,
  programme: none,
  major: none,
  supervisor: none,
  advisors: (none,),
  collabpartner: none,
  date: none,
  pages: none,
  language: none,
  abstract: none,
  keywords: (none,),
  main-font: "New Computer Modern",
  accent-font: "Arial",
  body
) = [
  
  #let abstract-entry(description, content) = table.cell[
    #strong(text(font: accent-font)[#description])
    #text(font: main-font)[#content]
  ]

  #image("../assets/aalto_logo_FI_square.png", width: 3cm, alt: "Aalto Logo Finnish")
  
  #if collabpartner != none {
    table(
      columns: (1fr, ),
      abstract-entry("Tekijä", author),
      abstract-entry("Työn nimi", title + " " + sym.dash.em + " " + subtitle),
      abstract-entry("Koulutusohjelma", programme),
      abstract-entry("Pääaine", major),
      abstract-entry("Työn valvoja", supervisor),
      abstract-entry("Työn ohjaajat", advisors.join(", ")),
      abstract-entry("Yhteistyötaho", collabpartner),
      [
        #strong(text(font: accent-font)[Päivämäärä])
        #text(font: main-font)[#date]
        #h(1fr)
        #strong(text(font: accent-font)[Sivumäärä])
        #text(font: main-font)[#pages]
        #h(1fr)
        #strong(text(font: accent-font)[Kieli])
        #text(font: main-font)[#language]
      ],
      abstract-entry([Tiivistelmä#parbreak()], abstract),
      abstract-entry("Avainsanat", keywords.join(", ")),
    )
  } else {
    table(
      columns: (1fr, ),
      abstract-entry("Tekijä", author),
      abstract-entry("Työn nimi", title + " " + sym.dash.em + " " + subtitle),
      abstract-entry("Koulutusohjelma", programme),
      abstract-entry("Pääaine", major),
      abstract-entry("Työn valvoja", supervisor),
      abstract-entry("Työn ohjaajat", advisors.join(", ")),
      [
        #strong(text(font: accent-font)[Päivämäärä])
        #text(font: main-font)[#date]
        #h(1fr)
        #strong(text(font: accent-font)[Sivumäärä])
        #text(font: main-font)[#pages]
        #h(1fr)
        #strong(text(font: accent-font)[Kieli])
        #text(font: main-font)[#language]
      ],
      abstract-entry([Tiivistelmä#parbreak()], abstract),
      abstract-entry("Avainsanat", keywords.join(", ")),
    )
  }
  #pagebreak()

  #body
]
