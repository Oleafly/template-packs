#import "@preview/ctheorems:1.1.3": thmbox, thmenv, thmproof, thmrules

#let _locales = (
  de: json("../locales/de.json"),
  en: json("../locales/en.json"),
)

#let theorem = thmbox(
  "theorem",
  context _locales.at(text.lang).theorems.theorem,
  base: "heading",
  base_level: 1,
  inset: 0em,
  bodyfmt: emph,
)

#let proposition = thmbox(
  "theorem",
  context _locales.at(text.lang).theorems.proposition,
  inset: 0em,
  bodyfmt: emph,
)

#let lemma = thmbox(
  "theorem",
  context _locales.at(text.lang).theorems.lemma,
  base_level: 1,
  bodyfmt: emph,
  inset: 0em,
)

#let corollary = thmbox(
  "theorem",
  context _locales.at(text.lang).theorems.corollary,
  inset: 0em,
  bodyfmt: emph,
)

#let definition = thmbox(
  "theorem",
  context _locales.at(text.lang).theorems.definition,
  inset: 0em,
)

#let example = thmbox(
  "theorem",
  context _locales.at(text.lang).theorems.example,
  inset: 0em,
)

#let remark = thmbox(
  "theorem",
  context _locales.at(text.lang).theorems.remark,
  inset: 0em,
)

#let convention = thmbox(
  "theorem",
  context _locales.at(text.lang).theorems.convention,
  inset: 0em,
)

#let proof = thmproof(
  "proof",
  context _locales.at(text.lang).theorems.proof,
  inset: 0em,
)


