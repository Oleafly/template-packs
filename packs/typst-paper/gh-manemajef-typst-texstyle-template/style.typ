#import "elements.typ": *
#import "@preview/bidi-flow:0.1.1": *

#let smartbreak = (thresh: 30%, it) => {
  block(breakable: false, height: thresh)
  v(-thresh, weak: true)
  it
}

#let addline = it => {
  grid(
    columns: (auto, 1fr),
    column-gutter: 1em,
    it, pad(top: 50%, line(length: 100%, stroke: .5pt)),
  )
}



#let _INDENT = 1.2em
#let _LI_INDENT = 1em
#let _PAR_SPACING = 1.1em
#let _LEADING = .55em

#let style = body => {
  let fonts = (
    ..("David CLM", "Libertinus Math").map(f => (name: f, covers: regex("\p{Hebrew}"))),
    "New Computer Modern",
  )

  set page(margin: 1in, numbering: "1")
  set par(justify: true, leading: _LEADING)
  set text(font: fonts)
  show raw: set text(font: "New Computer Modern Mono")
  show heading: set block(above: 1.4em, below: 1em)
  show heading.where(level: 1): it => smartbreak(thresh: 20%, it)
  show heading.where(level: 2): it => smartbreak(thresh: 10%, it)
  show title: it => block(below: 3em, width: 100%, {
    set text(weight: "regular")
    set align(center)
    it.body
  })

  set list(indent: _LI_INDENT)
  set enum(indent: _LI_INDENT)
  set table(stroke: none)
  show math.equation: set block(above: 1.25em, below: 1.25em)
  set math.equation(numbering: "(1)")

  show math.equation: it => {
    if it.block and not it.has("label") [
      #counter(math.equation).update(v => v - 1)
      #math.equation(it.body, block: true, numbering: none)#label("___NOLABEL")
    ] else {
      it
    }
  }
  show: bidi-flow
  body
}

#let article = (first-line-indent: 1.8em, heading-numbering: "1.1", body) => {
  show: style
  set par(first-line-indent: first-line-indent, spacing: .55em)
  set heading(numbering: heading-numbering)
  set page(margin: 1.5in)
  set list(indent: 1.5em)
  set enum(indent: 1.5em)
  show list: set block(above: 1.5em)
  show enum: set block(above: 1.5em)
  body
}
