#let gallery(
  title: "",
  descr: "",
  content
) = {
  align(center)[
    #text(24pt)[#strong(title)] \
  ]
  [
    #set text(16pt)
    　　#descr \
  ]
  align(center)[
    #content
  ]

  pagebreak()
}