#import "../tokens.typ": *

#let cover(title, date, org) = {
  align(left)[
    #text(size: 22pt, weight: 400, tracking: -0.03em, fill: title-ink)[#title]
    #v(1.1em)
    #text(size: 9.75pt, fill: ink-muted)[Date: #date]
    #v(0.3em)
    #text(size: 9.75pt, fill: ink-muted)[#org]
    #v(1.35em)
    #line(length: 100%, stroke: 0.75pt + border)
    #v(1.25em)
    #outline(
      depth: 1,
      indent: 0pt,
    )
    #v(1.5em)
  ]
  pagebreak()
}
