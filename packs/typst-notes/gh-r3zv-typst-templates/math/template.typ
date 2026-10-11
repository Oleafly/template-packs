#let template(
  title: "",
  authors: (),
  date: none,
  heading-color: rgb("#000000"),
  link-color: rgb("#000000"),
  body
) = {
  set page(
  numbering: "1",
  number-align: center,
  margin: (
    top: 3cm,
    bottom: 2cm,
    x: 4.5cm,
  ))

  // Heading settings.
  set heading(numbering: "1.1")
  show heading.where(level: 1): set text(size: 14pt, fill: heading-color)
  show heading.where(level: 2): set text(size: 12pt, fill: heading-color)

  set text(font: "FreeSerif", lang: "en", size: 12pt)
  set document(author: authors, title: title)

  show math.equation: set text(weight: 400)

  // Title row.
  align(center)[
    #block(text(weight: 700, 1.75em, title))
    #v(1em, weak: true)
    #date
  ]

  // Author information.
  pad(
    top: 0.5em,
    bottom: 0.5em,
    x: 2em,
    grid(
      columns: (1fr,) * calc.min(3, authors.len()),
      gutter: 1em,
      ..authors.map(author => align(center, strong(author))),
    ),
  )


  // Table of contents
  set heading(numbering: "1.")
  show outline.entry.where(
    fill:  none,
    level: 1
  ): it => {
    v(12pt, weak: true)
    strong(it)
  }

  outline(indent: auto)
  pagebreak()

  // Main body.
  body
}
