#import "lib.typ": declaration-of-independent-processing, bachelor-thesis, master-thesis

// Register abbreviations
#import "dependencies.typ": make-glossary, print-glossary, register-glossary
#show: make-glossary
// Abbreviations
#import "abbreviations.typ": abbreviations-entry-list
#register-glossary(abbreviations-entry-list)
// Edit values in overview.typ -> thesis-overview
#import "overview.typ": thesis-overview

// typst watch main.typ thesis.pdf

// Initialize template
#show: master-thesis.with(
  ..thesis-overview,
  // Everything inside "before-content" will be automatically injected
  // into the document before the actual content starts.
  before-content: {
    // Print abbreviations
    pagebreak(weak: true)
    heading("Abbreviations", numbering: none)
    print-glossary(
      abbreviations-entry-list,
      disable-back-references: true,
    )
  },
  // Everything inside "after-content" will be automatically injected
  // into the document after the actual content ends.
  after-content: {
    // Print bibliography
    pagebreak(weak: true)
    bibliography("bibliography.bib", style: "./ieeetran.csl")

    // Declaration of independent processing (comment out to disable)
    declaration-of-independent-processing
  },
)

//#####################        Include chapters of thesis         #####################
#pagebreak(weak: true)
#include "chapters/introduction.typ"

