#let conf(
  title: "Dolgozat címe",
  department: [Programozáselmélet és Szoftvertechnológiai\ Tanszék],
  author: (name: "Hallgató Hanga", degree: "programtervező informatikus BSc"),
  supervisor: (name: "Témavezető Tamás", affiliation: "egyetemi tanársegéd"),
  ext-supervisor: none,
  city: "Budapest",
  year: 2025,
  doc,
) = {
  import "@preview/hydra:0.6.2": hydra

  import "@preview/codly:1.3.0": *
  import "@preview/codly-languages:0.1.1": *
  show: codly-init
  codly(
    languages: codly-languages,
    zebra-fill: none,
    lang-format: none,
    number-align: right + horizon,
    radius: 0em,
    stroke: none,
    fill: luma(245),
  )
  show raw: set text(font: "Latin Modern Mono 12")

  import "template/heading-config.typ": heading-config
  show: heading-config

  import "template/table-config.typ": table-config
  show: table-config

  import "template/figure-and-reference-config.typ": figure-and-reference-config
  show: figure-and-reference-config

  import "template/outline-config.typ": outline-config
  show: outline-config

  // Page setup
  set page(
    paper: "a4",
    margin: (left: 35mm, right: 25mm, top: 25mm, bottom: 25mm),
    numbering: "1",
    // Chapter title header
    header: context {
      let header_content = hydra(1)
      set text(font: "LMRomanSlant10")

      if header_content != none {
        rect(width: 100%, stroke: (bottom: 1pt), align(center, header_content))
      }
    },
  )

  // Typography
  set text(
    lang: "hu",
    size: 12pt,
    font: "Latin Modern Roman 12",
    hyphenate: true,
  )
  show smallcaps: set text(font: "LMRomanCaps10")
  set par(
    justify: true,
    leading: 1em,
    spacing: 1em,
    first-line-indent: (amount: 1.5em, all: true),
  )
  set block(spacing: 1.2em)

  // Citation and reference formatting
  set cite(style: "the-institution-of-engineering-and-technology")

  import "./template/cover.typ": make-cover

  make-cover(
    title,
    department,
    city,
    year,
    author,
    supervisor,
    ext-supervisor,
  )

  doc
}
