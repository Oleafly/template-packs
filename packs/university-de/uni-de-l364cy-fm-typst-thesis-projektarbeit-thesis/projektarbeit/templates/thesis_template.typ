#let project(
  title: "",
  degree: "",
  program: "",
  supervisor: "",
  advisors: (),
  author: "",
  startDate: none,
  submissionDate: none,
  body,
) = {
  import "@preview/abbr:0.1.1"
  set document(title: title, author: author)
  set page(
    margin: (left: 30mm, right: 30mm, top: 40mm, bottom: 40mm),
    numbering: "1",
    number-align: center,
  )

  let body-font = "Source Sans Pro"
  let sans-font = "Source Sans Pro"

  set text(
    font: body-font, 
    size: 12pt, 
    lang: "de"
  )
  
  show math.equation: set text(weight: 400)

  // --- Headings ---
  show heading: set block(below: 0.85em, above: 1.75em)
  show heading: set text(font: body-font)
  set heading(numbering: "1.1")
  // Reference first-level headings as "chapters"
  show ref: it => {
    let el = it.element
    if el != none and el.func() == heading and el.level == 1 {
      [Chapter ]
      numbering(
        el.numbering,
        ..counter(heading).at(el.location())
      )
    } else {
      it
    }
  }

  // --- Paragraphs ---
  set par(leading: 1em)

  // --- Citations ---
  set cite(style: "ieee")
  // --- Figures ---
  show figure: set text(size: 0.85em)
  
  // --- Table of Contents ---
  outline(
    title: {
      text(font: body-font, 1.5em, weight: 700, "Inhaltsverzeichnis")
      v(15mm)
    },
    indent: 2em
  )
  
  // List of figures.
  pagebreak()
  heading(numbering: none)[Abbildungsverzeichnis]
  outline(
    title:"",
    target: figure.where(kind: image),
  )

  // List of tables.
  pagebreak()
  heading(numbering: none)[Tabellenverzeichnis]
  outline(
    title: "",
    target: figure.where(kind: table),
  )

  pagebreak()
  abbr.list(title: "Abkürzüngsverzeichnis")

  pagebreak()
  // Main body.
  set par(justify: true, first-line-indent: 2em)

  body

  // Appendix.
  pagebreak()
  heading(numbering: none)[Anhang]
  include("../appendix.typ")

  pagebreak()
  bibliography("../thesis.bib", title: "Literaturverzeichnis")
}
