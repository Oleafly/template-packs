// components/inline.typ — Inline elements

#import "../theme.typ": evidence, fonts, palette, space, type-scale

// ── Badge ──────────────────────────────────────────────────────
// Small colored label, inline with text.
#let badge(content, color: palette.primary) = {
  box(
    fill: color,
    inset: (x: 4pt, y: 2pt),
    radius: 3pt,
    baseline: 20%,
    text(size: type-scale.tiny, fill: white, weight: "bold", content),
  )
}

// ── Tag ────────────────────────────────────────────────────────
// Outlined tag / category marker.
#let tag(content, color: palette.primary) = {
  box(
    stroke: 0.5pt + color,
    inset: (x: 4pt, y: 2pt),
    radius: 3pt,
    baseline: 20%,
    text(size: type-scale.tiny, fill: color, content),
  )
}

// ── Highlight-text ─────────────────────────────────────────────
// Background-highlighted text span.
#let highlight-text(content, color: palette.accent-light) = {
  box(
    fill: color.lighten(60%),
    inset: (x: 2pt, y: 0pt),
    outset: (y: 2pt),
    radius: 2pt,
    content,
  )
}

// ── Kbd ────────────────────────────────────────────────────────
// Keyboard shortcut display.
#let kbd(key) = {
  box(
    inset: (x: 4pt, y: 2pt),
    radius: 3pt,
    baseline: 20%,
    stroke: 0.5pt + palette.border,
    fill: palette.bg-subtle,
    text(font: fonts.mono, size: type-scale.small, key),
  )
}

// ── Icon-text ──────────────────────────────────────────────────
// Symbol + text pair, baseline-aligned.
#let icon-text(icon, content) = {
  box(baseline: 20%)[#icon]
  h(space.xs)
  content
}

// ── Evidence badge ─────────────────────────────────────────────
// Recommendation grade (A–D), color-coded per theme `evidence.grade`.
#let evidence-badge(grade) = {
  let g = upper(grade)
  let color = evidence.grade.at(g, default: palette.text-muted)
  box(
    fill: color,
    inset: (x: 5pt, y: 2pt),
    radius: 3pt,
    baseline: 20%,
    text(size: type-scale.tiny, fill: white, weight: "bold", font: fonts.sans)[Grad #g],
  )
}

// ── Level-of-evidence badge ────────────────────────────────────
// Evidenzlevel (LOE 1–5), color-coded per theme `evidence.loe`.
#let loe-badge(level) = {
  let idx = int(level) - 1
  let color = evidence.loe.at(idx, default: palette.text-muted)
  box(
    stroke: 1pt + color,
    fill: color.lighten(85%),
    inset: (x: 5pt, y: 2pt),
    radius: 3pt,
    baseline: 20%,
    text(size: type-scale.tiny, fill: color.darken(15%), weight: "bold", font: fonts.sans)[LOE #level],
  )
}

// ── Quantity (value + unit) ────────────────────────────────────
// Non-breaking thin space between value and unit, kept on one line —
// the medical-typesetting convention (e.g. `5 mg`, `36.8 °C`).
#let qty(value, unit) = box[#value#h(0.17em)#unit]

// ── Quantity range ─────────────────────────────────────────────
// En-dash range with a trailing unit, e.g. `80–120 mmHg`.
#let qty-range(lo, hi, unit) = box[#lo–#hi#h(0.17em)#unit]
