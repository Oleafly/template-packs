#let report(
  title: "NEUROCOGNITIVE EXAMINATION",
  author: "Joey W. Trampush, Ph.D.",
  patient: [Smalls, Biggie],
  name: [Biggie],
  doe: [],
  date_of_report: [],
  date: none,
  cols: 1,
  paper: "a4",
  margin: (top: 30mm, right: 25mm, bottom: 30.25mm, left: 25mm),
  lang: "en",
  region: "US",
  font: (),
  body-font: "Libertinus Serif",
  sans-font: "Libertinus Sans",
  fontsize: 11pt,
  sectionnumbering: none,
  doc,
) = {
  // // Metadata
  set document(title: title, author: author)

  let name = []
  let doe = []
  set page(
    header: context {
      let pageNum = counter(page).get().at(0)
      if pageNum == 1 {
        []
      } else {
        set par(leading: 0.65em)
        set text(9pt)
        smallcaps[
          *CONFIDENTIAL* \
          #name \
          #doe
        ]
      }
    },
    numbering: "1",
    number-align: center,
  )

  block(figure(image("src/img/logo.png")))
  // #block(figure(image("src/img/logo_looka.png", width: 45%)))

  align(
    center,
    text(1.75em, weight: 600)[
      *NEUROCOGNITIVE EXAMINATION*
    ],
  )

  // align headers
  show heading.where(level: 1): set align(center)
  show heading.where(level: 2): set align(left)
  // Set run-in subheadings, starting at level 4.
  show heading: it => {
    if it.level > 3 {
      parbreak()
      text(1em, style: "italic", weight: "regular", it.body + ":")
    } else {
      it
    }
  }
  set par(justify: true)

  // Set heading numbering.
  set heading(numbering: sectionnumbering)

  // Set heading font.
  // show heading: set text(font: sans-font, weight: "semibold")

  // Set list
  // set list(tight: true, body-indent: 0.25em)

  // Links
  show link: set text(font: body-font, fill: rgb(154, 37, 60), weight: 450)
  show link: underline

  // Title row.
  // align(center)[
  //   #block(text(font: sans-font, weight: 600, 1.75em, title))
  //   #v(1em, weak: true)
  // ]

  if date != none {
    align(center)[#block(inset: 1em)[
        #date
      ]]
  }

  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }
}
