// =============================================================================
// UL FRI Magistrsko delo – Povzetki / Abstracts
// =============================================================================

#import "style.typ": clear-empty-double-page

// --- Povzetek (slovenščina) --------------------------------------------------

#let povzetek(config: (:), body) = {
  [#heading(numbering: none, outlined: true, bookmarked: true)[Povzetek] <heading:povzetek>]

  [*Naslov:* #config.title]

  v(0.5em)

  body

  [#heading(level: 3, numbering: none, outlined: false)[Ključne besede]]
  emph[#config.keywords]

  clear-empty-double-page()
}

// --- Abstract (English) ------------------------------------------------------

#let abstract-page(config: (:), body) = {
  set text(lang: "en")

  [#heading(numbering: none, outlined: true, bookmarked: true)[Abstract] <heading:abstract>]

  [*Title:* #config.at("title-en", default: "")]

  v(0.5em)

  body

  [#heading(level: 3, numbering: none, outlined: false)[Keywords]]
  emph[#config.at("keywords-en", default: "")]

  // Reset language back to Slovenian after English abstract content.
  set text(lang: "sl")
  clear-empty-double-page()
}
