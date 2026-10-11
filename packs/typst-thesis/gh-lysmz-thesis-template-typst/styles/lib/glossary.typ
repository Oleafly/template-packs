/*
 * Typst Thesis Template @ Ohm
 *
 * Copyright (c) 2026 Nils Weber <me@vimkat.dev>
 */

#import "@preview/glossarium:0.5.10": make-glossary, print-glossary, register-glossary

#import "translations.typ" : t
#import "parameters.typ" : p
#import "util.typ" : frontmatter-heading

#let to-glossary-entries(dict) = dict.pairs().map(e => (key: e.at(0), ..e.at(1).map(s => eval(s, mode: "markup"))))

#let thesis-loa() = context {
  let entries = p("glossary")
  if entries != none and entries.at("acronyms", default: none) != none {
    frontmatter-heading(t("LOA"))
    print-glossary(to-glossary-entries(entries.acronyms))
  }
}

#let thesis-glossary() = context {
  let entries = p("glossary")
  if entries != none and entries.at("glossary", default: none) != none {
    frontmatter-heading(t("glossary"))
    print-glossary(to-glossary-entries(entries.glossary))
  }
}

#let setup-glossary(glossary) = {
  let entries = (
    to-glossary-entries(glossary.acronyms),
    to-glossary-entries(glossary.glossary),
  ).flatten()
  register-glossary(entries)
}
