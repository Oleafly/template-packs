#let project(title: "", authors: (), date: none, body) = {
  set document(author: authors, title: title)
  set page(numbering: "1", number-align: center)
  set text(font: "Yu Mincho", lang: "ja")
  set heading(numbering: "1.1. ")
  set enum(indent: 2em)
  set list(indent: 2em)

  show math.equation: set text(weight: 400)

  // Title row.
  align(center)[
    #block(text(weight: 700, 1.75em, title))
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

  // date information
  align(center, if date != none {
    date
  } else {
    hide("a")
  })

  // Main body.
  set par(justify: true, first-line-indent: 1em)

  body
}
