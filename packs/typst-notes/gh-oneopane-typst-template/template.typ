// Reusable page/layout template for notes documents.

#let notes-template(
  title: "Notes",
  author: none,
  date: none,
  doc,
) = {
  set document(title: title, author: if author == none { () } else { (author,) })
  set page(
    paper: "us-letter",
    margin: (x: 1in, y: 1in),
    numbering: "1",
    number-align: center,
  )
  set text(font: "New Computer Modern", size: 11pt, lang: "en")
  set par(justify: true, leading: 0.65em)
  set heading(numbering: "1.1")
  set list(indent: 1.25em, body-indent: 0.5em)
  set enum(indent: 1.25em, body-indent: 0.5em)
  show heading: set block(above: 1.2em, below: 0.55em)
  show link: underline

  align(center)[
    #text(size: 22pt, weight: "bold")[#title]

    #if author != none [#v(0.35em)#text(size: 12pt)[#author]]
    #if date != none [#v(0.2em)#text(size: 10pt)[#date]]
  ]

  v(1.5em)
  outline(title: [Contents])
  pagebreak()

  doc
}
