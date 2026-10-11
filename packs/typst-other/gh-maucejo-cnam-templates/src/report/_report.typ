#import "../common/_colors.typ": *
#import "../common/_utils.typ": *
#import "_report-utils.typ": *

#let default-titre = (
  titre: none,
  surtitre: ("En-tête", "personnalisable"),
  composante: "cnam",
  alignement: "irreg",
  logo: none
)

#let cnam-rapport(
  config-titre: (:),
  toc: true,
  sec-number: true,
  body
) = {
  let titre-dict =  default-titre + config-titre

  set text(font: "Crimson Pro", size: 12pt, lang: "fr", ligatures: false)
  // , number-type: "old-style")

  set par(justify: true)

  set list(indent: 1em, marker: ([#text(fill:primary.dark-blue)[#sym.bullet]], [#text(fill:primary.dark-blue)[#sym.triangle.filled.r]], [#text(fill:primary.dark-blue)[--]]))

  set enum(indent: 1em)

  set page(
    paper: "a4",
    header: none,
    footer: none
  )

  show outline.entry: it => {
    set text(font: "Raleway")
    if it.level == 1 {
      set text(fill: primary.red, weight: "bold")
      block(above: 0.5em, below: 0.1em)[#it]
    } else {
      set text(fill: primary.dark-blue)
      block(above: 0.25em, below: 0em)[#it]
    }
  }

  title-page(titre-dict)

  if toc {
    show heading.where(level: 1): it => {
    set text(size: 16pt, fill: primary.dark-blue)
    it
    v(1em)
    }
    set outline.entry(fill: none)
    outline(depth: 2)
    pagebreak()
  }

  let numbering = none
  if sec-number {
    numbering = "1.1."
  }
  set heading(numbering: numbering)
  show heading.where(level: 1): it => {
    set text(font: "Raleway", size: 14pt, fill: primary.red)

    it
    v(0.5em)
  }

  show heading.where(level: 2): it => {
    set text(font: "Raleway", size: 12pt, fill: primary.dark-blue)
    it

    v(0.5em)
  }

  show heading.where(level: 3): it => {
    set text(font: "Raleway", size: 11pt, fill: primary.dark-blue)
    it

    v(0.5em)
  }

  let footer = context {
    let current-page = counter(page).at(here()).first()
    if calc.odd(current-page) {
      set align(right)
      box(outset: 6pt, stroke: (right: 1pt + primary.dark-blue, bottom: 1pt + primary.dark-blue))[#current-page]
    } else {
      set align(left)
      box(outset: 6pt, stroke: (left: 1pt + primary.dark-blue, bottom: 1pt + primary.dark-blue))[#current-page]
      }
  }

  show figure.where(kind: table): set figure.caption(position: top)
  set ref(supplement: none)

  set page(
    paper: "a4",
    footer: footer
  )
  counter(page).update(1)

  body
}