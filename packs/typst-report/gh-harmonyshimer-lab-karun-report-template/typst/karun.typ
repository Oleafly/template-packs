// =============================================================================
// karun.typ — Karun report template (Typst port of karun.sty + titlepage.tex)
//
// Bilingual: English (LTR) and Persian (RTL). Usage in a report file:
//
//   #import "karun.typ": *
//   #import "metadata.typ": meta
//   #show: karun-report.with(lang: "en", meta: meta)
//   #title-page(meta, lang: "en")
//   #contents-page(lang: "en")
//   = First section ...
//
// Requires the Dubai font installed (XeLaTeX template used \setmainfont{Dubai}).
// =============================================================================

// -----------------------------------------------------------------------------
// Colors (from karun.sty \definecolor blocks)
// -----------------------------------------------------------------------------
#let karun-blue = rgb(0, 50, 100)
#let confidential-green = rgb(0, 128, 0)
#let confidential-orange = rgb(255, 165, 0)
#let confidential-red = rgb(255, 0, 0)
#let access-gray = rgb(180, 180, 180)
#let access-blue = rgb(0, 102, 153)
#let access-green = rgb(0, 128, 0)
#let access-strike = rgb(120, 120, 120)
#let bg-curve-color = rgb(230, 242, 255)

// -----------------------------------------------------------------------------
// Per-language helpers
// -----------------------------------------------------------------------------
#let logo-for(lang) = if lang == "en" { "images/karun-en.png" } else { "images/karun-fa.png" }
#let is-en(lang) = lang == "en"

// Metadata table labels per language.
#let meta-labels(lang) = if lang == "en" {
  (
    title: "Document Title:",
    employer: "Prepared for:",
    producer: "Prepared by:",
    access: "Access Level:",
    confidentiality: "Confidentiality:",
    id: "Document ID:",
    date: "Date:",
  )
} else {
  (
    title: "عنوان سند:",
    employer: "تهیه‌شده برای:",
    producer: "تهیه‌کننده:",
    access: "سطح دسترسی:",
    confidentiality: "سطح محرمانگی:",
    id: "شناسه سند:",
    date: "تاریخ تهیه:",
  )
}

// -----------------------------------------------------------------------------
// Access Level / Confidentiality toggles (strike-through inactive options)
//   access_level:   1 = Internal,  2 = External,     3 = Public
//   confidentiality:1 = Normal,    2 = Confidential, 3 = Top Secret
// -----------------------------------------------------------------------------
#let active-opt(color, body) = text(weight: "bold", fill: color)[#body]
#let inactive-opt(body) = text(fill: access-strike)[#strike[#body]]

#let toggle(active, labels, colors) = {
  let parts = ()
  for i in range(labels.len()) {
    if i + 1 == active {
      parts.push(active-opt(colors.at(i), labels.at(i)))
    } else {
      parts.push(inactive-opt(labels.at(i)))
    }
  }
  parts.join([ \/ ])
}

#let access-level(active, lang: "en") = {
  let labels = if lang == "en" { ("Internal", "External", "Public") } else {
    ("درون سازمانی", "برون سازمانی", "عمومی")
  }
  toggle(active, labels, (access-gray, access-blue, access-green))
}

#let confidentiality-level(active, lang: "en") = {
  let labels = if lang == "en" { ("Normal", "Confidential", "Top Secret") } else {
    ("عادی", "محرمانه", "خیلی محرمانه")
  }
  toggle(active, labels, (confidential-green, confidential-orange, confidential-red))
}

// -----------------------------------------------------------------------------
// Metadata table (booktabs-style: thick top/bottom rules, thin inner rules)
// -----------------------------------------------------------------------------
#let meta-table(meta, lang: "en") = {
  let L = meta-labels(lang)
  let row = (label, value) => (
    text(weight: "bold")[#label], value,
  )
  set text(size: 11pt)
  table(
    columns: (auto, 1fr),
    stroke: none,
    inset: (x: 6pt, y: 7pt),
    align: (if is-en(lang) { left } else { right }) + horizon,

    table.hline(stroke: 1.2pt + black),
    ..row(L.title, text(weight: "bold")[#meta.summary_title]),
    table.hline(stroke: 0.4pt + black),
    ..row(L.employer, meta.employer),
    table.hline(stroke: 0.4pt + black),
    ..row(L.producer, meta.producer),
    table.hline(stroke: 0.4pt + black),
    ..row(L.access, access-level(meta.access_level, lang: lang)),
    table.hline(stroke: 0.4pt + black),
    ..row(L.confidentiality, confidentiality-level(meta.confidentiality, lang: lang)),
    table.hline(stroke: 0.4pt + black),
    ..row(L.id, meta.doc_id),
    table.hline(stroke: 0.4pt + black),
    ..row(L.date, meta.date),
    table.hline(stroke: 1.2pt + black),
  )
}

// -----------------------------------------------------------------------------
// Title page (Typst port of titlepage.tex) — full-bleed, own layout.
// -----------------------------------------------------------------------------
#let title-page(meta, lang: "en") = {
  let english = is-en(lang)
  let logo = logo-for(lang)
  let h-edge = if english { left } else { right }
  let h-sign = if english { 1 } else { -1 }

  page(
    margin: 0pt,
    header: none,
    footer: none,
    numbering: none,
    background: image("images/bg.jpeg", width: 100%, height: 100%),
  )[
    // Top logo (4 cm), 1 cm inset, opposite the binding edge.
    #place(top + (if english { right } else { left }),
      dx: if english { -1cm } else { 1cm }, dy: 1cm,
      image(logo, width: 4cm))

    // Title + subtitle.
    #place(top + h-edge, dx: h-sign * 2cm, dy: 4.8cm,
      block(width: 13cm)[
        #set align(if english { left } else { right })
        #set par(leading: 0.4em, justify: false)
        #text(size: 25pt, weight: "bold")[#meta.title]
        #v(0.35cm, weak: false)
        #text(size: 15pt, fill: gray)[#meta.subtitle]
      ])

    // Metadata table.
    #place(top + h-edge, dx: h-sign * 2.5cm, dy: 8.8cm,
      block(width: 16cm)[#meta-table(meta, lang: lang)])

    // Footer logo (bottom-left), 1 cm inset.
    #place(bottom + left, dx: 1cm, dy: -1cm, image(logo, width: 2.5cm))

    // Disclaimer (LTR), to the right of the footer logo.
    #place(bottom + left, dx: 4cm, dy: -1cm,
      block(width: 10cm)[
        #set text(size: 7pt, lang: "en", dir: ltr)
        #set par(justify: false)
        This document is prepared by the Karun team for the intended recipients
        mentioned herein. Any reuse or redistribution to third parties, in any
        form, is prohibited without prior written consent.
      ])

    // Copyright (bottom-right).
    #place(bottom + right, dx: -1.5cm, dy: -1.5cm,
      text(size: 9pt, lang: "en", dir: ltr)[© #meta.year Karun, Iran])
  ]
}

// -----------------------------------------------------------------------------
// Table of contents page (styled like \tableofcontents in karun.sty)
// -----------------------------------------------------------------------------
#let contents-page(lang: "en") = {
  let title = if is-en(lang) { "Contents" } else { "فهرست مطالب" }
  heading(level: 1, numbering: none, outlined: false)[#title]
  outline(title: none, indent: auto, depth: 3)
  pagebreak()
}

// -----------------------------------------------------------------------------
// Running header / footer builders (capture meta + lang).
// -----------------------------------------------------------------------------
#let make-header(meta, lang) = context {
  set text(size: 9pt, fill: black)
  // start/end (not left/right) so the columns mirror correctly in RTL: the date
  // hugs the outer reading-start edge and the title stays centered in both langs.
  grid(
    columns: (1fr, 2fr, 1fr),
    align: (start + bottom, center + bottom, end + bottom),
    [#meta.date], [#meta.summary_title], [],
  )
  v(2pt, weak: true)
  line(length: 100%, stroke: 1pt + karun-blue)
}

#let make-footer(meta, lang) = context {
  let logo = logo-for(lang)
  let cur = counter(page).get().first()
  let total = counter(page).final().first()
  // The cover is an unnumbered page 1, so drop it from BOTH the current number
  // and the total (physical - 1). The last page then reads "n of n", not "n-1 of n".
  let page-text = if is-en(lang) {
    [Page #(cur - 1) of #(total - 1)]
  } else {
    [صفحه #(cur - 1) از #(total - 1)]
  }
  line(length: 100%, stroke: 1pt + karun-blue)
  v(2pt, weak: true)
  // start/end (not left/right) so in RTL the page number and logo hug the outer
  // edges instead of colliding in the middle.
  grid(
    columns: (1fr, 1fr),
    align: (start + horizon, end + horizon),
    text(size: 9pt)[#page-text],
    image(logo, height: 0.8cm),
  )
}

// -----------------------------------------------------------------------------
// Main show-rule wrapper (the \usepackage{karun} equivalent).
// -----------------------------------------------------------------------------
#let karun-report(lang: "en", meta: (:), body) = {
  let english = is-en(lang)

  set text(
    font: "Dubai",
    size: 11pt,
    lang: lang,
    dir: if english { ltr } else { rtl },
  )
  set par(justify: true, leading: 0.7em, spacing: 0.95em)

  // Section numbering and Karun-blue heading styling.
  set heading(numbering: "1.1")
  show heading: it => {
    set text(fill: karun-blue, weight: "bold")
    block(above: 16pt, below: 14pt, it)
  }
  show heading.where(level: 1): set text(size: 22pt)
  show heading.where(level: 2): set text(size: 14pt)
  show heading.where(level: 3): set text(size: 12pt)

  // Figures: caption label bold + Karun-blue, body small italic.
  set figure(numbering: "1")
  show figure: set block(spacing: 16pt)
  show figure.caption: it => {
    set align(left)
    set text(size: 9pt)
    box[
      #text(weight: "bold", fill: karun-blue)[#it.supplement #context it.counter.display(it.numbering): ]
      #text(style: "italic")[#it.body]
    ]
  }

  // Table of contents entry styling: level-1 bold Karun-blue, deeper black.
  show outline.entry.where(level: 1): set text(weight: "bold", fill: karun-blue)

  // Page geometry + running header/footer (cover overrides these to none).
  set page(
    paper: "a4",
    margin: (top: 2.4cm, bottom: 3.0cm, left: 3.1cm, right: 2.5cm),
    header-ascent: 0.8cm,
    footer-descent: 1.2cm,
    numbering: none,
    header: make-header(meta, lang),
    footer: make-footer(meta, lang),
  )

  body
}
