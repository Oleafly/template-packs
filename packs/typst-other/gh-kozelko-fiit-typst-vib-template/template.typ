#let make-title(
  name: "",
  title: "",
  subtitle: "",
  note: "",
  page-limit: "",
  study-programme: "",
  study-field: "",
  supervisor: "",
  date: "",
) = {
  set page(
    margin: (left: 2.5cm, right: 2.5cm, top: 2.5cm, bottom: 2.5cm),
    numbering: none,
  )

  set text(size: 11pt)
  set align(center)

  v(0mm)

  // University name
  text(size: 11pt)[
    Slovak University of Technology in Bratislava\
    Faculty of Informatics and Information Technologies
  ]

  v(1mm)
  line(length: 100%, stroke: 0.5pt)

  v(55mm)

  // Student name
  text(size: 11pt)[#name]

  v(10mm)

  // Thesis title
  text(size: 14pt, weight: "bold")[#title]

  v(10mm)

  // Subtitle
  text(size: 12pt)[#subtitle]

  v(10mm)

  // Note
  text(size: 12pt)[#note]

  v(10mm)

  // Page limit
  text(size: 12pt)[#page-limit]

  v(1fr)

  // Bottom information
  align(left)[
    #grid(
      columns: (auto, 1fr),
      column-gutter: 2em,
      row-gutter: 0.5em,
      [Study Programme:], [#study-programme],
      [Study Field:], [#study-field],
      [Thesis Supervisor:], [#supervisor],
      [#date], [],
    )
  ]
}

#let project(
  title: "",
  subtitle: "",
  name: "",
  note: "",
  page-limit: "",
  study-programme: "",
  study-field: "",
  supervisor: "",
  date: "",
  body,
) = {
  // Document setup
  set page(paper: "a4", margin: 3cm)
  set text(font: "New Computer Modern", size: 1.1em, lang: "en")
  set par(
    justify: true,
    leading: 1.3em,
    spacing: 1.5em,
    first-line-indent: 1em,
  )

  // Heading numbering
  set heading(numbering: "1.1.1")

  // Heading styles
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    set text(size: 16pt, weight: "bold")
    block(above: 2em, below: 2em, it)
  }

  show heading.where(level: 2): it => {
    set text(size: 14pt, weight: "bold")
    block(above: 1.5em, below: 1.5em, it)
  }

  show heading.where(level: 3): it => {
    set text(size: 13pt, weight: "bold")
    block(above: 1.2em, below: 1.2em, it)
  }

  // List spacing
  set list(indent: 1em, body-indent: 0.5em, spacing: 0.4em)
  set enum(indent: 1em, body-indent: 0.5em, spacing: 0.4em)

  make-title(
    name: name,
    title: title,
    subtitle: subtitle,
    note: note,
    page-limit: page-limit,
    study-programme: study-programme,
    study-field: study-field,
    supervisor: supervisor,
    date: date,
  )

  // Table of contents with Roman numerals
  set page(numbering: "i", number-align: center)
  counter(page).update(1)
  outline(title: "Contents", indent: auto, depth: 3)
  pagebreak()

  // Reset to Arabic numerals starting from 1 for main content
  set page(numbering: "1", number-align: center)
  counter(page).update(1)

  body
}
