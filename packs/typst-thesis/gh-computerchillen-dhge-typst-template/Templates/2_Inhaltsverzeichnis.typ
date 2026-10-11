#import "/Daten.typ": Font

#let inhaltsverzeichnis() = {
  set text(size: 12pt, font: Font)
  outline(
    title: "Inhaltsverzeichnis",
    depth: 2,
    indent: 2em,
  )
}