// -------------------------------------------------------------------------
// File: template/components/outlines.typ
// Authors : Noé Henchoz & Yoan Gilliand
// Date: 2025-12-02
// Description: Table of contents and table of figures components.
// License: MIT
// Copyright: (c) 2025 Noé Henchoz & Yoan Gilliand
// -------------------------------------------------------------------------

#import "../config.typ": *

// Table of Contents
#let table-of-contents() = {
  show outline.entry: it => {
    block(
      above: 1.5em,
      {
        set text(size: 11pt, weight: "bold", fill: rgb("#595959"), font: FONT_MAIN)
        it
      },
    )
  }
  outline(title: [Table des matières], indent: auto, depth: 3)
  pagebreak()
}

// Table of Figures
#let table-of-figures() = {
  pagebreak()
  heading(level: 1, numbering: "1.", outlined: true)[Table des illustrations]
  v(1em)
  show outline.entry: it => {
    set text(size: 11pt, weight: "regular", fill: black, font: FONT_MAIN)
    it
  }
  outline(
    title: none,
    target: figure.where(kind: image),
  )
}
