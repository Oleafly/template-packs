#counter(page).update(1)
#set page(numbering: "I")

#outline(title: "Inhaltsverzeichnis")

#pagebreak()

//Verzeichnisse erst ab 3 Elementen hinzufügen!

#heading([Tabellenverzeichnis], level: 2, outlined: false)

#outline(target: figure.where(kind: table), title: none)

#heading([Abbildungsverzeichnis], level: 2, outlined: false)

#outline(target: figure.where(kind: image), title: none)

#heading([Abkürzungsverzeichnis], level: 2, outlined: false)

#table(
  columns: (auto, auto),
  stroke: none,
  column-gutter: 4cm,
  inset: 0pt,

  [Aküfi], [Abkürzungsfimmel]
)

#heading([Verzeichnis der Code Listings], level: 2, outlined: false)

#outline(target: figure.where(supplement: [Listing]), title: none)