#import "@preview/acrostiche:0.7.0": init-acronyms, print-index

#import "meta.typ": acronyms, meta
#import "cover.typ": *
#import "layout.typ": layout

#let template(
  body,
  appendix: none,
  bib: none,
) = {
  // === Deckblatt
  cover()

  // === Layout -> Seitengestaltung
  show: layout

  // Abkürzungen
  init-acronyms(acronyms)

  include "abstract.typ"

  // === Verzeichnisse
  set page(numbering: "I")

  // Inhaltsverzeichnis
  outline(title: "Inhaltsverzeichnis")
  pagebreak()

  // Abkürzungsverzeichnis
  print-index(delimiter: "", title: "Abkürzungsverzeichnis", clickable: true, outlined: true, used-only: true)
  pagebreak()

  // Abbildungsverzeichnis
  heading(numbering: none)[Abbildungsverzeichnis]
  outline(
    title: none,
    target: figure.where(kind: image),
  )
  pagebreak()

  // Tabellenverzeichnis
  heading(numbering: none)[Tabellenverzeichnis]
  outline(
    title: none,
    target: figure.where(kind: table),
  )
  pagebreak()

  // === Inhalt
  set page(numbering: "1")
  counter(page).update(1)

  body

  // Cite
  if bib != none {
    pagebreak()
    bib
  }

  // === Anhang
  if appendix != none {
    pagebreak()

    set heading(numbering: "A.1", supplement: [Anhang])
    counter(heading).update(0)

    appendix
  }
}
