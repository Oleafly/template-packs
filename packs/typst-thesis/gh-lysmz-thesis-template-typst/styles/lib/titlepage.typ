/*
 * Typst Thesis Template @ Ohm
 *
 * Copyright (c) 2026 Nils Weber <me@vimkat.dev>
 */

#import "parameters.typ" : p
#import "translations.typ" : t
#import "util.typ" : normalize-multivalue, ex

#let thesis-titlepage() = context {
  pagebreak(weak: true)
  set page(numbering: none)
  set align(center)

  let examiners = normalize-multivalue(p("examiners"))
  let supervisors = normalize-multivalue(p("supervisors"))

  text(size: 8pt)[#t("faculty") #t("at_uni") #t("university")]
  v(6 * ex)
  image("../ohm-logo.svg", width: 90%)
  v(6 * ex)
  text(size: 14.4pt, p("type", map: t))
  v(8 * ex)
  text(size: 20.74pt, p("title"))
  v(8 * ex)
  text(size: 14.4pt, p("author"))
  if p("student-id", default: none) != none {
    [\ #t("student-id"): #p("student-id")]
  }
  v(8 * ex)
  text(size: 12pt, grid(
    columns: (auto, auto),
    row-gutter: 1.6em,
    column-gutter: 1em,
    align: (right, left),
    ..if examiners != none { (if examiners.len() == 1 [#t("examiners-singular"):] else [#t("examiners-plural"):], stack(spacing: 0.65em, ..examiners)) },
    ..if supervisors != none { (if supervisors.len() == 1 [#t("supervisors-singular"):] else [#t("supervisors-plural"):], stack(spacing: 0.65em, ..supervisors, p("company"))) },
  ))
  v(1fr)
  text(size: 8pt)[
    #let company = p("company")
    #let copyright = if company != none { company } else { p("author") }
    #sym.copyright #copyright #p("date", map: d => d.year())
    #v(2 * ex)
    #align(left, t("copyright"))
  ]
  pagebreak(weak: true)
}
