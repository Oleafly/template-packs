#import "../utils/style.typ": *
#import "../config/abbreviations.typ": (
  abbreviations, abbreviations-with-categories, create-abbrev-groups,
  get-abbreviation-stats, get-abbrevs-by-category, get-sorted-abbreviations,
  print-validation-report, validate-abbreviations-detailed,
)
#import "../config/glossary.typ": (
  generate-full-glossary, generate-glossary-page, get-combined-stats,
  get-extracted-glossary, get-glossary-by-category, get-glossary-categories,
  get-glossary-stats, get-sorted-glossary, glossary-entries, validate-glossary,
)

#let glossary-page() = {
  set page(
    margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 3cm),
  )

  align(center)[
    #text(size: 18pt, weight: "bold", fill: colors.primary)[
      Glossary of Terms and Abbreviations
    ]
  ]

  v(1cm)

  // Enhanced validation with detailed reporting
  let validation = validate-abbreviations-detailed()
  if validation.errors.len() > 0 {
    text(
      fill: red,
      weight: "bold",
    )[Abbreviation validation failed. Please fix the following errors:\n]
    for error in validation.errors {
      [- #error\n]
    }
    return
  }

  if abbreviations.len() == 0 {
    text("No abbreviations defined.")
  } else {
    // Sort alphabetically by key with enhanced sorting
    let sorted-abbrevs = get-sorted-abbreviations(sort-by: "key")

    for entry in sorted-abbrevs {
      block[
        *#entry.key* (#entry.short): #entry.long
      ]
      v(0.5em)
    }

    // Show statistics
    v(1cm)
    let stats = get-abbreviation-stats()
    text(size: 10pt, fill: gray)[
      *Statistics:* #stats.total total abbreviations, average key length: #stats.avg-key-length, average abbreviation length: #stats.avg-abbrev-length
    ]
  }
}

#let abbreviations-page() = {
  set page(
    margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 3cm),
  )

  align(center)[
    #text(size: 18pt, weight: "bold", fill: colors.primary)[
      List of Abbreviations
    ]
  ]

  v(1cm)

  // Enhanced validation with detailed reporting
  let validation = validate-abbreviations-detailed()
  if validation.errors.len() > 0 {
    text(
      fill: red,
      weight: "bold",
    )[Abbreviation validation failed. Please fix the following errors:\n]
    for error in validation.errors {
      [- #error\n]
    }
    return
  }

  if abbreviations.len() == 0 {
    text("No abbreviations defined.")
  } else {
    // Sort alphabetically by abbreviation
    let sorted-abbrevs = get-sorted-abbreviations(sort-by: "short")

    table(
      columns: (auto, auto, 1fr),
      column-gutter: 1em,
      [*Abbreviation*, *Term*, *Definition*],
      ..sorted-abbrevs.map(entry => [
        entry.short,
        entry.key,
        entry.long
      ]),
    )

    // Show statistics
    v(1cm)
    let stats = get-abbreviation-stats()
    text(size: 10pt, fill: gray)[
      *Statistics:* #stats.total total abbreviations, average abbreviation length: #stats.avg-abbrev-length
    ]
  }
}

#let comprehensive-glossary-page() = {
  set page(
    margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 3cm),
  )

  // Use the automated glossary generation system
  // Call the generate function without extra flags to use defaults
  generate-glossary-page()
}
