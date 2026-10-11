#let resume(name, contacts, body) = {
  // Page setup: A4, tight margins, no page number
  set page(
    paper: "a4",
    margin: (top: 1.0cm, bottom: 0.8cm, x: 1.25cm),
    numbering: none,
  )

  // Typography Settings
  set text(
    font: ("Times New Roman", "Songti SC"),
    size: 10pt,
    lang: "zh",
  )
  show raw: set text(font: "Menlo")

  // Link style: clickable but looks like normal text
  show link: set text(fill: rgb(25, 80, 150))

  // Paragraph & List Density Layout
  set par(justify: false, leading: 0.75em)
  set list(tight: false, indent: 1em)
  set enum(tight: false, indent: 1em)
  
  // Squeeze spacing between list items
  show list: set block(spacing: 0.65em)
  show enum: set block(spacing: 0.65em)

  // Head Section: Name & Contacts
  align(center)[
    #text(weight: "bold", size: 18pt)[#name]
    #v(0.3em)
    #contacts
  ]

  // Body content
  body
}

// Renders contact row items, divided by |
#let contact-row(items) = {
  items.join([ #sym.bar.v ])
}

// Renders section heading and a divider line
#let section-block(title, body) = {
  v(-0.2em)
  text(weight: "bold", size: 13pt)[#title]
  v(-0.65em)
  line(length: 100%, stroke: 0.5pt + black)
  v(0.2em)
  body
}

// Renders standard entry: title, subtitle, date, etc.
#let entry(title, subtitle: none, date: none, body: none) = {
  block(
    grid(
      columns: (1fr, auto),
      [
        #title
        #if subtitle != none {
          [ | #subtitle]
        }
      ],
      align(right)[#date]
    )
  )
  if body != none {
    body
  }
}

// Renders single project line inside entry (e.g. nested projects)
#let project-line(title, stack: none) = {
  block(
    grid(
      columns: (1fr, auto),
      title,
      align(right)[#stack]
    )
  )
}

// Renders italicized tech stack text
#let tech-stack(text) = {
  emph[技术栈: #text]
}

// Renders bold project description
#let project-desc(text) = {
  strong[项目简介：] + text
}

// Renders a thin subdivision line
#let subdivider() = {
  v(0.3em)
  align(center)[#line(length: 100%, stroke: 0.5pt + luma(180))]
  v(0.3em)
}
