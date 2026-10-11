#import "prelude.typ": *
#show: abbr.show-rule
#show: make-glossary

#abbr.make(
  ("API", "Application Programming Interface"),
  ("ECS", "Entity Component System", "Entity Component Systems"),
)

#register-glossary(glossary)

#show: thesis.with(
  title: "My very fancy thesis title.",
  thesis-type: "Bachelorarbeit",
  author: "Georg Simon Ohm",
  program: "Informatik",
  student-id: "123 4567",
  faculty: "Fakultät Informatik",
  first-examiner: "Prof. Dr. Korbinian Riedhammer",
  second-examiner: "Prof. Dr. Bartosz von Rymon Lipinski",
  // Uncomment these for an industry thesis.
  // advisor: "M.Sc. Martina Schmidt",
  // company: "Musterfirma GmbH",
  logo: "figures/ohm-logo.png",
  keywords: ("hot", "fuzz"),
)

#frontmatter[
  #include "content/0_abstract.typ"
  asdasd
  #outline(title: [Contents], depth: 2)
]

#mainmatter[
  #include "content/1_intro.typ"
  #include "content/2_data.typ"
  #include "content/3_method.typ"
  #include "content/4_experiments.typ"
  #include "content/5_outlook.typ"
  #include "content/6_summary.typ"
]

#appendices[
  #include "content/a1_supplemental.typ"
]

#backmatter[
  #outline(title: [List of Figures], target: figure.where(kind: image))
  #outline(title: [List of Tables], target: figure.where(kind: table))
  #outline(title: [List of Listings], target: figure.where(kind: raw))

  #abbr.list(title: "Abbreviations", columns: 1)

  = References
  #bibliography("refs.bib", style: "ieee", title: none)

  = Glossary
  #print-glossary(glossary, show-all: true)
]
