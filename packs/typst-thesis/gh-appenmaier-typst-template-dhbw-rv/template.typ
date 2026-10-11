// Imports
#import "user/config.typ": config, show-confidentiality-notice, show-company-supervisor, show-supervisor, show-abstract, lang
#import "i18n/DE.typ": labels as labels-DE
#import "i18n/EN.typ": labels as labels-EN
#let labels = if lang == "EN" { labels-EN } else { labels-DE }

// ---- Template version ---- //
#let template-version = "1.1.2"

// ---- Page layout ---- //
#let margin = (left: 2.5cm, right: 2.5cm, top: 2.5cm, bottom: 2cm)
#let header-ascent = 0.8cm   // space reserved for the header within the top margin
#let logo-path = "../images/dhbw-logo.png"
#let font = "Arial"          // base font; must be installed on the system

// Page components
#import "pages/title-page.typ": title-page
#import "pages/confidentiality-notice.typ": confidentiality-notice
#import "pages/abstract.typ": abstract-page
#import "pages/table-of-contents.typ": table-of-contents
#import "pages/list-of-abbreviations.typ": list-of-abbreviations
#import "pages/common.typ": outline-page
#import "pages/appendix.typ": appendix
#import "pages/bibliography.typ": bibliography-page
#import "pages/declaration.typ": declaration
#import "pages/ai-declaration.typ": ai-declaration

// Page format and margins
#set page(
  paper: "a4",
  margin: margin,
)

// Base font
#set text(font: font, size: 11pt, lang: lang)

// Line spacing 1.5, justified text
#set par(leading: 1em, spacing: 1.5em, justify: true)

// Headings
#set heading(numbering: "1.1")
#show heading: it => {
  if it.level == 1 {
    set text(size: 16pt)
    pagebreak(weak: true)
    it
    v(0.75em)
  } else if it.level == 2 {
    set text(size: 14pt)
    v(2.5em, weak: true)
    it
    v(0.75em)
  } else {
    set text(size: 12pt)
    v(2.5em, weak: true)
    it
    v(0.75em)
  }
}

// Code block background
#show raw.where(block: true): it => block(
  fill: luma(245),
  inset: (x: 8pt, y: 6pt),
  radius: 3pt,
  width: 100%,
  it,
)

// Figure and table captions
#set figure.caption(position: bottom)
#show figure.caption: it => {
  set text(size: 10pt)
  strong(it.supplement + "\u{00a0}" + it.counter.display() + ":") + " " + it.body
}
#show figure.where(kind: image): set figure(supplement: labels.supplement-figure)
#show figure.where(kind: table): set figure(supplement: labels.supplement-table)
#show figure.where(kind: raw):   set figure(supplement: labels.supplement-listing)

// Equation numbering
#set math.equation(numbering: "(1)")

// Outline entries:
// - Headings: display page number in the numbering style of the target page (roman/arabic);
//   hide unnumbered entries deeper than level 1 (e.g. appendix sub-sections).
// - Figures/tables/listings: bold prefix (e.g. "Abbildung 1").
// Note: .where(element: figure) does not match in Typst 0.15; element.func() == figure is required.
#show outline.entry: it => {
  if it.element.func() == figure {
    link(it.element.location(), it.indented(
      strong(it.prefix()),
      it.body() + box(width: 1fr, it.fill) + it.page(),
    ))
  } else {
    if it.element.numbering == none and it.level > 1 { return }
    let loc = it.element.location()
    let page-num = counter(page).at(loc).first()
    let num-style = loc.page-numbering()
    let page-label = if num-style != none { numbering(num-style, page-num) } else { str(page-num) }
    let entry = it.indented(it.prefix(), it.body() + box(width: 1fr, it.fill) + page-label)
    if it.level == 1 {
      block(above: 1.2em, below: 0.3em, link(loc, strong(entry)))
    } else {
      link(loc, entry)
    }
  }
}

// Title page
#title-page(labels: labels, margin: margin, logo-path: logo-path, show-company-supervisor: show-company-supervisor, show-supervisor: show-supervisor, ..config)

// Roman page numbers
#set page(
  numbering: "I",
  header: none,
  footer: context {
    set text(size: 10pt, font: font)
    align(right, counter(page).display("I"))
  }
)

// Optional confidentiality notice
#if show-confidentiality-notice {
  confidentiality-notice(labels: labels, margin: margin)
}
// Advance roman counter past title (I) and optional confidentiality notice (II)
#counter(page).update(if show-confidentiality-notice { 3 } else { 2 })

// Optional abstract
#if show-abstract {
  import "user/abstract.typ": abstract-body
  abstract-page(labels: labels, body: abstract-body)
}

// Table of contents
#table-of-contents(labels: labels)

// List of abbreviations
#list-of-abbreviations(labels: labels)

// List of figures
#outline-page(labels.figures, image)

// List of tables
#outline-page(labels.tables, table)

// List of listings
#outline-page(labels.listings, raw)

// Arabic page numbers
#counter(page).update(1)
#set page(
  numbering: "1",
  header-ascent: header-ascent,
  header: context {
    set text(size: 10pt)
    let on-page = query(heading.where(level: 1))
      .filter(h => h.location().page() == here().page())
    let current-heading = if on-page.len() > 0 {
      on-page.first()
    } else {
      let before = query(selector(heading.where(level: 1)).before(here()))
      if before.len() > 0 { before.last() } else { none }
    }
    if current-heading != none {
      let num = if current-heading.numbering != none {
        numbering(current-heading.numbering, ..counter(heading).at(current-heading.location())) + " "
      } else { "" }
      num + current-heading.body.text
    } else { [] }
    line(length: 100%, stroke: 0.5pt)
  },
  footer: context {
    set text(size: 10pt, font: font)
    align(right, counter(page).display("1"))
  }
)

// Chapters
#include "chapters/introduction.typ"
#include "chapters/main.typ"
#include "chapters/discussion.typ"
#include "chapters/conclusion.typ"

// Appendix
#appendix(labels: labels)

// Bibliography
#bibliography-page(labels: labels)

// Declaration of independence
#declaration(
  labels:   labels,
  margin:   margin,
  doc-type: config.doc-type,
  title:    config.title,
  subtitle: config.subtitle,
)

// AI declaration
#ai-declaration(
  labels: labels,
  margin: margin,
)
