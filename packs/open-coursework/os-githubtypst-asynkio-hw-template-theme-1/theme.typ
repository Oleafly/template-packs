#import "@preview/cjk-unbreak:0.1.1": remove-cjk-break-space
#import "@preview/oxifmt:0.3.0": strfmt

#let project(
  title: "",
  authors: (),
  date: none,
  body,
) = {
  set document(author: authors.map(a => a.name), title: title)
  set page(numbering: "1", number-align: center)
  set text(font: ("Libertinus Serif", "HYShuSongEr"), lang: "zh")
  // set heading(numbering: "1.1")

  show: remove-cjk-break-space
  show strong: text.with(
    font: ("Libertinus Serif", "HYZhongHei"),
    baseline: 0pt,
  )
  show heading: text.with(font: ("Libertinus Serif", "HYZhongHei"))
  show raw: set text(font: ("Hack", "Noto Sans CJK SC"))
  show math.equation: set text(font: ("Libertinus Math", "HYShuSongEr"))
  show table.cell.where(y: 0): strong
  show table.cell.where(x: 0): strong
  set enum(numbering: n => text(font: "HYShuSongEr")[(#n)])

  show raw.where(block: true): set text(size: 6pt)
  show raw: set block(
    width: 95%,
    fill: luma(90%),
    inset: 9pt,
    radius: 4pt,
  )

  show link: underline
  show link: set text(eastern)

  // Title row.
  align(center)[
    #block(text(weight: 700, 1.75em, title))
    #v(1em, weak: true)
    #date
  ]

  // Author information.

  // Author information.
  pad(
    top: 0.5em,
    bottom: 0.5em,
    x: 2em,
    grid(
      columns: (1fr,) * calc.min(3, authors.len()),
      gutter: 1em,
      ..authors.map(author => align(center)[
        *#author.name* \
        #author.email \
        #author.affiliation
      ]),
    ),
  )

  // Main body.
  set par(justify: true)

  body
}
