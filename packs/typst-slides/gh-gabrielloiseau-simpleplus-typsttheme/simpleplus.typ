// Bookly Slides: a Typst port of pm25/SimplePlus-BeamerTheme.
// This port is MIT licensed; the original theme is Unlicensed.
// Polylux provides Beamer-like slides and overlays; this file provides the look.
#import "@preview/polylux:0.4.0": slide, toolbox

#let dark-blue = rgb("#0d2659")
#let medium-blue = rgb("#045073")
#let medium-red = rgb("#ec5858")
#let medium-green = rgb("#5eb3a8")
#let muted-blue = rgb("#ebebf7")
#let muted-red = rgb("#f7ebeb")
#let muted-green = rgb("#ebf7eb")

// Apply once with `#show: simpleplus` before making slides.
#let simpleplus(body) = {
  set page(
    width: 160mm,
    height: 90mm,
    margin: (left: 7.7mm, right: 7.7mm, top: 5.6mm, bottom: 5.6mm),
    fill: white,
    footer: align(right, move(dx: 15.5pt, dy: 3.5pt, text(size: 5.98pt)[#toolbox.slide-number/#toolbox.last-slide-number])),
  )
  set text(font: "CMU Sans Serif", size: 10.91pt, fill: black)
  show raw: set text(font: "CMU Typewriter Text")
  set par(leading: 0.55em)
  set list(
    indent: 1em,
    body-indent: 0.5em,
    spacing: 0.83em,
    marker: (
      move(dy: -1.19pt, text(font: "New Computer Modern Math", size: 10.91pt, fill: dark-blue)[•]),
      move(dy: -1.19pt, text(font: "New Computer Modern Math", size: 10.91pt, fill: dark-blue)[•]),
    ),
  )
  show list: it => move(dy: 2.33pt, it)
  set enum(indent: 1em + 6.25pt, spacing: 0.83em, numbering: n => text(fill: dark-blue)[#n.])
  show enum: it => move(dy: -4.72pt, it)
  body
}

#let frame-heading(title, subtitle: none) = [
  #grid(
    columns: (1fr,),
    row-gutter: 3mm,
    [
      #text(size: 14.35pt, weight: "bold", fill: dark-blue)[#title]
      #if subtitle != none { [#v(0.7mm) #text(size: 11.96pt, fill: dark-blue)[#subtitle]] }
    ],
    line(length: 100%, stroke: (paint: dark-blue, thickness: 0.25pt)),
  )
]

// The main Beamer frame equivalent. Polylux overlays work inside `body`.
#let frame(title, body, subtitle: none, vertical: horizon) = slide[
  #place(top + left)[#block(width: 100%)[#frame-heading(title, subtitle: subtitle)]]
  #if vertical == top { [#v(15.75mm) #body] } else { align(vertical)[#body] }
]

#let title-slide(title, subtitle: none, author: none, institute: none, date: none, graphic: none) = slide[
  #place(center + top, dy: 25.49mm)[#text(size: 17.22pt, weight: "bold", fill: dark-blue)[#title]]
  #if subtitle != none { place(center + top, dy: 33.49mm)[#text(size: 10.91pt, weight: "bold", fill: dark-blue)[#subtitle]] }
  #if author != none { place(center + top, dy: 44.77mm)[#text(size: 11.96pt, tracking: -0.14pt)[#author]] }
  #if institute != none { place(center + top, dy: 50.64mm)[#align(center)[#text(size: 7.97pt, tracking: 0.2pt)[#institute]]] }
  #if date != none {
    let date-position = if author == none and institute == none { 44.77mm } else { 62.45mm }
    place(center + top, dy: date-position)[#text(size: 7.97pt, tracking: 0.2pt)[#date]]
  }
  #if graphic != none { place(center + top, dy: 71mm)[#graphic] }
]

// Pass sections as `( (title: [First], subsections: ([Topic],)), ... )`.
#let overview(sections) = frame([Overview], [
  #v(14.7mm)
  #for (i, section) in sections.enumerate() {
    block(below: 13.84mm)[
      #h(0.5mm) #text(size: 11.96pt, weight: "bold", fill: dark-blue)[#(i + 1). #section.title]
      #for (j, subsection) in section.at("subsections", default: ()).enumerate() {
        [#v(1mm) #h(8mm) #text(size: 9pt)[#(i + 1).#(j + 1) #subsection] #linebreak()]
      }
    ]
  }
], vertical: top)

#let alert(body) = text(fill: red, body)

#let colored-block(title, body, accent: medium-blue, tint: muted-blue) = {
  v(-2.31pt)
  move(dx: -1.5mm, block(width: 100% + 3mm, fill: tint, radius: 1.5mm, clip: true, above: 2.49mm, below: 0pt)[
    #block(width: 100%, fill: accent, inset: (x: 1.5mm, y: 0.9mm), above: 0pt, below: 0pt)[
      #text(fill: white, size: 11.96pt)[#title]
    ]
    #block(width: 100%, inset: (x: 1.5mm, y: 2mm), above: 0pt, below: 0pt)[#body]
  ])
  v(-0.55pt)
}

#let standard-block(title, body) = colored-block(title, body)
#let alert-block(title, body) = colored-block(title, body, accent: medium-red, tint: muted-red)
#let example-block(title, body) = colored-block(title, body, accent: medium-green, tint: muted-green)
#let theorem(title, body) = {
  v(-2.68pt)
  colored-block(title, body)
}

#let closing(body) = slide[
  #place(center + top, dy: 28.91mm)[#text(size: 24.79pt, weight: "bold", fill: black)[#body]]
]
