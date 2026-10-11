/*
 * Typst Thesis Template @ Ohm
 *
 * Copyright (c) 2026 Nils Weber <me@vimkat.dev>
 */

#import "parameters.typ" : p
#import "translations.typ" : t
#import "util.typ" : frontmatter-heading

#let thesis-bibliography() = context {
  let bib-file = p("bibliography-file")
  let bib-style = p("bibliography-style")

  if bib-file != none {
    frontmatter-heading(t("BIB"))
    bibliography(
      "../../" + bib-file,
      title: none,
      style: if bib-style == "alphanumeric" { "ieee" } else { bib-style },
    )
  }
}
