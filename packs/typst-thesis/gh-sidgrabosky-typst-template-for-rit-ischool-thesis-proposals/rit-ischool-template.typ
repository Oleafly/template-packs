#let rit-ischool-capstone(
  // Document metadata
  title: "Title of the Project",
  display-title: none, // Optional: title with manual line breaks for title page
  author: "Student's Name",
  degree-type: "Master of Science",
  degree-symbol: "M.S.",

  // Committee information
  committee-chair: "Dr. Felix Frankfurter",
  chair-title: "Assistant Professor",
  reader: "Dr. Learned Hand\nAssociate Professor",
  observer: none,

  // Dates
  grant-month: "Month",
  grant-year: "Year",
  copyright-year: 2024,

  // Document type settings
  is-project: true,  // true for project, false for thesis
  is-proposal: true, // true for proposal, false for final report
  include-copyright: false,
  include-figures-list: true,
  include-tables-list: true,

  // Previous degrees (optional)
  previous-degrees: none,

  // Abstract content
  abstract: none,

  // Document body
  body
) = {

  // Set page parameters
  set page(
    paper: "us-letter",
    margin: (
      top: 1.5in,
      bottom: 1in,
      left: 1.5in,
      right: 1in
    ),
    header-ascent: 0.5in,
  )

  // Configure fonts
  set text(
    font: "STIX Two Text",
    size: 12pt,
    lang: "en"
  )

  // Set math font
  show math.equation: set text(font: "STIX Two Math")

  // Set paragraph parameters
  set par(
    justify: true,
    leading: 0.65em,
    first-line-indent: 0.5in
  )

  // Enable section numbering for body content
  set heading(numbering: "1.1")

  // Set heading styles
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(0.2in)
    block(
      text(size: 18pt, weight: "bold")[
        #if it.numbering != none [#counter(heading).display() #h(0.5em)]
        #it.body
      ]
    )
    v(40pt)
  }

  show heading.where(level: 2): it => {
    v(24pt)
    block(
      text(size: 14pt, weight: "bold")[
        #if it.numbering != none [#counter(heading).display() #h(0.5em)]
        #it.body
      ]
    )
    v(12pt)
  }

  // Configure figure captions
  show figure.caption: it => {
    text(size: 11pt, it)
  }

  // Title Page
  page(
    header: none,
    footer: none,
    {
      set align(center)
      set par(leading: 0.6em)

      // Top section - title and author
      {
        // Large title at top (use display-title if provided, otherwise title)
        text(size: 22pt, weight: "bold", if display-title != none { display-title } else { title })
        v(0.8in, weak: true)

        // "by" section
        text(size: 14pt)[by]
        v(0.3in)
        text(size: 14pt, weight: "bold", author)
        if previous-degrees != none {
          v(0.2in)
          text(size: 12pt, previous-degrees)
        }
      }

      // Flexible spacing to push content apart
      v(1fr)

      // Middle section - submission text and supervisor
      {
        // Project/Thesis submission text
        text(size: 14pt)[
          A #if is-project [Project] else [Thesis]
          #if is-proposal [ Proposal] else if is-project [ Report]
          #if is-proposal [] else [ ]
          Submitted
        ]
        linebreak()
        text(size: 14pt)[in]
        linebreak()
        text(size: 14pt)[Partial Fulfillment of the]
        linebreak()
        text(size: 14pt)[Requirements for the Degree of]
        linebreak()
        text(size: 14pt, degree-type)
        v(0.4in)

        text(size: 14pt)[Supervised by]
        v(0.3in)
        text(size: 14pt, committee-chair)
      }

      // Flexible spacing to push bottom content down
      v(1fr)

      // Bottom section - pinned to bottom
      {
        // Institution information
        text(size: 12pt)[School of Information]
        v(0.3in)
        text(size: 12pt)[B. Thomas Golisano College of Computing and Information Sciences]
        linebreak()
        text(size: 12pt)[Rochester Institute of Technology]
        linebreak()
        text(size: 12pt)[Rochester, New York]
        v(0.3in)

        text(size: 12pt, grant-month + " " + grant-year)
      }
    }
  )

  // Copyright Page (optional)
  if include-copyright {
    page(
      header: none,
      footer: none,
      {
        v(1fr)
        align(center)[
          #text(size: 14pt)[© Copyright #copyright-year by #author]

          #text(size: 14pt)[All Rights Reserved]
        ]
        v(1fr)
      }
    )
  }

  // Signature Page
  page(
    header: none,
    footer: none,
    {
      set par(leading: 1.2em)

      let doc-type = if is-project {
        if is-proposal ["project proposal"] else ["project report"]
      } else {
        if is-proposal ["thesis proposal"] else ["thesis"]
      }

      [The #doc-type "#title" by #author has been examined and approved by the following Examination Committee:]

      v(1fr)

      // Committee Chair signature
      align(right)[
        #box(width: 4in)[
          #v(0.5in)
          #line(length: 3in)
          #committee-chair

          #chair-title

          #{if is-project ["Project"] else ["Thesis"]} Committee Chair
        ]
      ]

      v(0.8in)

      // Reader signature
      align(right)[
        #box(width: 4in)[
          #v(0.5in)
          #line(length: 3in)
          #reader
        ]
      ]

      // Observer signature (if present)
      if observer != none {
        v(0.8in)
        align(right)[
          #box(width: 4in)[
            #v(0.5in)
            #line(length: 3in)
            #observer
          ]
        ]
      }

      v(1fr)
    }
  )

  // Setup page numbering for front matter
  set page(
    numbering: "i",
    number-align: center,
    header: none,
    footer: context align(center, str(counter(page).get().first()))
  )

  counter(page).update(1)

  // Abstract Page
  {
    align(center)[
      #heading(level: 1, numbering: none)[Abstract]
    ]

    v(0.2in)

    align(center)[
      #text(size: 14pt, weight: "bold", title)

      #v(0.25in)
      #text(size: 12pt, author)

      #v(0.25in)
      #text(size: 12pt)[Supervising Professor: #committee-chair]
    ]

    v(0.5in)

    // Abstract content
    if abstract != none {
      set par(first-line-indent: 0pt)
      abstract
    }
  }

  pagebreak()

  // Table of Contents
  {
    align(center)[
      #heading(level: 1, numbering: none)[Contents]
    ]
    v(0.5in)

    // Format outline entries
    show outline.entry.where(level: 1): it => {
      text(weight: "bold", it)
    }

    outline(
      title: none,
      depth: 3,
      indent: auto
    )
  }

  // List of Tables (if enabled)
  if include-tables-list {
    pagebreak()

    align(center)[
      #heading(level: 1, numbering: none)[List of Tables]
    ]
    v(0.5in)

    outline(
      title: none,
      target: figure.where(kind: table)
    )
  }

  // List of Figures (if enabled)
  if include-figures-list {
    pagebreak()

    align(center)[
      #heading(level: 1, numbering: none)[List of Figures]
    ]
    v(0.5in)

    outline(
      title: none,
      target: figure.where(kind: image)
    )
  }

  // Main document body
  pagebreak()

  // Reset page numbering for main content
  set page(
    numbering: "1",
    number-align: center,
    header: none,
    footer: context align(center, str(counter(page).get().first()))
  )

  counter(page).update(1)

  // Set paragraph indentation for body text
  set par(first-line-indent: 0.5in)

  // Main content
  body
}

// Helper function for dedication page
#let dedication-page(content) = {
  page(
    header: none,
    footer: context align(center, str(counter(page).get().first())),
    {
      align(center)[
        = Dedication
      ]
      v(1fr)
      align(center, content)
      v(1fr)
    }
  )
}

// Helper function for acknowledgments page
#let acknowledgments-page(content) = {
  page(
    header: none,
    footer: context align(center, str(counter(page).get().first())),
    {
      align(center)[
        = Acknowledgments
      ]
      v(1fr)
      align(center, content)
      v(1fr)
    }
  )
}


// Helper function for bibliography
#let bibliography-page(bib-file) = {
  pagebreak()

  set page(
    footer: context align(center, str(counter(page).get().first()))
  )

  heading(level: 1, outlined: true, numbering: none)[References]

  bibliography(bib-file, style: "apa")
}