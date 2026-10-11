/*
 * Typst Thesis Template @ Ohm
 *
 * Copyright (c) 2026 Nils Weber <me@vimkat.dev>
 */

#import "parameters.typ" : p
#import "translations.typ" : t
#import "util.typ" : frontmatter-heading

#let thesis-acknowledgements() = context {
  if p("acknowledgements") != none {
    frontmatter-heading(numbering: none, t("ack"))
    p("acknowledgements")
  }
}
