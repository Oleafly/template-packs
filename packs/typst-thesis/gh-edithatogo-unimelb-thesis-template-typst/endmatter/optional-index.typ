// Optional Index Generation Module
// This module provides automatic index generation and management
// Include this in your thesis configuration to enable optional index features

#import "../utils/style.typ": colors
#import "../config/index.typ": (
  auto-extract-index, extract-index-terms, format-page-references,
  generate-index, generate-index-page, get-index-stats, get-index-terms,
  get-term-references, index-term, validate-index,
)

// Index entry function for marking terms in the document
// Usage: #index("term") or #index("term", "subterm")
#let index(term, subterm: none) = {
  // Store index entries in document metadata for later processing
  // This is a placeholder - full implementation would require Typst's query system
  // For now, this serves as documentation of the intended API

  // In a full implementation, this would:
  // 1. Store the term and location in document state
  // 2. Generate page references during final rendering
  // 3. Handle sub-entries and cross-references

  // Placeholder implementation - just returns invisible content
  metadata((
    type: "index-entry",
    term: term,
    subterm: subterm,
    location: here(),
  ))
  []
}

// Generate optional index page with manual entries
#let optional-index-page(
  custom-entries: (:),
  show-page-numbers: true,
  columns: 2,
) = {
  // If custom entries are provided, add them to the automated index
  if custom-entries.len() > 0 {
    for (term, pages) in custom-entries.pairs() {
      // Parse page string like "15, 23, 45" into array
      let page-nums = pages
        .split(", ")
        .map(p => {
          if p.contains("-") {
            // Handle ranges like "23-25"
            let parts = p.split("-")
            range(int(parts.at(0)), int(parts.at(1)) + 1)
          } else {
            int(p)
          }
        })
        .flatten()

      // Add to automated index
      for page in page-nums {
        index-term(term)
        // Note: This simplified approach doesn't perfectly handle the page tracking
        // In a full implementation, we'd need to simulate the location context
      }
    }
  }

  // Use the automated index generation system
  generate-index-page(
    title: "Index",
    include-categories: true,
    include-statistics: true,
    columns: columns,
  )
}

// Advanced index with sub-entries support
#let optional-index-with-subentries(
  entries: (:),
  show-page-numbers: true,
  columns: 2,
) = {
  // Convert hierarchical entries to automated index format
  if entries.len() > 0 {
    for (main_term, sub_entries) in entries.pairs() {
      for (sub_term, pages) in sub_entries.pairs() {
        // Parse page string and add to index
        let page_nums = pages
          .split(", ")
          .map(p => {
            if p.contains("-") {
              let parts = p.split("-")
              range(int(parts.at(0)), int(parts.at(1)) + 1)
            } else {
              int(p)
            }
          })
          .flatten()

        // Add main term and sub-term
        for page in page_nums {
          index-term(main_term, subterm: sub_term)
        }
      }
    }
  }

  // Use automated generation
  generate-index-page(
    title: "Index with Sub-entries",
    include-categories: true,
    include-statistics: true,
    columns: columns,
  )
}

// Combined index and glossary helper
#let optional-index-glossary-page(
  index-entries: (:),
  glossary-terms: (:),
  show-statistics: true,
) = {
  // Add manual index entries to automated system
  if index-entries.len() > 0 {
    for (term, pages) in index-entries.pairs() {
      let page-nums = pages
        .split(", ")
        .map(p => {
          if p.contains("-") {
            let parts = p.split("-")
            range(int(parts.at(0)), int(parts.at(1)) + 1)
          } else {
            int(p)
          }
        })
        .flatten()

      for page in page-nums {
        index-term(term, category: "manual")
      }
    }
  }

  // Index section
  generate-index-page(
    title: "Index",
    include-categories: true,
    include-statistics: show-statistics,
    columns: 2,
  )

  pagebreak()

  // Glossary section - use the automated glossary system
  import "../config/glossary.typ": generate-glossary-page
  generate-glossary-page(
    title: "Glossary",
    include-abbreviations: false,
    include-manual-glossary: true,
    include-extracted-terms: false,
    show-statistics: show-statistics,
  )
}
