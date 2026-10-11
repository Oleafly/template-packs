// template: manual edits from https://github.com/shunichironomura/iac-typst-template. Was "MIT No Attribution License".

#let project(
  paper-size: "us-letter",
  project-title: [],
  abstract-text: [Abstract],
  abstract: [],
  authors: (),
  body,
) = {
  // Set the document's basic properties.
  let par-spacing = 0.65em
  let font-size = 11pt

  set document(author: authors, title: project-title)
  set par(
    spacing: par-spacing,
    justify: true,
    first-line-indent: 0.5cm,
  )
  set page(
    paper: paper-size,
    footer: align(right)[
      Page
      #context counter(page).display(
        "1 of 1",
        both: true,
      )
    ],
  )

  set text(size: font-size)
  show heading: set text(size: font-size)

  // Front matter.
  {
    let intro-vspacing = 1.3em // vertical spacing in intro section

    // Title
    if project-title != [] {
      align(center, {
        show title: set text(size: font-size)
        title()
        v(intro-vspacing, weak: true)
      })
    }

    // Authors
    if authors != () {
      align(center, {
        authors.map(author => text(author, weight: "bold")).join(", ")
        v(intro-vspacing, weak: true)
      })
    }

    // Abstract.
    if abstract != [] {
      align(center)[= #abstract-text]
      abstract
      v(intro-vspacing, weak: true)
    }
  }

  // Main body.
  {
    show: columns.with(2, gutter: 1.3em)

    show heading: set text(weight: "regular", style: "italic")
    show heading: set block(below: 1.1em, above: 1.1em)
    show heading.where(level: 1): set text(weight: "bold", style: "normal")
    set heading(numbering: "1.")

    // Media show rules
    show figure: set block(below: 1.3em, above: 1.3em)
    set figure.caption(separator: [. ])
    show figure.caption: it => box(align(left, it))
    show figure.where(kind: table): set figure.caption(position: top)

    // discourage hyphenation
    set text(costs: (hyphenation: 150%))

    body
  }
}
