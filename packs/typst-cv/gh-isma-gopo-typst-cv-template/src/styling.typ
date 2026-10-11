#import "palette.typ": *
#import "personal_information.typ": *

// ------------------------
// PREAMBLE
// ------------------------

// ---DOCUMENT---
#let document_title = "Curriculum Vitae"
#let date = datetime.today()
#let date_display = date.display("[month repr:long] [day], [year]")


// ---CODE---

#let section_header(content) = block(
  fill: colours.background-2,
  inset: 8pt,
  width: 100%,
)[
  #align(center)[
    #content
  ]
]

#let margin_stroke() = rect(
  width: 1cm,
  height: 50cm,
  fill: colours.primary-1,
  stroke: none,
)


// ---STYLING---

#let styling(it) = {
  set document(
    author: author,
    title: [#document_title],
    date: date,
    description: [#document_title at #date_display],
  )

  set text(font: "Libertinus Serif", size: sizes.font-size)
  set text(lang: "es")

  show heading: set text(weight: "regular")
  show heading.where(level: 2): set text(size: sizes.h2-size)
  show heading.where(level: 3): set text(size: sizes.h3-size)
  show heading.where(level: 2): content => {
    v(1fr)
    v(-4pt)
    section_header(content)
    v(-2pt)
  }

  show list: content => {
    content
    // v(-6pt)
  }

  let left_page_margin = 0.5cm
  set page(
    margin: (left: left_page_margin + sizes.left_stroke, right: 0.8cm, top: 1cm, bottom: 1cm),
  )
  place(
    dx: -(left_page_margin + sizes.left_stroke),
    dy: -10cm,
  )[
    #margin_stroke()
  ]

  it
}
