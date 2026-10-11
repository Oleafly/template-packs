// =================================
// Modular Config Layer
// =================================

// Import all config modules
#import "metadata.typ": *
#import "publications.typ": *
#import "abbreviations.typ": *
#import "appendix.typ": *
#import "contributions.typ": *

// =================================
// Automated Index System
// =================================

// State for tracking index terms and their page references
#let _index-terms = state("index-terms", (:))
#let _index-page-references = state("index-page-references", (:))

// Mark a term for inclusion in the index
// Usage: #index-term("machine learning") or #index-term("machine learning", category: "AI")
#let index-term(term, category: none, subterm: none) = {
  locate(loc => {
    let page-num = loc.page()

    // Update index terms state
    _index-terms.update(terms => {
      if term in terms in terms {
        terms.insert(term, (category: category, subterm: subterm, pages: ()))
      }

      // Add page reference if not already present
      let current-term = terms.at(term)
      if page-num not in current-term.pages {
        current-term.pages.push(page-num)
        terms.insert(term, current-term)
      }

      terms
    })

    // Update page references state for reverse lookup
    _index-page-references.update(refs => {
      if page-num not in refs {
        refs.insert(page-num, ())
      }
      if term not in refs.at(page-num) {
        refs.at(page-num).push(term)
      }
      refs
    })
  })

  // Return invisible content to mark the location
  metadata((
    type: "index-term",
    term: term,
    category: category,
    subterm: subterm,
  ))
  []
}

// Extract potential index terms from content using pattern matching
#let extract-index-terms(content) = {
  let terms = ()

  // Pattern for capitalized terms (potential proper nouns, concepts)
  let capitalized-pattern = regex("([A-Z][a-z]+(?:\s+[A-Z][a-z]+)*)")
  let matches = content.matches(capitalized-pattern)

  for match in matches {
    let term = match.text.trim()
    // Filter out common words and very short terms
    let exclude-words = (
      "the",
      "and",
      "for",
      "are",
      "but",
      "not",
      "you",
      "all",
      "can",
      "had",
      "her",
      "was",
      "one",
      "our",
      "out",
      "day",
      "get",
      "has",
      "him",
      "his",
      "how",
      "its",
      "may",
      "new",
      "now",
      "old",
      "see",
      "two",
      "way",
      "who",
      "boy",
      "did",
      "has",
      "let",
      "put",
      "say",
      "she",
      "too",
      "use",
    )
    if term.len() >= 3 and lower(term) not in exclude-words {
      if term not in terms {
        terms.push(term)
      }
    }
  }

  terms
}

// Auto-extract index terms from document content
#let auto-extract-index(content, min-length: 3, exclude-words: ()) = {
  let extracted = extract-index-terms(content)

  // Filter by minimum length and exclude common words
  let filtered = extracted.filter(term => (
    term.len() >= min-length and lower(term) not in exclude-words
  ))

  // Add extracted terms to index
  for term in filtered {
    index-term(term, category: "auto-extracted")
  }

  filtered
}

// Get all index terms with their page references
#let get-index-terms() = {
  _index-terms.get()
}

// Get page references for a specific term
#let get-term-references(term) = {
  let terms = _index-terms.get()
  if term in terms {
    terms.at(term).pages.sorted()
  } else {
    ()
  }
}

// Generate formatted page references (e.g., "15, 23-25, 30")
#let format-page-references(pages) = {
  if pages.len() == 0 {
    return ""
  }

  let sorted-pages = pages.sorted()
  let ranges = ()
  let start = sorted-pages.at(0)
  let prev = start

  for page in sorted-pages.slice(1) {
    if page == prev + 1 {
      prev = page
    } else {
      if start == prev {
        ranges.push(str(start))
      } else {
        ranges.push(str(start) + "-" + str(prev))
      }
      start = page
      prev = page
    }
  }

  // Handle the last range
  if start == prev {
    ranges.push(str(start))
  } else {
    ranges.push(str(start) + "-" + str(prev))
  }

  ranges.join(", ")
}

// Generate index entry with formatted references
#let generate-index-entry(term, pages, subterm: none, category: none) = {
  let formatted-pages = format-page-references(pages)

  if subterm != none {
    [#subterm, #formatted-pages]
  } else {
    [#formatted-pages]
  }
}

// Generate complete index with categorization
#let generate-index(
  include-categories: true,
  include-subentries: true,
  sort-by: "term", // "term" or "category"
) = {
  let terms = _index-terms.get()
  let sorted-terms = ()

  if sort-by == "category" {
    // Group by category first
    let by-category = (:)
    for (term, data) in terms.pairs() {
      let cat = data.category
      if cat == none {
        cat = "General"
      }
      if cat not in by-category {
        by-category.insert(cat, ())
      }
      by-category.at(cat).push((term, data))
    }

    // Sort categories and terms within each category
    for cat in by-category.keys().sorted() {
      let cat-terms = by-category.at(cat).map(item => item.at(0)).sorted()
      sorted-terms += cat-terms
    }
  } else {
    // Sort alphabetically by term
    sorted-terms = terms.keys().sorted()
  }

  // Generate the index structure
  let index-data = (:)
  for term in sorted-terms {
    let data = terms.at(term)
    index-data.insert(term, data)
  }

  index-data
}

// Generate index page with automatic formatting
#let generate-index-page(
  title: "Index",
  include-categories: true,
  include-statistics: true,
  columns: 2,
) = {
  set page(
    margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 3cm),
  )

  align(center)[
    #text(size: 18pt, weight: "bold", fill: colors.primary)[
      #title
    ]
  ]

  v(1cm)

  let index-data = generate-index(include-categories: include-categories)

  if index-data.len() == 0 {
    text(fill: gray)[
      *No Index Terms Found*

      To populate the index automatically:

      1. *Mark Terms*: Use `#index-term("term name")` throughout your document
      2. *Auto-extraction*: Call `auto-extract-index(content)` on your content
      3. *Categories*: Use `#index-term("term", category: "Category Name")` for organization

      *Example:*
      ```typst
      The #index-term("machine learning") algorithm uses #index-term("neural networks", category: "AI").
      ```
    ]
  } else {
    // Group terms by first letter for better organization
    let grouped-terms = (:)
    for term in index-data.keys().sorted() {
      let first-letter = upper(term.at(0))
      if first-letter not in grouped-terms {
        grouped-terms.insert(first-letter, ())
      }
      grouped-terms.at(first-letter).push(term)
    }

    // Display index in columns
    if columns == 1 {
      // Single column layout
      for letter in grouped-terms.keys().sorted() {
        heading(letter, level: 3, numbering: none)
        for term in grouped-terms.at(letter) {
          let data = index-data.at(term)
          let formatted-refs = format-page-references(data.pages)
          block[*#term*#if data.subterm != none [, #data.subterm] — #formatted-refs]
          v(0.3em)
        }
        v(0.5em)
      }
    } else {
      // Multi-column layout
      columns(columns, gutter: 1em)[
        for letter in grouped-terms.keys().sorted() {
        heading(letter, level: 3, numbering: none)
        for term in grouped-terms.at(letter) {
        let data = index-data.at(term)
        let formatted-refs = format-page-references(data.pages)
        block[*#term*#if data.subterm != none [, #data.subterm] — #formatted-refs]
        v(0.3em)
        }
        v(0.5em)
        }
      ]
    }

    // Statistics
    if include-statistics {
      v(1cm)
      let total-terms = index-data.len()
      let total-references = index-data
        .values()
        .map(data => data.pages.len())
        .sum()
      let categories = index-data
        .values()
        .map(data => data.category)
        .filter(cat => cat != none)
        .dedup()
        .len()

      text(size: 10pt, fill: gray)[
        *Index Statistics:* #total-terms unique terms, #total-references total references, #categories categories
      ]
    }
  }
}

// Validate index terms and references
#let validate-index() = {
  let terms = _index-terms.get()
  let errors = ()
  let warnings = ()

  // Check for empty terms
  for (term, data) in terms.pairs() {
    if term.trim() == "" {
      errors.push("Empty index term found")
    }
    if data.pages.len() == 0 {
      warnings.push("Index term '" + term + "' has no page references")
    }
  }

  (
    errors: errors,
    warnings: warnings,
    total-terms: terms.len(),
    total-references: terms.values().map(data => data.pages.len()).sum(),
  )
}

// Get index statistics
#let get-index-stats() = {
  let validation = validate-index()
  (
    total: validation.total-terms,
    references: validation.total-references,
    errors: validation.errors.len(),
    warnings: validation.warnings.len(),
  )
}

// =================================
// Unified Config Interface
// =================================

// Main config dictionary exposing all modules
#let config = (
  // Metadata configuration
  metadata: (
    required-fields: required-fields,
    resolve: resolve,
  ),

  // Publications configuration
  publications: (
    statuses: statuses,
    validate: validate,
    publication-footnote: publication-footnote,
    publication-status-table: publication-status-table,
  ),

  // Abbreviations configuration
  abbreviations: (
    list: abbreviations,
  ),

  // Appendix configuration
  appendix: (
    appendix-counter: appendix-counter,
    reset-appendix-counter: reset-appendix-counter,
    appendix: appendix,
    creative-output-descriptor: creative-output-descriptor,
    appendix-summary: appendix-summary,
  ),

  // Contributions configuration
  contributions: (
    validate: validate-contribution,
    simple-table: simple-contribution-table,
    detailed-table: detailed-contribution-table,
    percentage-table: percentage-breakdown-table,
    ai-table: ai-contribution-table,
    matrix: contribution-matrix,
    sample: sample-contributions,
  ),

  // Index configuration
  index: (
    term: index-term,
    extract: extract-index-terms,
    auto-extract: auto-extract-index,
    get-terms: get-index-terms,
    get-references: get-term-references,
    format-references: format-page-references,
    generate: generate-index,
    generate-page: generate-index-page,
    validate: validate-index,
    stats: get-index-stats,
  ),
)

// =================================
// Helper Functions
// =================================

// Get a specific config module
#let get-config-module(name) = {
  config.at(name, default: none)
}

// Validate entire config against requirements
#let validate-config(metadata, publications: (), appendices: ()) = {
  // Validate metadata
  let resolved-metadata = config.metadata.resolve(metadata)

  // Validate publications
  let valid-publications = publications.map(config.publications.validate)

  // Validate appendices structure (basic validation)
  let valid-appendices = appendices

  (
    metadata: resolved-metadata,
    publications: valid-publications,
    appendices: valid-appendices,
  )
}
