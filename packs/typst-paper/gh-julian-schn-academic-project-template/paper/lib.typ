// Academic Paper Template for Typst
// Hochschule der Medien Stuttgart Style
// Version 1.0.0

#let academic-paper(
  // Title page information
  title: "",
  author: "",
  email: "",
  institution: "Hochschule der Medien Stuttgart",
  faculty: "Faculty of Printing and Media",
  program: "Computer Science and Media (B.Sc.)",
  course: "",
  instructor: "",
  semester: "",
  date: datetime.today(),

  // Document settings
  paper-size: "a4",
  font: "New Computer Modern",
  font-size: 11pt,
  line-spacing: 1.5,

  // Abstract
  abstract: none,

  // Acknowledgments
  acknowledgments: none,

  // AI-usage declaration
  ai-usage: none,           // Free-text statement of how AI was used
  ai-tools: (),             // Array of (tool: "", purpose: "", verification: "")

  // Declaration of Authorship (Selbstständigkeitserklärung)
  declaration: false,       // Set true to render the formal affidavit
  declaration-place: "",    // Place for the signature line (date reuses `date`)

  // Bibliography file
  bibliography-file: none,

  // Document body
  body,
) = {

  // Document metadata
  set document(
    title: title,
    author: author,
  )

  // === TITLE PAGE ===
  set page(
    paper: paper-size,
    margin: (left: 3cm, right: 3cm, top: 4cm, bottom: 4cm),
    numbering: none,
  )

  align(center)[
    #v(1fr)

    #text(size: 14pt, weight: "bold")[#institution] \
    #text(size: 12pt)[#faculty] \
    #text(size: 11pt)[#program]

    #v(4fr)

    #text(size: 22pt, weight: "bold")[
      #title
    ]

    #v(4fr)

    #grid(
      columns: (1fr, 1fr),
      align: (left, right),
      [
        *Author:* \
        #author \
        #email
      ],
      [
        *Course:* \
        #course \
        #instructor
      ],
    )

    #v(2fr)

    #text(size: 11pt)[#semester] \
    #text(size: 11pt)[#date.display("[day]. [month repr:short] [year]")]

    #v(1fr)
  ]

  pagebreak()

  // === DOCUMENT SETTINGS ===
  set page(
    paper: paper-size,
    margin: 2.54cm,
    numbering: "1",
    number-align: center,
  )

  // Typography
  set text(
    font: font,
    size: font-size,
  )

  set par(
    justify: true,
    leading: 0.65em * line-spacing,
    first-line-indent: 1.27cm,
  )

  // Headings
  set heading(numbering: "1.1")

  show heading.where(level: 1): it => {
    set text(size: 14pt, weight: "bold")
    v(11pt)
    block(it)
    v(6pt)
  }

  show heading.where(level: 2): it => {
    set text(size: 11pt, weight: "bold")
    v(10pt)
    block(it)
    v(4pt)
  }

  show heading.where(level: 3): it => {
    set text(size: 11pt, weight: "bold", style: "italic")
    v(8pt)
    block(it)
    v(4pt)
  }

  // Remove first-line indent after headings
  show heading: it => {
    it
    par(first-line-indent: 0pt)[]
  }

  // === ABSTRACT ===
  if abstract != none {
    align(center)[#text(weight: "bold")[Abstract]]
    v(0.5em)
    par(first-line-indent: 0pt)[
      #emph[#abstract]
    ]
    v(1.5em)
  }

  // === MAIN BODY ===
  body

  // === ACKNOWLEDGMENTS ===
  if acknowledgments != none {
    pagebreak()
    heading(level: 1, numbering: none)[Acknowledgement]
    acknowledgments
  }

  // === BIBLIOGRAPHY ===
  if bibliography-file != none {
    pagebreak()
    bibliography(bibliography-file, title: "References", style: "ieee")
  }

  // === DECLARATION ON THE USE OF AI TOOLS ===
  if ai-usage != none or ai-tools.len() > 0 {
    pagebreak()
    heading(level: 1, numbering: none)[Declaration on the Use of AI Tools]

    if ai-usage != none {
      par(first-line-indent: 0pt)[#ai-usage]
      v(0.5em)
    }

    if ai-tools.len() > 0 {
      table(
        columns: (auto, 1fr, 1fr),
        align: (left + top, left + top, left + top),
        inset: 8pt,
        table.header(
          [*Tool*], [*Purpose*], [*Verification*],
        ),
        ..ai-tools
          .map(entry => ([#entry.tool], [#entry.purpose], [#entry.verification]))
          .flatten()
      )
    }
  }

  // === DECLARATION OF AUTHORSHIP ===
  if declaration {
    pagebreak()
    heading(level: 1, numbering: none)[Declaration of Authorship]

    par(first-line-indent: 0pt)[
      I hereby declare that I have written the present paper independently and
      without the use of any sources or aids other than those indicated. All
      passages taken verbatim or in substance from published or unpublished
      works of others are marked as such. Aids used in preparing this paper,
      including AI-based tools, are disclosed in the _Declaration on the Use of
      AI Tools_. This paper has not previously been submitted in the same or a
      similar form to any other examination authority and has not been published.
    ]

    v(3cm)

    grid(
      columns: (1fr, 1fr),
      align: (left, left),
      [
        #line(length: 80%) \
        #if declaration-place != "" [#declaration-place, ]#date.display("[day]. [month repr:short] [year]")
      ],
      [
        #line(length: 80%) \
        #author
      ],
    )
  }
}
