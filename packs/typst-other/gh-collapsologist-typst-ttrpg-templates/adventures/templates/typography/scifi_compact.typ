/* 
* Setup for a compact (almost) B/W sci-fi piece.
*
* To create your own custom typographic configuration,
* Simply copy this file and change what you like.
*
* See trifold.typ for examples of use.
*/

#let heading_font = "Kelly Slab"
#let body_font = "Liberation Mono"
#let table_row_odd_color = rgb("D7D9E0")

#let typography(doc) = [ 
  #set text(
    font: body_font,
    size: 8pt,
  )

  #set highlight(fill: table_row_odd_color)

  #set par(
    justify: true,
  )

  #set table(
    fill: (_, y) => if calc.odd(y) {table_row_odd_color},
    stroke: none,
  )

  #show heading.where(level: 1): it => [
    #set align(center)
    #set text(
      font: heading_font,
      size: 15pt,
      fill: white,
    )
    #highlight(
      fill: black,
      extent: 10pt,
    )[
      #smallcaps(it.body)
    ]
  ]

  #show heading.where(level: 2): it => [
    #set text(
      size: 12pt,
      font: heading_font,
      fill: white,
    )
    #highlight(
      fill: black,
    )[
    #smallcaps(it.body)]
  ]

  #show heading.where(level: 3): it => [
    #set text(
      size:9pt,
      font: heading_font,
    )
    #box[\- #it.body -]
  ]

  #doc
]

#let clue(content) = highlight(fill: black)[
    #text(
      fill: white,
    )[*#content*]]

#let hint(content) = underline[#content]
