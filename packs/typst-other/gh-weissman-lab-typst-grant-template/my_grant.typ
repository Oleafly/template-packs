#import "@preview/showybox:2.0.4": showybox // for pop-up boxes
#import "@preview/lilaq:0.6.0" as lq

#set page(width: 8.5in, height: 11in, margin: 0.5in)
#set text(font: "Arial", size: 11pt, hyphenate: false)
#set par(justify: true)

// Stop incomplete paragraphs from breaking to next page
#set text(costs: (widow: 0%, orphan: 0%))

// Sometimes superscripts randomly appear bold, so do this:
// https://github.com/typst/typst/issues/4006
#set super(typographic: false)

// Make captions small font and fix spacing (NIH allows 8pt font in captions)
#show figure.caption: it => [#par(leading: 0.3em)[
  #text(8pt, it.supplement)
  #text(8pt, context it.counter.display(it.numbering))#text(8pt,[:])
  #text(8pt, it.body)]
]

// Custom justified line break for column text
#let jlb = linebreak(justify: true)

// Set up headings
#set heading(numbering: "A.1.a.") 
#show heading: set text(size: 12pt)
#show heading.where(level: 1): it => {
  box(
  stroke: (bottom: 0.5pt),
  inset: (bottom: 0.2em),
)[#text(size: 11pt, weight: "bold", it)]
}

#show heading.where(level: 2): it => {
 text(size: 11pt, weight: "bold", it)
 v(5pt)
}

#show heading.where(level: 3): it => {
  box(
  stroke: (bottom: 0.5pt),
  inset: (bottom: 0.2em),
)[#text(size: 11pt, weight: "medium", it)]
}



= Approach 

One of the best papers I've ever read.@tversky1974judgment #lorem(25)

== More details

This is a subsection with details about all of this work. #lorem(40)
#v(-5pt) // get rid of extra white space
// create a grid where the text and image will go side-by-side
#grid(columns : (1.5fr, 1fr), // the relative "fr"action of the page width for each column
  gutter: 10pt, // how much space between the columns of the grid
  [#lorem(75) #jlb], // content of the left grid element
  [#figure(image("exhibits/conceptual_model.pdf"), gap: -10pt, caption: [Time is a circle.]) <fig-conceptual-model>] // content of the right grid element
  )
#v(-5pt) // get rid of extra white space
// more text after the wrapped area
This can all be seen very clearly in @fig-conceptual-model. #lorem(25)

=== Even more details

This is a sub-subsection. This is *important* to _really_ understand what is #underline[going on].

#showybox(frame: (
    border-color: blue,
    title-color: blue.lighten(30%),
    body-color: blue.lighten(95%),
    footer-color: blue.lighten(80%)
  ),[
  *Specific Aim 1: Develop a new method to improve the estimate of outcomes in this population.*
])

#showybox(frame: (
    border-color: blue,
    title-color: blue.lighten(30%),
    body-color: blue.lighten(95%),
    footer-color: blue.lighten(80%)
  ),[
  *Critical analytic decision: Represent mortality as a binary variable.*
], 
[While there are stories of people passing back and forth between this world and the next (e.g. see Orpheus and Euridyce), we have elected to model mortality as a binary outcome. Although this reduces the validity of any measurements related to study participants traveling to and subsequently returning from the underworld, it does reflect a more stable representation for most planned study participants who are real people and not mythical figures.] 
)

#grid(columns: (1.6fr, 1fr), gutter: 10pt,
[#lorem(75)],
[
  #let x = lq.linspace(0, 10)
#let y = x.map(x => calc.sin(0.1 * x * x))

#lq.diagram(
  lq.plot(x, y),
  lq.plot(x, x => calc.sin(x + 0.541))
)
]
)

= References

#bibliography("grant_references.bib", title : none, style: "vancouver-superscript")  


