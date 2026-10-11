#let project(
  title: "Arc42 Template",
  abstract: [],
  authors: (),
  date: none,
  logo: none,
  body,
) = {
  set document(author: authors, title: title)
  set page(numbering: "1", number-align: center)
  set text(lang: "en")
  set heading(numbering: "1.1")
  set cite(style: "chicago-shortened-notes")
  
  show heading: it => {
    if it.level > 3 {
      parbreak()
      text(11pt, style: "italic", weight: 500, it.body + "")
    } else {
      it
    }
  }

  set par(spacing: 1.7em, leading: 0.75em)

  v(0.6fr)
  if logo != none {
    align(right, image(logo, width: 26%))
  }
  v(9.6fr)

  text(1.1em, date)
  v(1.2em, weak: true)
  text(2em, weight: 700, title)

  // Author information.
  pad(
    top: 0.7em,
    right: 20%,
    grid(
      columns: (1fr,) * calc.min(3, authors.len()),
      gutter: 1em,
      ..authors.map(author => align(start, strong(author))),
    ),
  )

  v(2.4fr)
  pagebreak()

  // Abstract page.
  v(1fr)
  align(center)[
    #heading(
      outlined: false,
      numbering: none,
      text(0.85em, smallcaps[Abstract]),
    )
    #abstract
  ]
  v(1.618fr)
  pagebreak()

  // Table of contents.
  outline(depth: 3, indent: auto)
  pagebreak()

  // Main body.
  set par(justify: true)

  body
}