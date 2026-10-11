// styles/print.typ — Prepress helpers (bleed, crop marks, print-mode)
//
// Activated with:  typst compile --input print=true …
// Screen / UA builds leave print unset → zero bleed, no marks.
//
// Architecture decision (devtracks/prepress-pdfx):
//   · Bleed + Schnittmarken: native Typst (page.bleed + foreground marks)
//   · PDF/X + CMYK: Ghostscript post-step (Typst has no --pdf-standard x-*)
//   · Design tokens stay RGB; conversion happens in the print pipeline

// ── Build-mode detection ───────────────────────────────────────
// All sys.inputs values are strings.
#let print-mode = sys.inputs.at("print", default: "false") == "true"

// Standard European commercial-print bleed (Beschnitt).
#let prepress-bleed = 3mm

// Effective bleed for the current build.
#let page-bleed = if print-mode { prepress-bleed } else { 0pt }

// ── Crop / trim marks (Schnittmarken) ──────────────────────────
// Drawn in page.foreground. Relative coordinates in foreground/
// background resolve against page size *including* bleed
// (Typst page docs). `page.width` / `page.height` remain the trim size.
//
// With 3 mm bleed, marks are short L-shapes just outside the trim.
// Full registration bullseyes need more bleed; we use simple centre
// crosses (Passkreuze light) that fit the strip.
#let crop-marks(
  bleed: prepress-bleed,
  mark-length: 2.2mm,
  gap: 0.6mm,
  stroke: 0.2pt + black,
  registration: true,
) = context {
  let b = bleed
  if b <= 0pt { return }

  let tw = page.width
  let th = page.height
  let len = mark-length
  let g = gap
  let s = stroke

  // Trim box origin in media coordinates (top-left of media = 0,0)
  let tl-x = b
  let tl-y = b
  let tr-x = b + tw
  let tr-y = b
  let bl-x = b
  let bl-y = b + th
  let br-x = b + tw
  let br-y = b + th

  let h-mark(dx, dy) = place(
    top + left,
    dx: dx,
    dy: dy,
    line(start: (0pt, 0pt), end: (len, 0pt), stroke: s),
  )
  let v-mark(dx, dy) = place(
    top + left,
    dx: dx,
    dy: dy,
    line(start: (0pt, 0pt), end: (0pt, len), stroke: s),
  )

  // ── Top-left ─────────────────────────────────────────────────
  h-mark(tl-x - g - len, tl-y) // horizontal, left of trim
  v-mark(tl-x, tl-y - g - len) // vertical, above trim

  // ── Top-right ────────────────────────────────────────────────
  h-mark(tr-x + g, tr-y)
  v-mark(tr-x, tr-y - g - len)

  // ── Bottom-left ──────────────────────────────────────────────
  h-mark(bl-x - g - len, bl-y)
  v-mark(bl-x, bl-y + g)

  // ── Bottom-right ─────────────────────────────────────────────
  h-mark(br-x + g, br-y)
  v-mark(br-x, br-y + g)

  // ── Mid-edge crosses (Passmarken light) ──────────────────────
  if registration {
    let arm = calc.min(len * 0.55, b * 0.45)
    let mid-x = b + tw / 2
    let mid-y = b + th / 2
    let mid-edge = b / 2

    // Top mid
    place(top + left, dx: mid-x - arm, dy: mid-edge,
      line(start: (0pt, 0pt), end: (2 * arm, 0pt), stroke: s))
    place(top + left, dx: mid-x, dy: mid-edge - arm,
      line(start: (0pt, 0pt), end: (0pt, 2 * arm), stroke: s))
    // Bottom mid
    place(top + left, dx: mid-x - arm, dy: b + th + mid-edge,
      line(start: (0pt, 0pt), end: (2 * arm, 0pt), stroke: s))
    place(top + left, dx: mid-x, dy: b + th + mid-edge - arm,
      line(start: (0pt, 0pt), end: (0pt, 2 * arm), stroke: s))
    // Left mid
    place(top + left, dx: mid-edge - arm, dy: mid-y,
      line(start: (0pt, 0pt), end: (2 * arm, 0pt), stroke: s))
    place(top + left, dx: mid-edge, dy: mid-y - arm,
      line(start: (0pt, 0pt), end: (0pt, 2 * arm), stroke: s))
    // Right mid
    place(top + left, dx: b + tw + mid-edge - arm, dy: mid-y,
      line(start: (0pt, 0pt), end: (2 * arm, 0pt), stroke: s))
    place(top + left, dx: b + tw + mid-edge, dy: mid-y - arm,
      line(start: (0pt, 0pt), end: (0pt, 2 * arm), stroke: s))
  }
}

// Foreground content for print builds (empty otherwise).
#let print-foreground = if print-mode { crop-marks() } else { none }

// Page-set dictionary fragment to spread into set page(...) when needed.
// Usage: set page(margin: 0pt, ..print-page-args())
#let print-page-args() = if print-mode {
  (bleed: prepress-bleed, foreground: crop-marks())
} else {
  (:)
}
