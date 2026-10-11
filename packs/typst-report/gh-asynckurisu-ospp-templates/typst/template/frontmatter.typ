#let thesis-contents() = {
  set page(
    numbering: "i",
    header: none,
    footer: context align(center, counter(page).display("i")),
  )
  outline(title: [目录], depth: 4)
  pagebreak()
}

#let front-matter(body) = {
  body
}
