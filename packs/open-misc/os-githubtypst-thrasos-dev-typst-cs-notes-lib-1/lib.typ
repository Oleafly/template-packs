#import "@preview/frame-it:1.2.0": *

#let (example,) = frames(
  example: (
    "Example",
    gray
  ),
  kind: "example",
)
#let (definition,) = frames(
  definition: (
    "Definition",
    eastern
  ),
  kind: "definition",
)
#let (theorem,) = frames(
  theorem: (
    "Theorem",
    orange
  ),
  kind: "theorem",
)

#let notes(
  doc_title: "[Title]",
  doc_author: "[Author]",
  doc,
) = {
  // Packages
  show: frame-style(styles.boxy, kind: "example")
  show: frame-style(styles.boxy, kind: "definition")
  show: frame-style(styles.boxy, kind: "theorem")

  // Document setup
  set document(title: doc_title, author: doc_author)
  set page(paper: "a4")
  set par(justify: true)
  set heading(numbering: "1.1")
  set text(size: 12pt)
  show quote: set align(center)

  // Title page
  place(
      top + center,
      float: true,
      scope: "parent",
      clearance: 2em,
      {
        title()

        doc_author
      }
    )
  outline()
  pagebreak()

  // Page numbering
  counter(page).update(1)
  set page(numbering: "1")

  // Header
  set page(header: [
    _ #doc_title _
    #h(1fr)
    #doc_author
  ])

  doc
}
