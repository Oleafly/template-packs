// BiomathBeamer template for Typst 0.13
// Converted from LaTeX template by Saba Daneshgar
// Original template based on work by Joris Meys

// ============================================================================
// CITATIONS WITH ZOTERO
// ============================================================================
// To use Zotero citations in your presentation:
//
// 1. Export your Zotero library as BibTeX (.bib file)
//    - In Zotero: File > Export Library > choose BibTeX
//    - Or use Better BibTeX extension for persistent citation keys
//
// 2. Pass the bibliography path to the template:
//    #show: doc => biomath-template(
//      bibliography: "references.bib",  // Path to your .bib file
//      ...
//    )
//
// 3. Use citations in your slides:
//    - @key2024        → (Author, 2024)
//    - [@key2024]      → [(Author, 2024)]
//    - [@key2024; p.5] → [(Author, 2024, p.5)]
//
// 4. Add a references slide at the end:
//    #bibliography("references.bib", style: "apa")

// Define colors
#let ug-blue = rgb(30, 100, 200)
#let ug-yellow = rgb(255, 210, 0)
#let bw-color = rgb(39, 171, 173)

// Define module variables for section tracking
#let section-info = (
  curr-section: "",
  curr-subsection: ""
)

// Function to update section info
#let update-section(title: none, subtitle: none) = {
  // Define module variables for section tracking
  let section-info = (
    curr-section: "",
    curr-subsection: ""
  )
  if title != none {
    section-info.curr-section = title
  }

  if subtitle != none {
    section-info.curr-subsection = subtitle
  }
}

// Block styles
#let note(body) = {
  block(
    width: 100%,
    breakable: false,
    stack(
      dir: ttb,
      block(
        width: 100%,
        fill: ug-blue,
        inset: (x: 1em, y: 0.5em),
        text(weight: "bold", fill: white, "Note", size:1.5em)
      ),
      block(
        width: 100%,
        fill: ug-blue.lighten(80%),
        inset: 1em,
        body
      )
    )
  )
}

#let warning(body) = {
  block(
    width: 100%,
    breakable: false,
    stack(
      dir: ttb,
      block(
        width: 100%,
        fill: rgb(200, 0, 0),
        inset: (x: 1em, y: 0.5em),
        text(weight: "bold", fill: white, "Warning", size:1.5em)
      ),
      block(
        width: 100%,
        fill: rgb(200, 0, 0).lighten(80%),
        inset: 1em,
        body
      )
    )
  )
}

#let example(body) = {
  block(
    width: 100%,
    breakable: false,
    stack(
      dir: ttb,
      block(
        width: 100%,
        fill: bw-color,
        inset: (x: 1em, y: 0.5em),
        text(weight: "bold", fill: white, "Example", size:1.5em)
      ),
      block(
        width: 100%,
        fill: bw-color.lighten(80%),
        inset: 1em,
        body
      )
    )
  )
}

// ============================================================================
// BIBLIOGRAPHY FUNCTION - For Zotero BibTeX integration
// Use this to display references in your slides
// ============================================================================
#let show-references(
  bib-path,
  style: "apa",
  title: "References"
) = {
  pagebreak(weak: true)
  
  block(
    width: 100%,
    fill: ug-blue,
    inset: (x: 1.5em, y: 0.8em),
    text(size: 1.5em, weight: "bold", fill: white, title)
  )
  
  v(1em)
  
  // Display bibliography using Typst's built-in function
  bibliography(bib-path, style: style, title: title)
}

// Title slide function
#let title-slide(
  title,
  subtitle: none,
  authors: none,
  institute: none,
  date: none,
  email: none
) = {
  set page(margin: 0pt)

  grid(
    columns: 1,
    rows: (15%, auto, 1fr, auto),
    gutter: 0pt,
    {
      align(left + horizon)[
        #pad(left: 2em, top: 2em)[
          #image("logos/bw-en.png", width: 30%)
        ]
      ]
    },
    v(1.5em),
    {
      block(
        width: 100%,
        fill: ug-blue,
        inset: 3em,
        {
          if date != none {
            text(fill: white, size: 1.8em)[#date]
            v(3em)
          }

          [
            #text(size: 2.5em, weight: "bold", style: "normal", fill: white)[#upper(title)]
          ]

          if subtitle != none {
            v(0.5em)
            align(horizon)[
              #text(size: 1.6em, fill: white)[#emph(subtitle)]
            ]
          }

          v(1.5em)

          if authors != none {
            align(horizon)[
              #text(size: 1.6em, fill: ug-yellow)[
                #upper(authors)
                #if institute != none [
                  (#institute)
                ]
              ]
            ]
          }
        }
      )
    },
    { },
    {
      grid(
        columns: (1fr, auto),
        gutter: 1em,
        align(left + bottom)[
          #pad(left: 2em, bottom: 2em)[
            #image("logos/ugent-en.png", width: 20%)
          ]
        ],
        align(right + bottom)[
          #pad(right: 2em, bottom: 2em)[
            #image("logos/logo-biomath.png", width: 50%)
          ]
        ]
      )
    }
  )
}

// Slide function
#let slide(title: none, subtitle: none, body) = {
  update-section(title: title, subtitle: subtitle)
  pagebreak(weak: true)
  body
}

// Template main function
#let biomath-template(
  title: none,
  subtitle: none,
  authors: none,
  date: none,
  email: none,
  institute: none,
  body
) = {
  // Set page properties
  set page(
    paper: "presentation-16-9",
    margin: (x: 2em, top: 4em, bottom: 4em),
    header: {
      set block(width: 100%)
      grid(
        columns: (1fr, 1fr),
        rows: (auto),
        block(
          fill: ug-blue,
          inset: (y: 0.5em, x: 1em),
          text(
            size: 0.8em,
            fill: white,
            weight: "bold",

            section-info.curr-section
          )
        ),
        block(
          fill: ug-blue.lighten(80%),
          inset: (y: 0.5em, x: 1em),
          text(
            size: 0.8em,
            fill: ug-blue,
            weight: "bold",

            section-info.curr-subsection
          )
        )
      )
    },
    footer: {
      set block(width: 100%)
      grid(
        columns: (1fr, 1fr),
        rows: (auto),
        block(
          fill: ug-blue,
          inset: (y: 0.5em, x: 1em),
          text(
            size: 0.8em,
            fill: white,

            if authors != none {
              [#authors #if email != none [~(~#email~)~]]
            } else { "" }
          )
        ),
        block(
          fill: ug-blue.lighten(80%),
          inset: (y: 0.5em, x: 1em),
          text(
            size: 0.8em,
            fill: ug-blue,
            [#if title != none { title } #h(1fr) ]
          )
        )
      )
    }
  )

  // Set the font
  set text(font: "Helvetica", size: 11pt)
  show math.equation: set text(font: "Helvetica")

  // Code blocks styling
  show raw.where(block: true): it => {
    block(
      width: 100%,
      fill: rgb(242, 242, 235),
      radius: 3pt,
      inset: 10pt,
      text(font: "Courier New", size: 0.9em, it)
    )
  }

  // Auto-update section tracking
  show heading.where(level: 1): it => {
    update-section(title: it.body)
    set text(fill: ug-blue, size: 1.8em, weight: "bold")
    block(it.body)
  }

  show heading.where(level: 2): it => {
    update-section(subtitle: it.body)
    set text(fill: ug-blue, size: 1.4em)
    block(it.body)
  }

  // Title slide
  title-slide(
    title,
    subtitle: subtitle,
    authors: authors,
    institute: institute,
    date: date,
    email: email
  )

  // The actual content
  body
}

//////////////////////////////////////////////////////////////////
// DOCUMENT BEGINS HERE - This is the actual presentation content
//////////////////////////////////////////////////////////////////

#show: doc => biomath-template(
  title: "Your Presentation Title",
  subtitle: "Optional Subtitle",
  authors: "Your Name",
  email: "your.email@ugent.be",
  institute: "Your Institute",
  date: "May 21, 2025",
  doc,
)

// First regular slide
#slide(title: "Introduction")[
  = Introduction

  This is a sample slide with some text.

  #note[
    This is a note block similar to the LaTeX template.
  ]
]

// Second slide
#slide()[
  = Code Example

  Here's an example of code:

  ```python
  def hello_world():
      print("Hello, world!")
      return True
  ```
]

// Third slide with blocks
#slide()[
  = Blocks Example

  #note[
    This is a standard block
  ]

  #warning[
    This is an alert block
  ]

  #example[
    This is an example block
  ]
]

// Section slide with subsection
#slide(title: "Section Title", subtitle: "Subsection")[
  = Section Title
  == Subsection

  Content for this section...
]

// Continue with more slides as needed