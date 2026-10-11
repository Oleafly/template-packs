#let abstract-EN(
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

  #image("../assets/aalto_logo_EN_square.png", width: 3cm, alt: "Aalto Logo English")

  #if collabpartner != none {
    table(
      columns: (1fr, ),
      abstract-entry("Author", author),
      abstract-entry("Title", title + " " + sym.dash.em + " " + subtitle),
      abstract-entry("Degree programme", programme),
      abstract-entry("Major", major),
      abstract-entry("Supervisor", supervisor),
      abstract-entry("Advisors", advisors.join(", ")),
      abstract-entry("Yhteistyötaho", collabpartner),
      [
        #strong(text(font: accent-font)[Date])
        #text(font: main-font)[#date]
        #h(1fr)
        #strong(text(font: accent-font)[Number of pages])
        #text(font: main-font)[#pages]
        #h(1fr)
        #strong(text(font: accent-font)[Language])
        #text(font: main-font)[#language]
      ],
      abstract-entry([Abstract#parbreak()], abstract),
      abstract-entry("Keywords", keywords.join(", ")),
    )
  } else {
    table(
      columns: (1fr, ),
      abstract-entry("Author", author),
      abstract-entry("Title", title + " " + sym.dash.em + " " + subtitle),
      abstract-entry("Degree programme", programme),
      abstract-entry("Major", major),
      abstract-entry("Supervisor", supervisor),
      abstract-entry("Advisors", advisors.join(", ")),
      [
        #strong(text(font: accent-font)[Date])
        #text(font: main-font)[#date]
        #h(1fr)
        #strong(text(font: accent-font)[Number of pages])
        #text(font: main-font)[#pages]
        #h(1fr)
        #strong(text(font: accent-font)[Language])
        #text(font: main-font)[#language]
      ],
      abstract-entry([Abstract#parbreak()], abstract),
      abstract-entry("Keywords", keywords.join(", ")),
    )
  }
  #pagebreak()

  #body
]