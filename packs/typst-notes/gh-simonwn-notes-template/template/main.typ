#import "../lib.typ": notes

#show: notes.with(
  title: [Simple Note Template],
  authors: (
    (
      name: "Simon Winther",
      location: [Aarhus, Denmark],
      email: "name@example.com"
    ),
  ),
  bibliography: bibliography("refs.bib"),
  figure-supplement: [Fig.],
)

= Introduction
#lorem(25)

$ a + b = gamma $ <eq:gamma>

#lorem(25)

This is a reference @ppo.

= Methods

#figure(
  placement: none,
  circle(radius: 15pt),
  caption: [A figure]
) <fig:first>

#lorem(50)

== Detailed Method
#lorem(25)

#figure(
  caption: [Some Numbers in a Table],
  table(
    columns: (auto, auto),
    align: (center, right),
    inset: (x: 8pt, y: 4pt),
    stroke: (x, y) => if y <= 1 { (top: 0.5pt) },
    fill: (x, y) => if y > 0 and calc.rem(y, 2) == 0  { rgb("#efefef") },

    table.header[Number 1][Number 2],
    [1], [1.2],
    [2], [2.2],
    [3], [4.6],
    [4], [5.9],
    [5], [7.6],
  )
) <tab:numbers>

@fig:first shows a circle, whereas @tab:numbers shows a table of numbers.

#lorem(100)

#figure(
  caption: [Some Code],
```rust
fn main() {
    println!("Hello World!");
}
```
)
