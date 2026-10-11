#let title(
  title: "GAME SYSTEM ARCHITECTURE",
  subtitle: "From a Game Engine Perspective",
  author: "Nakuya (泣くや)",
  role: "Software Engineer",
  cover_image: none,
  version: "1.0.0",
) = {
  let primary-blue = rgb("#1a3a5f")
  let body-gray = rgb("#2c3e50")

  set page(
    paper: "a5",
    margin: (x: 0.8in, y: 1in),
  )

  set text(font: "Inter", fill: body-gray)

  align(left)[
    #v(1cm)
    #text(size: 20pt, weight: "bold", fill: primary-blue, tracking: -0.35pt)[#title] \
    #text(size: 12pt, weight: "medium", fill: gray)[#subtitle]
    #v(0.5em)
    #line(length: 100%, stroke: 1pt + primary-blue)
  ]

  v(1fr)

  if cover_image != none {
    align(center)[
      #block(
        stroke: none,
        radius: 4pt,
        clip: true,
        width: 100%,
      )[
        #if type(cover_image) == str {
          image(cover_image, width: 100%)
        } else {
          cover_image
        }
      ]
    ]
  }

  v(1fr)

  align(right)[
    #line(length: 40%, stroke: 0.5pt + gray)
    #v(-0.2em)
    #text(size: 12pt, weight: "semibold", fill: primary-blue)[#author]
    #v(-0.8em)
    #text(size: 8pt, fill: gray)[#role] \
    #text(size: 6pt, font: "Geist Mono", weight: "light", fill: gray.lighten(20%))[BUILD_REV: #version] ]
  pagebreak()
}

// Academic cover page, styled with the same design language as `title`,
// but carrying the metadata an academic report needs (course, advisor, etc.).
#let report-cover(
  report-type: "Final Report (Reading)",
  title: "Untitled Report",
  subtitle: "",
  author: "",
  student-id: "",
  advisor: "",
  course: "",
  term: "",
  faculty: "",
  institution: "",
  cover_image: none,
  date: "",
) = {
  let primary-blue = rgb("#1a3a5f")
  let body-gray = rgb("#2c3e50")

  set page(paper: "a5", margin: (x: 0.8in, y: 1in))
  set text(font: "Inter", fill: body-gray)

  align(left)[
    #v(0.2cm)
    #text(size: 8pt, weight: "bold", tracking: 2.5pt, fill: gray)[#upper(report-type)]
    #v(0.7em)
    #text(size: 21pt, weight: "bold", fill: primary-blue, tracking: -0.4pt)[#title]
    #if subtitle != "" [
      #linebreak()
      #v(0.35em)
      #text(size: 11pt, weight: "medium", style: "italic", fill: gray)[#subtitle]
    ]
    #v(0.65em)
    #line(length: 100%, stroke: 1pt + primary-blue)
  ]

  v(1fr)

  if cover_image != none {
    align(center)[
      #if type(cover_image) == str {
        block(stroke: none, radius: 4pt, clip: true, width: 100%)[
          #image(cover_image, width: 100%)
        ]
      } else {
        cover_image
      }
    ]
  }

  v(1fr)

  let meta-row(label, value) = (
    text(size: 7.5pt, weight: "bold", tracking: 1pt, fill: gray)[#upper(label)],
    text(size: 10pt, weight: "medium", fill: body-gray)[#value],
  )

  align(left)[
    #line(length: 36%, stroke: 0.5pt + gray)
    #v(0.55em)
    #grid(
      columns: (auto, 1fr),
      column-gutter: 1.4em,
      row-gutter: 0.78em,
      ..meta-row("Prepared by", [#author #h(0.5em) #text(fill: gray, weight: "regular")[#student-id]]),
      ..meta-row("Submitted to", advisor),
      ..meta-row("Course", course),
      ..meta-row("Term", term),
      ..meta-row("Faculty", faculty),
      ..meta-row("Institution", institution),
    )
  ]

  if date != "" {
    v(1.1em)
    align(left, text(
      size: 6pt,
      font: "Geist Mono",
      weight: "light",
      fill: gray.lighten(20%),
    )[#upper("compiled · " + date)])
  }

  pagebreak()
}
