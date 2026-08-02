#let solo-document(title: "Replace Me", author: "Replace Me", body) = {
  set document(title: title, author: author)
  set page(paper: "a4", margin: 25mm)
  set text(font: "New Computer Modern", size: 11pt)
  set heading(numbering: "1.")

  align(center)[
    #text(size: 22pt, weight: "bold", title)
    #v(0.5em)
    #author
  ]

  v(2em)
  body
}
