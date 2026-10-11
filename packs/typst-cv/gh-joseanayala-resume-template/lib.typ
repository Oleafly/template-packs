// Public entry point for the resume template.

#import "lib/tokens.typ": *
#import "lib/icons.typ": *
#import "lib/components.typ": *

#let resume(body) = {
  set page(paper: "us-letter", margin: page-margin)
  set text(font: body-font, size: body-size, hyphenate: false)
  set par(spacing: s2)
  show link: it => text(fill: black, it)
  show heading: it => block(above: s4, below: s1)[
    #text(
      font: heading-font,
      size: heading-size,
      weight: "bold",
      smallcaps(it.body),
    )
    #v(s1, weak: true)
    #line(length: 100%, stroke: rule-stroke)
  ]
  body
}
