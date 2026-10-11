#let directories(meta) = {

  set page(
    numbering: "I",
    footer: none,
    header: context {
      [
        #h(1fr)
        #if meta.secret == true{
          if here().page() > 3 [
            #counter(page).display()
          ]
        } else {
          if here().page() > 2 [
            #counter(page).display()
          ]
        }
      ]
    },
  )

  set text(font: "Arial")
  show outline.entry: set text(size: 11pt)

  outline(
    title: "Inhaltsverzeichnis",
    depth: 3,
  )
  pagebreak()

  [= Abkürzungsverzeichnis]
  table(
    columns: (1fr, 2fr),
    inset: 10pt,
    stroke: none,
  [abk.], [Abkürzung],
  )
  pagebreak()

  [= Abbildungsverzeichnis]
  outline(
    title: none,
    target: figure.where(kind: image),
  )

  pagebreak()

  [= Tabellenverzeichnis]
  outline(
    title: none,
    target: figure.where(kind: table),
  )

  pagebreak()

  counter(page).update(1)
  set page(numbering: "1")
}