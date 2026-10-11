#import "utils.typ": get

#let default-uservars = (
  headingfont: "Times New Roman",
  bodyfont: "Times New Roman",
  fontsize: 10pt,
  linespacing: 6pt,
  headingsmallcaps: false,
  margin: 0.5in,
)

#let apply-style(uservars, doc) = {
  set page(
    paper: "us-letter",
    margin: get(uservars, "margin", 0.5in),
  )

  set text(
    font: get(uservars, "bodyfont", "Times New Roman"),
    size: get(uservars, "fontsize", 10pt),
    hyphenate: false,
  )

  set list(
    spacing: get(uservars, "linespacing", 6pt),
  )

  set par(
    leading: get(uservars, "linespacing", 6pt),
    justify: true,
  )

  show heading.where(level: 2): it => block(width: 100%)[
    #set align(left)
    #set text(
      font: get(uservars, "headingfont", "Times New Roman"),
      size: 1em,
      weight: "bold",
    )
    #if get(uservars, "headingsmallcaps", false) {
      smallcaps(it.body)
    } else {
      upper(it.body)
    }
    #v(-0.75em)
    #line(length: 100%, stroke: 1pt + black)
  ]

  show heading.where(level: 1): it => block(width: 100%)[
    #set text(
      font: get(uservars, "headingfont", "Times New Roman"),
      size: 1.5em,
      weight: "bold",
    )
    #if get(uservars, "headingsmallcaps", false) {
      smallcaps(it.body)
    } else {
      upper(it.body)
    }
    #v(2pt)
  ]

  doc
}
