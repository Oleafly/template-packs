// #let ft(txt) = text(size: 0.8em, style: "italic")[#txt]

#set page(numbering: "i",
  footer: context {
    align(center)[#counter(page).display()]
  },)
#counter(page).update(3)
// // This page is the supervisor information
// ACADEMIC DISSERTATION\
// _Tampere University, Faculty of Engineering and Natural Sciences Finland_#v(1em)
// #table(
//   columns: (12.5em, 1fr),
//   align: (left, left),
//   column-gutter: 1em, row-gutter: -.1em,
//   stroke: none,
//   [_Supervising professor_#v(.2em)],[],
//   [#h(1em)Title], [Name],
//             [],[#ft[Institute]],
//             [],[#ft[Institute]#v(1em)],
//   [_Supervisors_#v(.2em)],[],
//   [#h(1em)Title], [Name],
//             [],[#ft[Institute]],
//             [],[#ft[Institute]#v(1em)],
//
//   [_Pre-examiners_#v(.2em)],[],
//   [#h(1em)Title], [Name],
//             [],[#ft[Institute]#v(1em)],
//   [#h(1em)Title], [Name],
//             [],[#ft[Institute]#v(1em)],
//   [_Opponent_#v(.2em)],[],
//   [#h(1em)Title], [Name],
//             [],[#ft[Institute]],
//             [],[#ft[Institute]#v(1em)],
// )
// #v(1fr)
// The originality of this thesis has been checked using the Turnitin OriginalityCheck service.#v(1.5em)
// Copyright ©20?? ?author?#v(1.5em)
// Cover design: Roihu Inc.#v(1.5em)
//   ISBN ??(printed version) \
//   ISSN ?? \
//   ISBN ??(pdf version)\
//   ISSN ??\
//   `https://`#v(1.5em)
//   PunaMusta Oy -- Yliopistopaino\
//   Vantaa 2020
//
// #pagebreak(weak: true, to: "odd")

#heading(numbering: none, outlined: true, level: 1)[Acknowledgement]
- Sep. 2026:

I comment out the first 2 pages, which is the title page and supervising information page. Because it seems that you are required to use the `.docx` template for the first 2 pages. You can still insert the title page by providing the printed PDF of the title pages.

Also, the article cover page is now inserted as a 2 pages PDF file. The template is also provided and you need to first make a 2 page PDF from the template. Then just put the name of the pdf in the list of data, which is at the end of the `main.typ` file.

I might make an exact template for the title pages as well, but since very slight differences are inevitible, it is safer to use the template to get the exactly same output.

Some people prefer putting this at the end. It is a matter of taste to my opinion.
#pagebreak(weak: true, to: "odd")

#heading(numbering: none, outlined: true, level: 1)[Abstract]
#lorem(30)
#pagebreak(weak: true, to: "odd")

// outline
#heading(numbering: none, outlined: true, level: 1)[Contents]
#outline(title: none, indent: 1.8em, depth: 3)
#pagebreak(weak: true)

// outline of figures and tables
#heading(numbering: none, outlined: false, level: 2)[List of Figures]
#outline(title: none, target: figure.where(kind: image))
#heading(numbering: none, outlined: false, level: 2)[List of Tables]
#outline(title: none, target: figure.where(kind: table))

// outline of symbols and abbreviations
#heading(numbering: none, outlined: true, level: 1)[Symbols and Abbreviations]
#heading(numbering: none, outlined: false, level: 2)[Symbols]
// Define a borderless table with two columns
#table(
  columns: (3em, 1fr),
  align: (right, left),
  column-gutter: 1em,
  row-gutter: .5em,
  stroke: none,

  [$H$], [Hessian matrix],
  [$E_k$], [Kinetic energy],
  [$E_p$], [Potential energy],
  [$E_A$], [Activation energy barrier],
  [$sigma$], [Stress],
  [$epsilon$], [Strain],
  [$omega$], [Vibrational frequency],
)
#heading(numbering: none, outlined: false, level: 2)[Abbreviations]
#{
show table.cell.where(x: 0): set text(weight: "semibold")
table(
  columns: (3em, 1fr),
  align: (right, left),
  column-gutter: 1em,
  row-gutter: .5em,
  stroke: none,

  [PEL], [Potential energy landscape],
  [ART], [Activation-relaxation technique],
)
}
#pagebreak(weak: true, to: "odd")

// publication data
#heading(numbering: none, outlined: true, level: 1)[Original publications]

Publication I
#align(right)[
#box(width: 85%)[#set align(left)
*F. Lastname*, F. Lastname (2024): Title of the paper, _Journal of ??_, 628, 12840. DOI:
]]

Publication I
#align(right)[
#box(width: 85%)[#set align(left)
*F. Lastname*, F. Lastname (2024): Title of the paper, _Journal of ??_, 628, 12840. DOI:
]]

Publication I
#align(right)[
#box(width: 85%)[#set align(left)
*F. Lastname*, F. Lastname (2024): Title of the paper, _Journal of ??_, 628, 12840. DOI:
]]

Publication I
#align(right)[
#box(width: 85%)[#set align(left)
*F. Lastname*, F. Lastname (2024): Title of the paper, _Journal of ??_, 628, 12840. DOI:
]]

// author's contribution
#heading(numbering: none, outlined: true, level: 1)[Author's contribution]

In Publication I, the author has done ...

#pagebreak(weak: true, to: "odd")
