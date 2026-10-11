// ALTEN BST (Bilan Scientifique et Technique) Template
// Main document file

// Import utilities
#import "Utilities/cover.typ": make-cover
#import "./Utilities/style.typ": apply-style
// Document metadata
#let title = "Title"
#let subtitle = "Subtitle"
#let short-title = "test"
#let year = "2026"
#let department = "Innovation Department - Quentin Balezeau"

// Apply document style
#show: apply-style.with(
  title: title,
  short-title: short-title
)

// Cover page
#make-cover(
  title: title,
  subtitle: subtitle,
  year: year,
  department: department
)

// Table of contents
#pagebreak()
#outline(
  title: "Contents",
  depth: 3,
  indent: auto
)

// Explainer section (non-numbered)
#pagebreak()
#heading(numbering: none)[Explainer]
#include "Sections/_Explainer.typ"

// Abstract section (non-numbered)
#pagebreak()
#heading(numbering: none)[Abstract]
#include "Sections/0_Abstract.typ"

// Main sections (numbered)
#pagebreak()
#include "Sections/1_Introduction.typ"

#pagebreak()
#include "Sections/2_Problem.typ"

#pagebreak()
#include "Sections/3_SoTA.typ"

#pagebreak()
#include "Sections/4_Operations.typ"

#pagebreak()
#include "Sections/5_Conclusions.typ"

// Bibliography
#pagebreak()
#heading(numbering: none)[References]
#bibliography("Utilities/Bibliography.bib", style: "ieee")

// Glossary
#pagebreak()
#heading(numbering: none)[Glossary]
#include "Utilities/Glossary.typ"
