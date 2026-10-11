/*
 * Typst Thesis Template @ Ohm
 *
 * Copyright (c) 2026 Nils Weber <me@vimkat.dev>
 */

#import "parameters.typ" : p
#import "translations.typ" : t
#import "util.typ" : frontmatter-heading, normalize-multivalue

#let thesis-abstract() = context {
  frontmatter-heading(numbering: none, t("abstract"))
  let abstract = p("abstract")
  abstract.main

  let keywords = normalize-multivalue(p("keywords"))
  if keywords != none and keywords.len() > 0 {
    frontmatter-heading(numbering: none, depth: 2)[Keywords]
    keywords.join([, ])
  }
  if abstract.alt != none {
    pagebreak(weak: true)
    frontmatter-heading(numbering: none, depth: 1, t("kurzdarstellung"))
    abstract.alt
  }
}

