// kami-typst — Professional Document Templates
// Warm parchment, ink-blue accent, serif hierarchy.
//
// Usage:
//   #import "@preview/kami:0.1.0": *
// Or locally:
//   #import "templates/resume.typ": resume
//   #import "templates/slides.typ": cover, slide, slide-components

#import "tokens.typ": *

// Re-export all tokens so users can customize
#let kami-tokens = (
  parchment: parchment, ivory: ivory, brand: brand,
  near-black: near-black, dark-warm: dark-warm, olive: olive, stone: stone,
  border: border, border-soft: border-soft,
  serif-zh: serif-zh, serif-en: serif-en, mono: mono,
  size-display: size-display, size-h1: size-h1, size-h2: size-h2,
  size-body: size-body, lh-reading: lh-reading,
)

// Templates (uncomment as they are implemented)
// #import "templates/one-pager.typ": one-pager
// #import "templates/resume.typ": resume
// #import "templates/long-doc.typ": long-doc
// #import "templates/letter.typ": letter
// #import "templates/portfolio.typ": portfolio
#import "templates/slides.typ": cover, slide, eyebrow, slide-title, section-heading, body-text, callout, page-footer, ms-label, sm-text
// #import "templates/equity-report.typ": equity-report
// #import "templates/changelog.typ": changelog
// #import "templates/landing-page.typ": landing-page
