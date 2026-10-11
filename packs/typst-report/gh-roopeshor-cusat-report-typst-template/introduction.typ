#import "@preview/algorithmic:1.0.7"
#import "@preview/wrap-it:0.1.1": wrap-content
#import algorithmic: algorithm-figure, style-algorithm
#show: style-algorithm

= Introduction

Commonly used contructs:

=== Grid:
#figure(
  grid(
    align: horizon,
    columns: 2,
    column-gutter: 50pt,
    row-gutter: 10pt,
    image("images/cusat.svg", height: 6cm), image("images/cusat.svg", height: 6cm),
    text([(a) fig1]), text([(b) fig2]),
    v(10pt),
  ),
  caption: [Common caption, (only this text will be listed in LOF)],
)<fig:cusat>


=== Floating figure:
#let fig = [
  #figure(
    image("images/cusat.svg", width: 4cm),
    caption: [Caption],
  )
]

#let body = [
  #lorem(60)
]

#wrap-content(fig, body, align: top + right)

=== Algorithm
#algorithm-figure(
  "Transmitter Initialization",
  {
    import algorithmic: *
    Line[Init Button and LED GPIO pins]
    Assign[`LED_SEND`][`HIGH`]
    If([Radio not responding], {
      Line[(Infinite loop)]
    })
    Line[Set radio in listening mode]
  },
)

=== Lists
unnumbered:
- 1
- a
- b

numbered:
+ a
+ b
+ c

=== Referncing

use `<ref>` to create a anchor, use `@ref` to reference them..
eg:
+ see fig @fig:cusat
+ in the @lit

Use same syntax to referenence a entry from bibliography: @history

=== Tables
https://typst.app/docs/guides/tables/

#figure(
  caption: "Table with row and column spans",
  table(
    columns: 5,
    align: center + horizon,
    inset: 12pt,
    [*Title 1*], [1], [2], [3], [4],
    [*title 2*], table.cell(colspan: 4)[5],
    [*title 4*], table.cell(rowspan: 2)[6], [], [8], [9],
    [*title 4*], [10], [11], [12],
  ),
)

#figure(
  caption: "Adjusted widths",
  table(
    columns: (1.5cm, 1fr, 2fr),
    align: center + horizon,
    inset: 12pt,
    [*No.*], [*title 2*], [*Title 3*],
    [10], [11], [12],
  ),
)
