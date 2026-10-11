
// UAntwerpen Master Thesis
// Import the custom thesis template
#import "uantwerpen-thesis.typ": *

#show: uantwerpen-thesis.with(
  faculty: "be",
  title: [Your Thesis Title Here],
  subtitle: none,
  author: [Your Name],
  degree: [Master of Engineering: Electronics and ICT],
  doc-type: [Master's Thesis],
  academic-year: [2024 - 2025],
  supervisors: (
    ([prof. dr. Supervisor Name], [UAntwerpen]),
  ),
  cosupervisors: (),
  extsupervisors: (),
  lang: "en",
  logo-path: "logos/logo-uantwerpen-be-en-rgb-pos.pdf",
  frontmatter-pages: 1, // ToC + abstract page count for roman numbering
  draft: false, // Set to true for single-sided draft mode (easier screen reading)
)

// Abstract/summary page
#page(
  header: none,
  footer: none,
)[
  #align(center)[
    #text(size: 14pt, weight: 700)[Abstract] \
    #v(0.5em)
    #text(size: 16pt, weight: 700)[Your Thesis Title Here] \
    #v(0.3em)
    Your Name
  ]
  
  #v(2em)
  
  // Two-column abstract content
  #block(width: 100%)[
    #columns(2)[
      Write your abstract here. This is a two-column summary of your thesis work.
      
      #lorem(100)
    ]
  ]
]

// Main content
= Introduction

#inset-text-be[Important highlighted text appears like this!]

#lorem(50)

= Literature Review

Your literature review content goes here.

== Background

#lorem(30)

== Related Work

#lorem(30)

= Methodology

Describe your research methodology.

== Research Question

#inset-quote-be[You can use this style for important quotes or statements that you want to highlight in your thesis.]

== Approach

#lorem(50)

= Results

Present your results here.

== Experimental Setup

#lorem(30)

== Findings

Mathematical equations can be written using standard Typst syntax:

$ E = m c^2 $

$ integral_0^infinity e^(-x^2) dif x = sqrt(pi)/2 $

#lorem(50)

= Discussion

Discuss your findings here.

#lorem(1500)

= Conclusion

Summarize your work and conclusions.

#lorem(30)

// Appendices
#set heading(numbering: "A.1", supplement: [Appendix])
#counter(heading).update(0)

= List of Symbols

Define symbols used in your thesis.

= References

Your references go here. Consider using Typst's bibliography features.


