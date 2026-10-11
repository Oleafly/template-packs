// -------------------------------------------------------------------------
// File: template/components/footer.typ
// Authors : Noé Henchoz & Yoan Gilliand
// Date: 2025-12-02
// Description: Footer component for the Typify template.
// License: MIT
// Copyright: (c) 2025 Noé Henchoz & Yoan Gilliand
// -------------------------------------------------------------------------

#import "../config.typ": *

// Footer content
#let footer-content(authors, formatted-date) = {
  line(length: 100%, stroke: 2pt + COLOR_GRAY)
  v(1.5em)
  grid(
    columns: (1fr, auto, 1fr),
    align: (left, center, right),
    // Authors on left
    text(size: 10pt, weight: "bold", style: "italic", fill: COLOR_GRAY, font: FONT_MAIN)[
      #if authors.len() > 0 { authors.join(", ") }
    ],
    // Page numbers in center
    text(size: 10pt, weight: "bold", style: "italic", fill: COLOR_GRAY, font: FONT_MAIN)[
      #context {
        let current = counter(page).display("1")
        let total = counter(page).final().first()
        [#current / #total]
      }
    ],
    // Date on right
    text(size: 10pt, weight: "bold", style: "italic", fill: COLOR_GRAY, font: FONT_MAIN)[
      #formatted-date
    ],
  )
}
