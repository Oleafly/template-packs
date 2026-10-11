#import "cover.typ": cover
#import "frontmatter.typ": *
#import "mainbody.typ": mainbody
#import "aftermatter.typ": *
#import "@preview/lovelace:0.3.0": *
#import "@preview/mitex:0.2.7": *

#let osppdoc(config, body) = {
  set document(title: config.project-title, author: config.applicant)
  set text(
    lang: "zh",
    region: "cn",
    font: (config.en-main-font, config.ch-main-font),
    size: config.main-fontsize,
  )
  set page(paper: "a4", margin: config.page-margin)
  set par(
    first-line-indent: (amount: 2em, all: true),
    leading: 15pt,
    spacing: 15pt,
    justify: true,
  )
  set list(indent: 2em)
  set enum(indent: 2em, numbering: "1.")
  show link: set text(fill: blue.darken(40%))
  show raw.where(block: true): set block(fill: rgb("#f7f7f7"), inset: 8pt, radius: 2pt)

  cover(config)
  body
}
