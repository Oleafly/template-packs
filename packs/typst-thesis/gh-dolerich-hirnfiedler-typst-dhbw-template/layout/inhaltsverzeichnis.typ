#let toc() = {
  counter(page).update(1)
  set page(numbering: "i")
  outline(indent: auto, title: [Inhaltsverzeichniss], depth: 3)
  pagebreak()
  outline(indent: auto, title:[Abbildungsverzeichniss], target: figure.where(kind: image))
  pagebreak()
  outline(indent: auto, title:[Tabellenverzeichniss],target: figure.where(kind: table))
}
