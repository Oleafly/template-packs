#import "tokens.typ": ink, ink-muted, ink-faint, ink-label, surface, surface-dim, border, title-ink, code-ink, code-block-fill, font-body, font-mono, file-icon
#import "components/cover.typ": cover
#import "components/finding.typ": cite-pill, bullet-item, finding
#import "components/divider.typ": section-divider, verification-limits
#import "components/table.typ": etable
#import "components/badge.typ": badge, badges
#import "components/highlight.typ": hl

#let editorial(title: "", date: "", org: "", body) = {
  set page(paper: "a4", margin: (top: 24mm, bottom: 24mm, left: 24mm, right: 24mm), fill: white)
  set text(font: font-body, size: 10pt, fill: ink, lang: "en", ligatures: true)
  set par(justify: false, leading: 0.88em, spacing: 0.95em)
  set heading(numbering: none)

  show heading.where(level: 1): it => {
    v(2em, weak: true)
    text(size: 17pt, weight: 400, tracking: -0.03em, fill: title-ink)[#it.body]
    v(0.45em)
    line(length: 100%, stroke: 0.4pt + luma(160))
    v(0.75em)
  }
  show heading.where(level: 2): it => {
    v(0.75em, weak: true)
    text(size: 14pt, weight: 400, tracking: -0.03em, fill: title-ink)[#it.body]
    v(0.6em)
  }
  show outline.entry: it => {
    v(0.35em)
    set text(size: 9.5pt, fill: ink-muted, weight: 400)
    it
  }
  show strong: set text(weight: 600)

  show raw.where(block: false): it => box(
    fill: surface,
    inset: (x: 4pt, y: 1pt),
    radius: 4pt,
    outset: (y: 1pt),
  )[
    #text(font: font-mono, size: 8.25pt, fill: code-ink, weight: "regular")[#it.text]
  ]
  show raw.where(block: true): set block(
    fill: code-block-fill,
    inset: 10pt,
    radius: 6pt,
    stroke: 0.5pt + surface-dim,
    width: 100%,
  )
  show raw.where(block: true): set text(font: font-mono, size: 8pt, fill: ink-muted)

  cover(title, date, org)
  body
}
