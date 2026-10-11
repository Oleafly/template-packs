#let thesis-setup(meta, body) = {
  set document(
    title: meta.title,
    author: meta.author,
  )

  set page(
    paper: "a4",
    margin: (x: 2cm, y: 2cm),
    numbering: none,
  )

  set text(
    font: "New Computer Modern",
    size: 11pt,
  )

  set par(
    justify: true,
    leading: 1.5em,
  )

  set heading(numbering: "1.")
  set figure(numbering: "1")
  set table(inset: 6pt)
  set math.equation(
    numbering: "(1)",
    number-align: end + horizon,
  )

  show math.equation: set block(breakable: true)
  show figure.where(kind: table): set figure.caption(position: top)

  body
}

#let title-page(meta) = align(center)[
  #v(10%)
  #text(size: 18pt, weight: "bold")[#meta.university]
  #v(0.8em)
  #text(size: 14pt)[#meta.faculty]
  #v(3em)
  #text(size: 22pt, weight: "bold")[#meta.title]
  #v(1em)
  #text(size: 13pt, style: "italic")[#meta.subtitle]
  #v(3em)
  #grid(
    columns: (1fr, 1fr),
    gutter: 1.2em,
    align(left)[*Author* \ #meta.author],
    align(left)[*Advisor* \ #meta.advisor],
  )
  #v(1em)
  #grid(
    columns: (1fr, 1fr),
    gutter: 1.2em,
    align(left)[*Program* \ #meta.program],
    align(left)[*Date* \ #meta.date],
  )
  #v(4em)
  #text(size: 11pt, fill: rgb("666666"))[
    Thesis sandbox for learning Typst through a computational structural engineering case study.
  ]
]

#let chapter-kicker(label, body) = block(
  fill: rgb("F4F7FB"),
  stroke: 0.8pt + rgb("D6E0EA"),
  inset: 10pt,
  radius: 6pt,
)[
  #text(weight: "bold", fill: rgb("3A6EA5"))[#label]\
  #body
]

#let result-card(title, value, note) = block(
  width: 100%,
  fill: rgb("FAFAFC"),
  stroke: 0.7pt + rgb("DADDE5"),
  inset: 10pt,
  radius: 6pt,
)[
  #text(size: 10pt, fill: rgb("666666"))[#title]\
  #v(0.2em)
  #text(size: 18pt, weight: "bold")[#value]\
  #v(0.3em)
  #note
]

#let callout(title, body) = block(
  fill: rgb("FFF7E6"),
  stroke: 0.7pt + rgb("E7C46A"),
  inset: 10pt,
  radius: 6pt,
)[
  #text(weight: "bold")[#title]\
  #body
]

#let csv-results-table(path, caption) = {
  let rows = csv(path)
  let header = rows.at(0)
  let body = rows.slice(1)

  figure(
    table(
      columns: header.len(),
      table.header(..header.map(cell => [#strong(cell)])),
      ..body.flatten().map(cell => [#cell]),
    ),
    caption: caption,
  )
}
