#let ft(txt) = text(size: 0.8em, style: "italic")[#txt]

#set page(numbering: "i",
  header: context {
    align(left)[#counter(page).display()]
  },)
#counter(page).update(2)
// This page is the supervisor information
#text(size: 1.2em)[
#table(
  columns: (12.5em, 1fr),
  align: (left, left),
  column-gutter: 1em, row-gutter: -.1em,
  stroke: none,
  [*Supervising professor*#v(.2em)],[],
  [#h(1em)Title], [Name],
            [],[#ft[Institute]],
            [],[#ft[Institute]#v(1em)],
  [*Supervisors*#v(.2em)],[],
  [#h(1em)Title], [Name],
            [],[#ft[Institute]],
            [],[#ft[Institute]#v(1em)],

  [*Pre-examiners*#v(.2em)],[],
  [#h(1em)Title], [Name],
            [],[#ft[Institute]#v(1em)],
  [#h(1em)Title], [Name],
            [],[#ft[Institute]#v(1em)],
  [*Opponent*#v(.2em)],[],
  [#h(1em)Title], [Name],
            [],[#ft[Institute]],
            [],[#ft[Institute]#v(1em)],
)]
#v(1fr)
#align(center)[
  ISBN ??(printed version) \
  ISSN ?? \
  Helsinki 20?? \
  Unigrafia Oy #v(2em)
  ISBN ??\
  ISSN ??\
  `https://ethesis.helsinki.fi`\
  Helsinki 20??\
  Electronic Poblications @ University of Helsinki\
  (Helsingin yliopiston verkkojulkaisut)
]
#pagebreak(weak: true)

This page is copyright info
#pagebreak(weak: true, to: "odd")

#heading(numbering: none, outlined: true, level: 1)[Acknowledgement]
Some people prefer putting this at the end. It is a matter of taste to my opinion.
#pagebreak(weak: true, to: "odd")

#heading(numbering: none, outlined: true, level: 2)[Abstract]
#lorem(30)
#pagebreak(weak: true, to: "odd")

#v(4em)
#heading(numbering: none, outlined: true, depth: 2)[Contents]
#v(3em)
#outline(title: none, indent: 1.8em, depth: 3)
#pagebreak(weak: true)

#heading(numbering: none, outlined: true, level: 2)[List of symbols]

// Define a borderless table with two columns
#table(
  columns: (3em, 1fr),
  align: (right, left),
  column-gutter: 1em,
  //row-gutter: .5em,
  stroke: none,

  [$H$], [Hessian matrix],
  [$E_k$], [Kinetic energy],
  [$E_p$], [Potential energy],
  [$E_A$], [Activation energy barrier],
  [$sigma$], [Stress],
  [$epsilon$], [Strain],
  [$omega$], [Vibrational frequency],
)
#pagebreak(weak: true)
#heading(numbering: none, outlined: true, level: 2)[Abbreviations]
#{
  show table.cell.where(x: 0): set text(weight: "bold")
  table(
    columns: (3em, 1fr),
    align: (right, left),
    column-gutter: 1em,
    //row-gutter: .5em,
    stroke: none,

    [PEL], [Potential energy landscape],
    [ART], [Activation-relaxation technique],
)
}
#pagebreak(weak: true, to: "odd")
