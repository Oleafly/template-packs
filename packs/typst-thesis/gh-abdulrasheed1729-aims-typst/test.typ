//-----------------------------------------------------------------------------
// Template for AIMS Structured Masters Research Project
//
// The fonts, linespacing, numbering, page styles, order
// of  Title/Abstract/TOC/Body/{Appendices}/Acknowledgements/References
// are prescribed as the AIMS house style.
//
// Do not change them or add to it without getting approval first.
// Essays are not accepted if they do not follow house style.
//-----------------------------------------------------------------------------

#import "main.typ": aimsessay, appendix
// #import "@preview/ctheorems:1.1.3": *

// // ----------------------------------------------------------------------------
// // Built-in Equivalents for LaTeX Packages:
// // ----------------------------------------------------------------------------
// // utf8, fontenc, lmodern -> Typst is natively UTF-8. Fonts are set in aimsessay.typ.
// // amsmath, amsfonts, amssymb, mathtools -> All native to Typst math.
// // parskip, enumerate -> Native.
// // graphicx, float, subcaption -> Handled natively by #figure, #grid, and #image.
// // booktabs, array -> Handled natively by #table.
// // tikz -> Use the Typst native package "@preview/cetz:0.2.2" instead.
// // sagetex / listings / moreverb -> Typst has built-in raw code blocks (```python).
// // siunitx -> Try the "@preview/unify" or "@preview/quantities" package.

// // ----------------------------------------------------------------------------
// // Theorems Setup (Replacing amsthm)
// // We use ctheorems to replicate the \swapnumbers, italics, and numbering logic.
// // ----------------------------------------------------------------------------
// #show: thmrules
// #show: aimsessay

// // Format to swap numbers (e.g., "1.1 Theorem" instead of "Theorem 1.1")
// #let swap_fmt(name, number, body, title: none) = {
//   [#strong[#number #name]#if title != none { [ (#title)] }.]
//   h(0.5em)
//   body
// }

// // Plain style (italics)
// #let thm = thmbox("theorem", "Theorem", base: "heading", fmt: swap_fmt, stroke: none)

// // Definition style (upright/normal font)
// // Note: In ctheorems, we can force the body to be upright by wrapping it in #text() if needed,
// // but by default Typst theorems are upright. We explicitly make `thm` italic if we want strict LaTeX matching.
// #let lem = thmbox("lemma", "Lemma", base: "heading", fmt: swap_fmt, stroke: none)
// #let cor = thmbox("corollary", "Corollary", base: "heading", fmt: swap_fmt, stroke: none)
// #let conj = thmbox("conjecture", "Conjecture", base: "heading", fmt: swap_fmt, stroke: none)
// #let pro = thmbox("proposition", "Proposition", base: "heading", fmt: swap_fmt, stroke: none)
// #let exa = thmbox("example", "Example", base: "heading", fmt: swap_fmt, stroke: none)
// #let defn = thmbox("definition", "Definition", base: "heading", fmt: swap_fmt, stroke: none)
// #let rem = thmbox("remark", "Remark", base: "heading", fmt: swap_fmt, stroke: none)

// // Number equations by section (e.g., 1.1, 1.2)
// #set math.equation(numbering: "(1.1)")

// // ----------------------------------------------------------------------------
// // Custom Command Shortcuts
// // Keep them clearly separate from other sections. Use #let instead of \newcommand.
// // ----------------------------------------------------------------------------
// #let be(body) = math.equation(block: true, body)
// #let C = math.bb("C") // Complex
// #let Z = math.bb("Z") // Integers
// #let R = math.bb("R") // Real
// #let sech = math.op("sech")

// -----------------------------------------------------------------------------
// TITLE PAGE CONFIGURATION
// -----------------------------------------------------------------------------
// On this page you must have NO full-word capitalizations, bold, or colour.
// All AIMS research projects per year have the same title page.

#set page(numbering: none, header: none) // Empty pagestyle for title page

#align(center)[
  // Title
  #v(6cm)
  #text(size: 18pt)[The Essay Title goes here Rafał RAFAŁ test]

  #v(2.5em)
  // Author
  #text(size: 12pt)[
    Firstname Middlename Familyname (email\@aims.ac.za)
    // Amharic, Arabic, etc. can be typed directly natively in Typst!
    // e.g. نووووووسسسسح
    \
    African Institute for Mathematical Sciences (AIMS)\
    \
    #text(size: 10pt)[
      Supervised by: Title Firstname Lastname\
      Institute of Supervisor, Country\
      // and Dr So And-so\
      // University of Life, Country
    ]
  ]

  // #v(1fr) // Pushes the date/logo to the bottom
  #v(0.5cm)

  // Date and details
  #text(size: 10pt)[24 October 2024]\
  #text(size: 8pt, style: "italic")[
    Submitted in partial fulfillment of a structured masters degree at AIMS South Africa
  ]

  #v(0.5em)
  // Ensure you have the logo in an images/ folder
  #image("images/AIMS_SA_Logo.pdf", width: 50%)
]

// -------------------------------------------------------------------------
// MAIN DOCUMENT START
// -------------------------------------------------------------------------
#pagebreak()

// We number roman numerals until the main body
#set page(numbering: "i", header: none)
#counter(page).update(1)

// The abstract is the first thing we want to see. No acknowledgements or
// dedications here. Fetch the abstract from a separate file.
#include "abstract.typ"

#pagebreak()

// Don't go typing out the contents.
#outline(title: "Contents", indent: auto, depth: 2)

#pagebreak()

// We switch to arabic numerals here where your page count starts
// Essays must be close to 30 pages long *starting here*.
#set page(numbering: "1", header: context {
  // Re-enable the running header defined in aimsessay.typ
  // (Assuming aimsessay.typ's header logic checks page numbers)
})
#counter(page).update(1)

//-----------------------------------------------------------------------------
// Each chapter goes in a separate file
//-----------------------------------------------------------------------------
#include "chapter1.typ"
#pagebreak()
#include "chapter2.typ"
// #include "chapter3.typ"
// #include "chapter4.typ"

//-----------------------------------------------------------------------------
// Acknowledgements
//-----------------------------------------------------------------------------
// #include "acknowledgement.typ"

//-----------------------------------------------------------------------------
// THE BIBLIOGRAPHY
// Note: Typst handles standard bib files. Use `style: "apa"` or "ieee"
// depending on AIMS' exact author-year or numbered preference.
//-----------------------------------------------------------------------------
#pagebreak()
#heading(numbering: none)[References]
#bibliography("references.bib", style: "apa", title: none)
