#let report(
  title: "",
  author: "",
  preview: false,
  doc,
) = {
  set text(
    font: "New Computer Modern",
    size: 12pt
  )

  set enum(indent: 2em, spacing:1em)
  

  set document(
    author: author,
    date: datetime(day: 27, month: 11, year: 2024),
    title: title,
  )

  set enum(numbering: "1.a.i.")

  heading(title)
  author

  pagebreak()

  outline(indent: auto)

  set par(
    first-line-indent: 15pt,
    justify: true,
    leading: 0.52em,
  )

  set page(
    header: [
      #title
      #h(1fr)
      #author
    ],
  )

  set heading(
    numbering: "1.1.1",
  )

  doc
}

#let display-word-count(body : content, preview: bool) = {
  word-count(total => {
    if preview [_(#total.words words)_]
    body
  }, exclude: (heading, strike))
}