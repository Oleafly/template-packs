#import "@preview/numbly:0.1.0": numbly
#import "@preview/linguify:0.4.2": *
#import "./titlepage.typ": *

#let proposal(
  metadata,
  bib_path: "",
  is_print: false,
  body,
) = {
  // Load linguify translations
  let lang-data = (
    conf: (
      default-lang: "de",
    ),
    lang: (
      de: toml("./i18n/de.toml"),
      en: toml("./i18n/en.toml"),
    ),
  )
  set-database(lang-data)

  let sans-font = "Nimbus Sans"
  let serif-font = "TeX Gyre Termes"
  set text(
    lang: metadata.settings.language,
    font: serif-font,
    size: 12pt,
  )

  titlepage(metadata)

  // Set the document's basic properties.
  set page(
    margin: (inside: 37.5mm, outside: 25mm, top: 25mm, bottom: 40mm),
    binding: left,
    footer: context align(if calc.odd(counter(page).get().first()) { right } else { left })[
      #counter(page).display()
    ],
  )

  show math.equation: set text(weight: 400, font: "TeX Gyre Termes Math")
  show math.equation: math.upright

  // --- Equations ---
  set math.equation(numbering: (..num) => numbering("(1.1)", counter(heading).get().first(), num.pos().first()))

  // --- Headings ---
  set heading(numbering: "1.1")

  show heading: it => {
    // Only apply numbering to levels 1-3
    let should-number = it.level <= 3

    set text(font: sans-font, weight: 400)

    let (size, above, below) = if it.level == 1 {
      (23.25pt, 0pt, 46pt)
    } else if it.level == 2 {
      (16.0pt, 33pt, 29pt)
    } else if it.level == 3 {
      (14pt, 25.5pt, 24pt)
    } else if it.level == 4 {
      (12pt, 25.5pt, 24pt)
    } else {
      (12pt, 16.5pt, 16.5pt)
    }

    if it.level == 1 {
      counter(math.equation).update(0)
      counter(figure.where(kind: image)).update(0)
      counter(figure.where(kind: table)).update(0)
      counter(figure.where(kind: raw)).update(0)
      pagebreak(weak: true)
      v(34mm)
    }

    set block(above: above, below: below)

    if should-number {
      block(text(size: size, it))
    } else {
      block(text(size: size, it.body))
    }
  }

  // --- Paragraphs ---
  set par(leading: 6.5pt, justify: true, first-line-indent: 0em, spacing: 16.5pt)

  // --- Citation Style ---
  set cite(style: "ieee")

  // --- Figures ---
  set figure(numbering: (..num) => numbering("1.1", counter(heading).get().first(), num.pos().first()))

  show figure: set text(size: 0.85em)

  set enum(full: true, numbering: numbly(
    "{1:1}.",
    "{2:a}.",
    "{3:i}.",
    "{4:A}.",
    "{5:I}.",
  ))

  body

  pagebreak()
  bibliography(title: linguify("bibliography"), bib_path, style: "ieee")
}

#let table-of-contents() = {
  set page(numbering: "i")
  counter(page).update(1)
  set heading(numbering: none)

  show outline: set text(font: "Nimbus Sans")
  show outline.entry.where(level: 1): it => {
    v(18pt, weak: true)
    it
  }

  outline(
    title: [#linguify("tableOfContents") #v(21pt)],
    depth: 3,
    indent: n => {
      if n == 0 { 0em } else if n == 1 { 1em } else { 3em }
    },
  )

  pagebreak(to: "odd")

  set page(numbering: "1")
  counter(page).update(1)
  set heading(numbering: "1.1")
}

#let list-of-figures() = {
  set heading(numbering: none)
  heading(linguify("listOfFigures"))
  v(46pt, weak: true)
  outline(
    title: none,
    target: figure.where(kind: image),
  )
  pagebreak(weak: true)
}

#let list-of-tables() = {
  heading(linguify("listOfTables"))
  v(46pt, weak: true)
  outline(
    title: none,
    target: figure.where(kind: table),
  )
}
