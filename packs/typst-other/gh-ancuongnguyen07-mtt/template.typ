#import "@preview/elembic:1.1.1" as e: field, element

// zebraw package for showing code snippets
#import "@preview/zebraw:0.6.3": *
#show: zebraw

// set up constants
#let VSPACE = 0.3cm
#let INDENTSPACE = 1.5em

#let paraheadline = element.declare(
  "paraheadline",
  doc: "A headline for a paragraph",
  prefix: "@preview/my-package,v1",
  display: it => v(VSPACE) + h(-INDENTSPACE) + box[
    #set text(weight: "bold")
    #set par(first-line-indent: 0em)
    #it.body
  ] + h(0.35em),
  fields: (field("body", content, required: true),)
)

#let paraheadlineplus(x) = h(INDENTSPACE) + v(-VSPACE) + paraheadline(x) 

#set page(
  paper: "us-letter",
  numbering: "1",
  // margin: 1.75in,
)

#set text(
  size: 12pt,
  font: "New Computer Modern",
)

#set heading(numbering: "1.")
#show heading: set block(above: 1.4em, below: 1em) 

#show title: set text(size: 20pt)
#show title: set align(center)

#show link: set text(fill: blue)
#show link: underline

#show cite: set text(fill: blue)

// #show rules for #figure
#show figure: set align(center)
#show figure: set block(breakable: true)
#show figure.where(kind: table): set figure.caption(position: top)

#show ref: set text(fill: blue)

// including the following setting for proper indention
#set par(
  leading: 0.55em,
  spacing: 0.55em,
  first-line-indent: INDENTSPACE,
  linebreaks: auto,
  justify: true,
)

#let author(name) = align(center, text(size: 14pt, name))
#let subtitle(tit) = align(center, text(size: 16pt, tit))

#set table(
  inset: (right: 1.5em),
)

#let mytable(..args) = {
  show table.cell: it => {
    if it.x == 0 or it.y == 0 {
      set text(white)
      strong(it)
    } else if it.body == [] {
      pad(..it.inset)[_N/A_]
    } else {
      it
    }
  }
  table(
    fill: (x,y) => {
      if x == 0 or y == 0 {gray}
    },
    ..args
  )
}


// Title
#title[
  Main title // Change me!
]

// Job name
#subtitle[
  Subtitle // Change me
]
#author[Cuong Nguyen]

// including the following setting for proper indention
#set par(
  leading: 0.55em,
  spacing: 0.55em,
  first-line-indent: INDENTSPACE,
  linebreaks: auto,
  justify: true,
)



#bibliography(
  "template.bib",
  title: "References",
  style: "ieee",
)