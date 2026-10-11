// Layout Helpers
// Grid and layout utilities for better document structure

#import "../colors.typ": *

#let two-column(left, right, ratio: 1fr) = {
  grid(
    columns: (ratio, 1fr),
    column-gutter: 1em,
    left, right
  )
}

#let three-column(left, center, right) = {
  grid(
    columns: (1fr, 1fr, 1fr),
    column-gutter: 1em,
    left, center, right
  )
}

#let dtu-line() = {
  v(0.5em)
  line(length: 100%, stroke: 1pt + dtu-gray)
  v(0.5em)
}

#let page-break() = pagebreak()

// Flexible column layout
#let columns(..content, count: 2, gutter: 1em) = {
  let cols = (1fr,) * count
  grid(
    columns: cols,
    column-gutter: gutter,
    ..content.pos()
  )
}
