// kami-typst · Slides Template
// Landscape presentation deck (280mm × 158mm)
//
// Usage:
//   #import "@preview/kami:0.1.0": slides-cover, slides-page, slide-components
//   // or locally:
//   #import "templates/slides.typ": cover, slide, eyebrow, slide-title, section-heading, body-text, callout, page-footer, ms-label, sm-text

#import "../tokens.typ": *

// ═══════════════════════════════════════════
// Page setup
// ═══════════════════════════════════════════

#set page(
  width: 280mm,
  height: 158mm,
  margin: (x: 20mm, top: 16mm, bottom: 10mm),
  background: rect(fill: parchment, width: 100%, height: 100%),
)

#set text(
  font: serif-zh,
  size: 13pt,
  fill: near-black,
  lang: "zh",
)

// ═══════════════════════════════════════════
// Components
// ═══════════════════════════════════════════

// Section eyebrow (mono, uppercase feel)
#let eyebrow(label) = {
  text(size: 9.5pt, fill: stone, font: mono, tracking: 2pt)[#label]
}

// Slide title (large serif)
#let slide-title(body) = {
  text(size: 24pt, weight: "semibold", fill: near-black)[#body]
}

// Section heading (brand blue, smaller)
#let section-heading(body) = {
  text(size: 15pt, weight: "semibold", fill: brand)[#body]
}

// Lead paragraph (olive, slightly larger)
#let slide-lead(body) = {
  text(size: 12pt, fill: olive)[#body]
}

// Body text (dark warm, standard size)
#let body-text(body) = {
  text(size: 11pt, fill: dark-warm)[#body]
}

// Module title with large brand letter prefix
#let module-title(letter, title) = {
  [#text(size: 24pt, weight: "semibold", fill: brand)[#letter] #text(size: 16pt, weight: "semibold", fill: near-black)[#title]]
}

// Pinned conclusion callout (bottom of slide)
#let callout(body) = {
  align(bottom)[#text(size: 11pt, weight: "semibold", fill: brand)[#body]]
}

// Page footer with mark and number
#let page-footer(num, mark) = {
  align(bottom)[
    #grid(
      columns: (1fr, 1fr),
      align(left)[#text(size: 9pt, fill: stone, font: mono)[#mark]],
      align(right)[#text(size: 9pt, fill: stone, font: mono)[#num]],
    )
  ]
}

// Mono section label (for tech specs, data labels)
#let ms-label(body) = {
  text(size: 7.5pt, fill: stone, font: mono, tracking: 1.5pt)[#body]
}

// Small text (captions, notes)
#let sm-text(body) = {
  text(size: 9.5pt, fill: olive)[#body]
}

// ═══════════════════════════════════════════
// Page builders
// ═══════════════════════════════════════════

// Cover slide
#let cover(title, subtitle, meta) = {
  align(center + horizon)[
    #v(40mm)
    #text(size: 38pt, weight: "semibold", fill: near-black)[#title]
    #v(12pt)
    #text(size: 14pt, fill: olive)[#subtitle]
    #v(32pt)
    #text(size: 10pt, fill: stone)[#meta]
  ]
}

// Content slide wrapper
#let slide(body) = {
  pagebreak()
  body
}
