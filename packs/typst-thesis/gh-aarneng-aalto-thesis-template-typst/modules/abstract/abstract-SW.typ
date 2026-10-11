#let abstract-SW(
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
  
  #image("../assets/aalto_logo_SW_square.png", width: 3cm, alt: "Aalto Logo Swedish")

  #if collabpartner != none {
    table(
      columns: (1fr, ),
      abstract-entry("Författare", author),
      abstract-entry("Titel", title +" " + sym.dash.em + " "+ subtitle),
      abstract-entry("Utbildningsprogram", programme),
      abstract-entry("Huvudämne", major),
      abstract-entry("Övervakare", supervisor),
      abstract-entry("Handledare", advisors.join(", ")),
      abstract-entry("Samarbetspartner", collabpartner),
      [
        #strong(text(font: accent-font)[Datum])
        #text(font: main-font)[#date]
        #h(1fr)
        #strong(text(font: accent-font)[Antal sidor])
        #text(font: main-font)[#pages]
        #h(1fr)
        #strong(text(font: accent-font)[Språk])
        #text(font: main-font)[#language]
      ],
      abstract-entry([Sammandrag#parbreak()], abstract),
      abstract-entry("Nyckelord", keywords.join(", ")),
    )
  } else {
    table(
      columns: (1fr, ),
      abstract-entry("Författare", author),
      abstract-entry("Titel", title +" " + sym.dash.em + " "+ subtitle),
      abstract-entry("Utbildningsprogram", programme),
      abstract-entry("Huvudämne", major),
      abstract-entry("Övervakare", supervisor),
      abstract-entry("Handledare", advisors.join(", ")),
      [
        #strong(text(font: accent-font)[Datum])
        #text(font: main-font)[#date]
        #h(1fr)
        #strong(text(font: accent-font)[Antal sidor])
        #text(font: main-font)[#pages]
        #h(1fr)
        #strong(text(font: accent-font)[Språk])
        #text(font: main-font)[#language]
      ],
      abstract-entry([Sammandrag#parbreak()], abstract),
      abstract-entry("Nyckelord", keywords.join(", ")),
    )
  }

  #pagebreak()

  #body
]
