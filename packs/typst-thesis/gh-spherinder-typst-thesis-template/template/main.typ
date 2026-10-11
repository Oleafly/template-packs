#import "thesis.typ": thesis, todo
#import "glossary.typ": glossary, abbreviations

#show: thesis.with(
  title: "Your Thesis Title Here",
  author: "Your Name",
  kind: "Semester Project",
  date: "Month Year to Month Year",
  supervisors: (
    (role: "Supervisor", name: "Prof. Firstname Lastname"),
    (role: "Co-Supervisors", name: ("Firstname Lastname", "Firstname Lastname")),
  ),
  keywords: (
    "keyword one",
    "keyword two",
    "keyword three",
  ),
  synopsis: [
    A short abstract of your work. Say what problem you tackle, the approach you
    take, and the headline result. A couple of paragraphs is plenty — this sits
    on its own page before the table of contents.
  ],
  // logo-center: image("assets/project-logo.svg"),
  glossary: glossary,
  abbreviations: abbreviations,
  bibliography: bibliography("bibliography.bib", full: true),
  // declaration: align(center, image("assets/declaration.png", width: 115%)),
)

#include "content.typ"
