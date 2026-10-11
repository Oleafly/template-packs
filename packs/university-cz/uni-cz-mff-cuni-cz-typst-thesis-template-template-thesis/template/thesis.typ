// When installed as a local package, use:
//   #import "@local/mff-thesis:0.1.1": mff-thesis, abbr, ite
// For development directly from the repo:
#import "../lib.typ": abbr, ite, mff-thesis

// Must come before #show: mff-thesis.with(...)
#abbr.load("abbreviations.csv")
#abbr.config(style: it => text(black, it))

// ── Template ──────────────────────────────────────────────────────────────────
#show: mff-thesis.with(
  title: "Thesis title",
  title-local: "Název práce",
  author: "Jan Novak",
  department: "Department name",
  department-local: "Jméno katedry",
  supervisor: "doc. Jan Novak, Ph.D.",
  supervisor-department: "Department name",
  supervisor-department-local: "Katedra vedoucího",
  study-programme: "Computer Science",
  study-branch: "Systems Programming",
  year: 2026,
  keywords: ("keyword one", "keyword two", "keyword three"),
  keywords-local: ("slovo", "dalsi slovo", "jeste dalsi slovo"),
  abstract: lorem(80),
  abstract-local: "Česky " + lorem(80),
  acknowledgements: lorem(60),
  logo: image("logo-en.svg"),
  thesis-type: "bachelor",
  for-print: "digital",
)

#heading(numbering: none)[Introduction]

#lorem(60)

#lorem(60)

#pagebreak()

= Typography Showcase

== Paragraphs and Inline Formatting

A modern #abbr.a[OS] running on a #abbr.a[CPU] with limited #abbr.a[RAM] must
manage memory carefully. #lorem(40)

Words can be *bold*, _italic_, or _*bold italic*_. Inline `code` uses a
monospaced font. You can also use #smallcaps[small capitals] or
#underline[underlined text] sparingly. Superscripts#super[1] and
subscripts#sub[2] are available too.

#lorem(50)

== Lists

Unordered list:

- #lorem(30)
- #lorem(10)
- #lorem(10)
  - Nested item: #lorem(8)
  - Nested item: #lorem(8)
- #lorem(10)

Ordered list:

+ #lorem(10)
+ #lorem(10)
+ #lorem(10)
  + Nested step: #lorem(8)
  + Nested step: #lorem(8)
+ #lorem(10)

== Block Quotation

#lorem(20)

#quote(block: true, quotes: true, attribution: [Plato])[
  #lorem(100)
]

#lorem(20)

== Tables

#figure(
  table(
    columns: (auto, 1fr, 1fr),
    table.header[*Name*][*Value*][*Description*],
    [Alpha], [1.0], [#lorem(8)],
    [Beta], [2.5], [#lorem(8)],
    [Gamma], [0.3], [#lorem(8)],
  ),
  caption: [Sample data table.],
) <tab-sample>

@tab-sample shows a representative set of values. #lorem(20)

== Figures

#figure(
  rect(width: 10cm, height: 6cm, fill: luma(235), stroke: luma(160), radius: 4pt),
  caption: [Placeholder figure — replace with an actual image.],
) <fig-placeholder>

As shown in @fig-placeholder, #lorem(30)

== Mathematics

Inline mathematics: the area of a circle with radius $r$ is $A = pi r^2$.

The Pythagorean theorem states that for a right triangle with legs $a$, $b$
and hypotenuse $c$:

$ a^2 + b^2 = c^2 $ <eq-pythagoras>

@eq-pythagoras is one of the most fundamental results in geometry.

== Code Listings

Inline code: call `greet()` with a name string as the argument.

#figure(
  ```python
  def greet(name: str) -> str:
      """Return a greeting string."""
      return f"Hello, {name}!"

  print(greet("world"))
  ```,
  caption: [A minimal Python function demonstrating a docstring and f-string.],
) <lst-greet>

== Cross-References and Citations

#lorem(30) @knuth1984texbook. #lorem(20) @typst2024.

The `ite` helper strips the author prefix from numeric citations, leaving only
the bracketed number — useful with IEEE style: see #ite(<knuth1984texbook>).

== Heading Levels

=== Level Three

#lorem(30)

==== Level Four

#lorem(30)

===== Level five run-in. #lorem(20)

#lorem(30)

#pagebreak()
#heading(numbering: none)[Conclusion]

#lorem(80)

#pagebreak()
#outline(title: "List of Figures", target: figure)

#pagebreak()
#bibliography("sources.bib", style: "ieee-bc.csl")

#pagebreak()
#abbr.list()

#pagebreak()

#set heading(numbering: "A.1")
#counter(heading).update(0)

= Appendix

== First
