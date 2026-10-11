#import "oist_thesis.typ": *

#show: doc => thesis(
  title: "Typst Dissertation Template",
  author: "Kazuma Takada",
  supervisor: "S. Upervisor",
  cosupervisor: "C. O'Supervisor",
  submission_date: "September 2025",
  mode: "review", // Change to "submission" for the final submission
  colored_refs: false, // true = blue clickable citations/cross-references (screen copy)
  doc,
)

// ================================
// PREAMBLE SECTION
// ================================

// Front matter pages
#include "preamble/declaration.typ"
#include "preamble/declaration_ai_tools.typ"
#include "preamble/abstract.typ"
#include "preamble/acknowledgments.typ"
#include "preamble/abbreviations.typ"
#include "preamble/glossary.typ"
#include "preamble/nomenclature.typ"
#include "preamble/publications.typ"
#include "preamble/dedication.typ"

// ================================
// LISTS AND CONTENTS
// ================================

// Table of Contents
#unnumbered-chapter("Table of Contents")
#v(2em)
#outline(
  title: none,
  depth: 3,
  indent: 2em,
)

// Add space before List of Figures
#v(2em)

// List of Figures
#unnumbered-chapter("List of Figures")
#v(2em)
#list_of_figures()

// Add space before List of Tables
#v(2em)

// List of Tables
#unnumbered-chapter("List of Tables")
#v(2em)
#list_of_tables()

// ================================
// MAIN TEXT
// ================================

// Switch to main content with headers only (no footer page numbers)
// FIXED: Set proper page configuration for main content
#set page(
  numbering: "1",  // Enable page numbering (but it will show in header only)
  header: page_header,
  footer: none,  // Explicitly disable footer
)
#counter(page).update(1)

// ================================
// FIRST-LINE INDENT AFTER BLOCKS
// ================================
// Typst treats the text following a figure/table/list as a continuation of the
// same paragraph, so it does not get the 1.5em first-line indent. Emitting an
// invisible empty paragraph after each block element (and pulling the extra
// height back with a negative `v`) makes the next real paragraph start fresh
// and therefore indent. The `oist-in-heading` guard suppresses the trailer for
// elements emitted while a heading (or `embed_pdf`) is rendering, so the first
// paragraph of a chapter stays flush left and embedded PDF pages do not get a
// blank page pushed after each of them.
//
// `block` and bare `table` are deliberately NOT targeted: the figure show rule
// in oist_thesis.typ builds captions out of blocks with an explicit
// `spacing: 10pt`, and the negative `v` below (which assumes `par.spacing`)
// would then over-compensate and drag the table up over its own caption.
#let indent-targets = (
  figure,
  list,
  enum,
  grid,
  math.equation.where(block: true)
)

#show selector.or(..indent-targets): it => context {
  it
  if state("oist-in-heading", 0).get() == 0 {
    ""
    v(-measure("").height - par.spacing)
  }
}

// Main chapters
#include "chapters/introduction.typ"
#include "chapters/guideline.typ"
#include "chapters/howtouse.typ"
#include "chapters/figures_tables.typ"
#include "chapters/conclusion.typ"

// ================================
// BIBLIOGRAPHY
// ================================

#v(2em)
#unnumbered-chapter("Bibliography")
#bibliography("bibliography.bib", title: none)

// ================================
// APPENDICES
// ================================

#v(2em)
#unnumbered-chapter("Appendices")

// Table of Appendices
#v(1em)
#let appendix_entries = (
  ("A", "First Appendix", <appendix-a>),
  ("B", "Second Appendix", <appendix-b>),
)
#table(
  columns: (auto, 1fr, auto),
  stroke: none,
  align: (left, left, right),
  [*Appendix*], [*Title*], [*Page*],
  table.hline(),
  ..appendix_entries.map(entry => (
    [#entry.at(0)],
    [#entry.at(1)],
    [#context {
      let targets = query(entry.at(2))
      if targets.len() > 0 {
        counter(page).at(targets.first().location()).first()
      } else {
        "?"
      }
    }],
  )).flatten()
)

#pagebreak()

// Appendix content without chapter structure.
// Each file wraps its body in #appendix("<letter>")[...] so its sections and
// figures are numbered A.1, B.1, ... instead of continuing the chapter counter.
#include "chapters/appendixA.typ"
#include "chapters/appendixB.typ"
