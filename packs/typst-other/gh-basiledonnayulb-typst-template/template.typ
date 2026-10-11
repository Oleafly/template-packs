#import "@preview/hydra:0.6.0": hydra

#let project(
  title: "",
  abstract: [],
  authors: (),
  logo: none,
  body
) = {
  // Set the document's basic properties.
  set document(author: authors.map(a => a.name), title: title)
  show math.equation: set text(font: "Fira Math", weight: 400)
  set text(font: "Fira Sans", lang: "en")
  set par(justify: true)
  set par(first-line-indent: 0pt)
  set text(size: 1.1em)
  show heading: it => {
    text(it)
    v(15pt)
  }

  // Title page.
  v(0.25fr)
  align(left, text(("Université libre de Bruxelles"), size: 2.2em))
  align(left, text(weight: "regular", ("Faculty of Sciences"), size: 1.1em))
  align(left, text(weight: "regular", ("Department of Computer Science"), size: 1.1em))
  v(0.15fr)
  align(center, line(length: 75%))
  align(center)[
    #text(2em, weight: 700, smallcaps(title))
    
    #text(1em, weight: "light", "Preparatory work for the master thesis — MEMO-F-403")
  ]

  // Author information.
  pad(
    top: 0.7em,
    align(center, 
    box(
      width: 70%,
      grid(
          columns: (1fr, 1fr),
          gutter: 5em,
          align(left,
            emph(authors.at(0).status) + ":" + linebreak() + strong[#authors.at(0).name]
          ),
          align(right,
            emph(authors.at(1).status) + ":" + linebreak() + authors.at(1).name
          ),
        )
      )
    )  
  )

  // Logo
  if logo != none {
    v(0.50fr)
    align(center, image(logo, width: 26%))
    v(0.25fr)
  } else {
    v(0.75fr)
  }

  pagebreak()

  // Abstract page.
  set page(numbering: "I", number-align: center)
  v(1fr)
  if (abstract != "") {
  align(center)[
    #heading(
      outlined: false,
      numbering: none,
      text(0.85em, smallcaps[Abstract]),
    )
  ]}
  abstract
  v(1.618fr)
  counter(page).update(1)
  pagebreak()

  // Table of contents
  outline(depth: 2, title: "Table of Contents")

  set text(size: 12pt, spacing: 3pt)
  set enum(spacing: 40pt)
  set page(numbering: "1", number-align: center, margin: (top : 2.5cm, left: 3.5cm, right: 3cm, bottom: 2.5cm))
  set par(first-line-indent: 0pt, leading: 0.5em)
  counter(page).update(1)
  
  set page(header: context {
    if calc.odd(here().page()) {
      align(right, emph(hydra(1)))
    } else {
      align(left, emph(hydra(2)))
    }
    line(length: 100%)
  })
  set heading(numbering: "I.1")
  show heading.where(level: 1): it => pagebreak(weak: true) + it
  body
}