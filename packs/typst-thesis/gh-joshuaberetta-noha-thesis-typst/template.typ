// Academic document template
// Import this in your main document with: #import "template.typ": *

// Highlighted emphasis block — use for research questions, key definitions, etc.
#let block_emph(body) = block(
  width: 100%,
  fill: luma(240),
  inset: 1em,
  radius: 4pt,
  text(style: "italic", body),
)

// Draft helper: lorem filler rendered in amber so placeholder text is visually distinct
#let lorem(n) = text(fill: rgb("#b85c00"), style: "italic", std.lorem(n))

// Page setup function
#let setup-page(doc) = {
  set page(
    paper: "a4",
    margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 3cm),
    numbering: "1",
    number-align: right,
  )
  
  set text(
    font: "New Computer Modern",
    size: 12pt,
    lang: "en",
    hyphenate: true,
  )
  
  set par(
    justify: true,
    leading: 0.5em,
    first-line-indent: 0em,
    spacing: 0.85em,
    linebreaks: "optimized",
  )
  
  set heading(numbering: "1.1.1")
  
  // Indent all paragraphs except first after heading/list
  set par(first-line-indent: 1.5em)
  
  // Reset indent after headings
  show heading: it => {
    it
    par(first-line-indent: 0em)[]
  }
  
  // Reset indent after lists and quotes
  show quote: it => {
    it
    par(first-line-indent: 0em)[]
  }
  
  // Level 1 headings: start on new page, bold
  show heading.where(level: 1): it => {
    set text(size: 14pt, weight: "bold")
    pagebreak(weak: true)
    block(above: 2em, below: 1.5em)[#it]
  }
  
  // Level 2 headings
  show heading.where(level: 2): it => {
    set text(size: 12pt, weight: "bold")
    block(above: 1.5em, below: 1em)[#it]
  }
  
  // Level 3 headings
  show heading.where(level: 3): it => {
    set text(size: 12pt, weight: "bold")
    block(above: 1.2em, below: 0.8em)[#it]
  }
  
  // Quote styling
  show quote: set block(spacing: 1.5em)
  show quote: set pad(left: 2em, right: 2em)

  // Better spacing for lists
  set list(indent: 1em, body-indent: 0.5em, spacing: 0.85em)
  set enum(indent: 1em, body-indent: 0.5em, spacing: 0.85em)

  // Spacing around figures and tables
  show figure: set block(above: 2em, below: 2em)

  // External hyperlinks (URLs): blue. Internal document links (glossarium, cross-refs): inherit body colour.
  show link: it => if type(it.dest) == str { text(fill: rgb("#0066cc"), it) } else { it }

  // Citations: black (same as body text)
  show cite: set text(fill: luma(0))

  // Footnote styling: 10pt, single-spaced, extra gap between notes
  show footnote.entry: set text(size: 10pt)
  set footnote.entry(gap: 1em)

  doc
}

// Title page function
#let title-page(
  title: "",
  subtitle: "",
  author: "",
  student-number: "",
  supervisor: "",
  supervisor-affiliation: "",
  month-year: "",
) = {
  set page(numbering: none)

  // Top: RUG banner + NOHA logo
  place(
    top + center,
    dy: -1.5cm,
    align(center)[
      #image("assets/uni-logo.jpg", width: 16cm)
      #v(0.6em)
      #image("assets/noha-logo.png", width: 6cm)
    ]
  )

  // Title block in centre of page
  align(center + horizon)[
    #text(size: 22pt, weight: "bold")[#title]
    #v(0.7em)
    #text(size: 14pt, style: "italic")[#subtitle]
  ]

  // Bottom: author, supervisor, date, mandatory declaration
  place(
    bottom + center,
    dy: 1.5cm,
    align(center)[
      #text(size: 12pt)[
        #text(weight: "bold")[#author] \
        #v(0.2em)
        #student-number \
        #v(0.5em)
        Supervisor: #supervisor \
        #supervisor-affiliation \
        #v(0.5em)
        #month-year
      ]
      #v(1.5em)
      #box(width: 12cm)[
        #set par(first-line-indent: 0em, hanging-indent: 0em)
        #text(size: 9pt, style: "italic")[
          This thesis is submitted for obtaining the Master's Degree in
          International Humanitarian Action. By submitting the thesis, the author
          certifies that the text is from his/her hand, does not include the work
          of someone else unless clearly indicated, and that the thesis has been
          produced in accordance with proper academic practices.
        ]
      ]
      #v(3em)
    ]
  )

  pagebreak()
}
