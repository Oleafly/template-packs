#import "@preview/hydra:0.6.2": hydra

#let darkgrey = rgb(100, 100, 100)

#let project(
  title: "",
  author: "",
  module: "",
  student_number: "",
  body
) = {
  set document(title: title, author: author)
  set text(font: "New Computer Modern", size: 10.5pt, lang: "en")
  set par(justify: true)
  set heading(numbering: "1.")
  set list(indent: 1em)
  show heading: set text(font: "Libertinus Serif", weight: "bold", style: "italic")
  
  show heading.where(level: 1): it => [
    #set text(size: 17pt)
    #block(it)
  ]
  show heading.where(level: 2): it => [
    #set text(size: 14pt)
    #block(it)
  ]

  set page(
    paper: "a4",
    margin: (top: 3cm, bottom: 3cm, x: 2cm),
    header: context {
      if counter(page).get().first() > 1 {
        set text(size: 9pt, font: "New Computer Modern", weight: "bold")
        grid(
          columns: (1fr, 1fr, 1fr),
          align(left, hydra(skip-starting: false, 1)),
          align(center, text(fill: darkgrey)[#module | Coursework]),
          align(right, hydra(2))
        )
        v(-5pt)
        line(length: 100%, stroke: 0.5pt + gray)
      }
    },

    footer: context {
      if counter(page).get().first() > 1 {
        set text(size: 9pt, font: "new computer modern", weight: "bold")
        line(length: 100%, stroke: 0.5pt + gray)
        v(5pt)
        grid(
          columns: (1fr, 1fr, 1fr),
          align(left)[#datetime.today().display()],
          align(center, text(fill: darkgrey)[#author | #student_number]),
          align(right)[#counter(page).display()]
        )
      }
    }
  )

  page(
    margin: (top: 4cm, bottom: 2cm, x: 2cm),
    header: none,
    footer: none
  )[
    #set align(right)
    #set text(font: "Libertinus Serif")

    #line(length: 100%, stroke: 1pt)
    #v(1cm)
    #text(size: 28pt, weight: "bold", title)
    #v(1cm)
    #line(length: 100%, stroke: 1pt)

    #v(2cm)

    #text(size: 24pt)[
      #module \
      #student_number \
      #author
    ]
    #v(1fr)
    #line(length: 100%, stroke: 1pt)
    #v(1em)
  ]

  show outline.entry: it => text(font: "New Computer Modern", it)
  outline(title: "Contents", indent: auto)
  pagebreak()

  body
}
