// =============================================================================
// Theorem environments
// =============================================================================
//
// Minimal definitions so the boilerplate compiles out of the box.
// TODO: adapt — customize styles, add lemma, proposition, corollary, etc.
// See the ctheorems package: https://typst.app/universe/package/ctheorems
// =============================================================================

#import "@preview/ctheorems:1.1.3": thmrules, thmbox, thmproof
#import "i18n.typ": t

#let theoreme = thmbox("theoreme", t("Théorème", "Theorem"), base_level: 1)
#let demo = thmproof("demo", t("Démonstration", "Proof"), base: "theoreme")
