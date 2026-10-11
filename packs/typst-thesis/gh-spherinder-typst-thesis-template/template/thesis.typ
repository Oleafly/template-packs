#import "@preview/glossarium:0.5.9": make-glossary, register-glossary, print-glossary, gls, Gls

#import "@preview/outrageous:0.4.1"

#let todo(..args) = text(fill: color.olive, weight: "extrabold", size: 1.25em)[
  `TODO`#if args.pos().len() > 0 [ #args.pos().first()]
]

#let _supervisor-line(entry) = {
  let names = if type(entry.name) == array { entry.name.join(", ") } else { entry.name }
  [#entry.role: #names]
}

#let thesis(
  title: "Thesis Title",
  author: "Author Name",
  kind: "Semester Project",
  date: "Month Year to Month Year",
  supervisors: (
    (role: "Supervisor", name: "Prof. Name"),
    (role: "Co-Supervisor", name: ("Name One", "Name Two")),
  ),
  keywords: (),
  synopsis: [],
  logo-left: "assets/ethlogo_black.svg",
  logo-right: "assets/systemslogo-3colour-blacktext.svg",
  logo-footer: "assets/dinfk-logo.svg",
  logo-center: none,
  glossary: (),
  abbreviations: (),
  glossary-title: "Glossary",
  outline-title: "Contents",
  bibliography: none,
  declaration: none,
  body,
) = {
  set document(author: author, title: title)

  set page(numbering: "i", margin: 2.4cm)

  set heading(numbering: none)
  show heading.where(level: 1): set text(size: 22pt)
  show heading.where(level: 1): set block(below: 1em)
  show heading.where(level: 2): set text(size: 16pt)
  show heading.where(level: 3): set text(size: 14pt)

  show link: it => underline(stroke: 0.1pt + gray.darken(20%), offset: 2pt, it)

  show: make-glossary
  register-glossary(glossary)
  register-glossary(abbreviations)

  stack(
    dir: ltr,
    if logo-left != none { image(logo-left, height: 18mm) },
    h(1fr),
    if logo-right != none { image(logo-right, height: 16mm) },
  )

  align(center)[
    #v(1.5fr)
    #text(size: 22pt, weight: "bold", title)
    #v(0.8em)
    #text(1.3em)[*#kind*]
    #v(1fr)
    #if logo-center != none { image(logo-center) }
    #v(1fr)
    #text(1.1em)[*Author: #author*]
    #v(0.5em)
    #for s in supervisors [ #_supervisor-line(s) \ ]
    #v(1fr)
    #date
  ]

  if logo-footer != none { image(logo-footer, height: 6.5mm) }

  pagebreak(weak: true)

  set par(justify: true)

  align(horizon)[
    *#author*

    *Thesis title*

    #title,

    *Keywords*

    #keywords.join(", ")

    *Synopsis*

    #synopsis
  ]

  pagebreak(weak: true)

  show outline.entry: outrageous.show-entry.with(
    ..outrageous.presets.typst,
    fill: (none, repeat(text(" "))),
    font-weight: ("semibold", auto),
  )

  outline(title: outline-title)

  set page(numbering: "1")
  counter(page).update(1)

  set heading(numbering: "1.1")
  show heading.where(level: 1): set heading(supplement: "Chapter")
  show heading.where(level: 1): it => if it.numbering == none { it } else {
    pagebreak(weak: true)
    block[
      #it.supplement #counter(heading).display(it.numbering) \
      #it.body
    ]
  }

  body

  set heading(numbering: none)

  if glossary.len() > 0 or abbreviations.len() > 0 {
    pagebreak(weak: true)
    [= #glossary-title <glossary>]

    if glossary.len() > 0 {
      print-glossary(glossary, disable-back-references: true, show-all: true)
    }

    if abbreviations.len() > 0 {
      heading(outlined: false, level: 3, "Abbreviations")
      print-glossary(abbreviations, disable-back-references: true, show-all: true)
    }
  }

  if bibliography != none {
    pagebreak(weak: true)
    bibliography
  }

  if declaration != none {
    pagebreak(weak: true)
    declaration
  }
}
