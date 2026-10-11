// Design tokens shared by the slide, poster and lecture-notes themes (palette.yaml, the lab
// style guide's tokens.json v3). Import, do not copy: `#import "tokens.typ": *`.

// ---------------------------------------------------------------- palette (palette.yaml)
#let ink = rgb("#000000")
#let muted = rgb("#333333")
#let band = rgb("#F0F0F0")
#let brand = rgb("#500000")
#let link-color = rgb("#0097A7")      // large text only
#let link-text = rgb("#007682")       // body-size links and citations (4.65:1 on white)
#let plot = (red: rgb("#FF2D55"), yellow: rgb("#FFCC00"), green: rgb("#61D935"), blue: rgb("#00A2FF"))
#let plot-text = (red: rgb("#E2284B"), yellow: rgb("#8E7200"), green: rgb("#3C8620"), blue: rgb("#007BC1"))
// Lab style guide (KartheinLab/How-tos/_Karthein-Lab-Style-Guide/tokens.json, v3):
// line colours for borders and rules (>= 5.2:1 on white), panel and fill tints, radii.
#let line-color = (red: rgb("#D60042"), yellow: rgb("#856900"), green: rgb("#007D00"), blue: rgb("#0070AD"))
#let text-color = (red: rgb("#A60033"), yellow: rgb("#634E00"), green: rgb("#005F00"), blue: rgb("#005685"))
#let panel = (red: rgb("#FFEDF3"), yellow: rgb("#FFFBED"), green: rgb("#EDFDED"), blue: rgb("#EDF9FF"))
#let fill-color = (red: rgb("#FFADC7"), yellow: rgb("#FFEEAD"), green: rgb("#ADF4AD"), blue: rgb("#ADE2FF"))
#let ink-muted = rgb("#4A4A46")
#let radius = (sm: 4pt, md: 8pt, lg: 12pt)

/// shadow-md from the style guide ("an image lifted off its background"): Typst has no
/// blur, so the 0 2px 8px rgba(26,26,24,0.12) shadow is built from two offset layers.
#let lifted(body, radius: 0pt) = context {
  let sz = measure(body)
  box(width: sz.width, height: sz.height, {
    place(top + left, dx: 0pt, dy: 2pt, rect(width: sz.width + 4pt, height: sz.height + 4pt, radius: radius, fill: rgb("#1A1A18").transparentize(94%), stroke: none), )
    place(top + left, dx: 1pt, dy: 2pt, rect(width: sz.width + 1pt, height: sz.height + 2pt, radius: radius, fill: rgb("#1A1A18").transparentize(88%), stroke: none))
    body
  })
}

/// One-line caption under a figure (11 pt italic, muted), never smaller.
#let caption-line(body) = align(center, text(size: 11pt, style: "italic", fill: muted, body))
