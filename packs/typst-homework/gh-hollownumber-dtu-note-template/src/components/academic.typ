// Academic Components

#import "../colors.typ": *

#let definition(title: none, content) = {
  block(
    width: 100%,
    inset: 1.2em,
    fill: rgb("#f8f9ff"),
    stroke: (left: 4pt + dtu-blue),
    radius: (right: 3pt),
    breakable: true,
    [
      #text(weight: "bold", fill: dtu-blue, size: 12pt)[
        Definition#if title != none [ (#title) ]
      ]
      #v(0.3em)
      #content
    ],
  )
}

#let theorem(title: none, content) = {
  block(
    width: 100%,
    inset: 1.2em,
    fill: rgb("#fff8f8"),
    stroke: (left: 4pt + dtu-red),
    radius: (right: 3pt),
    breakable: true,
    [
      #text(weight: "bold", fill: dtu-red, size: 12pt)[
        Theorem#if title != none [ (#title) ]
      ]
      #v(0.3em)
      #content
    ],
  )
}

#let example(title: none, content) = {
  block(
    width: 100%,
    inset: 1.2em,
    fill: rgb("#f9fff9"),
    stroke: (left: 4pt + dtu-green),
    radius: (right: 3pt),
    breakable: true,
    [
      #text(weight: "bold", fill: dtu-green, size: 12pt)[
        Example#if title != none [ (#title) ]
      ]
      #v(0.3em)
      #content
    ],
  )
}
