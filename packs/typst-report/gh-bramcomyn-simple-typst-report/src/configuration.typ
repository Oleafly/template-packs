// IEEE Template for Typst
// made by Bram Comyn - December 2025

#let configuration(
  authors: (
    (
      name: "First Author",
      affiliation: "Affiliation 1",
      email: "first.author@example.org"
    ),
    (
      name: "Second Author",
      affiliation: "Affiliation 2",
      email: "second.author@example.org"
    )
  ),
  abstract: lorem(80),
  doc
) = {

  let header-style(content) = [
    #show text: set text(size: 9pt, weight: "regular")
    #content
  ]

  set page(
    paper: "a4",
    header: align(
      right + horizon,
      header-style(title())    
    ),
    columns: 2,
    numbering: "1."
  )

  set par(justify: true)
  set text(
    font: "New Computer Modern",
    size: 11pt
  )

  show heading.where(level: 1): smallcaps
  show heading.where(level: 1): set align(center)
  show heading.where(level: 1): set text(
    size: 13pt,
    weight: "regular"
  )

  show heading.where(level: 2): set text(
    size: 11pt,
    weight: "regular",
    style: "italic"
  )

  show heading.where(level: 2): it => {
    it.body + [.]
  }

  place(
    top + center,
    float: true,
    scope: "parent",
    clearance: 2em,
    {
      title()

      let count = authors.len()
      let ncols = calc.min(count, 3)
      grid(
        columns: (1fr,) * ncols,
        row-gutter: 24pt,
        ..authors.map(author => [
          #author.name \
          #author.affiliation \
          #link("mailto:" + author.email)
        ]),
      )

      par(justify: false)[
        *Abstract* \
        #abstract
      ]
    }
  )

  doc
}
