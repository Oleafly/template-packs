//
//  Typst template for Linköping Univerity, IDA
//

#let project(
  course: "",
  title: "",
  authors: (),
  date: "",
  version: "1.0",
  term: "",
  body,
) = {

  //
  //  TEMPLATE SETTINGS
  //

  // Set authors and title
  set document(author: authors.map(a => a.name), title: title)

  // Set default font and language for text
  set text(font: "New Computer Modern", lang: "sv")

  // Set page-numbering to current / total in footer
  set page(numbering: "1 / 1", number-align: end)

  // Hide page numbering for title page and table of contents
  set page(footer: none)

  // Number each header with 1, 1.1 and so on
  set heading(numbering: "1.1")

  //
  //  TITLE PAGE
  //

  set rect(
    inset: 0pt,
    fill: rgb("#f3f3f3"),
    width: 100pt,
  )

  grid(
    columns: (170pt, 1fr),
    align: (left, center),
    rect[
      #block(fill: rgb("#00ff00"))
      #block([#image("lith.png", width: 100pt)], fill: rgb("#ffffff"), inset: 0pt, above: 0pt)
      #v(1fr)
      #image("ida.png", width: 100pt)
    ],
    [

      // Padding
      #v(10em)

      // Add course title
      #text(2.4em, weight: "thin", course, fill: rgb("#00008b"))
      #v(8em)

      // Title
      #text(2.2em, weight: 700, title)
      #v(1em, weak: true)

      // Authors
      #text(1em, "Författare")
      #grid(columns: 1fr, gutter: 1em, ..authors.map(author => align(center)[
        #text([*#author.name*, #author.email], font: "New Computer Modern Mono", size: 0.8em)
      ]))

      // Padding, down to end of page - padding
      #v(1fr)

      // Term
      #text(1em, term)
      #v(0.5em, weak: true)

      // Version
      #text(1em, "Version " + version)
      #v(1em, weak: true)

      // Date
      #text(1em, date)



      // Padding
      #v(1.5em)
    ]
  )

  pagebreak()

  //
  //  TABLE OF CONTENTS
  //

  outline(depth: 3)
  pagebreak()

  //
  //  DOCUMENT
  //

  // Reset page counter after table of contents
  counter(page).update(1)

  // Set header and footer for remaining pages
  set page(footer: auto, header: [
    #grid(columns: (1fr, 1fr, 1fr),
    align: (left, center, right),
    [], [#title], [#date])
  ])

  // Justify text
  set par(justify: true)

  body
}
