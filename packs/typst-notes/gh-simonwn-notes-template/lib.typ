#let notes(
  title: [Paper Title],
  authors: (),
  paper-size: "a4",
  bibliography: none,
  figure-supplement: [Figure],
  body
) = {
  set document(title: title, author: authors.map(author => author.name))
  set text(font: "New Computer Modern", size: 10pt, spacing: .35em)
  set enum(numbering: "1)a)i)")

  show figure: set block(spacing: 15.5pt)
  show figure: set place(clearance: 15.5pt)
  show figure.where(kind: table): set figure.caption(position: top, separator: [\ ])
  show figure.where(kind: table): set text(size: 8pt)
  show figure.where(kind: table): set figure(numbering: "1")
  show figure.where(kind: image): set figure(numbering: "1")
  show figure.caption: set text(size: 8pt)
  show figure.caption: set align(start)
  show figure.caption.where(kind: table): set align(center)

  show figure.where(kind: raw): set align(start)
  show figure.caption.where(kind: raw): set align(center)
  
  set figure.caption(separator: [. ])
  show figure: fig => {
    let prefix = (
      if fig.kind == table [Table]
      else if fig.kind == image [Figure]
      else [#fig.supplement]
    )
    let numbers = numbering(fig.numbering, ..fig.counter.at(fig.location()))
    show figure.caption: it => block[#prefix~#numbers. #it.body]
    fig
  }

  // Code blocks
  show raw: set text(
    font: "New Computer Modern",
    ligatures: false,
    size: 1em / 0.8,
    spacing: 100%,
  )

  show raw.where(block: true): code => {
    show raw.line: line => {
      text(fill: gray)[#line.number]
      h(1em)
      line.body
    }
    code
  }

  set page(
    columns: 1,
    paper: paper-size,
    margin: (x: 80pt, top: 80pt, bottom: 80pt)
  )

  // Equation numbering and spacing.
  set math.equation(numbering: "(1)")
  show math.equation: set block(spacing: 0.65em)

  // Configure appearance of equation references
  show ref: it => {
    if it.element != none and it.element.func() == math.equation {
      // Override equation references.
      link(it.element.location(), numbering(
        it.element.numbering,
        ..counter(math.equation).at(it.element.location())
      ))
    } else {
      it
    }
  }

  // Configure lists.
  set enum(indent: 10pt, body-indent: 9pt)
  set list(indent: 10pt, body-indent: 9pt)

  // Configure headings.
  set heading(numbering: "1.1.1")

  // Style bibliography.
  show std.bibliography: set text(8pt)
  show std.bibliography: set block(spacing: 0.5em)
  set std.bibliography(title: text(10pt)[References], style: "ieee")

  // Display the paper's title and authors
  place(
    top,
    float: true,
    scope: "parent",
    clearance: 30pt,
    {
      show std.title: set align(center)
      show std.title: set par(leading: 0.5em)
      show std.title: set text(size: 24pt, weight: "regular")
      show std.title: set block(below: 8.35mm)
      v(150pt)
      std.title()

      // Display the authors list.
      set par(leading: 0.6em)
      for i in range(calc.ceil(authors.len() / 3)) {
        let end = calc.min((i + 1) * 3, authors.len())
        let is-last = authors.len() == end
        let slice = authors.slice(i * 3, end)
        grid(
          columns: slice.len() * (1fr,),
          gutter: 12pt,
          ..slice.map(author => align(center, {
            text(size: 11pt, author.name)
            if "department" in author [
              \ #emph(author.department)
            ]
            if "organization" in author [
              \ #emph(author.organization)
            ]
            if "location" in author [
              \ #author.location
            ]
            if "email" in author {
              if type(author.email) == str [
                \ #link("mailto:" + author.email)
              ] else [
                \ #author.email
              ]
            }
          }))
        )

        if not is-last {
          v(16pt, weak: true)
        }
      }
    }
  )

  set par(justify: true, spacing: 1.5em, leading: 0.5em)

  // Table of contents and page break before content
  columns(2, gutter: 8pt)[
    #outline()
  ]

  [#pagebreak()]

  body

  bibliography
}
