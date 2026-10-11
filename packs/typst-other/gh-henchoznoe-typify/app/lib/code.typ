// -------------------------------------------------------------------------
// File: lib/code.typ
// Authors : Noé Henchoz & Yoan Gilliand
// Date: 2025-12-01
// Description: Advanced code block component with headers and styling.
// License: MIT
// Copyright: (c) 2025 Noé Henchoz & Yoan Gilliand
// -------------------------------------------------------------------------

// --- Constants ---
#let FRAME_COLOR = rgb("#f4f6fa")
#let BORDER_COLOR = rgb("#dbe2ef")
#let HEADER_COLOR = rgb("#e6ebf5")
#let TEXT_COLOR = rgb("#2c3e50")
#let CORNER_RADIUS = 4pt

// --- Code Frame Function ---

#let code-frame(
  code,
  title: none,
  lang: none,
  numbers: false,
) = {
  let content = if type(code) == str {
    raw(code, lang: lang, block: true)
  } else {
    code
  }

  block(
    fill: FRAME_COLOR,
    stroke: 0.5pt + BORDER_COLOR,
    radius: CORNER_RADIUS,
    clip: true,
    width: 100%,
    {
      if title != none {
        block(
          fill: HEADER_COLOR,
          width: 100%,
          inset: (x: 10pt, y: 6pt),
          below: 0pt,
          text(size: 8pt, weight: "bold", fill: TEXT_COLOR)[#title],
        )
        line(length: 100%, stroke: 0.5pt + BORDER_COLOR)
      }

      let code-styled = if numbers {
        set raw(align: start, block: true)
        show raw.line: it => {
          text(fill: rgb("#95a5a6"), size: 8pt)[#it.number]
          h(1em)
          it.body
        }
        content
      } else {
        content
      }

      pad(
        left: 10pt,
        right: 10pt,
        bottom: 10pt,
        top: if title != none { 0pt } else { 10pt },
        {
          show raw: set text(size: 7.5pt)
          show raw: set block(fill: none, stroke: none, inset: 0pt, radius: 0pt)
          code-styled
        },
      )
    },
  )
}
