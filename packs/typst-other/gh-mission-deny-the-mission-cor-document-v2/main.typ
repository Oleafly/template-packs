#import "glossary.typ": *
#import "literature-review.typ"

#set page(
  paper: "a4",
  margin: (left: 2.5cm, right: 2.5cm, top: 2.5cm, bottom: 2.5cm)
)

#set text(
  font: "New Computer Modern",
  size: 11pt
)

#set par(
  justify: true,
  first-line-indent: 1.2em
)

#set heading(numbering: "1.1")

#show link: set text(fill: blue)

#align(center)[
  #text(size: 20pt, weight: "bold")[
    Improving Realism and Immersion in Cyber Security Educational Scenarios through Generative AI
  ]

  #v(1em)

  #text(size: 14pt)[Harry James Hall]

  #v(0.5em)

  #text(size: 12pt)[July 2025 - January 2026]
]

#v(2em)

#outline(
  title: "Table of Contents",
  indent: auto
)

#v(2em)

// Cliffe: "cyber security" has 2 words in the UK
// Cliffe: Typst seems great actually!
// Cliffe: I suggest you organise this main file to just be a list of includes, as it's confusing that some whole sections are imports while other top-level sections are not.

#include "introduction.typ"
#include "aims-and-objectives.typ"
#include "research-questions.typ"
// Cliffe: literature review should include SecGen, Hackerbot, and position your work.
#include "literature-review.typ"
#include "methodology.typ"
// Cliffe: outline how your research involves separate DSR studies, and list them.
#include "studies.typ"
#include "feasibility.typ"
#include "research_training.typ"

#bibliography("zotero.bib", style: "harvard-cite-them-right")

#printglossary()
