// -------------------------------------------------------------------------
// File: template/components/cover-heia.typ
// Authors : Noé Henchoz & Yoan Gilliand
// Date: 2025-12-02
// Description: HEIA-FR cover page component.
// License: MIT
// Copyright: (c) 2025 Noé Henchoz & Yoan Gilliand
// -------------------------------------------------------------------------

#import "../config.typ": *

// Cover page rendering (HEIA theme)
#let cover-page-heia(title, authors, formatted-date, subtitle: none, classe: none, theme) = {
  set page(header: none, footer: none)

  // Header image (respects margins)
  if theme.cover-image != none {
    align(center)[
      #image(theme.cover-image, width: 100%)
    ]
  }

  v(1.5cm)

  // Title
  align(center)[
    #text(size: 20pt, weight: "bold", fill: theme.primary)[
      #title
    ]
  ]

  v(0.8cm)

  // Horizontal divider
  align(center)[
    #line(length: 100%, stroke: 2pt + gray)
  ]

  v(0.8cm)

  // Subtitle (if provided)
  if subtitle != none {
    align(center)[
      #text(size: 18pt, weight: "regular", fill: theme.primary)[
        #subtitle
      ]
    ]
    v(1cm)
  }

  v(1fr)

  // Information rectangle
  rect(
    width: 100%,
    height: if subtitle != none { 7cm } else { 9cm },
    fill: theme.accent,
    stroke: 2pt + theme.accent-border,
    inset: 1.5cm,
    {
      set text(fill: black, size: 12pt)
      set align(left + horizon)

      // Class field
      if classe != none {
        text(weight: "bold")[Classe : ]
        text[#classe]
        v(1em)
      }

      // Authors field
      if authors.len() > 0 {
        text(weight: "bold")[Auteur#if authors.len() > 1 [s] : ]
        text[#authors.join(", ")]
        v(1em)
      }

      // Date field
      text(weight: "bold")[Date : ]
      text[#formatted-date]
    },
  )

  pagebreak()
}
