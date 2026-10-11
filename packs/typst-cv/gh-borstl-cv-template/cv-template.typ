#let lightblue = color.rgb("#609CD8")
#let darkblue = color.rgb("#17366E")
#let tealblue = color.rgb("#00688C")

#let jobPar(company, jobTitle, timerange, body) = [
  #text(12pt, fill: tealblue, weight: "bold")[#company]
  #text(10pt)[ #timerange]
  #linebreak()
  #text(10pt)[*#jobTitle*]
  #linebreak()
  #body
]

#set page(margin: 2cm, footer: align(center)[])
#set text(font: "SF Pro Text")
#set line(stroke: lightblue + 0.2em)

#let name = align(center, text(22pt, fill: lightblue)[
  *Name Surname*
])

#let picture = image(
  "github-mark.svg",
  height: 10em,
  width: 10em,
  fit: "cover",
  alt: "A profile picture of myself",
)

#let description = align(left, par(
  justify: true,
  [
    #lorem(35)
    #linebreak()
    *Aktuell*: Doing a lot of important stuff
  ],
))

#let impressum = align(left, stack(
  spacing: 1em,
  text("􀍕 mail@mail.com"),
  text("􀌾 +12 3456 7890"),
  text("􀎫 City"),
  text("􁖩 01.01.1970"),
  text(fill: tealblue)[
    􀉩
    #link("https://linkedin.com/in/???")[linkedin] |
    􀙗
    #link("https://github.com/???")[github]
  ],
))


#block(
  inset: 1em,
  stroke: 2pt + darkblue,
  radius: 2em,
  align(
    center + horizon,
    grid(
      columns: (60%, 30%),
      rows: 2,
      gutter: 2em,
      box(
        width: 100%,
        inset: 3em,
        radius: 5em,
        fill: tealblue,
        name,
      ),
      box(
        clip: true,
        radius: 5em,
        stroke: 5pt + gradient.linear(tealblue, darkblue),
        picture,
      ),

      box(
        width: 100%,
        description,
      ),
      box(
        width: 100%,
        impressum,
      ),
    ),
  ),
)

== Erfahrungen
#line(length: 18%)
#jobPar(
  "Company 1",
  "Working Student – Technician",
  "Month 2024 – Heute",
  list(
    [#lorem(10)],
    [#lorem(9)],
  ),
)
#jobPar(
  "Company 2",
  "Praktikum - Development",
  "Month 2024 - Month 2024",
  list(
    [#lorem(10)],
    [#lorem(4)],
  ),
)
#jobPar(
  "Company 3",
  "Working Student – Full-Stack Development",
  "Month 2019 – Month 2023",
  [
    #text(10pt)[*#lorem(5)*]
    #list(
      [#lorem(10)],
      [#lorem(7)],
      [#lorem(12)],
      [#lorem(10)],
      [#lorem(10)],
    )
    #text(10pt)[*#lorem(7)*]
    #list(
      [#lorem(8)],
      [#lorem(9)],
      [#lorem(10)],
      [#lorem(11)],
    )
  ],
)
#jobPar(
  "Company 4",
  "Ausbildung - Elektroniker",
  "Month 2014 - Month 2018",
  [
    #list(
      [#lorem(5)],
      [#lorem(2)],
      [#lorem(1)],
    )
    #text(10pt)[*Anstellung - Sachbearbeiter Metering*]
    #list(
      [#lorem(6)],
    )
  ],
)
#pagebreak()
== Bildung
#line(length: 12%)

#jobPar(
  "Universität für wichtigen Kram",
  "Bachelor of Science, Informatik",
  "2019 - Heute",
  text()[
    #text(10pt)[*Algorithmen und Datenstrukturen*]
    #list([Graphs, Trees, Sorting, Hash, Stack])
    #text(10pt)[*Machine Learning*]
    #list[MLX, Embedded ML, Image Recognition, Regression]
    #text(10pt)[*Software Engineering*]
    #list[MVC, REST, Software Design Pattern]
    #text(10pt)[*Verteilte Systeme*]
    #list[Middleware, Routing, Protocol Design, TCP/IP]
    #text(10pt)[*IT Sicherheit*]
    #list[TLS, Certificates, Cryptography, Authentication, Authorization]
    #text(10pt)[*Bachelorthesis*]
    #list(
      lorem(16),
    )
  ],
)
#line(length: 100%, stroke: darkblue + 0.2em)

== Fertigkeiten
#line(length: 18%)

#table(
  columns: 2,
  stroke: none,
  text()[*Mobile Development*:],
  text()[Swift, SwiftUI, UIKit, Foundation, Kotlin],

  text()[*Frontend*:], text()[React, Vue, JavaScript, HTML, CSS],
  text()[*Backend*:],
  text()[PHP, Symfony, MySQL, PostgreSQL, OAuth, SAML, Docker],

  text()[*Weitere*:],
  text()[Git, Bash, JWT, Xcode, Neovim, MQTT, Arduino, Python, MLX],
)

#grid(
  columns: (50%, 50%),
  gutter: 2em,
  grid.cell()[
    == Technische Interessen
    #line(length: 64%)
    #box(width: 95%)[
      #stack(
        spacing: 1em,
        [#lorem(4)],
        [#lorem(3)],
        [#lorem(2)],
        [#lorem(1)],
      )
    ]
  ],
  grid.cell()[
    == Persönliche Interessen
    #line(length: 64%)
    #stack(
      spacing: 1em,
      [#lorem(3)],
      [#lorem(2)],
      [#lorem(1)],
      [#lorem(1)],
    )
  ],
  grid.cell()[
    == Sprachen
    #line(length: 6em)
    #stack(
      spacing: 1em,
      "Deutsch: Muttersprache",
      "Englisch: Verhandlungssicher",
    )
  ],
)
