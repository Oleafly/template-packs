#import "default/lang.en.typ": lang as l
#import "default/config.typ": config as c

#set page(
  paper: "a4",
  margin: (x: 0.79in, y: 0.99in),
  header: [
    #image("kcci-logo.png", height: 0.22in)
  ],
)

#set text(
  font: "Arial",
  size: 10pt,
)

#set heading(numbering: "1.")

#show heading.where(level: 1): it => {
  set align(center)
  set text(size: 24pt, weight: "bold")
  it.body
  v(0.4em)
}

#show heading.where(level: 2): it => {
  v(0.5em)
  set text(size: 12pt, weight: "bold")
  counter(heading).display((..n) => str(n.pos().last()) + ". ")
  it.body
  v(0.2em)
}

#show heading.where(level: 3): it => {
  set text(size: 11pt, weight: "bold")
  counter(heading).display((..n) => str(n.pos().last()) + ". ")
  it.body
  v(0.5em)
}

= #l.title

#let thead(text) = table.cell(fill: rgb("#f2f2f2"))[#text]
#let smol(str) = text(size: 9pt, str)

== #l.personal.title
#table(
  columns: (3.2cm, 1fr, 2fr, 1fr, 2fr),
  align: center + horizon,
  stroke: 0.5pt + rgb("#bfbfbf"),
  inset: (y: 0.75em),

  table.cell(rowspan: 5)[#align(center + horizon)[
    #image("assets/photo.png", width: 3cm, height: 4cm, fit: "cover")
  ]],
  thead[#l.personal.name], smol[#c.personal.name], thead[#l.personal.company], smol[#c.personal.company],
  thead[#l.personal.dob], smol[#c.personal.dob], thead[#l.personal.position], smol[#c.personal.position],
  thead[#l.personal.address], table.cell(colspan: 3)[#align(left)[#smol[#c.personal.address]]],
  thead[#l.personal.phone], table.cell(colspan: 3)[#align(left)[#smol[#c.personal.phone]]],
  thead[#l.personal.email], table.cell(colspan: 3)[#align(left)[#smol[#c.personal.email]]],
  [#l.personal.competencies],
  table.cell(colspan: 4, fill: rgb("#f2f2f2"))[#align(left)[
    #smol[#c.personal.competencies]
  ]],
)

== #l.education.title
#table(
  columns: (1fr, 1.2fr, 1.5fr, 1fr, 1fr),
  inset: (y: 0.75em),
  align: center + horizon,
  stroke: 0.5pt + rgb("#bfbfbf"),

  thead[#l.education.period],
  thead[#l.education.institution],
  thead[#l.education.major],
  thead[#l.education.degree],
  thead[#l.education.location],
  ..for e in c.education {
    (
      (e.period),
      e.institution,
      [#if e.major == [] or e.gpa == [] [] else [#e.major / (#e.gpa)]],
      e.degree,
      e.location,
    ).map(smol)
  },
)

== #l.work.title
#table(
  columns: (1fr, 1fr, 2fr, 1fr),
  inset: (y: 0.75em),
  align: center + horizon,
  stroke: 0.5pt + rgb("#bfbfbf"),

  thead[#l.work.period], thead[#l.work.company], thead[#l.work.responsibilities], thead[#l.work.position],
  ..for e in c.work {
    (
      e.period,
      e.company,
      align(left, e.resp),
      e.position,
    ).map(smol)
  },
)

== #l.cert.title
#table(
  columns: (1fr, 1.5fr, 1fr, 1.5fr),
  inset: (y: 0.75em),
  align: center + horizon,
  stroke: 0.5pt + rgb("#bfbfbf"),

  thead[#l.cert.category], thead[#l.cert.level], thead[#l.cert.date], thead[#l.cert.org],
  ..for e in c.cert {
    (
      align(left, e.category),
      e.level,
      e.date,
      align(left, e.org),
    ).map(smol)
  },
)

#block(breakable: false)[
  == #l.training.title
  #table(
    columns: (2fr, 1fr, 2fr),
    inset: (y: 0.75em),
    align: center + horizon,
    stroke: 0.5pt + rgb("#bfbfbf"),

    thead[#l.training.course], thead[#l.training.period], thead[#l.training.provider],
    ..for e in c.training {
      (
        align(left, e.course),
        e.period,
        align(left, e.provider),
      ).map(smol)
    },
  )

]

#pagebreak()
= #l.statement.title

#let essay(message) = {
  table(
    columns: 1fr,
    inset: (y: 0.75em),
    align: left + horizon,
    stroke: 0.5pt + rgb("#bfbfbf"),
    message
  )
  v(1em)
}

=== #l.statement.motivation
#essay[
  #set text(weight: "bold")
  #smol(c.motivation)
]
=== #l.statement.skills
#essay[
  #set text(weight: "bold")
  #smol(c.skills)
]
#block(breakable: false)[
  === #l.statement.about
  #essay[
    #set text(weight: "bold")
    #smol(c.about)
  ]
]

#pagebreak()
= #l.project.title

#table(
  columns: (3cm, 1fr),
  inset: (y: 0.75em),
  align: left + horizon,
  stroke: 0.5pt + rgb("#bfbfbf"),

  thead[#align(center)[#l.project.name]], thead[#c.project.name],
  [#align(center)[#l.project.period]], smol[#c.project.period],
  [#align(center)[#l.project.role]], smol[#c.project.role],
  [#align(center)[#l.project.objectives]], smol[#c.project.objectives],
  [#align(center)[#l.project.tech]], smol[#c.project.tech],
  table.cell(colspan: 2)[#align(center)[#l.project.details]],
  table.cell(inset: 10pt, align: top, colspan: 2)[
    #set text(weight: "bold")
    #smol(c.project.details)
  ],
)
