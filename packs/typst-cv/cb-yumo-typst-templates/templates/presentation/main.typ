// settings
#import "@preview/polylux:0.4.0": *

#let speaker-note
// docs: https://polylux.dev/book/getting-started/getting-started.html
#set page(paper: "presentation-16-9")
#set text(
  font: "Inter",
  size: 16pt,
)
#show raw: it => {
  box(
    fill: rgb("f5f5f5"),
    inset: 10pt,
    radius: 0pt,
    stroke: rgb("dddddd"),
  )[
    #set text(font: "JetBrainsMono NF", ligatures: false)
    #it
  ]
}
//

#enable-handout-mode(true)
#slide[
  #set align(horizon)
  = Title
  by _some idiot_
]
#slide[
  == Section 1

  Some very interesting description.
  - interesting fact
]
