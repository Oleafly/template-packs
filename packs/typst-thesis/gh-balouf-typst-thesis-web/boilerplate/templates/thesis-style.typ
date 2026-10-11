// =============================================================================
// Thesis style
// =============================================================================
//
// TODO: adapt — define your thesis page layout, headers, title page, etc.
// This file should export a thesis-style show rule and a title-page function.
// Example:
//   #let thesis-style(doc) = {
//     set text(font: "New Computer Modern", size: 12pt)
//     set page(paper: "a4", margin: 2.5cm)
//     doc
//   }
//   #let title-page() = { ... }
// =============================================================================

#import "i18n.typ": t
#import "meta-data.typ": *

// Minimal style so the boilerplate compiles out of the box.
// TODO: adapt — replace with your full thesis style.
#let thesis-style(doc) = {
  set text(font: "New Computer Modern", size: 12pt, lang: t("fr", "en"), region: t("FR", "US"))
  set math.equation(numbering: "(1)")
  doc
}
