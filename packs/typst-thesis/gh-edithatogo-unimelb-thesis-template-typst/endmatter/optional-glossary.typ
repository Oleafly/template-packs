// Optional Glossary Generation Module
// This module provides automatic glossary generation from abbreviation data
// Include this in your thesis configuration to enable optional glossary features

#import "../config/abbreviations.typ": (
  abbreviations, get-abbreviation-stats, get-sorted-abbreviations,
  validate-abbreviations-detailed,
)
#import "../utils/style.typ": colors

// Generate optional glossary page with automatic content from abbreviations
#let optional-glossary-page(show-validation: true, show-statistics: true) = {
  set page(
    margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 3cm),
  )

  align(center)[
    #text(size: 18pt, weight: "bold", fill: colors.primary)[
      Glossary of Terms and Abbreviations
    ]
  ]

  v(1cm)

  // Optional validation reporting
  if show-validation {
    let validation = validate-abbreviations-detailed()
    if validation.errors.len() > 0 {
      text(fill: red, weight: "bold")[Glossary validation issues detected:\n]
      for error in validation.errors {
        [- #error\n]
      }
      v(0.5cm)
    }
  }

  // Check if we have abbreviations to display
  if abbreviations.len() == 0 {
    text(
      fill: gray,
    )[No glossary terms defined. Add abbreviations using the abbreviation management system.]
  } else {
    // Generate glossary from abbreviations, sorted alphabetically by full term
    let sorted-abbrevs = get-sorted-abbreviations(sort-by: "key")

    for entry in sorted-abbrevs {
      block[
        *#entry.key* (#entry.short): #entry.long
      ]
      v(0.5em)
    }

    // Optional statistics
    if show-statistics {
      v(1cm)
      let stats = get-abbreviation-stats()
      text(size: 10pt, fill: gray)[
        *Glossary Statistics:* #stats.total terms defined, average term length: #stats.avg-key-length characters
      ]
    }
  }
}

// Generate optional abbreviations list page
#let optional-abbreviations-page(
  show-validation: true,
  show-statistics: true,
) = {
  set page(
    margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 3cm),
  )

  align(center)[
    #text(size: 18pt, weight: "bold", fill: colors.primary)[
      List of Abbreviations
    ]
  ]

  v(1cm)

  // Optional validation reporting
  if show-validation {
    let validation = validate-abbreviations-detailed()
    if validation.errors.len() > 0 {
      text(
        fill: red,
        weight: "bold",
      )[Abbreviation validation issues detected:\n]
      for error in validation.errors {
        [- #error\n]
      }
      v(0.5cm)
    }
  }

  // Check if we have abbreviations to display
  if abbreviations.len() == 0 {
    text(
      fill: gray,
    )[No abbreviations defined. Add abbreviations using the abbreviation management system.]
  } else {
    // Generate table from abbreviations, sorted by abbreviation
    let sorted-abbrevs = get-sorted-abbreviations(sort-by: "short")

    table(
      columns: (auto, auto, 1fr),
      column-gutter: 1em,
      align: (left, left, left),
      table.header([*Abbreviation*], [*Full Term*], [*Definition*]),
      ..sorted-abbrevs
        .map(entry => (
          text(weight: "bold")[#entry.short],
          entry.key,
          entry.long,
        ))
        .flatten(),
    )

    // Optional statistics
    if show-statistics {
      v(1cm)
      let stats = get-abbreviation-stats()
      text(size: 10pt, fill: gray)[
        *Abbreviation Statistics:* #stats.total abbreviations, average abbreviation length: #stats.avg-abbrev-length characters
      ]
    }
  }
}

// Combined glossary and abbreviations page
#let optional-glossary-abbreviations-page(
  show-validation: true,
  show-statistics: true,
  separate-pages: true,
) = {
  if separate-pages {
    optional-glossary-page(
      show-validation: show-validation,
      show-statistics: show-statistics,
    )
    pagebreak()
    optional-abbreviations-page(
      show-validation: show-validation,
      show-statistics: show-statistics,
    )
  } else {
    // Single page with both sections
    set page(
      margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 3cm),
    )

    align(center)[
      #text(size: 18pt, weight: "bold", fill: colors.primary)[
        Glossary and Abbreviations
      ]
    ]

    v(1cm)

    // Validation
    if show-validation {
      let validation = validate-abbreviations-detailed()
      if validation.errors.len() > 0 {
        text(fill: red, weight: "bold")[Validation issues detected:\n]
        for error in validation.errors {
          [- #error\n]
        }
        v(0.5cm)
      }
    }

    if abbreviations.len() == 0 {
      text(fill: gray)[No glossary terms or abbreviations defined.]
    } else {
      // Glossary section
      heading("Glossary of Terms", level: 2, numbering: none)
      let sorted-by-key = get-sorted-abbreviations(sort-by: "key")
      for entry in sorted-by-key {
        block[*#entry.key* (#entry.short): #entry.long]
        v(0.3em)
      }

      v(1cm)

      // Abbreviations section
      heading("List of Abbreviations", level: 2, numbering: none)
      let sorted-by-short = get-sorted-abbreviations(sort-by: "short")
      table(
        columns: (auto, 1fr),
        column-gutter: 1em,
        align: (left, left),
        table.header([*Abbreviation*], [*Full Term and Definition*]),
        ..sorted-by-short.map(entry => (
          text(weight: "bold")[#entry.short],
          [#entry.key: #entry.long],
        )),
      )

      // Statistics
      if show-statistics {
        v(1cm)
        let stats = get-abbreviation-stats()
        text(size: 10pt, fill: gray)[
          *Combined Statistics:* #stats.total terms/abbreviations, average term length: #stats.avg-key-length, average abbreviation length: #stats.avg-abbrev-length
        ]
      }
    }
  }
}
