#import "/Daten.typ": Font

#let abbildungsverzeichnis() = {
  set text(size: 11pt, font: Font)
  outline(
    title: none,
    target: figure.where(kind: image),
  )
}