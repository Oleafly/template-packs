#import "config.typ": *


#let init_conf(doc)={
  set page(
    paper: "a4",
    margin: (left: left_margin, right: right_margin, top: top_margin, bottom: bottom_margin),
    header-ascent: header_ascent,
    footer-descent: footer_descent,
    numbering: none,
   
  )

  set text(font: main_font, size: main_font_size, hyphenate: true, lang: "en")
  set par(
    leading: line_spacing,
    spacing: paragraph_spacing,
    justify: true,
    // first-line-indent: 12mm
  )

  show heading.where(level: 1): it => [
    #set text(font: heading_font, size: h1_font_size, weight: "bold")
    #it.body
    #v(0.5cm)
  ]

  show heading.where(level: 2): it => [
    #v(section_space_before, weak: true)
    #pad(left: 0mm)[
      #set text(font: heading_font, size: h2_font_size, weight: "bold")
      #it
    ]
    #v(section_space_after, weak: true)
  ]

  show heading.where(level: 3): it => [
    #v(subsection_space_before, weak: true)
    #pad(left: 0mm)[
      #set text(font: heading_font, size: h3_font_size, weight: "bold")
      #it
    ]
    #v(subsection_space_after, weak: true)
  ]

  set heading(numbering: "1.1.1")

  show figure.where(kind: table): it => [
    #v(0.5cm)
    #it.body
    #v(0.5em)
    #align(center)[
      #it.caption
    ]
    #v(0.5cm)

  ]

  show figure.where(kind: image): it => [
    #v(0.5cm)
    #it.body
    #v(0.5em)
    #align(center)[
      #it.caption
    ]
    #v(0.5cm)
  ]

doc
}


#let heading_without_numbering(val) = {
  set text(
    font: main_font,
    size: h1_font_size,
    weight: "bold",
    style: "italic"
  )
  smallcaps(val)
}

#let heading_without_numbering_smallcaps(val) = {
  set text(
    font: main_font,
    size: h1_font_size,
    weight: "bold",
    style: "italic"
  )
  val
}

