/*
document.typ

This file contains the content of the document. 
When editing the content, this file should be used.
*/

// Package for acronyms
#import "@preview/acrostiche:0.5.1": *
// Frontpage
#import "resources/frontpage.typ": frontpage
// Declaration of personal contribution
#import "resources/erklaerung.typ": erklaerung

// Front page
// Adjust the column sizes in resources/frontpage.typ (line 54)
// if your (supervisors) name is too long
#frontpage(
  workTitle:"Bachelor thesis",
  title: "My Topic",
  studyProgram: "Faculty of Computer Science",
  universityName: "Duale Hochschule Baden-Württemberg (DHBW) Stuttgart",
  author: "My Name",
  matrNum: "0000000",
  course: "My course",
  supervisor: "Max Mustermann",
)

// Set regular line spacing and justification
// Move this line above #frontpage to use line spacings for the title
#set par(justify: true, leading: 1.5em, spacing: 1.5em)

#pagebreak()

// Erklärung
#erklaerung(
  title: "My Topic"
)

// First line indent for new paragrapha
#set par(first-line-indent: 1em)

// Abstract (remove line if not needed)
#pagebreak()
#include "content/abstract.typ"

// Table of contents
// Headings level one in bold
#show outline.entry.where(
  level: 1
): set text(weight: "bold")
// Print outline
#pagebreak()
#outline(
  title: text()[Table of Contents],
)
#pagebreak()

// List of figures
#show outline.entry.where(
  level: 1
): set text(weight: "regular")
#outline(
  title: text()[List of Figures],
  target: figure.where(kind: image)
)
#pagebreak()

// List of Listings
#outline(
  title: text()[List of Listings],
  target: figure.where(kind: "listing")
)
#pagebreak()

// List of tables
#outline(
  title: text()[List of Tables],
  target: figure.where(kind: table)
)
#pagebreak()

// List of formulas
#outline(
  title: text()[List of Formulas],
  target: math.equation.where(block: true)
)

// Acronyms
#pagebreak()
#print-index(title: "Abbreviations", row-gutter: 1.5em, delimiter: "", used-only: true)

// Header
#set page(
  header: [#align(right, image("images/logo.png", width: 17.5%))],
)

// Set regular page formatting
#set page(
  header: [#align(right, image("images/logo.png", width: 17.5%))],
  numbering: "1",
  footer: context[
    #set par(spacing: 1em)
    #align(center)[
      #line(length: 100%, stroke: 0.5pt) // Line above number in page footer
      #counter(page).display("1")
      ]
    ]
)

// Set page number to 1
#counter(page).update(1)


// Chapters / actual content
// Include the files you need
#include "content/chapter1.typ"
#include "content/chapter2.typ"
#include "content/chapter3.typ"
#include "content/chapter4.typ"


// Bibliography page
#pagebreak()
#bibliography("bibliography.bib", title: text()[Bibliography])


// Appendix

// Settings
#pagebreak()
#heading([Appendix], numbering: none)
#counter(heading).update(0)
#set heading(numbering: "A.")
// Content
#include "appendix.typ"

