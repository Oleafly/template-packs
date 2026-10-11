
// Generic SVG icon loader — loads static/<name>.svg
#let icon(name, static-path: "../static/") = box(
  height: 0.85em,
  baseline: 0.1em,
  image(static-path + name + ".svg"),
)

// CV Template
#let template_cv(doc) = [
  #set page(
    paper: "a4",
    margin: (x: 0.5in, y: 0.5in),
    numbering: none
  )
  #set text(size: 10pt, font: "Helvetica Neue")
  #set par(justify: false, leading: 0.65em)

  #show heading.where(level: 1): it => [
    #text(fill: rgb("#4169E1"), weight: "bold", size: 11pt)[#it.body]
    #v(-1em)
    #line(length: 100%, stroke: 0.5mm + rgb("#4169E1"))
  ]
  #doc
]

#let experience(job) = {
  let job = job.at(0)
  [
    *#job.title*
    #h(1fr) #job.city
    #v(-0.5em)
    #text(size: 9pt)[_#(job.company)_]
    #h(1fr) #text(size: 9pt)[#job.period]
  ]
}

#let education(edu) = {
  let edu = edu.at(0)
  [
    *#(edu.institution)*
    #h(1fr) #edu.city
    #v(-0.5em)
    #text(size: 9pt)[_#(edu.degree)_ (_#(edu.grade)_)]
    #h(1fr) #text(size: 9pt)[#(edu.period)]
  ]
}

#let skills(..items) = {
  for (icon, name) in items.pos() {
    icon
    h(0.2em)
    name
    h(0.8em) // Space between items
  }
}

// Cover letter Template
#let template_letter(doc) = [
  #set page(
    paper: "us-letter",
    margin: (x: 1in, y: 1in),
  )
  #set text(
    font: "New Computer Modern",
    size: 11pt,
  )
  #set par(
    justify: true,
    leading: 0.65em,
  )
  #doc
]
