#import "@preview/bookly:2.0.0": *

#import "./preamble.typ": dunkelblau


#let custom(colors: default-colors, it) = {
  states.theme.update("custom")

  // ...

  it
}

// Part
#let part(title, show-number: true) = context {
  states.counter-part.update(i => i + 1)
  set page(
    header: none,
    footer: none,
    numbering: none
  )

  set align(center + horizon)

  pagebreak(weak: true, to:"odd")

  let dx = 0%
  if states.tufte.get() {
    dx = 21.68%
  }

  [
    #set page(background: [
      #place(dx: 1cm, dy: 6cm,
        image("./images/logo/MedUni-Wien.svg", width: 600%)
      )
      #box(width: 100%, height: 100%, fill: white.transparentize(5%))
    ])

    #set text(
      fill: dunkelblau.lighten(10%),
      font: (
        "Libre Baskerville",
        "Libertinus Serif"
      ),
    )

    #move(dx: dx)[
      #if show-number [
        #text(size: 2.5em)[#states.localization.get().part #states.counter-part.get().first()]
        #v(1em)
      ]
      #text(size: 3em)[*#title*]
    ]

    #show heading: none
    #heading(numbering: none)[#box[
      #if show-number [
        #states.localization.get().part #states.counter-part.get().first() --
      ]
      #title
    ]]
  ]

  pagebreak(weak: true, to: "odd")
}

#let minitoc = context {
  let toc-header = states.localization.get().toc
  block(above: 3.5em)[
    #text([*#toc-header*])
    #v(-0.5em)
  ]

  let miniline = line(stroke: 0.75pt, length: 100%)

  miniline
  v(0.5em)
  suboutline(target: heading.where(outlined: true, level: 2))
  miniline
}