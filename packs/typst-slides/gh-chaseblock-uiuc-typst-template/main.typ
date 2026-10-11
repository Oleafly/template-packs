// main.typ — starter deck. Replace the content below with your talk.
// Compile with:  typst compile main.typ   (or `typst watch main.typ`)
//
// demo.typ shows every layout the template offers; README.md documents them.

#import "uiuc.typ": *

#show: uiuc-slides.with(
  title: "Title of Presentation",
  authors: ("First Author", "Second Author"),
  date: "MONTH YEAR",
  // subtitle, footer-left and footer-right default to the Siebel School /
  // Grainger Engineering strings; override them here for another unit.
)

// ---------------------------------------------------------------- overview
== Outline

#two-col[
  === Background
  - First topic
  - Second topic

  #pause

  === Motivation
  - Why this matters
][
  #pause

  === Approach
  - Key idea

  #pause

  === Evaluation
  - Headline result
]

// ---------------------------------------------------------------- background
= Background

== A content slide

Body text, - bullets, *bold*, $a^2 + b^2 = c^2$ — everything Typst supports.

=== Orange subheading

- A point
#pause
- A point revealed on the next click

==== Navy subheading

Text under the smaller subheading.

== Figure beside text

#img-left(placeholder("FIGURE", height: px(400)))[
  === What the figure shows
  - Swap `placeholder(...)` for `image("figures/plot.pdf")`
  - `img-right` puts the figure on the other side
]

// ---------------------------------------------------------------- results
#divider(
  "Results",
  body: [A divider can carry a sentence of context under the heading.],
)

== A chart

#chart(
  placeholder("CHART / GRAPH", width: px(839), height: px(380)),
  caption: [(Short commentary on what the chart shows.)],
)

// ---------------------------------------------------------------- closing
#closing-slide(
  lines: ("Summary", "Thank You", "Questions"),
  body: [name\@illinois.edu],
)
