#import "/Daten.typ": Font

#let tabellenverzeichnis() = {
  set text(size: 11pt, font: Font)
  outline(
    title: none,
    target: figure.where(kind: table),
    fill: box(width: 1fr, repeat[#text(" . ", spacing: 2pt)]),
  )
}