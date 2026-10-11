#let after-matter(body) = {
  body
}

#let bib(path) = {
  pagebreak(weak: true)
  align(center)[
    #text(font: "SimHei", size: 16pt, weight: "bold")[参考文献]
  ]
  set text(size: 10.5pt)
  bibliography(
    "../" + path,
    title: none,
    style: "gb-7714-2015-numeric",
  )
}
