#import "/Daten.typ": Font

#let anhangsverzeichnis() = {
  set text(size: 11pt, font: Font)
  outline(
    title: none,
    target: figure.where(kind: "Anhang"),
  )
}