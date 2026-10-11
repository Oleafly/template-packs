// Here you can set up the main layout of your book.

#import "@preview/markly:0.3.0"

#import "theme.typ": blood-red, dark-red, moon-silver, night-blue, parchment, shadow-gray
#import "variables.typ": title, author, body-font, title-font, subtitle
#import "utils.typ": page_illustration, section-header, subsection-header

#let ttrpg-template(
  markly-context,
  contents,
  pagetext,
  body,
) = {
  // Document settings
  set document(
    title: title,
    author: author,
  )

  let extra-margin-horiz = (markly-context.stock-width - markly-context.content-width) / 2
  let extra-margin-vert = (markly-context.stock-height - markly-context.content-height) / 2

  // Page setup
  set page(
    width: markly-context.stock-width,
    height: markly-context.stock-height,
    margin: (
      top: 1in + extra-margin-vert,
      bottom: 1in + extra-margin-vert,
      left: 0.75in + extra-margin-horiz,
      right: 0.75in + extra-margin-horiz,
    ),
    header: context {
      if counter(page).get().first() > 1 [
        #set text(size: 9pt, fill: gray)
        #grid(
          columns: (1fr, 1fr),
          align: (left, right),
          [title], [#counter(page).display("1")],
        )
        #v(-8pt)
        #line(length: 100%, stroke: 0.5pt + gray.lighten(50%))
      ]
    },
    footer: context {
      if counter(page).get().first() > 1 [
        #line(length: 100%, stroke: 0.5pt + gray.lighten(50%))
        #v(-8pt)
        #set text(size: 8pt, fill: gray)
        #align(center)[
          #pagetext
          #counter(page).display("1")
        ]
      ]
    },
  )

  // Text settings
  set text(
    font: body-font,
    size: 11pt,
    lang: "en",
    weight: "regular",
  )

  // Paragraph settings
  set par(
    justify: true,
    leading: 0.65em,
  )

  // Heading styles
  show heading.where(level: 1): it => {
    pagebreak()
    v(24pt)
    section-header(it.body)
    v(12pt)
  }

  show heading.where(level: 2): it => {
    v(8pt)
    subsection-header(it.body)
    v(8pt)
  }

  show heading.where(level: 3): it => {
    v(8pt)
    text(size: 14pt, weight: "bold", fill: shadow-gray)[#it.body]
    v(8pt)
  }

  show heading.where(level: 4): it => {
    v(8pt)
    text(size: 12pt, weight: "bold", style: "italic")[#it.body]
    v(6pt)
  }

  // List styling
  set list(marker: ([•], [◦], [▪]))
  set enum(numbering: "1.a.i.")

  // Link styling
  show link: it => {
    text(fill: blood-red, it)
  }

  // Emphasis styling
  show emph: it => {
    text(style: "italic", fill: dark-red.lighten(20%), it)
  }

  show strong: it => {
    text(weight: "bold", fill: shadow-gray, it)
  }

  // Cover page
  if markly-context.bleed == 0pt {
    page(
      margin: 0pt,
      header: none,
      footer: none,
      background: {
        place(top + left, image("../art/cover_art.webp", width: 100%, height: 100%, fit: "cover"))
        place(bottom + left, rect(width: 100%, height: 60%, fill: gradient.linear(
          rgb(0, 0, 0, 0),
          black,
          angle: 90deg,
        )))
      },
    )[
      #place(
        bottom + center,
        dy: -0.5in,
        [
          #align(center)[
            #place(center, dx: 2pt, dy: 2pt)[
              #text(
                fill: black,
                size: 42pt,
                weight: "bold",
                font: title-font,
              )[#title]
            ]
            #text(size: 42pt, weight: "bold", fill: blood-red, font: title-font)[#title]
            #v(-36pt)
            #text(size: 16pt, fill: parchment)[
              #subtitle
            ]
            #v(0pt)
            #text(size: 12pt, fill: white.darken(40%))[
              #version
            ]
            #v(66pt)
            // #place(bottom + left, dx: 0.5in, dy: -0.25in, image("../art/stamp.png", width: 15%))
            #place(bottom + center, dy: -0.25in - 4pt, image("../art/by-sa.png", width: 15%))
            #place(bottom + right, dx: -0.5in, dy: -0.25in + 8pt, image("../art/trippy_pizza.webp", width: 15%))
          ]
        ],
      )
    ]
  } else {
    page(footer: none, header: none)[
      #align(horizon)[
        #align(center)[
          #text(size: 48pt, weight: "bold", fill: black, font: title-font)[#title]
          #v(6pt)
          #text(size: 20pt, fill: black)[
            #subtitle
          ]
        ]
      ]
    ]
  }

  // Table of contents
  page[
    #outline(
      title: [
        #v(24pt)
        #text(size: 28pt, weight: "bold", fill: blood-red)[#contents]
        #v(12pt)
      ],
      indent: auto,
      depth: 2,
    )
  ]

  // Main content
  body
}
