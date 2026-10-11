#import "@preview/clean-acmart:0.0.1": acmart-ccs, acmart-keywords, acmart-ref, to-string
#import "template.typ": acmartVS

#let cuhk = super(sym.suit.spade)

#let title = [
  Computer Hamster: The logical evolution of the mouse
]
#let authors = (
  // You can use grouped affiliations with mark
  (
    name: [Hamsti Hamsterton],
    email: [hamsti\@uni-kassel.de],
  ),
)
#let affiliations = (
  (
    name: [University of Kassel],
    department: [Department of revolutionary computer peripheral devices],
    city: [Kassel],
  ),
)
#let conference = (
  name:  [ACM SIGOPS 31th Symposium on Operating Systems Principles],
  short: [SOSP ’25],
  year:  [2025],
  date:  [October 13–16],
  venue: [Seoul, Republic of Korea],
)
#let doi = "https://doi.org/10.1145/0000000000"


#show: acmartVS.with(
  title: title,
  authors: authors,
  affiliations: affiliations,
  conference: conference,
  doi: doi,
  copyright: none,
  // Set review to submission ID for the review process or to "none" for the final version.
  // review: [\#001],
)

#let ccs = (
  (
    generic: [Human-centered computing],
    specific: ([Human computer interaction (HCI)], [Interaction devices], ),
  ),
  (
    generic: [Bio-Inspired Computing],
    specific: ([Modeling and simulation], ),
  ),
)
#let keywords = ("Computer Hamster", "Novel Input Devices", "Bio-Inspired Computing", )

#include "text/abstract.typ"

#acmart-ccs(ccs)
#acmart-keywords(keywords)

// include your text here
#include "text/paper.typ"

#bibliography("refs.bib", title: "References", style: "association-for-computing-machinery")

#colbreak(weak: true)
#set heading(numbering: "A.a.a")

= Artifact Appendix
In this section we show how to reproduce our findings.

