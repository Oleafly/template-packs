#set page(
  paper: "a4",
  margin: (top: 1in, right: 1in, bottom: 1in, left: 1in),
)

#set text(font: "Times New Roman", size: 12pt)

#set heading(numbering: "1.a)")
#show heading: it => {
  block(
    it,
    below: 1em,
  )
}

#set par(leading: 1.0em)

#set page(
  header: context [
    #grid(
      columns: (1fr, auto),
      align: (left, right),
      gutter: 0pt,
      [Fancy Head],
      [#counter(page).display("1")],
    )
  ],
  footer: [],
)

#set bibliography(style: "ieee") // numeric-ish

#include "sections/title_page.typ"
#include "sections/abstract.typ"
#include "sections/introduction.typ"
#include "sections/methodology.typ"
#include "sections/experiments.typ"
#include "sections/results.typ"
#include "sections/discussion.typ"
#include "sections/future_work.typ"
#include "sections/conclusions.typ"
#include "sections/appendix.typ"

#pagebreak()
// Typst will only show documents that have been referenced here!
#bibliography("references.bib", title: "References")

