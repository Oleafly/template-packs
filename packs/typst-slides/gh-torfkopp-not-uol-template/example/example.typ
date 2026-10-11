#import "@preview/touying:0.6.1": *
#import "../uol.typ": *

#set text(font: "Arial")

#show: uol-theme.with(
  aspect-ratio: "16-9",
  config-info(
    title: [Titel der Präsentation \ Arial Regular 44 pt],
    short-title: [Titel der Präsentation],
    subtitle: [Untertitel der Präsentation \ Arial Regular, 24 pt],
    short-subtitle: [Untertitel der Präsentation],
    author: [Name des Autors],
    date: datetime.today(),
    institution: [Universität Oldenburg],
  ),
  config-page(
    // header: none,
    margin: (left: 7em, top: 6em, right: 2em),
    header-ascent: 40%,
  )
)


#title-slide()

= First Section
#lorem(20)

== First Slide

A slide with a title and an *important* information.

== Überschrift
- Aufzählung Standard
  - Aufzählung Ebene 2, zweizeilig \
    Aufzählung Ebene 2
      - Aufzählung Ebene 3
      - ...
  - ...
- Aufzählung Standard
- #text(size: 24pt, [Aufzählung Vergrößert \ zweizeilig])

== Überschrift

#lorem(40)
#v(-1em)
#align(center)[
  #set text(fill: blue2, size: 24pt)
#curve(
  stroke: 2pt +blue2,
  curve.move((0pt, 0pt)),
  curve.line((50pt, 20pt)),
  curve.line((100pt, 0pt))
)
#v(-0.5em)
Dies ist der Blindtext einer \ farbigen Hervorhebung, wie zum Beispiel \ eine Zusammenfassung
]

== Überschrift

#columns(2)[
  #[
    Fließtext, 2-Spaltig. Nam dui ligula, fringilla
a, euismod sodales, sollicitudin vel, wisi.
Morbi auctor lorem non justo. Nam lacus
libero, pretium at, lobortis vitae, ultricies et,
tellus. 

=== Eine Zwischenüberschrift

Nam dui ligula, fringilla a, euismod sodales,
sollicitudin vel, wisi. Morbi auctor lorem non
justo. Nam lacus libero, pretium at, lobortis
vitae, ultricies et, tellus. Donec aliquet,
tortor sed accumsan bibendum, erat ligula
aliquet magna, vitae ornare odio metus a
mi. *Eine Hervorhebung.* Morbi ac orci et
nisl hendrerit mollis. Suspendisse ut massa.
Cras nec ante. Pellentesque a nulla. Cum
sociis natoque penatibus et magnis dis
parturient montes.
  ]
]

== Überschrift

#columns(2)[
  #[
    Nam dui ligula, fringilla a, euismod sodales,
    sollicitudin vel, wisi. Morbi auctor lorem non
    justo. Nam lacus libero, pretium at, lobortis
    vitae, ultricies et, tellus. Donec aliquet,
    tortor sed accumsan bibendum, erat ligula
    aliquet magna, vitae ornare odio metus a
    mi. Morbi ac orci et nisl hendrerit mollis.
    Suspendisse ut massa.
  ]
  #colbreak()
  #block(fill: black, outset: 10pt)[
    #image("../util/UOL_Logo_Negativ.png", width: 100%)
  ]
]

#slide(skip-header: true)[
  #table(
    table.cell(colspan: 3)[*Überschrift einer Tabelle*],
    stroke: (x, y) => if y == 0{
        (bottom: 0.9pt + blue3)
        (top: 0.9pt + blue3)
      } else if y == 4 {
        (bottom: 0.9pt + blue3)
      },
    row-gutter: 0.5em,
    columns: (1fr, auto, auto),
    [Zeile einer Tabelle], [00 AB], [Lorem Ipsum],
    [Zeile einer Tabelle], [00 AB], [Lorem Ipsum],
    [Zeile einer Tabelle], [00 AB], [Lorem Ipsum],
    [Zeile einer Tabelle], [00 AB], [Lorem Ipsum],
  )

  #block(width: 60%)[
    #table(
      table.cell(colspan: 3)[*Überschrift einer Tabelle*],
      stroke: (x, y) => if y == 0{
        (bottom: 0.9pt + blue3)
        (top: 0.9pt + blue3)
      } else if y == 4 {
        (bottom: 0.9pt + blue3)
      },
      row-gutter: 0.5em,
      columns: (1fr, auto, auto),
      [Zeile einer Tabelle], [00 AB], [Lorem Ipsum],
      [Zeile einer Tabelle], [00 AB], [Lorem Ipsum],
      [Zeile einer Tabelle], [00 AB], [Lorem Ipsum],
      [Zeile einer Tabelle], [00 AB], [Lorem Ipsum],
    )
  ]
]

#slide(skip-header: true)[
  #stack(
    dir: ltr,
    spacing: 1em,
    block(fill: blue2, outset: 6pt)[#align(center)[#text(fill:white)[Beispiel für \ zentrierten Blindtext \ auf einem \ farbigen Infokasten]]],
    block(fill: white, stroke: 2pt+ blue1, outset: 6pt)[#align(left)[#text(fill:blue1)[Beispiel für links- \ bündigen Blindtext \ auf einem Outline- \ Infokasten]]],
    block(width: 45%)[
      #grid(columns: 2, rows: 6, gutter: 1em,
          line(length: 100%, stroke: 6pt + blue2), line(length: 100%, stroke: 6pt + uolblue), 
          line(length: 100%, stroke: 5pt + blue2), line(length: 100%, stroke: 5pt + uolblue), 
          line(length: 100%, stroke: 4pt + blue2), line(length: 100%, stroke: 4pt + uolblue),
          line(length: 100%, stroke: 3pt + blue2), line(length: 100%, stroke: 3pt + uolblue), 
          line(length: 100%, stroke: 2pt + blue2), line(length: 100%, stroke: 2pt + uolblue), 
          line(length: 100%, stroke: 1pt + blue2), line(length: 100%, stroke: 1pt + uolblue)
        )
    ]
  )
  #stack(
    dir: ltr,
    spacing: -2.5em,
    polygon(
      fill: blue2,
      (0%, 0%),
      (20%, 0cm),
      (30%, 2em),
      (20%, 4em),
      (0%, 4em),
      (10%, 2em),
    ),
    polygon(
      fill: blue2,
      (0%, 0%),
      (20%, 0cm),
      (30%, 2em),
      (20%, 4em),
      (0%, 4em),
      (10%, 2em),
    ),
    polygon(
      fill: blue2,
      (0%, 0%),
      (20%, 0cm),
      (30%, 2em),
      (20%, 4em),
      (0%, 4em),
      (10%, 2em),
    ),
    polygon(
      fill: blue2,
      (0%, 0%),
      (20%, 0cm),
      (30%, 2em),
      (20%, 4em),
      (0%, 4em),
      (10%, 2em),
    ),
  )
  #v(-3.5em)
  #stack(
    dir: ltr,
    spacing: 7em,
    h(5em),
    text(fill: white)[1],  text(fill: white)[2],  text(fill: white)[3],  text(fill: white)[4]
  )
  \
  Keine Verläufe \
  Keine farbigen Schriften auf farbigen Flächen \
  Keine Schrift auf Bildern \
  Grundsätzliches Farbklima: Blau
]

== Farben

#columns(2)[
  #[
    === Primärfarben
    UOL Blau

    #box(fill: uolblue, width: 16.8em, height: 4em)

    Farbgruppe Blau
    #stack(
      dir: ltr,
      spacing: 0.2em,
      box(fill: blue1, width: 4em, height: 4em), box(fill: blue2, width: 4em, height: 4em), box(fill: blue3, width: 4em, height: 4em), box(fill: blue4, width: 4em, height: 4em)
    )
  ]
  #colbreak()
  #[
    === Sekundärfarben
    Farbgruppe Grün
    #stack(
      dir: ltr,
      spacing: 0.2em,
      box(fill: green1, width: 4em, height: 4em), box(fill: green2, width: 4em, height: 4em), box(fill: green3, width: 4em, height: 4em), box(fill: green4, width: 4em, height: 4em)
    )
    Farbgruppe Orange
    #stack(
      dir: ltr,
      spacing: 0.2em,
      box(fill: orange1, width: 4em, height: 4em), box(fill: orange2, width: 4em, height: 4em), box(fill: orange3, width: 4em, height: 4em), box(fill: orange4, width: 4em, height: 4em)
    )
  ]
]

#focus-slide("ATTENTION")
