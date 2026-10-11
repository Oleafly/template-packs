//
// Dartmouth College Thesis Template in Typst
//

#import "dcthesis.typ": appendices, backmatter, dcthesis, frontmatter, mainmatter
#import "@preview/pergamon:0.8.0": *

#add-bib-resource(read("/references.bib"))

#let hyphenate = true // Set to false to disable hyphenation (useful for proofreading)

#show: dcthesis.with(
  thesis-title: [A Study in Typst Thesis Templates],
  author: [Author Name],
  degree: "Doctor of Philosophy",
  field: "Psychological and Brain Sciences",
  school: "Guarini School of Graduate and Advanced Studies",
  date: "February 2026",

  advisor: [Advisor One Name],
  examiner-1: [Advisor Two Name],
  examiner-2: [Advisor Three Name],
  examiner-3: [Advisor Four Name],
  dean: [F. Jon Kull, Ph.D.],
  dean-title: "Dean of the Guarini School of Graduate and Advanced Studies",

  // copyright: (year: 2026),  // Uncomment to add copyright page

  hyphenate: hyphenate,
  draft: false,
)

// ============================================================================
// FRONT MATTER
// ============================================================================

#frontmatter[
  = Abstract

  Write your abstract here.
  
  = Acknowledgments


  // Table of Contents (automatic)
  #outline(
    title: "Contents",
    indent: auto,
    depth: 3, // Match LaTeX: chapters, sections, subsections (not subsubsections)
  )

  // List of Tables (optional)
  // #outline(
  //   title: "List of Tables",
  //   target: figure.where(kind: table),
  // )

  // List of Figures (optional)
  // #outline(
  //   title: "List of Figures",
  //   target: figure.where(kind: image),
  // )
]

// ============================================================================
// MAIN MATTER
// ============================================================================

#mainmatter[
  #include "sections/ch-1.typ"
  #include "sections/ch-2.typ"

  // ==========================================================================
  // APPENDICES
  // ==========================================================================

  #show: appendices // Switch to appendix numbering
  #include "sections/supp-1.typ"
]

// ============================================================================
// BACK MATTER
// ============================================================================

// BACK MATTER (optional)
//
// This template uses Pergamon for per-chapter bibliographies via refsection.
// Each chapter wraps its content in #refsection(style: style)[...] and ends
// with #print-apa7-bibliography(style). See sections/ch-2.typ for an example.
//
// If you prefer a single global bibliography instead, uncomment the backmatter
// block below and remove the refsection wrappers from your chapter files.
// Note: Typst's built-in bibliography() conflicts with Pergamon — use one or
// the other, not both.
//
// #backmatter[
//   #bibliography("references.bib", style: "apa", title: "References")
// ]
