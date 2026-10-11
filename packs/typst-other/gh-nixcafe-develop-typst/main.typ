#set page(width: auto, height: auto, margin: 2.5cm)
#set par(justify: true)
#set text(font: "Libertinus Serif", size: 11pt)

#align(center, block(inset: 12pt)[
  #text(size: 2em, weight: "bold")[Example Document]
  #v(0.5em)
  #text(size: 1.1em)[Author]

  #v(1em)
  #line(length: 40%)
  #v(1em)

  #text(size: 1em)[#datetime.today().display()]
])

#v(1.5em)

= Introduction
This is a reproducible Typst document powered by Nix flakes.

== Math
Inline math: $E = m c^2$.

Display math:
$ integral_a^b f(x) dif x = F(b) - F(a) $

== Lists
+ First item
+ Second item
+ Third item

== Code Block
```typ
#let add(x, y) = x + y
#add(1, 2)
```

== Table
#figure(
  table(
    columns: (auto, auto, auto),
    inset: 10pt,
    align: center + horizon,
    table.header([*Name*], [*Value*], [*Unit*]),
    [$alpha$], [0.5], [m],
    [$beta$], [1.2], [s],
    [$gamma$], [3.7], [kg],
  ),
  caption: [A sample table.]
)
