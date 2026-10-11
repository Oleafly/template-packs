#import "thesis-type.typ": *

#import "@preview/datify:1.0.0": custom-date-format

#let faublue = rgb("#002E6C")

#let title-page(
  author,
  title,
  type,
  program,
  start-date,
  submit-date,
) = {
  set page("a4")
  set text(font: ("Noto Sans", "DejaVu Sans"), fallback: false, size: 14pt, weight: "regular")

  image("assets/fau-techfak-q.svg", width: 70%)

  v(20pt)

  let squaresize = 30pt
  curve(stroke: faublue,
    curve.move((-squaresize, 0%)),
    curve.line((100% - 2 * squaresize, 0%)),
    curve.line((100% - 2 * squaresize, squaresize)),
    curve.line((100% - squaresize, squaresize)),
    curve.line((100% - squaresize, 0%)),
    curve.line((100% + squaresize, 0%))
  )

  [
    #heading(outlined: false)[Lehrstuhl für Informatik 3]

    #heading(depth: 2, outlined: false)[Rechnerarchitektur]
  ]

  v(1.5*squaresize)
  line(stroke: faublue, start: (-squaresize, 0%), length: 100% + 2 * squaresize)
  v(squaresize)

  [
    #author
    #v(1pt)
    #text(size: 1.1em, weight: "bold")[#title]
    #v(1pt)
    #thesis-type-name(type)
    im Fach
    #program
    #v(1pt)
    #custom-date-format(submit-date,
      pattern: "dd. MMMM, yyyy", lang: "de"
    )
  ]

  set align(bottom)

  set text(size: 8pt)

  [
    Please cite as:\
    #author,
    "#title",
    #thesis-type-name(type, lang: "en"),
    University of Erlangen,
    Dept. of Computer Science,
    #custom-date-format(submit-date,
      pattern: "MMMM yyyy"
    )
  ]

  v(10pt)

  line(stroke: faublue, start: (-squaresize, 0%), length: 100% + 2 * squaresize)

  grid(columns: (50%, 50%),
  [
    #set align(top)
    #image("assets/fau-q.svg", width: 100%)
  ],
  [
    #v(5pt)
    #set align(right)
    Friedrich-Alexander-Universität Erlangen-Nürnberg\
    Department Informatik\
    Rechnerarchitektur

    Martensstr. 3 - 91058 Erlangen - Germany

    #link("https://www3.cs.fau.de")[www3.cs.fau.de]
  ])
}
