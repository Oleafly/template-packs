#import "@preview/zebraw:0.6.3": *

#let normal_text_size = 13pt;

// alias of numbered math.equation
#let eqn(content) = {
  math.equation(block: true, numbering: "(1)", content)
}

// display a right aligned Q.E.D. symbol
#let rqed() = {
  h(1fr)
  $qed$
}

#let a4_default_style(body) = {
  // page default style
  set page(paper: "a4", numbering: "1", number-align: center, margin: (x: 1.6cm, y: 1.2cm))

  // paragraph default style
  set par(
    justify: false,
    linebreaks: "simple",
  )

  // text default style
  set text(
    hyphenate: true,
    font: "Maple Mono NF",
    size: normal_text_size,
    weight: "light",
  )

  // heading default style
  set heading(numbering: none)

  // terms default style
  set terms(hanging-indent: 0em)

  // let inline math equations look better
  show math.equation.where(block: false): it => h(0.125em, weak: true) + it + h(0.125em, weak: true)

  // code block default style, ligature off
  show raw: set text(font: "Maple Mono NF", size: 10pt, features: (calt: 0))

  // inline code block default style
  show raw.where(block: false): box.with(
    fill: luma(240),
    inset: (x: 4pt, y: 1pt),
    outset: (y: 3pt),
    radius: 0.2em,
  )

  // zebraw package style
  show: zebraw.with(inset: (top: 4pt, bottom: 4pt, left: 4pt, right: 4pt), indentation: 2, hanging-indent: true)

  body
}

#let header(title) = {
  align(center)[
    #set text(size: 20pt)
    #title
  ]
  line(length: 100%, stroke: 0.75pt + black)
}

#let _content_block_insect = 14pt
#let content_block(color: blue, title, content) = block(
  fill: color.lighten(90%),
  stroke: 0.5pt + color.lighten(45%),
  radius: 2pt,
  width: 100%,
  inset: _content_block_insect,
  above: 2em,
)[
  #place(
    top + left,
    dx: 10pt - _content_block_insect,
    dy: -10pt - _content_block_insect,
    rect(fill: color.lighten(22.5%), radius: 1pt, inset: 2.5pt, outset: 2pt)[
      #text(fill: white, title)
    ],
  )
  #content
]
