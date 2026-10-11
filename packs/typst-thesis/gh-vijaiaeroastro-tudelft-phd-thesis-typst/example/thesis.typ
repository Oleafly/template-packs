#import "../src/tudelft-phd-thesis.typ": *

#show: thesis.with(
  title: "Studies in Radioactivity and Measurement",
  author: "Marie S. CURIE",
  bibliography: "../example/references.bib",
)

#show: front-matter
#title-page(
  title: "Studies in Radioactivity and Measurement",
  author: "Marie S. CURIE",
  defence-date: "Thursday, 25 June 1903 at 10:00 A.M.",
)
#committee-page(
  promotors: (
    ("Prof. dr. H. A. Lorentz", "Delft University of Technology, promotor"),
    ("Prof. dr. E. Noether", "Delft University of Technology, promotor"),
  ),
  members: (
    ("Prof. A. Einstein", "University of Zurich"),
    ("Prof. N. Bohr", "University of Copenhagen"),
    ("Prof. A. Lovelace", "Independent member"),
    ("Prof. S. Hawking", "University of Cambridge"),
  ),
  sponsors: align(center)[
    #grid(
      columns: (1fr, 1fr),
      column-gutter: 18pt,
      funding-mark("GUTENBERG", subtitle: "Research Foundation", accent: delft-navy),
      funding-mark("HELIOS", subtitle: "Science Fund", accent: delft-blue),
    )
  ],
  funding: [This fictional dissertation was supported by the Gutenberg Research Foundation and the Helios Science Fund.],
  keywords: [radioactivity; measurement; Typst; doctoral dissertation; template],
  printer: [Gutenberg Press, Delft],
  isbn: [000-0-000-00000-0],
  copyright: [Copyright © 1903 Marie S. Curie],
  repository-url: "https://repository.tudelft.nl/",
)

#pagebreak()
#table-of-contents()
#pagebreak()
#list-of-figures()
#pagebreak()
#list-of-tables()
#pagebreak()
#list-of-algorithms()
#pagebreak()
#list-of-listings()
#blank-page()

#include "front-matter/summary.typ"
#blank-page()
#pagebreak()
#include "front-matter/summary-nl.typ"
#blank-page()

#show: main-matter
#chapter(title: "Introduction", body: include "chapters/introduction.typ", first: true)
#chapter(title: "Experimental Apparatus", body: include "chapters/apparatus.typ")
#chapter(title: "Measurement Protocol", body: include "chapters/methods.typ")
#chapter(title: "Results and Interpretation", body: include "chapters/results.typ")
#chapter(title: "Conclusion", body: include "chapters/conclusion.typ")
#bibliography-section()

#show: appendix-matter
#appendix(title: "Additional Material", body: include "appendices/additional-material.typ")

#show: back-matter
#pagebreak()
#include "back-matter/epilogue.typ"
#blank-page()
#pagebreak()
#include "back-matter/acknowledgements.typ"
#blank-page()
#pagebreak()
#include "back-matter/cv.typ"
#pagebreak()
#include "back-matter/publications.typ"
#blank-page()
#pagebreak()
#include "back-matter/presentations.typ"
#blank-page()
#pagebreak()
#include "back-matter/propositions.typ"
