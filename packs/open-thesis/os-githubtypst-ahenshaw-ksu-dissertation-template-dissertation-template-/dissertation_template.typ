#let thesis(
  title: "",
  abstract: [],
  author: "",
  degree: "Ph.D. in Data Science and Analytics",
  institute: "Kennesaw State University",
  body,
) = {
  // Set the document's basic properties.
  set document(author: author, title: title)
  set page(
    paper: "us-letter",
    number-align: center,
    margin: (left: 1.25in, rest: 1.0in)
  )
  set text(font: "New Computer Modern", lang: "en")
  set heading(numbering: "1.1.")
  // Title page
  v(1.25in)
  align(center)[
    #text(2em, title)
    #v(1.0in)
    #text(1.5em, "by")
    #v(1.0in)
    #text(1.75em, author)
    #v(1.5in)
    A dissertation submitted in conformity with the requirements \
    for the degree of #degree \
    #institute\
]
  place(bottom+center)[
    #sym.copyright by #author, #datetime.today().year()
  ]
  set page(numbering: "i")
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
  outline(depth: 3, indent: true)
  pagebreak()
  set page(numbering: "1")
  counter(page).update(1)



  // Main body.
  let line-spacing=0.65em * 1.5
  set par(justify: true, leading: line-spacing )
  show heading: set block(above: 2em, below:1em)
  body


}