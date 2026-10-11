#import "thesis-type.typ": *

#import "@preview/datify:1.0.0": custom-date-format

#let detail-page(
  author,
  author-birthday,
  author-birthplace,
  title,
  type,
  program,
  start-date,
  submit-date,
  supervisor,
  professor,
) = {
  set page("a4", margin: 20%)
  set text(font: ("Noto Serif", "DejaVu Serif"), fallback: false, size: 9.5pt, weight: "regular")
  set align(horizon + center)
  set par(spacing: 3em, first-line-indent: 0em)
  show heading: set block(spacing: 3em)

  [
    #heading(outlined: false)[#title]

    #thesis-type-name(type) im Fach #program

    vorgelegt von

    *#author*

    geb. am
    #custom-date-format(author-birthday,
      pattern: "dd. MMMM yyyy", lang: "de"
    )\
    in #author-birthplace

    angefertigt am

    *Lehrstuhl für Informatik 3\
    Rechnerarchitektur*

    *Department Informatik\
    Friedrich-Alexander-Universität Erlangen-Nürnberg*

    #grid(columns: (50%, 50%), column-gutter: 2em,
    [
      #set align(right)
      Betreuer:\
      Betreuender Hochschullehrer:
    ],
    [
      #set align(left)
      *#supervisor*\
      *#professor*
    ])

    #grid(columns: (50%, 50%), column-gutter: 2em,
    [
      #set align(right)
      Beginn der Arbeit:\
      Abgabe der Arbeit:
    ],
    [
      #set align(left)
      *#custom-date-format(start-date,
        pattern: "dd. MMMM yyyy", lang: "de"
      )*\
      *#custom-date-format(submit-date,
        pattern: "dd. MMMM yyyy", lang: "de"
      )*
    ])
  ]
}