#import "@preview/physica:0.9.3": *
#let project(course: "", code: "", lab: 0, title: "", authors: (), date: none, body) = {
  // Set the document's basic properties.
  set document(author: authors.map(a => a.name), title: title)
  set page(
    margin: (left: 30mm, right: 30mm, top: 30mm, bottom: 30mm),
    number-align: right,
  )
  set text(font: "New Computer Modern", lang: "en")
  show math.equation: set text(weight: 400)
  set heading(numbering: "1.")
  show heading.where(level: 1): it=>{
    v(0.4em)
    text(weight: 700, size: 1.2em)[#it]
    v(0.4em)
  }
  show heading.where(level: 2): it=>{
    v(0.4em)
    text(weight: 700, size: 1.1em)[#it]
    v(0.4em)
  }

  // cover header row
  align(center)[
    #line(length: 100%)
    #show: smallcaps
    #block(text(1.5em, "UM–SJTU Joint Institute"))
    #v(1.5em)
    #block(text(1.5em, course))
    #block(text(1.5em, "("+code+")"))
    #line(length: 100%)
  ]

  // title
  align(center)[
    #v(15em)
    #show: smallcaps
    #block(text(1.5em, "Laboratory Report"))
    #v(1.5em)
    #block(text(1.5em, "Lab " + str(lab)))
  ]
  align(center)[
    #block(text(1.5em, title))
  ]

  // Author information.
  align(left+bottom)[
    #grid(
      columns: (1fr,) * calc.min(3, authors.len()),
      gutter: 1em,
      ..authors.map(author => align(center,{align(left)[
        Name: #author.name \
        ID: #author.affiliation
      ]}),
    ))
    #v(1em)
    #date
    #v(2em)
  ]

  pagebreak()

  set page(
    numbering: "1",
    header: [
      #code Lab #lab #h(1fr) Laboratory Report
    ],
    header-ascent: 50%,
  )

  // Main body.
  set par(justify: true)
  [
    #counter(page).update(1)
    #body
  ]
}
