#let tableOfListings(title: "Listings", layoutConfig: none) = {
  show: layoutConfig
  heading(numbering: none, outlined: false, bookmarked: true, title)
  v(1em)
  outline(
    title: none,
    target: figure.where(kind: raw)
  )
}

#let tableOfTables(title: "Tables", layoutConfig: none) = {
  show: layoutConfig
  heading(numbering: none, outlined: false, bookmarked: true, title)
  v(1em)
  outline(
    title: none,
    target: figure.where(kind: table)
  )
}

#let tableOfFigures(title: "Figures", layoutConfig: none) = {
  show: layoutConfig
  heading(numbering: none, outlined: false, bookmarked: true, title)
  v(1em)
  outline(
    title: none,
    target: figure.where(kind: image),
  )
}

#let tableOfContents(title: "Table of Contents", layoutConfig: none) = {
  show: layoutConfig
  set page(margin: (left: 25mm, right: 25mm, top: 25mm, bottom: 30mm))
  heading(numbering: none, outlined: false, bookmarked: true, title)
  v(1em)
  outline(
    title: none,
    indent: 2em
  )
}

#let secondPage(
  title: "",
  author: "",
  submissionDate: ""
) = {
  set page(footer: "")
  let font = "New Computer Modern"
  v(97%)
  align(left, text(font: font, 1.1em, weight: 400, author + ": " + text(style: "italic", title) + ", © " + submissionDate))
}
