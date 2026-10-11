#import "lib.typ": *
#import "@preview/acrostiche:0.7.0": init-acronyms, print-index, reset-all-acronyms
#import "acronyms.typ": acronyms

#init-acronyms(acronyms)

#show: thesis.with(
  paper: "a4",
  margin: 2.5cm,
  text-size: 12pt,
  line-leading: 0.75em,
  paragraph-spacing: 1.5em,
  heading-numbering: "1.1",
)

#title-page(
  title: [Your title],
  author: [Name, BSc],
  degree: [Master of Physics (Medical Physics)],
  supervisors: (
    [Dr. Name LAST NAME],
    [Adj/Prof. Name LAST NAME],
    [Dr. Name LAST NAME],
  ),
  date: datetime.today(),
  logo: image("img/uwa.PNG", width: 20%),
)

#front-matter[
  #front-section([Declaration])[
    #include "1_frontmatter/declaration.typ"
  ]

  #front-section([Acknowledgements])[
    #include "1_frontmatter/acknowledgements.typ"
  ]

  #front-section([Summary of Student's Achievements])[
    #include "1_frontmatter/achievements.typ"
  ]

  #outline(title: [Contents], depth: 5)
  #pagebreak()

  #outline(
    title: [List of Figures],
    target: figure.where(kind: image),
  )
  #outline(
    title: [List of Tables],
    target: figure.where(kind: table),
  )
  #pagebreak()

  #print-index(
    title: "Acronyms",
    // level: 1,
    numbering: none,
    outlined: false,
    used-only: false,
    sorted: "up",
  )
  #pagebreak()

  #front-section([Abstract])[
    #include "1_frontmatter/abstract.typ"
  ]
]

#reset-all-acronyms()

#main-matter[
  #include "2_body/introduction.typ"
  #include "2_body/methods.typ"
  #include "2_body/results.typ"
  #include "2_body/discussion.typ"
  #include "2_body/conclusions.typ"

  #pagebreak(weak: true)
  #bibliography(
    "references.bib",
    style: "ieee",
    title: [References],
  )

  #appendices[
    #include "3_backmatter/appendices.typ"
  ]
]
