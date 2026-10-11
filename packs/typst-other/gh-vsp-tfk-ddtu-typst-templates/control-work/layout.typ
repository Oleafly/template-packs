#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *

#let setup_layout(body) = {
  set text(
    font: "Times New Roman",
    size: 14pt,
    lang: "uk",
    region: "ua"
  )
  set page(
    paper: "a4",
    margin: (
      top: 2cm,
      right: 1cm,
      bottom: 2cm,
      left: 2.5cm
    ),
    numbering: "1",
    number-align: center + top
  )

  set heading(numbering: "1.")

  show heading: it => [
    #block(above: 2em, below: 1em)[#it]
  ]

  show heading.where(level: 1): it => [
    #set align(center)
    #pagebreak()
    #it
  ]

   set par(first-line-indent: (amount: 1.25cm, all: true), justify: true, leading: 1.5em)

  set list(indent: 1.25cm)
  // set enum(indent: 1.25cm)

  show link: underline

  show raw.where(block: true): it => [
    #par(leading: 1em)[#it]
  ]

  show heading.where(level: 1): it => {
    counter(math.equation).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
    it
  }

  set math.equation(numbering: num =>
    numbering("(1.1)", counter(heading).get().first(), num)
  )
  set figure(numbering: num =>
    numbering("1.1", counter(heading).get().first(), num)
  )

  show figure.caption.where(kind: raw): set align(left)

  // show raw: set text(font: "Fira Mono")
  show: codly-init.with()
  codly(
    zebra-fill: none,
    display-name: false,
    display-icon: false,
     languages: codly-languages,
  )

  body
}