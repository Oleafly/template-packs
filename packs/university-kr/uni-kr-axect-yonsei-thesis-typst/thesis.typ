// ┌─────────────────────────────────────────────────────────┐
//   Thesis Template for Yonsei University (Author: Axect)
// └─────────────────────────────────────────────────────────┘
#let thesis(
  title: "",
  title_kr: "",
  author: "",
  degree: "",
  department: "",
  university: "Yonsei University",
  date: "",
  month: "",
  year: "",
  supervisor: "",
  committee: (),
  is_doctoral: true, // true for doctoral dissertation, false for master's thesis
  body
) = {
  // Set the document metadata
  set document(title: title, author: author)
  
  // Set the page size to A4
  set page(
    paper: "a4",
    margin: (
      top: 5.3cm,
      bottom: 5.3cm,
      left: 3.5cm,
      right: 3.5cm,
    ),
    header-ascent: 1.5cm,
    footer-descent: 3.2cm,
    numbering: none, // Initially no numbering
  )
  
  // Set font to Times New Roman
  set text(
    font: "Times New Roman",
    //font: "STIX Two Text",
    size: 11pt,
    top-edge: 0.75em,
  )
  show math.equation: set text(font: "STIX Two Math")
  
  // Set paragraph properties - indentation and justified alignment
  set par(
    first-line-indent: 1.25em,
    justify: true,
    leading: 0.65em,
    spacing: 1.15em, // Paragraph spacing
  )
  
  // Set heading properties
  set heading(
    numbering: "1.1",
  )
  
  // Style for headings at different levels
  show heading.where(level: 1): it => {
    set text(size: 16pt, weight: "bold", top-edge: 0.75em)
    it
  }
  
  show heading.where(level: 2): it => {
    set text(size: 13pt, weight: "bold", top-edge: 0.75em)
    it
  }
  
  show heading.where(level: 3): it => {
    set text(size: 13pt, weight: "bold", top-edge: 0.75em)
    it
  }

  show heading.where(level: 4): it => {
    set text(size: 13pt, weight: "bold", top-edge: 0.75em)
    it
  }
  
  // Footnote settings
  show footnote.entry: it => {
    set text(size: 9pt, top-edge: 0.75em)
    set par(leading: 0.4em) // Apply the same line spacing to footnotes
    it
  }

  // Equation numbering
  set math.equation(numbering: "(1)")
  
  // Cover page (Appendix 1)
  page(margin: (top: 8cm, rest: 3.5cm))[
    #align(center)[
      #grid(
        rows: (50%, 30%, 20%),
        text(size: 18pt, weight: "bold")[#title],
        text(size: 18pt, weight: "bold")[#author],
        text(size: 18pt, weight: "bold")[
          Department of #department \
          Graduate School \
          Yonsei University \
        ]
      )
    ]
  ]
  
  // Title page (Appendix 2)
  page[
    #align(center)[
      #grid(
        rows: (18.75%, 12.5%, 37.5%, 4.2%, 20.5%, auto),
        text(size: 16pt, weight: "bold")[#title],
        text(size: 16pt, weight: "bold")[Advisor: #supervisor],
        text(size: 16pt)[
          A #if is_doctoral { "Dissertation" } else { "Thesis" } Submitted \
          to the Department of #department \
          and the Committee on Graduate School \
          of Yonsei University in Partial Fulfillment of the \
          Requirements for the Degree of \
          Doctor of #degree
        ],
        text(size: 16pt, weight: "bold")[#author],
        [],
        text(size: 16pt)[#month #year]
      )
    ]
  ]
  
  // Signature page (Appendix 3)
  page[
    #align(center)[
      #grid(
        rows: (13%, 14%, 49.5%, 8.36%, auto),
        text(size: 13pt, weight: "bold")[#title],
        text(size: 13pt, weight: "bold")[
          This Certifies that the Dissertation of #author is Approved
        ],
        grid(
          columns: (7%, 32.6%, auto),
          rows: committee.len() + 1,
          row-gutter: 2.75em,
          [],
          [
            #hide(line(length: 100%))
            #v(-0.55em)
            #align(left)[#text(size: 13pt, weight: "bold")[Committee Chair]]
            #v(0.5cm)
          ],
          [
            #line(length: 88%)
            #v(-0.55em)
            #align(left)[#text(size: 13pt, weight: "bold")[#h(1em) #supervisor]]
            #v(0.5cm)
          ],
          ..committee.map(member => (
            [],
            [
              #hide(line(length: 100%))
              #v(-0.55em)
              #align(left)[#text(size: 13pt, weight: "bold")[Committee Member]]
              #v(0.5cm)
            ], 
            [
              #line(length: 88%)
              #v(-0.55em)
              #align(left)[#text(size: 13pt, weight: "bold")[#h(1em) #member]]
              #v(0.5cm)
            ]
          )).flatten()
        ),
        [],
        align(bottom)[#text(size: 13pt, weight: "bold")[
          Department of #department \
          Graduate School \
          Yonsei University \
          #month #year
        ]]
      )
    ]
  ]
  
  // Start using Roman numerals for preliminary pages
  set page(numbering: "i")
  counter(page).update(1) // Start at page i
  
  // Optional dedication or acknowledgements page can be added here
  
  // Table of contents page
  [
    #outline(
      title: [
        #grid(
          columns: (1fr, auto, 1fr),
          [],
          text(size: 16pt)[#align(center)[TABLE OF CONTENTS]],
          [],
        )
        #v(0.5cm)
      ],
      indent: auto,
      depth: 3,
    )
  ]
  
  // List of Figures (if applicable)
  [
    #pagebreak()
    #set heading(numbering: none)
    #show heading: it => [
      #set text(size: 13pt, weight: "bold", top-edge: 0.75em)
      #block(it.body)
    ]

    = LIST OF FIGURES
    #outline(
      title: [],
      target: figure.where(kind: image),
    )
  ]
  
  // List of Tables (if applicable)
  [
    #pagebreak()
    #set heading(numbering: none)
    #show heading: it => [
      #set text(size: 13pt, weight: "bold", top-edge: 0.75em)
      #block(it.body)
    ]
    = LIST OF TABLES
    #outline(
      title: [],
      target: figure.where(kind: table),
    )
  ]
  
  // Abstract in English
  [
    #pagebreak()
    #set heading(numbering: none)
    #show heading: it => [
      #set text(size: 13pt, weight: "bold", top-edge: 0.75em)
      #block(it.body)
    ]
    #grid(
      rows: (8%, 14%, 70%, 8%),
      [
        = ABSTRACT
      ],
      align(center)[
        #text(size: 13pt, weight: "bold")[#title]
      ],
      [
        // Abstract content would go here
        This is a placeholder for the abstract content. Abstract should be two pages or less.
      ],
      [
        #line(length: 100%)
        #v(-0.15cm)
        #text(size: 10pt, weight: "bold")[Key words: ] #text(size: 10pt)[Within 10 words]
      ]
    )
  ]
  
  // Switch to Arabic numerals for main content
  set page(numbering: "1")
  counter(page).update(1) // Reset to page 1
  
  // Main body content
  body

  // Abstract in Korean at the end
  [
    #pagebreak()
    #set heading(numbering: none)
    #show heading: it => [
      #set text(size: 13pt, weight: "bold", top-edge: 0.75em)
      #block(it.body)
    ]
    #grid(
      rows: (8%, 14%, 70%, 8%),
      [
        = ABSTRACT IN KOREAN
      ],
      align(center)[
        #text(size: 13pt, weight: "bold")[#title_kr]
      ],
      [
        #set text(size: 11pt)
        #set par(leading: 0.75em)

        // Abstract content would go here
        이곳에 한글 초록 내용이 들어갑니다. 초록은 두 페이지 이내로 작성되어야 합니다.
      ],
      [
        #line(length: 100%)
        #v(-0.15cm)
        #text(size: 10pt, weight: "bold")[핵심되는 말: ] #text(size: 10pt)[10단어 이내]
      ]
    )
  ]
}

// ┌─────────────────────────────────────────────────────────┐
//  Main Document
// └─────────────────────────────────────────────────────────┘
#show: doc => thesis(
  title: "Title",
  title_kr: "한국어 제목",
  author: "Your Name",
  degree: "Philosophy",
  department: "Your Department",
  university: "Yonsei University",
  date: "2025",
  month: "June",
  year: "2025",
  supervisor: "Name of Supervisor",
  committee: ("Name1", "Name2", "Name3", "Name4"),
  is_doctoral: true,
  doc,
)

= Introduction

This is the introduction of the dissertation. The text is set with Times New Roman font at 11pt with 1.15 line spacing. Paragraphs begin with an indentation of 2 spaces and are justified.

Here is a second paragraph to demonstrate the paragraph indentation. Notice how the justified alignment makes the text align with both the left and right margins.

== Background

This is a level 2 heading, which appears in 13pt bold font according to the requirements.

A footnote can be added like this.#footnote[This is a footnote in 9pt size.]

=== Key Findings
Some key findings from previous research include...

= Literature Review

This chapter presents a review of relevant literature. The page numbering continues with Arabic numerals.

== Previous Research

Previous research in this field has established several important principles.

= Methodology

This chapter describes the methodology used in this research.

= Results and Discussion

This chapter presents the results of the research and discusses their implications.

= Conclusion

This chapter summarizes the findings and conclusions of the research.
