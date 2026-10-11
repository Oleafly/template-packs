// -------------------------------------------------------------------------
// File: template/components/cover-default.typ
// Authors : Noé Henchoz & Yoan Gilliand
// Date: 2025-12-02
// Description: Default professional cover page - clean and minimal design.
// License: MIT
// Copyright: (c) 2025 Noé Henchoz & Yoan Gilliand
// -------------------------------------------------------------------------

#import "../config.typ": *

// Cover page rendering (Default theme - minimal & elegant)
#let cover-page-default(title, authors, formatted-date, subtitle: none, classe: none, theme) = {
  set page(header: none, footer: none)
  set align(center)

  v(6cm)

  // Title - Large and bold
  text(size: 36pt, weight: "bold", fill: theme.primary)[
    #title
  ]

  // Subtitle - Lighter and smaller
  if subtitle != none {
    v(1.2em)
    text(size: 22pt, weight: "light", fill: theme.primary.lighten(15%))[
      #subtitle
    ]
  }

  v(5cm)

  // Class info
  if classe != none {
    text(size: 13pt, fill: gray)[
      #classe
    ]
    v(2em)
  }

  // Authors - Simple and clean
  if authors.len() > 0 {
    text(size: 13pt)[
      #authors.join(" • ")
    ]
    v(1.5em)
  }

  // Date
  text(size: 12pt, fill: gray.darken(10%))[
    #formatted-date
  ]

  pagebreak()
}
