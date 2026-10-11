#import "@preview/fontawesome:0.1.0": *
#import "@preview/hydra:0.5.2": hydra
#import "@preview/acrostiche:0.5.1": *

#import "../ads/meta.typ": *
#import "utils.typ": *
#import "titlepage.typ": titlepage
#import "declaration.typ": declaration
#import "../ads/abstract.typ": abstract

#let thesis(doc) = {
  set text(
    font: "New Computer Modern",
    weight: "regular",
    size: 11pt,
    lang: language,
  )
  set align(left)

  let ht-first = state("page-first-section", [])
  let ht-last = state("page-last-section", [])

  set page(
    paper: "a4",
    margin: (
      left: 4cm,
      right: 2cm,
      top: 2.5cm,
      bottom: 1.5cm,
    ),
    background: none,
    header: context {
      align(right, hydra(2))
    },
  )

  set heading(numbering: "1.1")
  show heading.where(level: 1): it => [
    #set align(left)
    #set text(20pt, weight: "bold")
    #block(it)
  ]
  show heading.where(level: 2): it => [
    #set align(left)
    #set text(17pt, weight: "regular")
    #v(0.5cm)
    #block(it)
    #v(0.5cm)
  ]
  show heading.where(level: 3): it => [
    #set align(left)
    #set text(14pt, weight: "regular")
    #v(0.25cm)
    #block(it)
    #v(0.25cm)
  ]
  show heading.where(level: 4): it => [
    #set align(left)
    #set text(11pt, weight: "regular")
    #block(it)
  ]

  set par(justify: true)

  titlepage
  declaration
  abstract
  table_of_contents

  // Start page numbering when actual content starts
  set page(numbering: "1")
  counter(page).update(1)

  doc

  table_of_figures
  table_of_tables
  table_of_listings
  table_of_acronyms
  bib
}
