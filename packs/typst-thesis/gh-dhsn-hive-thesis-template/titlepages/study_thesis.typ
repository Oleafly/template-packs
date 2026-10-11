#set align(center)
#set text(font: "New Computer Modern Sans")

Duale Hochschule Sachsen

Staatliche Studienakademie Leipzig

#v(2cm)

#text(size: 16pt, weight: "bold")[{Titel der Arbeit}]

Studienarbeit

im Studiengang {Studiengang}

{Modulbezeichnung}

#v(1cm)

#set align(left)

#table(
  columns: (auto, 1fr),
  stroke: none,
  column-gutter: 1.5cm,
  [Eingereicht von:],
  [
    {Vorname Name}

    {Anschrift}

    {Seminargruppe}

    {Matrikelnummer}
  ]
)

#v(10cm)
#align(left)[
    Leipzig, den #datetime.today().display(
  "[day].[month].[year]"
)
    ]

#pagebreak()