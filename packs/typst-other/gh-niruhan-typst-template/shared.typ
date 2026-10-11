#import "@preview/touying:0.5.3": *
#import themes.university: slide as university-slide

// -------------------------------------------------------------
// COLORS
// -------------------------------------------------------------
#let western-purple = rgb("#4F2683")
#let western-orchid = rgb("#8F55E0")
#let western-grey   = rgb("#807F83")
#let western-white  = rgb("#FFFFFF")

#let western-tint = western-purple.lighten(94%)
#let good-green   = rgb("#2E7D4F")
#let flag-red     = rgb("#B23A48")

// -------------------------------------------------------------
// HELPER BOXES
// -------------------------------------------------------------
#let note-box(body) = block(
  fill: western-tint,
  stroke: (left: 3pt + western-orchid),
  inset: 10pt,
  radius: 2pt,
  body,
)

#let strength-box(body) = block(
  fill: good-green.lighten(92%),
  stroke: (left: 3pt + good-green),
  inset: 10pt,
  radius: 2pt,
  body,
)

#let weakness-box(body) = block(
  fill: flag-red.lighten(92%),
  stroke: (left: 3pt + flag-red),
  inset: 10pt,
  radius: 2pt,
  body,
)

// -------------------------------------------------------------
// DISCUSSION BOX
// -------------------------------------------------------------
#let discuss(body) = align(center + horizon)[
  #block(
    fill: western-tint,
    stroke: 1pt + western-orchid,
    inset: 18pt,
    radius: 4pt,
    width: 85%,
    text(size: 21pt, body),
  )
]

// -------------------------------------------------------------
// CUSTOM SLIDE — adds space below the header
// -------------------------------------------------------------
#let slide = university-slide.with(
  setting: body => {
    v(0.5em)
    body
  },
)