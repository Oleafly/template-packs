// UTwente MSc Computer Science Template
// Converted from mcs.sty LaTeX package
// https://www.overleaf.com/latex/templates/template-for-the-msc-computer-science-research-topics-or-final-project-university-of-twente/njhdgsjfkxfd

#let conf(
  study: "MSc Business & IT",
  title: "",
  author: "",
  supervisor: "",
  doctype: "",
  date: datetime.today(),
  bibliography_style: "ieee",
  department: "Department of Computer Science
Faculty of Electrical Engineering,
Mathematics and Computer Science,
",
  body,
) = {
  set page(
    paper: "a4",
    margin: (
      left: 3cm,
      right: 3cm,
      top: 3cm,
      bottom: 3cm,
    ),
    header-ascent: 1cm,
    footer-descent: 1.5cm,
    numbering: "1",
  )

  set text(
    font: "Times New Roman",
    size: 11pt,
    lang: "en",
  )

  set par(
    justify: true,
    leading: 0.65em,
  )

  set heading(numbering: "1.1")

  show link: it => text(fill: blue, it)

  show figure.caption: it => context {
    text(size: 0.9em)[
      #smallcaps[
        #it.supplement #it.counter.display(it.numbering):
      ] #it.body
    ]
  }

  set math.equation(numbering: "(1)")

  set bibliography(style: bibliography_style)

  // Custom date formatting function
  let format-date(date) = {
    let months = (
      "January", "February", "March", "April", "May", "June",
      "July", "August", "September", "October", "November", "December"
    )
    let month = months.at(date.month() - 1)
    month + ", " + str(date.year())
  }

  // Cover page function
  let make-cover-page() = {
    page(
      margin: (left: 0cm, right: 3cm, top: 0cm, bottom: 0cm),
      header: none,
      footer: none,
      numbering: none,
    )[
      // Position sidebar as background spanning full height
      #place(
        left + top,
        dx: 0cm,
        dy: 2cm,
        image("sidebar.png", width: 85%, height: 82%)
      )

      // Position logo at bottom left
      #place(
        left + bottom,
        dx: 0.5cm,
        dy: -1cm,
        image("utlogo.png", width: 6cm)
      )

      // Text content positioned on the right
      #grid(
        columns: (0.75fr, 1fr),
        column-gutter: 0cm,
        // Empty left column (space for images)
        [],
        // Right column: Text content
        [
          #v(2cm)
          #text(size: 18pt)[#study\ #doctype]

          #v(1fr)
          #v(1fr)

          #text(size: 24pt, weight: "bold")[#title]

          #v(1fr)

          #text(size: 18pt)[#author]

          #v(1fr)

          Supervisor: #supervisor

          #v(1fr)

          #format-date(date)

          #v(1fr)

          #department
          University of Twente

          #v(0.75fr)
        ]
      )
      #pagebreak()
    ]
  }

  make-cover-page()

  // Reset page numbering for main content
  counter(page).update(1)

  // Main document content
  body
}

// Keywords environment function
#let keywords(content) = {
  v(1em)
  par(first-line-indent: 0pt)[
    #emph[Keywords:] #content
  ]
}

