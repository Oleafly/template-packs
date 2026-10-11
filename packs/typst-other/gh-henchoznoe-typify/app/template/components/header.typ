// -------------------------------------------------------------------------
// File: template/components/header.typ
// Authors : Noé Henchoz & Yoan Gilliand
// Date: 2025-12-02
// Description: Header component for the Typify template.
// License: MIT
// Copyright: (c) 2025 Noé Henchoz & Yoan Gilliand
// -------------------------------------------------------------------------

#import "../config.typ": *

// Header content
#let header-content(title, subtitle, formatted-date, logo: none) = {
  if logo != none {
    // HEIA layout: logo + title/subtitle
    grid(
      columns: (auto, 1fr),
      column-gutter: 1em,
      align: (left + bottom, right + bottom),
      image(logo, height: 1cm),
      {
        text(size: 10pt, weight: "bold", style: "italic", fill: COLOR_GRAY, font: FONT_MAIN)[#title]
        if subtitle != none {
          linebreak()
          text(size: 10pt, weight: "bold", style: "italic", fill: COLOR_GRAY, font: FONT_MAIN)[#subtitle]
        }
      },
    )
  } else {
    // Default layout: title/subtitle on left, date on right
    grid(
      columns: (1fr, auto),
      column-gutter: 2em,
      align: (left + bottom, right + bottom),
      {
        text(size: 10pt, weight: "bold", style: "italic", fill: COLOR_GRAY, font: FONT_MAIN)[#title]
      },
      if subtitle != none {
        text(size: 10pt, weight: "bold", style: "italic", fill: COLOR_GRAY, font: FONT_MAIN)[#subtitle]
      },
    )
  }
  v(0.5em)
  line(length: 100%, stroke: 2pt + COLOR_GRAY)
}
