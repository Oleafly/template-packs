// BYU Engineering cover/business letter template.
// Geometry and styling are distilled from
// "2020_College_Deans Office_Letterhead Template.docx".

#let byu-blue = rgb("#002E5D")

#let business-letter(
  logo: "civilengineer_parent_gray.png",
  logo-width: 3.36in,
  font: "IBM Plex Sans",
  sender-role: [Dean's Office],
  sender-name: [Ira A. Fulton College of Engineering],
  contact-lines: (
    [Brigham Young University • 240 Engineering Building • Provo, UT 84602],
    [(801) 422-4326],
  ),
  date: [Month 00, Year],
  recipient: [Dear Name,],
  closing: [Sincerely,],
  signature-name: [Name],
  body,
) = {
  let brand = if logo == none {
    none
  } else if type(logo) == str {
    image(logo, width: logo-width)
  } else {
    logo
  }

  set page(
    paper: "us-letter",
    margin: (
      top: 2in,
      right: 1.25in,
      bottom: 1in,
      left: 3in,
    ),
    background: context {
      // Positions are page-relative. The source DOCX anchors these items to
      // the 3-inch body-column edge, so explicit page coordinates are the
      // most stable Typst equivalent.
      if brand != none {
        place(
          top + left,
          // Align the visible edge of the supplied Civil Engineering logo
          // with the 3-inch body column. (The source DOCX logo had more
          // transparent padding and therefore used a farther-left anchor.)
          dx: 2.96in,
          // The vertical offset aligns the visible bottom of this logo with
          // the bottom of the two-line sender block.
          dy: 0.96in,
          brand,
        )
      }

      place(
        top + left,
        dx: 0.20in,
        dy: 1.08in,
        block(width: 2.42in)[
          #set text(font: font, size: 9pt)
          #set par(leading: 0.35em)
          #align(right)[
            #sender-name\
            #sender-role
          ]
        ],
      )

      place(
        top + left,
        dx: -0.03in,
        dy: 1.986in,
        line(length: 2.7in, stroke: 1pt + byu-blue),
      )

      place(
        top + left,
        dx: 0.20in,
        dy: 2.02in,
        block(width: 2.42in)[
          #set text(
            font: font,
            size: 10pt,
            weight: "bold",
            fill: byu-blue,
          )
          #align(right)[#date]
        ],
      )
    },
    footer: context {
      set text(font: font, size: 9pt)
      set par(leading: 0.35em)
      align(center)[
        #for line in contact-lines {
          line
          linebreak()
        }
      ]
    },
  )

  set text(font: font, size: 10pt)
  set par(leading: 0.36em, spacing: 0.85em)

  recipient
  v(0.85em)
  body
  v(1.25em)
  closing
  v(2.5em)
  signature-name
}
