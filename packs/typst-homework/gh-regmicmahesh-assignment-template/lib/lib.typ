

#let assignment-content(body) = {
  set page(
    header: auto,
    numbering: "1",
  )
  body
}


#let assignment-content-page(title: none, body) = {
  if title != none {
    heading(level: 1, title)
  }
  body
  pagebreak()
}
