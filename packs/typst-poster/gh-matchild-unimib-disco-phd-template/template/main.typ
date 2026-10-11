#import "unimib-DISCo-phd-template.typ": main-heading, dual-grid, wide-section


#show: main-heading.with(
  title: "My Poster Title: My Research Topic",
  author: "Name Surname",
  supervisor: "Name Surname",
  tutor: "Name Surname",
  email: "mail@mail.it",
  phdcycle: "XXX",
  logo-left: "Unimib.png",
  logo-right: none
)



#let problem-statement = [
  #lorem(150)
]
#let approach = [
  #lorem(150)
]
#let main-left = [
  #lorem(400)
]
#let main-right= [
  #lorem(400)
]
#let results = [
  #lorem(140)
]
#let references = [
  #bibliography("ref.bib", title:none,  style: "ieee")
]


///////////////////////////////////////
// Call layout functions
#dual-grid(
  "Problem Statement", problem-statement,
  "Approach", approach
)
#wide-section(
  "Main Section",
  main-left,
  main-right
)
#dual-grid(
  "Results", results,
  "References", references
)