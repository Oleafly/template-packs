#let title = [A Sample Academic Paper]
#let subtitle = [A Two-Column Conference-Style Template]

#set page(
  paper: "us-letter",
  margin: (x: 1.8cm, y: 2cm),
  columns: 2,
  numbering: "1",
)

#set text(font: "Libertinus Serif", size: 10.5pt)
#set par(justify: true, leading: 0.6em)

// --- Heading styles ---
#show heading.where(level: 1): it => [
  #set align(center)
  #set text(12pt, weight: "regular")
  #block(smallcaps(it.body), above: 1.5em, below: 0.6em)
]

#show heading.where(level: 2): it => text(
  size: 10.5pt,
  weight: "regular",
  style: "italic",
  it.body + [.],
)

// --- Title block ---
#place(top + center, float: true, scope: "parent", clearance: 2em)[
  #text(16pt, weight: "bold")[*#title*]

  #grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    [
      First Author \
      University of Somewhere \
      #link("mailto:first@example.edu")
    ],
    [
      Second Author \
      Another Institute \
      #link("mailto:second@example.edu")
    ],
  )

  #set par(justify: false)
  *Abstract* \
  #lorem(60)
]

= Introduction

Recent advances in typographic typesetting have led to renewed interest
in programmable document preparation systems. This paper presents a
template for academic writing using Typst @typst2024.

#lorem(60)

== Motivation

Traditional LaTeX workflows, while powerful, suffer from slow compile
times and opaque macro systems. Typst addresses these issues with a
modern scripting language and instant preview.

#lorem(40)

== Contributions

- We provide a minimal, reusable conference paper template.
- We demonstrate citation, figure, and table integration.
- We show how Typst's scripting enables custom styling.

= Methodology

Our approach follows the standard experimental pipeline described
in @prior-work. The key equation is:

$ R = (1 - alpha) sum_(i=1)^n w_i x_i + beta $

Where $alpha$ is the decay factor and $beta$ the bias term.

#lorem(80)

== Experimental Setup

We evaluate on three benchmark datasets summarized in @tbl:datasets.

#figure(
  table(
    columns: (1fr, 1fr, 1fr),
    stroke: 0.5pt + black,
    fill: (row, col) => if calc.even(row) { luma(240) } else { white },
    [*Dataset*], [*Samples*], [*Classes*],
    [Dataset A], [10,000], [5],
    [Dataset B], [25,000], [10],
    [Dataset C], [50,000], [15],
  ),
  caption: [Dataset statistics.],
) <tbl:datasets>

= Results

As shown in @fig:results, our method achieves competitive performance.

#figure(
  rect(width: 80%, height: 3cm, fill: teal.transparentize(70%)),
  caption: [Performance comparison across datasets.],
) <fig:results>

#lorem(50)

== Comparison with Prior Work

// See @tbl:comparison for the full comparison.
#figure(
  table(
    columns: (1fr, 1fr, 1fr),
    stroke: 0.5pt + black,
    [*Method*], [*Accuracy*], [*F1 Score*],
    [Ours], [95.2%], [94.8%],
    [Baseline], [91.3%], [90.7%],
  ),
  caption: [Comparison with state-of-the-art.],
) <tbl:comparison>

= Conclusion

#lorem(40)

This template provides a starting point for academic papers in Typst.
The source is fully customizable via the scripting language.

// --- Bibliography ---
#bibliography("works.bib")
