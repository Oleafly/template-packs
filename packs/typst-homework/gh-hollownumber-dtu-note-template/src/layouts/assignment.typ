// DTU Assignment Layout
// Academic assignment template following DTU design guidelines

#import "../colors.typ": *

#let dtu-assignment(
  course: "",
  course-name: "",
  title: "",
  due-date: datetime.today(),
  author: "",
  semester: "",
  body
) = {
  // Page setup (consistent with notes)
  set page(
    paper: "a4",
    margin: (x: 2.5cm, y: 2cm),
    header: context {
      let page-number = counter(page).display()
      if page-number != "1" {
        grid(
          columns: (auto, 1fr, auto),
          align: (left, center, right),
          column-gutter: 1em,
          [
            #rect(
              width: 1.2cm,
              height: 0.4cm,
              fill: dtu-red,
              radius: 1pt,
              stroke: none,
              align(center + horizon)[
                #text(size: 8pt, weight: "bold", fill: white)[DTU]
              ]
            )
          ],
          [#text(size: 9pt, fill: dtu-black)[#course - #title]],
          [#text(size: 9pt, fill: dtu-black)[Page #page-number]]
        )
        v(-0.2em)
        line(length: 100%, stroke: 0.5pt + dtu-gray)
      }
    },
    footer: context {
      let page-number = counter(page).display()
      if page-number != "1" {
        align(center)[
          #text(size: 8pt, fill: dtu-gray)[
            Technical University of Denmark
          ]
        ]
      }
    }
  )

  // Typography (same as notes) with robust fallbacks
  set text(
    font: ("Liberation Sans", "DejaVu Sans", "Arial", "Helvetica"),
    size: 11pt,
    lang: "en"
  )

  set par(
    justify: true,
    leading: 0.65em,
  )

  // Math
  set math.equation(numbering: "(1)")

  // Problem numbering
  set enum(numbering: "1.a.i.")

  // DTU Assignment header
  align(center)[
    #grid(
      columns: (auto, 1fr, auto),
      align: (left, center, right),
      column-gutter: 1em,
      [
        #image("../assets/dtu-logo-cmyk.png", width: 25%)
      ],
      [],
      [
        #text(size: 10pt, fill: dtu-black, weight: "medium")[
          #semester Semester
        ]
      ]
    )

    #v(1.5em)

    #block(spacing: 1.5em)[
      #text(size: 22pt, weight: "bold", fill: dtu-red)[#title]
    ]

    #text(size: 16pt, fill: dtu-blue, weight: "bold")[#course]
    #if course-name != "" [
      #linebreak()
      #text(size: 13pt, fill: dtu-dark-blue, weight: "medium")[#course-name]
    ]

    #v(1.2em)

    #grid(
      columns: 2,
      column-gutter: 3em,
      align: center,
      [
        #if author != "" [
          #text(size: 11pt, fill: dtu-black)[*Student:* #author]
        ]
      ],
      [
        #text(size: 11pt, fill: dtu-black)[*Due:* #due-date.display("[day] [month repr:short] [year]")]
      ]
    )
  ]

  line(length: 100%, stroke: 1.5pt + dtu-red)

  v(2em)

  // Content
  body
}
