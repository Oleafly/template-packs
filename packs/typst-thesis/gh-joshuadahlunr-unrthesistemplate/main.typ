#import "@preview/muchpdf:0.1.0": muchpdf
#import "@preview/i-figured:0.2.4"

// Define conditional content
#let draft = false

// set document settings
#let default_margin(body) = page(margin: (
  top: 1in,
  bottom: 1.25in,
  left: 1.5in,
  right: 1in,
), body)
#set page(
  paper: "us-letter",
  header: context [ 
    #if draft { "Draft "; datetime.today().display("[month repr:long] [day], [year]")  } else { "" }
  ]
)
#let double_spaced = 1.5em
#let single_spaced = .65em
#set par(
  first-line-indent: (amount: 8mm, all: true),
  spacing: 22pt,
  leading: double_spaced
)
#set text(size: 12pt)
#show heading: set block(below: 2em, above: 2em)
#show: default_margin

// Helper functions/macros
#let note(body) = if draft { 
  markup("†", body, fill: green) 
}
#let fix(body) = if draft { 
  rect[fill: red][body] 
}
#let code(body) = text(tt, body)

#let embed_pdf(path) = {
  set page(
    margin: (
      top: 0in,
      bottom: 0in,
      left: 0in,
      right: 0in,
    )
  )
  pagebreak()
  muchpdf(read(path, encoding: none), width: 100%)
  // show: default_margin
}

#let embed_svg(path) = {
  set page(
    margin: (
      top: 0in,
      bottom: 0in,
      left: 0in,
      right: 0in,
    )
  )
  pagebreak()
  image(path, width: 100%)
  // show: default_margin
}




// Title and front matter
#include "titlePage.typ"
#include "copyright.typ"

#if draft {
  // Optional ToDo list
  include "todo.typ"
}

// Committee page as embedded PDF
#embed_svg("figures/committee.svg")
// #embed_pdf("figures/committee.svg")

#set page(
  margin: (
    top: 1in,
    bottom: 1.25in,
    left: 1.5in,
    right: 1in,
  ),
  numbering: "i",
  number-align: top,
  header: context [ 
    #if draft { "Draft "; datetime.today().display("[month repr:long] [day], [year]") } else { "" }
    #h(1fr)
    #counter(page).display("i")
  ]
)
#counter(page).update(1)
// Abstract, dedication, acknowledgments
#include "abstract.typ"
// #include "dedication.typ"
#include "acknowledgements.typ"

// Figure numbering per chapter
#show heading: i-figured.reset-counters
#show figure.caption: it => [ 
  #set par(leading: single_spaced)
  #it
]
#show figure: i-figured.show-figure

// TOC, List of Tables, List of Figures
#pagebreak()
#{
  show heading: none
  heading(numbering: none)[Contents]
}
#set par(
  first-line-indent: (amount: 8mm, all: true),
  spacing: 22pt,
  leading: single_spaced
)
#{
  show outline.entry.where(
    level: 1
  ): entry => {
    set block(above: 1.5em)
    set text(weight: "bold")
    entry
  }
  show outline.entry.where(level: 1): set outline.entry(fill: none)
  // set outline.entry.page().display()
  outline(depth: 10)
}

#pagebreak()
#{
  show heading: none
  heading(numbering: none)[List of Tables]
}
#i-figured.outline(
  title: [List of Tables],
  target-kind: table,
)

#pagebreak()
#{
  show heading: none
  heading(numbering: none)[List of Figures]
}
#i-figured.outline()


// Main matter
#set page(
  header: context [ 
    #if draft { "Draft "; datetime.today().display("[month repr:long] [day], [year]") } else { "" }
    #h(1fr)
    #counter(page).display("1")
  ],
  numbering: "1",
  number-align: top
)
#set par(
  first-line-indent: (amount: 8mm, all: true),
  spacing: 22pt,
  leading: 1.5em
)

#let chapter_include(name) = {
  pagebreak()
  include name
}
#let chapters(body) = {
  set heading(numbering: "1.1", 
    supplement: {
      content => if content.depth == 1 { return [Chapter] } else { return [Section] }
    }
  )
  body
}
#show: chapters
#counter(page).update(1)

#chapter_include("chapter1.typ")
#chapter_include("chapter2.typ")
#chapter_include("chapter3.typ")
#chapter_include("chapter4.typ")
#chapter_include("chapter5.typ")
#chapter_include("chapter6.typ")

// Bibliography
#pagebreak()
#set par(leading: single_spaced)
#bibliography("bib.bib", title: "References", style: "acm.csl")
#set par(leading: double_spaced)

// Appendices
#pagebreak()
#set heading(numbering: none)
= Appendices
#let appendix(body) = {
  set heading(numbering: "A.1", supplement: [Appendix])
  counter(heading).update(0)
  body
}
#show: appendix

#include "appendixA.typ"
// #chapter_include("appendixB.typ")
