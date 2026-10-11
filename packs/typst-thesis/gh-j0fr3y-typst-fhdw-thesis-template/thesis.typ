#import "template.typ": cover-page, frontmatter-title, value

#let meta = yaml("metadata.yaml")
#let bibliography-path = value(meta, "bibliography", default: "references.bib")
#let keywords = value(meta, "keywords", default: ())
#let language-tag = value(meta, "lang", default: "de-DE")
#let document-lang = if language-tag == "de" or language-tag == "de-DE" { "de" } else { "en" }

#set document(
  title: value(meta, "title", default: "Titel der Arbeit"),
  author: (value(meta, "author", default: "Max Mustermann"),),
  keywords: keywords,
)

#set text(
  lang: document-lang,
  size: 12pt,
)

#set par(
  justify: true,
  leading: 0.75em,
)

#set page(
  paper: "a4",
  margin: (
    top: 3cm,
    bottom: 2.5cm,
    left: 2.5cm,
    right: 2.5cm,
  ),
  footer: context align(center)[#counter(page).display()],
)

#set heading(numbering: "1.")
#set figure(numbering: "1")
#show raw.where(block: true): set block(
  fill: luma(245),
  inset: 10pt,
  radius: 4pt,
)

#cover-page(meta)

#set page(numbering: "i")
#counter(page).update(1)

#frontmatter-title([Abstract])
#include "front-matter/abstract.typ"
#pagebreak()

#if value(meta, "toc", default: true) [
  #outline(title: [Inhaltsverzeichnis], depth: 3)
  #pagebreak()
]

#if value(meta, "lof", default: true) [
  #outline(
    title: [Abbildungsverzeichnis],
    target: figure.where(kind: image),
  )
  #pagebreak()
]

#if value(meta, "lot", default: true) [
  #outline(
    title: [Tabellenverzeichnis],
    target: figure.where(kind: table),
  )
  #pagebreak()
]

#set page(numbering: "1")
#counter(page).update(1)

#include "chapters/01-einleitung.typ"
#include "chapters/02-grundlagen.typ"
#include "chapters/03-methodik.typ"
#include "chapters/04-ergebnisse.typ"
#include "chapters/05-diskussion.typ"
#include "chapters/06-fazit.typ"

#pagebreak()
#include "appendix/A-technische-details.typ"
#include "appendix/B-materialien.typ"

#pagebreak()
#bibliography(
  bibliography-path,
  style: "apa",
  title: [Quellenverzeichnis],
)
