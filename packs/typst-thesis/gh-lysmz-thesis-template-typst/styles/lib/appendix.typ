/*
 * Typst Thesis Template @ Ohm
 *
 * Copyright (c) 2026 Nils Weber <me@vimkat.dev>
 */

#import "parameters.typ" : p
#import "translations.typ" : t
#import "util.typ" : frontmatter-heading

#let appendix-content = state("appendix-content")
#let appendix(body) = { appendix-content.update(body) }
#let thesis-appendix() = context {
  show heading.where(level: 1): set heading(supplement: context t("appendix"))
  show heading: set heading(numbering: "A.1")

  counter(heading).update(0)

  appendix-content.get()
}
