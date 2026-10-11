#import "utu-thesis.typ": *

#let metadata = (
  title: "My Research Title",
  author: "John Doe",
  year: 2026,
  month: 1,
  university: "University of Turku",
  department: "Department of Computing",
  thesisType: "Master of Science (Tech) Thesis",
  lab: none,
  supervisors: ("Dr. Jane Smith", "Prof. John Wilson"),
  keywords: ("typist", "thesis"),
  includeTurnitin: false,
)


#show: doc => globalStyles(doc)

#coverPage(metadata: metadata)

#show: doc => lists(doc)
#tableOfContents()

#show: doc => mainContent(doc)


#include "1intro.typ"
#include "2background.typ"


#pagebreak()
#bibliography(
  (
    "references/example1.bib",
    "references/example2.bib",
  ),
  title: "References",
)
