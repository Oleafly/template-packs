#let report(
  title: "NEUROCOGNITIVE EXAMINATION",
  author: "Joey W. Trampush, Ph.D.",
  patient: [],
  name: [],
  doe: [],
  date_of_report: [],
  date: none,
  lang: "en",
  region: "US",
  paper: "us-letter",
  margin: (top: 30mm, right: 25mm, bottom: 30.25mm, left: 25mm),
  font: ("Equity B"),
  fontsize: 11.5pt,
  title-size: 1.5em,
  heading-family: ("Equity B"),
  heading-weight: "bold",
  heading-style: "normal",
  heading-color: black,
  heading-line-height: 0.65em,
  sectionnumbering: none,
  toc: false,
  cols: 1,
  doc,
) = {
  // Metadata
  set document(title: title, author: author)
  
  // Set page size, margins, and header.
  // Set up page properties
  set page(
    // paper: paper,
    margin: margin,
    header: none,
    numbering: "1/1",
    number-align: center,
    columns: cols,
  )
  
  // Add conditional header using page state
  set page(header: context {
    if counter(page).get().first() > 1 {
      // Only add header on pages after the first
      block[
        #set par(leading: 0.65em)
        #set text(9pt)
        #smallcaps[
          *CONFIDENTIAL* \
          #name \
          #doe
        ]
      ]
    }
  })

  // let name = []
  // let doe = []
  // set page(
  //   header: context {
  //     let pageNum = counter(page).get().at(0)
  //     if pageNum == 1 {
  //       []
  //     } else {
  //       set par(leading: 0.65em)
  //       set text(9pt)
  //       smallcaps[
  //         *CONFIDENTIAL* \
  //         #name \
  //         #doe
  //       ]
  //     }
  //   },
  //   numbering: "1",
  //   number-align: center,
  // )
  
  // align headers
  show heading.where(level: 0): set align(center)
  show heading.where(level: 1): set align(left)
  
  // Set paragraph justification and leading.
  set par(justify: true)
  
  // Set text and body font family.
  set text(font: font, size: fontsize, lang: lang, region: region)
  show math.equation: set text(weight: 400)
  
  // Set heading numbering.
  set heading(numbering: sectionnumbering)
  
  // Set heading font.
  show heading: set text(font: heading-family)
  
  // Set run-in subheadings, starting at level 4.
  show heading: it => {
    if it.level > 3 {
      parbreak()
      text(1em, style: "italic", weight: "regular", it.body + ":")
    } else {
      it
    }
  }
  
  show link: set text(font: font, fill: rgb(4, 1, 23), weight: 450)
  show link: underline
  
  // Logo
  block(figure(image("inst/resources/logo.png")))
  // block(figure(image("inst/resources/bwu_logo.png")))
  
  // Title row.
  align(center)[
    #block(text(font: font, weight: 600, 1.75em, title))
    #v(0em, weak: true)
  ]
  
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

#set table(
  inset: 6pt,
  stroke: none,
)
