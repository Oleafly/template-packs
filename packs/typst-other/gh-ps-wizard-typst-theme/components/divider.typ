#import "../tokens.typ": *

#let section-divider() = {
  v(1.5em)
  line(length: 100%, stroke: 0.4pt + luma(160))
  v(1.5em)
}

#let verification-limits(body) = {
  v(0.5em)
  text(size: 10pt, weight: 600, tracking: -0.015em, fill: ink)[Verification limits]
  v(0.45em)
  block(spacing: 0.92em)[
    #text(size: 9.5pt, weight: 400, fill: ink-muted)[#body]
  ]
}
