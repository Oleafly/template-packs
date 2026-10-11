#import "@preview/showybox:2.0.4": showybox
#import "template.typ": main-color, math-color, code-color

// inline boxes
#let i-box-defaults(color: main-color) = (
  fill: color.lighten(90%),
  stroke: color,
  radius: 3pt,
  inset: (
    x: 0.2em,
    y: 0.05em,
  ),
  outset: (
    x: 0em,
    y: 0.25em,
  ),
)
#let idb(body) = (
  box(
    ..i-box-defaults(color: main-color),
    body,
  )
)
#let imb(body) = (
  box(
    ..i-box-defaults(color: math-color),
    body,
  )
)
#let icb(body) = (
  box(
    ..i-box-defaults(color: code-color),
    body,
  )
)

// Small boxes, adjusted to content, no title
#let small-box-defaults(color: main-color) = (
  fill: color.lighten(90%),
  stroke: color,
  radius: 5pt,
  inset: (
    x: 0.2em,
    y: 0.2em,
  ),
  outset: (
    x: 0.4em,
    y: 0.4em,
  ),
)
#let sdb(body, aligned: (center), title: none) = (
  align(aligned)[
    #block(
      ..small-box-defaults(color: main-color),
      body,
    )
  ]
)
#let smb(body, aligned: (center), title: none) = (
  align(aligned)[
    #block(
      ..small-box-defaults(color: math-color),
      body,
    )
  ]
)
#let scb(body, aligned: (center), title: none) = (
  align(aligned)[
    #block(
      ..small-box-defaults(color: code-color),
      body,
    )
  ]
)


// Normal boxes, with title and footer
#let box-defaults(color: main-color, width: auto, breakable: true, footer: none, title: none) = (
  frame: (
      border-color: color,
      title-color: color,
      body-color: color.lighten(90%),
      footer-color: color.lighten(80%),
      title-inset: (
        x: 1em,
        y: 0.4em,
      ),
      radius: 5pt,
    ),
    footer-style: (
      color: black.lighten(15%),
      weight: 600,
    ),
    title-style: (
      weight: 900,
    ),
    width: width,
    breakable: breakable,
    ..if (title != none) {
      (title: text(size: 1.1em)[#title],)
    },
    ..if (footer != none) {
      (footer: footer,)
    } 
)
#let db(body, title: none, breakable: true, width: 100%, footer: none, aligned: (center)) = [
  #align(aligned)[
    #showybox(
      ..box-defaults(
        color: main-color, 
        width: width, 
        breakable: breakable, 
        footer: footer, 
        title: title
      ),
      body,
    )
  ]
]
#let mb(body, title: none, breakable: true, width: 100%, footer: none, aligned: (center)) = [
  #align(aligned)[
    #showybox(
      ..box-defaults(
        color: math-color, 
        width: width, 
        breakable: breakable, 
        footer: footer, 
        title: title
      ),
      body,
    )
  ]
]
#let cb(body, title: none, breakable: true, width: 100%, footer: none, aligned: (center)) = [
  #align(aligned)[
    #showybox(
      ..box-defaults(
        color: code-color, 
        width: width, 
        breakable: breakable, 
        footer: footer, 
        title: title
      ),
      body,
    )
  ]
]
