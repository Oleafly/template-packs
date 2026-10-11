#import "@preview/touying:0.6.1": *
#import themes.metropolis: *

#let bg = rgb("#fafafa")
#let accent = rgb("1a5fdc")
#let greytext = rgb("999999")

#show: metropolis-theme.with(
  aspect-ratio: "16-9",
  config-common(show-notes-on-second-screen: right),  
  config-colors(
    primary: accent,           // bold text, footer progress
    primary-light: bg,         // footer progress (left over)
    secondary: accent,         // header
    neutral-dark: accent,      // attention slides
    neutral-lightest: bg,

  ),
  // footer: self => text(size: 0.8em, []),
  footer-right: text(size: 0.8em, [#context utils.slide-counter.display()]),
  config-info(
    title: [This is a cool presentation],
    subtitle : [Made with touying!],
    author: "Author <author@example.com>",
    date: [1st Jan, 1970],
    institution: [
      #grid(columns: 2, gutter: 1em,
        image("figures/typst.png", width: 2em),
        [Typst University],
      )
    ]
  ),
)

// Styling
#set text(font: "Roboto", weight: "light", size: 25pt)
#set list(marker: sym.triangle.filled.r)
#show figure.caption: c => [
  #set text(size: 20pt)
  #c.body
]

// Functions
#let note(body) = { text(fill: greytext, [(#body)]) }
#let grey(body) = { text(fill: greytext, body) }
#let greyoutafter(body) = {
  alternatives([
    #body
  ], [
    #text(fill: greytext, [
      #body
    ])
  ])
}
#let ccalign(body) = { align(horizon+center, body) }
#let dual(cleft: 50%, cright: 50%, gutter: 1%, calign: left, left, right) = {
  grid(
    columns: (cleft, cright),
    gutter: gutter,
    align(calign, left),
    align(calign, right)
  )
}
#let triple(cleft: 30%, ccenter: 30%, cright: 30%, gutter: 1%, row-gutter: none, calign: left, left, center, right) = {
  grid(
    columns: (cleft, ccenter, cright),
    gutter: gutter,
    row-gutter: if row-gutter == none { gutter } else { row-gutter },
    align(calign, left),
    align(calign, center),
    align(calign, right)
  )
}

// PRESENTATION STARTS HERE...
#speaker-note()[
  - some introductory words...
]
#title-slide()

= Introduction
== Introduction


#ccalign(lorem(20))

== Grids

#dual(calign: center,[
  #image("figures/typst.png", height: 50%)
  ], [
    this..

    #pause
    #v(1em)
    but also this!
  ]
)

---

#dual(cleft: 20%, cright: 80%, [
  Also with adjustable column size
], [
  - one
  - another
  - and another
])

#speaker-note()[
  this is very important

  #text(size: 0.7em, [
    tip: use text function, if you need more speaker notes
  ])
]

---

#dual(cleft: 65%, [
  #only((1,2,3))[- Typst]
  #only((2,3))[- More Typst]
  #only(3)[- Even more Typst!]
], [
  #only(1)[#image("figures/typst.png", height: 50%)]
  #only(2)[#image("figures/typst.png", height: 50%)]
  #only(3)[#image("figures/typst.png", height: 50%)]
])

---

// default grids are still usefull to have :)
#grid(columns: (33%, 33%, 33%), row-gutter: 20%,
  only((1,2,3))[#align(center, image("figures/typst.png", width: 60%))],
  only((2,3))[#align(center, image("figures/typst.png", width: 60%))],
  only(3)[#align(center, image("figures/typst.png", width: 60%))],
  only((1,2,3))[#align(center, [Typst!])],
  only((2,3))[#align(center, [Horizontal!])],
  only(3)[#align(center, [whoaaa])],
)

---

#greyoutafter([- hello])
#greyoutafter([- im more important now!])
#greyoutafter([- nah, it's me!])

#focus-slide()[
  Important!
]
