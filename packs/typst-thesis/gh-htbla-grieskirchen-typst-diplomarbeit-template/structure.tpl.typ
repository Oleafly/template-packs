#import "style.tpl.typ": *

#let cover-page(
  fachrichtung,
  schuljahr,
  class,
  authors,
  betreuer-name,
) = context [
  #show: base-style
  #set par(leading: 0.5em, spacing: 0.5em, justify: false)
  #set align(center)
  #set page(
    footer: [
      #set align(left)
      #line(length: 100%)
      Abgabevermerk:\
      #grid(
        columns: (1fr, 1fr),
        gutter: 1cm,
        [Datum:], [Betreuer:],
      )
    ],
    footer-descent: 0cm,
  )

  #box(image("assets/htl-gkr-logo.png", height: 1.25cm))
  #h(1fr)
  #box[
    #text(size: 1.5em, weight: "bold")[HTBLA Grieskirchen]

    4710 Grieskirchen, Parzer Schulstraße 1
  ]
  #h(1fr)
  #box(image("assets/htl-bildung-logo.png", height: 1.25cm))
  #line(length: 100%)

  #v(1cm)
  #set text(weight: "bold")
  Fachrichtung #fachrichtung

  #v(2cm)
  Schuljahr #schuljahr

  #v(3cm)
  #text(size: 30pt)[DIPLOMARBEIT]
  #v(1cm)
  #text(weight: "regular")[Gesamtprojekt]
  #v(1cm)
  #show title: set text(size: 36pt, hyphenate: false)
  #title(auto)

  #v(1cm)
  #set par(spacing: 1.5em)
  #set align(left)
  #set text(weight: "regular")
  #grid(
    columns: (1fr, 1fr),
    gutter: 1cm,
    [
      *Ausgeführt von:*

      #authors.map(author => [#author.name, #class\-#author.catalognumber]).join([#parbreak()])
    ],
    [
      *Betreuer:*

      #betreuer-name
    ],
  )


  #v(1cm)
  #let date = if type(document.date) == datetime {
    document.date
  } else {
    datetime.today(offset: auto)
  }
  Grieskirchen, am #date.display("[day].[month].[year]")
]

#let front-matter = [
  #show: additional-sections-style

  = Inhaltsverzeichnis
  #outline(depth: 3, title: none)
]

#let back-matter(authors: ()) = context [
  #show: additional-sections-style

  = Anhang A

  Der als Anhang A beigelegte USB-Stick zum Thema #text(style: "italic")["#document.title"] enthält folgende Inhalte:
  - Projektantrag
  - Software
  - Dokumentation der Diplomarbeit (dieses Dokument)
  - Protokolle
  - Lasten- und Pflichtenheft

  = Anhang B

  Die Erstellung der im Dokument vorhandenen Kapitel und Unterkapitel verteilt sich laut unten angeführter Aufstellung:

  #table(
    columns: (auto, 1fr),
    align: (left, left),
    table.header[Verfasserin/Verfasser][Kapitel],
    ..authors
      .map(author => (
        [#author.name],
        if type(author.written-chapters) == array {
          author.written-chapters.join(", ")
        } else {
          author.written-chapters
        },
      ))
      .flatten(),
  )
]

#let diplomarbeit-structure(fachrichtung: "", schuljahr: "", class: "", authors: (), betreuer-name: "", doc) = context {
  cover-page(fachrichtung, schuljahr, class, authors, betreuer-name)

  doc
}
