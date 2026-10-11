// =============================================================================
// Thesis — PDF entry point
// =============================================================================
//
// Compilation:
//   typst compile --input lang=fr main.typ thesis-fr.pdf
//   typst compile --input lang=en main.typ thesis-en.pdf
// =============================================================================

// -----------------------------------------------------------------------------
// Imports
// -----------------------------------------------------------------------------

#import "templates/i18n.typ": lang, t
#import "templates/thesis-style.typ": *  // TODO: adapt — provide your thesis-style.typ
#import "templates/prelude.typ": *

// TODO: adapt — initialize acronyms if you use them
// #init-acronyms(acronyms)

// Show rules
// TODO: adapt — customize your thesis style in templates/thesis-style.typ
#show: thesis-style
#show: thmrules

// -----------------------------------------------------------------------------
// Title page
// -----------------------------------------------------------------------------

// TODO: adapt — call your title page function
// #title-page()

// -----------------------------------------------------------------------------
// Disclaimer
// -----------------------------------------------------------------------------

// TODO: adapt — include your disclaimer page
// #include "templates/disclaimer.typ"

// #pagebreak()

// -----------------------------------------------------------------------------
// Table of contents
// -----------------------------------------------------------------------------

#outline(
  title: t([Table des matières], [Table of Contents]),
  depth: 3,
  indent: auto,
)

// -----------------------------------------------------------------------------
// Chapters
// -----------------------------------------------------------------------------

// TODO: adapt — add your chapters here
#if lang == "en" {
  include "chapters/example.en.typ"
} else {
  include "chapters/example.typ"
}

// -----------------------------------------------------------------------------
// Bibliography
// -----------------------------------------------------------------------------

// TODO: adapt — point to your .bib and .csl files
// #pagebreak()
// #bibliography("references.bib", style: "springer-lncs-alphabetical.csl")
