#let config(
  title: none,
  description: "",
  authors: (),
  abstract: [],
  header: (
    start: [],
    middle: [],
    end: [],
  ),
  paper: "a4",
  doc,
) = {
  set heading(
    numbering: "1."
  )
  set text(
    font: "New Computer Modern",
    size: 12pt,
  )
  set document(
    title: title,
    author: authors.map(author => author.name),
    description: description,
  )

  // Frontpage
  set align(center)
  text(17pt, title)

  // Authors
  let count = authors.len()
  let ncols = calc.min(count, 2)
  grid(
    columns: (1fr, ) * ncols,
    row-gutter: 24pt,
    ..authors.map(author => [
      #author.name \
      #link("mailto:" + author.email)
    ]),
  )

  // Abstract
  set align(left)
  pagebreak()
  par(justify: false)[
    *Abstract* \
    #abstract
  ]

  // Table of contents
  pagebreak()
  outline()

  // Content
  set page(
    paper: paper,
    header: [#header.start #h(1fr) #header.middle #h(1fr) #header.end],
    numbering: "1/1",
    number-align: right,
  )
  
  counter(page).update(1)
  set align(left)
  doc
}
