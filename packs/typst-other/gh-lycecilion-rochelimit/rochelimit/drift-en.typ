// RocheLimit (Drift) for en-US
// This typst template is designed for shorter articles and announcements, and is not suitable for large publications, etc.

#import "@preview/m-jaxon:0.1.2"
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *

#let rl-font = (
  "TeX Gyre Schola",
  "Noto Serif CJK SC",
)
#let rl-lang = "en"
#let rl-region = "us"

#let rl-text-size = 10pt
#let rl-text-weight = "medium"

#let rl-title-size = 17pt
#let rl-heading-size = 13pt
#let rl-subhead-size = 11pt
#let rl-heading-weight = "extrabold"

#let rl-just-limits = (tracking: (min: -0.01em, max: 0.01em))
#let rl-fl-indent = (amount: 1.5em)

#let rl-date-display = "[month repr:short] [day], [year]"
#let rl-ver-display = "Version"
#let rl-outline-title = [Table of Contents]

#let rl-plain-text(it) = {
  if type(it) == str {
    it
  } else if it.has("text") {
    it.text
  } else if it.has("child") {
    rl-plain-text(it.child)
  } else if it.has("children") {
    it.children.map(rl-plain-text).join("")
  } else {
    ""
  }
}

#let flag(body) = {
  block(
    fill: rgb("#f9f9f9"),
    stroke: 1pt + luma(200),
    inset: (x: 1em, y: 1em),
    width: 100%,
    radius: 4pt,
    spacing: 1.2em,
    breakable: true,
  )[
    #text(weight: "bold", fill: rgb("#2d9c58"))[Flag] #h(0.5em) #body
  ]
}

#let callout(title, body) = {
  block(
    fill: rgb("#e8f4fd"),
    stroke: (left: 4pt + rgb("576A8F")),
    inset: (x: 1em, y: 1em),
    width: 100%,
    radius: 2pt,
    spacing: 1.2em,
    breakable: true,
  )[
    #set par(first-line-indent: 0em)
    #if title != [] [#text(weight: "bold", fill: rgb("576A8F"))[#title \ ]]
    #body
  ]
}

#let rl-content(
  title: none,
  authors: (),
  date: datetime.today(),
  version: none,
  rl-header: none,
  body,
) = {
  let rl-author-names = authors.map(author => {
    let name = if type(author) == array {
      author.at(0)
    } else if type(author) == dictionary {
      author.name
    } else {
      author
    }
    rl-plain-text(name)
  })
  set document(
    title: title,
    author: rl-author-names,
    date: date,
  )
  set text(font: rl-font, size: rl-text-size, weight: rl-text-weight, lang: rl-lang, region: rl-region)
  set page(paper: "a4", numbering: "1", header: rl-header)
  set par(leading: 0.85em, spacing: 0.85em, justify: true, justification-limits: rl-just-limits, first-line-indent: rl-fl-indent)

  show: codly-init.with()
  codly(languages: codly-languages)

  if title != none {
    text(font: rl-font, size: rl-title-size, weight: rl-heading-weight)[#title]
    parbreak()
  }

  v(1em)

  for i in range(calc.ceil(authors.len() / 3)) {
    let end = calc.min((i + 1) * 3, authors.len())
    let is-last = authors.len() == end
    let slice = authors.slice(i * 3, end)
    grid(
      columns: slice.len() * (1fr,),
      gutter: 12pt,
      ..slice.map(author => align(center, {
        text(size: rl-text-size, author.name)
        if "department" in author [
          \ #emph(author.department)
        ]
        if "organization" in author [
          \ #emph(author.organization)
        ]
        if "location" in author [
          \ #author.location
        ]
        if "email" in author [
          #if type(author.email) == str [
            \ #link("mailto:" + author.email)
          ] else [
            \ #author.email
          ]
        ]
      }))
    )

    v(16pt, weak: true)
  }

  v(10pt, weak: true)
  align(center)[
    #date.display(rl-date-display), #rl-ver-display #version
  ]

  set heading(numbering: "1. ")
  show heading: set block(below: 1em, above: 1.5em)
  show heading.where(level: 1): it => {
    align(center)[#text(weight: rl-heading-weight, size: rl-heading-size, it)]
    v(1em, weak: true)
  }
  show heading.where(level: 2): set text(weight: rl-heading-weight, size: rl-subhead-size)
  show heading.where(level: 2): set block(below: 1em, above: 2.2em)

  set figure(gap: 1em)
  show figure: set place(clearance: 1em)
  show figure.where(placement: none): it => block(above: 1.5em, below: 2em, it)

  show columns: it => block(above: 1.5em, below: 1.5em, it)

  show raw: set text(
    font: (
      (name: "Latin Modern Mono 8", covers: "latin-in-cjk"),
      "LXGW WenKai Mono",
    ),
    size: 1em / 0.85,
  )

  show link: set text(blue.darken(10%))
  show ref: set text(blue.darken(10%))

  set table(align: horizon, inset: 7pt)

  show footnote.entry: it => {
    let loc = it.note.location()
    super(counter(footnote).display(at: loc, "1"))
    [ ]
    it.note.body
  }

  set outline(title: none)
  show outline: it => block(fill: luma(245), inset: 1em, width: 100%, radius: 5pt)[
    #set par(first-line-indent: 0em)
    #v(.2em)
    #text(font: rl-font, size: rl-subhead-size, weight: rl-heading-weight, rl-outline-title)
    #v(.3em)
    #it
  ]

  show divider: set line(stroke: 1pt)
  show divider: it => block(above: 1.5em, below: 1.5em, it)

  v(1em)
  body
}
