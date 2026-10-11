#let cover(lecture-name: [Lecture Name]) = {
  set page(columns: 1, header: none)
  align(center)[
    #text(red, 40pt)[#lecture-name]
    #v(1fr)
    #text(20pt)[Coverpage]
  ]
}
