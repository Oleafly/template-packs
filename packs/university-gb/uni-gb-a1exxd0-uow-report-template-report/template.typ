// University of Warwick — Department of Computer Science report template.
// Usage: #show: report.with(title: ..., author: ..., ...)
#import "@preview/wordometer:0.1.5": total-words, word-count

#let report(
  title: none,
  author: none,
  student-id: none,
  supervisor: none,
  date: none,
  body,
) = {
  // ── Page & font setup ──────────────────────────────────────────────
  set document(title: title, author: author)
  set page(paper: "a4", margin: (x: 2cm, y: 2cm))
  set text(font: "New Computer Modern", size: 12pt, lang: "en")
  set par(justify: true, leading: 0.75em, spacing: 1.2em)
  set heading(numbering: "1.1")
  set block(spacing: 1.2em)

  // ── Heading styles ─────────────────────────────────────────────────
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(0.8em)
    text(size: 17pt, weight: "bold", it)
    v(0.5em)
  }

  show heading.where(level: 2): it => {
    v(0.6em)
    text(size: 13pt, weight: "bold", it)
    v(0.3em)
  }

  show heading.where(level: 3): it => {
    v(0.4em)
    text(size: 12pt, weight: "bold", it)
    v(0.2em)
  }

  // ── Figures & equations ────────────────────────────────────────────
  set math.equation(numbering: "(1)")
  set figure(gap: 0.8em)
  show figure.caption: set text(size: 0.9em)

  // ── Title page ─────────────────────────────────────────────────────
  {
    let brand-purple = rgb("#3C1053")
    set page(numbering: none, margin: 0pt)

    // Purple masthead band (background)
    place(top + left, rect(width: 100%, height: 13.5cm, fill: brand-purple))

    // Crest and wordmark (in the purple band)
    v(2.5cm)
    align(center)[
      #image("assets/warwick-crest-white.svg", height: 7cm)
      #v(0.4cm)
      #image("assets/warwick-wordmark-white.svg", width: 9cm)
    ]
    v(1.5cm)

    // Accent rule
    align(center, line(length: 5cm, stroke: 0.75pt + brand-purple))

    // Title and metadata
    v(1cm)
    align(center)[
      #block(width: 80%)[
        #set par(leading: 0.4em, justify: false)
        #text(size: 22pt, weight: "bold", title)
      ]
      #v(0.8cm)
      #text(size: 14pt, author)
      #if student-id != none [ \ #text(size: 12pt)[Student ID: #student-id] ]
      #v(0.5cm)
      #text(size: 12pt)[Supervisor: #supervisor]
      #v(0.3cm)
      #text(size: 12pt, date)
    ]

    v(1fr)

    // Department footer
    align(center)[
      #line(length: 3cm, stroke: 0.5pt + brand-purple)
      #v(0.4cm)
      #text(size: 11pt, fill: luma(100))[Department of Computer Science \ University of Warwick]
      #v(0.4cm)
      #text(size: 10pt, fill: luma(100))[Word count: #total-words]
    ]
    v(2cm)

    pagebreak()
  }

  // ── Front matter (roman numerals) ─────────────────────────────────
  set page(numbering: "i")
  counter(page).update(1)

  body
}

// ── Problem set / short-form report ────────────────────────────────
#let problem-set(
  title: none,
  author: none,
  student-id: none,
  module: none,
  date: none,
  body,
) = {
  // ── Page & font setup ──────────────────────────────────────────────
  set document(title: title, author: author)
  set page(paper: "a4", margin: (x: 2cm, y: 2cm), numbering: "1")
  set text(font: "New Computer Modern", size: 12pt, lang: "en")
  set par(justify: true, leading: 0.75em, spacing: 1.2em)
  set block(spacing: 1.2em)

  // ── Heading numbering: 1. / a. / i. ───────────────────────────────
  set heading(numbering: "1.a.")

  show heading.where(level: 1): it => {
    v(0.6em)
    text(size: 12pt, weight: "regular", style: "italic", it)
    v(0.3em)
  }

  show heading.where(level: 2): it => {
    v(0.4em)
    text(size: 12pt, weight: "regular", style: "italic", it)
    v(0.2em)
  }

  show heading.where(level: 3): it => {
    v(0.3em)
    text(size: 12pt, weight: "regular", style: "italic", it)
    v(0.15em)
  }

  // ── Figures & equations ────────────────────────────────────────────
  set math.equation(numbering: "(1)")
  set figure(gap: 0.8em)
  show figure.caption: set text(size: 0.9em)

  // ── Compact header ─────────────────────────────────────────────────
  {
    let brand-purple = rgb("#3C1053")

    align(center)[
      #text(size: 16pt, weight: "bold", title)
      #v(0.3cm)
      #text(size: 12pt, author)
      #if student-id != none [ --- #text(size: 11pt, student-id)]
      #if module != none [\ #text(size: 11pt, module)]
      #if date != none [\ #text(size: 11pt, date)]
    ]

    v(0.3cm)
    line(length: 100%, stroke: 0.5pt + brand-purple)
    v(0.3cm)
  }

  body
}

// ── Theorem environments ───────────────────────────────────────────
#let theorem(body, name: none) = figure(
  block(
    width: 100%,
    inset: 10pt,
    stroke: (left: 2pt + luma(80)),
    fill: luma(245),
  )[
    #align(left)[
      *Theorem #context {
        let num = counter(figure.where(kind: "theorem")).display()
        [#num]
      }#if name != none [
        (#name)]*.
      #emph(body)
    ]
  ],
  kind: "theorem",
  supplement: "Theorem",
)

#let corollary(body, name: none) = figure(
  block(
    width: 100%,
    inset: 10pt,
    stroke: (left: 2pt + luma(80)),
    fill: luma(245),
  )[
    #align(left)[
      *Corollary #context {
        let num = counter(figure.where(kind: "corollary")).display()
        [#num]
      }#if name != none [
        (#name)]*.
      #emph(body)
    ]
  ],
  kind: "corollary",
  supplement: "Corollary",
)

#let lemma(body, name: none) = figure(
  block(
    width: 100%,
    inset: 10pt,
    stroke: (left: 2pt + luma(80)),
    fill: luma(245),
  )[
    #align(left)[
      *Lemma #context {
        let num = counter(figure.where(kind: "lemma")).display()
        [#num]
      }#if name != none [
        (#name)]*. #body
    ]
  ],
  kind: "lemma",
  supplement: "Lemma",
)

#let definition(body, name: none) = figure(
  block(
    width: 100%,
    inset: 10pt,
    stroke: (left: 2pt + luma(140)),
    fill: luma(250),
  )[
    #align(left)[
      *Definition #context {
        let num = counter(figure.where(kind: "definition")).display()
        [#num]
      }#if name != none [
        (#name)]*. #body
    ]
  ],
  kind: "definition",
  supplement: "Definition",
)

#show heading.where(level: 1): it => {
  counter(figure.where(kind: "theorem")).update(0)
  counter(figure.where(kind: "definition")).update(0)
  it
}

#let proof(body) = {
  [_Proof._ #body #h(1fr) $square$]
}
