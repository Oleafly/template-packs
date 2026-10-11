// ==================== external packages ====================
#import "@preview/glossarium:0.5.6": print-glossary

// ==================== internal packages ====================
#import "cover.typ": cover-page
#import "glossary.typ": glossary-dictionary

// ==================== states ====================
#let matter = state("matter", none)


// ==================== cover page ====================
#matter.update("cover")
#cover-page(
  lorem(10),
  "Foulen Fouleni",
  "Software Engineering",
  (
    president-of-the-jury: "Mr./Ms. Prez",
    reviewer: "Mr./Ms. Reviewer",
    supervisor-at-the-company: "Mr./Ms. X",
    supervisor-at-insat: "Mr./Ms. Encadrante",
  ),
  "2024 / 2025",
  datetime(year: 2025, month: 10, day: 3).display(),
  "Lorem Ipsum GmbH",
  "/images/logos/company.png"
)

// ==================== frontmatter ====================
#matter.update("front")
#set heading(numbering: none, outlined: false)
// ====================

// dedication
#include "dedication.typ"
#pagebreak()

// acknowledgments
#include "acknowledgments.typ"
#pagebreak()

// start counting here
#set page(numbering: "i")
#counter(page).update(1)

// abstract
#include "abstract.typ"
#pagebreak()

// outline
#outline()
#pagebreak()

// list of figures, tables & extracts
#outline(
  title: [List of Figures],
  target: figure.where(kind: image),
)
#outline(
  title: [List of Tables],
  target: figure.where(kind: table),
)
#outline(
  title: [List of Extracts],
  target: figure.where(kind: raw),
)
#pagebreak()

// glossary
= Glossary
#block[
  #set text(size: 10pt)
  #print-glossary(glossary-dictionary, disable-back-references: true)
]
#pagebreak()


// ==================== mainmatter ====================
#matter.update("main")
#set page(numbering: "1")
#counter(page).update(1) 
#set heading(numbering: "1.", outlined: true)
// ====================

#include "chapters/0_introduction.typ"
#include "chapters/1_project_overview.typ"


// ==================== backmatter ====================
#matter.update("back")
#pagebreak()
#set page(numbering: none)
#set heading(numbering: none, outlined: true)
// ====================

// summary
#include "summary.typ"
#pagebreak()

#bibliography("bibliography.yaml") 
