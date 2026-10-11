// ============================================================================
// Back matter (UCSD formatting manual §III p.43).
//
// REFERENCE-MATTER ORDER (author's responsibility — enforced by source order):
//   Appendices -> Addenda -> Chronology -> Endnotes -> Glossary -> Bibliography
// The bibliography is the LAST element of the manuscript.
//
// This module is applied in the document via `#show: backmatter-rules` and the
// `#appendix(title, body)` helper; it does NOT modify `dissertation()`.
//
// CROSS-MODULE CONTRACT: lib/pagination.typ's back-matter() sets
// state("ucsd-matter") to "back" before any back-matter content.  floats-rules
// (lib/floats.typ) reads this same state key to skip chapter rendering for
// level-1 headings (appendix, bibliography) in back/front matter.
// ============================================================================

#import "blocks.typ": single-spaced

// Single line leading within a bibliography entry (Typst native single).
// NOTE: this literal 0.65em matches lib/blocks.typ's single-spaced leading.
// If blocks.typ's value ever changes, update this constant to match.
#let bib-leading = 0.65em
// Gap between bibliography entries: one blank single-spaced line.
// Calibrated empirically (Task 2, Step 5); ~2x the single leading.
#let bib-entry-gap = 1.3em

#let backmatter-rules(body) = {
  // Bibliography: single-spaced within entries, blank line between entries.
  show bibliography: set par(leading: bib-leading, spacing: bib-entry-gap)
  body
}

// Auto-lettered appendices (A, B, C, ...). Dedicated counter — does not collide
// with the page counter (P1) or chapter counter (P3).
#let appendix-counter = counter("p5-appendix")

#let appendix(title, body) = {
  appendix-counter.step()
  context {
    let letter = numbering("A", appendix-counter.get().first())
    heading(level: 1)[APPENDIX #letter: #title]
  }
  single-spaced(body)
}
