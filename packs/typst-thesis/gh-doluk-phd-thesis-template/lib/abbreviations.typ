// ═══════════════════════════════════════════════════════════════════════════
// ABBREVIATIONS
// ═══════════════════════════════════════════════════════════════════════════
//
// This is the ONE place where you declare acronyms. Afterwards you write
// `@AUC` anywhere in the text and the template expands it to
// "analytical ultracentrifugation (AUC)" on first use and to "AUC" after
// that. `abbreviation-list()` in appendix/abbreviations.typ prints the
// List of Abbreviations, containing exactly the entries you actually used.
//
// Useful specifiers (see https://typst.app/universe/package/abbr):
//   @AUC       automatic: long form on first use, short form afterwards
//   @AUC:s     always the short form              → "AUC"
//   @AUC:l     always the long form               → "analytical ultracentrifugation"
//   @AUC:pla   automatic, plural                  → "AUCs"
//
// Write the long forms in lower case and in the singular; that way they read
// naturally inside a sentence and the plural specifier works.
//
// Don't need acronyms at all? Delete this file, the two `#show:` /
// `#import` lines it is used in (main.typ and preview.typ) and
// appendix/abbreviations.typ.

#import "@preview/abbr:0.3.1"

// ── Your acronyms: ("SHORT", "long form") ──────────────────────────────────
#let abbreviations = (
  ("AUC", "analytical ultracentrifugation"),
  ("BFE", "band-forming experiment"),
  ("FEM", "finite element method"),
  ("FVM", "finite volume method"),
  ("RMSD", "root mean square deviation"),
  ("SV", "sedimentation velocity"),
)

// Applied once in main.typ as `#show: setup-abbreviations`.
#let setup-abbreviations(body) = {
  // Print acronyms as plain text instead of the package's grey bold default.
  abbr.config(style: short => short)
  for entry in abbreviations {
    abbr.make(entry)
  }
  show: abbr.show-rule
  body
}

// Prints the List of Abbreviations; call it wherever you want it to appear.
#let abbreviation-list(title: [List of Abbreviations], columns: 1) = {
  abbr.list(title: title, columns: columns)
}
