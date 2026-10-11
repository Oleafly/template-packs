// =============================================================================
// UL FRI Magistrsko delo – Package entrypoint
// Typst port of: https://github.com/UL-FRI/thesis-BMA
// =============================================================================

#import "@preview/headcount:0.1.0": dependent-numbering

#import "style.typ": thesis, LaTeX, clear-empty-double-page, mainmatter-header, mainmatter-footer
#import "front.typ": title-page, copyright-page, acknowledgments-page, dedication-page, abbreviations-page
#import "abstract.typ": povzetek, abstract-page

// Re-export dependent-numbering so users don't need to know about headcount.
// It is needed for appendix numbering setup (e.g., dependent-numbering("A.1")).
#let dependent-numbering = dependent-numbering
