#import "../utils/style.typ": *

// Glossary System for Academic Writing
// Provides comprehensive glossary management with cross-referencing and validation

// Default glossary entries (can be extended by users)
#let glossary-entries = (
  (
    term: "Thesis",
    definition: "A long piece of writing on a particular subject, especially one that is done for a higher college or university degree.",
    category: "Academic",
    related: ("Dissertation", "Research"),
  ),
  (
    term: "Methodology",
    definition: "The system of methods followed in a particular discipline or field of study.",
    category: "Research",
    related: ("Method", "Approach"),
  ),
  (
    term: "Literature Review",
    definition: "A scholarly paper that includes the current knowledge including substantive findings, as well as theoretical and methodological contributions to a particular topic.",
    category: "Research",
    related: ("Review", "Bibliography"),
  ),
  (
    term: "Hypothesis",
    definition: "A supposition or proposed explanation made on the basis of limited evidence as a starting point for further investigation.",
    category: "Research",
    related: ("Theory", "Proposition"),
  ),
  (
    term: "Peer Review",
    definition: "The evaluation of work by one or more people with similar competencies as the producers of the work.",
    category: "Academic",
    related: ("Review", "Evaluation"),
  ),
  (
    term: "Citation",
    definition: "A reference to a source of information used in a scholarly work.",
    category: "Academic",
    related: ("Reference", "Bibliography"),
  ),
  (
    term: "Plagiarism",
    definition: "The practice of taking someone else's work or ideas and passing them off as one's own.",
    category: "Academic",
    related: ("Academic Integrity", "Ethics"),
  ),
  (
    term: "Abstract",
    definition: "A brief summary of a research article, thesis, review, conference proceeding, or any in-depth analysis of a particular subject.",
    category: "Academic",
    related: ("Summary", "Synopsis"),
  ),
  (
    term: "Bibliography",
    definition: "A list of the books referred to in a scholarly work, typically printed as an appendix.",
    category: "Academic",
    related: ("References", "Works Cited"),
  ),
  (
    term: "Appendix",
    definition: "A section at the end of a book or document containing additional information.",
    category: "Academic",
    related: ("Supplement", "Addendum"),
  ),
)

// State for tracking extracted terms and their page references
#let _extracted-terms = state("extracted-terms", (:))
#let _term-page-references = state("term-page-references", (:))

// Mark a term for automatic glossary inclusion
// Usage: #glossary-term("Machine Learning", "A method of data analysis...")
#let glossary-term(term, definition, category: "General", related: ()) = {
  locate(loc => {
    // Add to extracted terms if not already present
    let current-extracted = _extracted-terms.at(loc)
    if term not in current-extracted {
      let entry = (
        term: term,
        definition: definition,
        category: category,
        related: related,
        auto-extracted: true,
      )
      _extracted-terms.update(current-extracted + ((term): entry))

      // Track page reference
      let current-pages = _term-page-references.at(loc)
      let page-num = loc.page()
      if term not in current-pages {
        _term-page-references.update(current-pages + ((term): (page-num,)))
      } else if page-num not in current-pages.at(term) {
        let existing-pages = current-pages.at(term)
        _term-page-references.update(
          current-pages + ((term): existing-pages + (page-num,)),
        )
      }
    }

    // Return the term with glossary link
    link(label("glossary-" + term))[#term]
  })
}

// Extract technical terms from text content (basic implementation)
// This function can be enhanced with more sophisticated NLP-like processing
#let extract-technical-terms(text, min-length: 3, max-length: 50) = {
  // Simple pattern-based extraction (can be enhanced)
  // Look for capitalized words, technical patterns, etc.
  let patterns = (
    regex("[A-Z][a-z]+(?:\s+[A-Z][a-z]+)*"), // Title case phrases
    regex("\\b[A-Z]{2,}\\b"), // Acronyms
    regex("\\b[a-z]+(?:-[a-z]+)+\\b"), // Hyphenated terms
  )

  let extracted = ()
  for pattern in patterns {
    let matches = text.matches(pattern)
    for match in matches {
      let term = match.text.trim()
      if (
        term.len() >= min-length
          and term.len() <= max-length
          and term not in extracted
      ) {
        extracted.push(term)
      }
    }
  }

  extracted
}

// Auto-extract terms from a block of content
#let auto-extract-glossary(content, category: "Auto-extracted") = {
  locate(loc => {
    // Convert content to string for analysis (limited capability in Typst)
    // This is a simplified approach - in practice, users would need to manually
    // identify terms they want in the glossary

    // For now, we'll provide a framework that users can extend
    // In a more advanced implementation, this could analyze the content string

    [#content] // Return content unchanged, but could trigger extraction
  })
}

// Get all extracted terms with their page references
#let get-extracted-glossary() = {
  locate(loc => {
    let extracted = _extracted-terms.at(loc)
    let pages = _term-page-references.at(loc)

    // Merge page references into extracted terms
    for term in extracted.keys() {
      if term in pages {
        let entry = extracted.at(term)
        entry.insert("page-references", pages.at(term).sorted())
        extracted.insert(term, entry)
      }
    }

    extracted
  })
}

// Generate comprehensive glossary including both manual and auto-extracted terms
#let generate-full-glossary(
  include-auto-extracted: true,
  include-page-refs: true,
) = {
  locate(loc => {
    let manual-terms = glossary-entries
    let auto-terms = if include-auto-extracted {
      get-extracted-glossary()
    } else { (:) }

    // Combine and deduplicate (manual takes precedence)
    let all-terms = (:)
    for entry in manual-terms {
      all-terms.insert(entry.term, entry)
    }

    for (term, entry) in auto-terms {
      if term not in all-terms {
        all-terms.insert(term, entry)
      }
    }

    // Convert to sorted array
    let sorted-terms = all-terms.values().sorted(key: e => e.term)

    sorted-terms
  })
}

// Validate glossary structure
#let validate-glossary() = {
  let errors = ()
  let warnings = ()

  // Check for required fields
  for entry in glossary-entries {
    if "term" not in entry {
      errors.push("Missing 'term' field in glossary entry")
    }
    if "definition" not in entry {
      errors.push(
        "Missing 'definition' field for term: "
          + entry.at("term", default: "unknown"),
      )
    }
  }

  // Check for duplicate terms
  let terms = glossary-entries.map(e => e.term)
  for (i, term) in terms.Enumerate() {
    for (j, other) in terms.enumerate() {
      if i < j and term == other {
        errors.push("Duplicate glossary term: " + term)
      }
    }
  }

  // Check for empty fields
  for entry in glossary-entries {
    if entry.term.trim() == "" {
      errors.push("Empty term found")
    }
    if entry.definition.trim() == "" {
      warnings.push("Empty definition for term: " + entry.term)
    }
  }

  (errors: errors, warnings: warnings)
}

// Get glossary term with auto-expansion on first use
#let glossary(term, link: true, expand: true, track-pages: true) = {
  let entry = glossary-entries.find(e => e.term == term)
  if entry == none {
    // Unknown term - show with warning
    text(fill: red, weight: "bold")[#term (?) ]
  } else {
    if expand {
      locate(loc => {
        let used = _glossary-used.at(loc)
        if term not in used {
          // First use - expand with definition
          _glossary-used.update(used => used + ((term): true))

          // Track page reference if enabled
          if track-pages {
            let current-pages = _term-page-references.at(loc)
            let page-num = loc.page()
            if term not in current-pages {
              _term-page-references.update(
                current-pages + ((term): (page-num,)),
              )
            } else if page-num not in current-pages.at(term) {
              let existing-pages = current-pages.at(term)
              _term-page-references.update(
                current-pages + ((term): existing-pages + (page-num,)),
              )
            }
          }
        }

        if link {
          link(label("glossary-" + term))[#entry.term]
        } else {
          [#entry.term]
        }
      })
    } else {
      if link {
        link(label("glossary-" + term))[#entry.term]
      } else {
        [#entry.term]
      }
    }
  }
}

// Get glossary entry by term
#let get-glossary-term(term) = {
  glossary-entries.find(e => e.term == term)
}

// Search glossary by pattern
#let search-glossary(pattern, field: "term") = {
  glossary-entries.filter(entry => {
    let value = if field == "term" { entry.term } else if (
      field == "definition"
    ) { entry.definition } else if field == "category" {
      entry.at("category", default: "")
    } else { "" }
    value.contains(pattern)
  })
}

// Get glossary terms by category
#let get-glossary-by-category(category) = {
  glossary-entries.filter(entry => (
    entry.at("category", default: "") == category
  ))
}

// Get all categories
#let get-glossary-categories() = {
  let categories = glossary-entries.map(e => e.at(
    "category",
    default: "General",
  ))
  categories.dedup()
}

// Get sorted glossary entries
#let get-sorted-glossary(sort-by: "term", reverse: false) = {
  let sorted = glossary-entries.sorted(key: e => {
    if sort-by == "term" { e.term } else if sort-by == "category" {
      e.at("category", default: "ZZZ")
    } else { e.term }
  })
  if reverse {
    sorted.rev()
  } else {
    sorted
  }
}

// Get related terms for a glossary entry
#let get-related-terms(term) = {
  let entry = get-glossary-term(term)
  if entry != none and "related" in entry {
    entry.related
  } else {
    ()
  }
}

// Create cross-references between related terms
#let create-glossary-cross-references() = {
  for entry in glossary-entries {
    if "related" in entry {
      for related in entry.related {
        let related-entry = get-glossary-term(related)
        if related-entry != none and "related" not in related-entry {
          // Add reverse relationship if it doesn't exist
          related-entry.insert("related", (entry.term,))
        }
      }
    }
  }
}

// Get glossary statistics
#let get-glossary-stats() = {
  let total = glossary-entries.len()
  let categories = get-glossary-categories()
  let avg-term-len = (
    glossary-entries.map(e => e.term.len()).sum(default: 0) / total
  )
  let avg-def-len = (
    glossary-entries.map(e => e.definition.len()).sum(default: 0) / total
  )

  (
    total: total,
    categories: categories.len(),
    avg-term-length: calc.round(avg-term-len, digits: 1),
    avg-definition-length: calc.round(avg-def-len, digits: 1),
  )
}

// Export glossary to different formats
#let export-glossary(format: "typst") = {
  if format == "typst" {
    [#glossary-entries]
  } else if format == "json" {
    [#repr(glossary-entries)]
  } else if format == "csv" {
    let csv-lines = ("Term,Category,Definition,Related",)
    for e in glossary-entries {
      let related-str = if "related" in e { e.related.join("; ") } else { "" }
      let line = (
        "\""
          + e.term.replace("\"", "\"\"")
          + "\",\""
          + e.at("category", default: "").replace("\"", "\"\"")
          + "\",\""
          + e.definition.replace("\"", "\"\"")
          + "\",\""
          + related-str.replace("\"", "\"\"")
          + "\""
      )
      csv-lines.push(line)
    }
    csv-lines.join("\n")
  } else {
    panic("Unsupported export format: " + format)
  }
}

// Import glossary entries
#let import-glossary(new-entries) = {
  // Validate format
  for entry in new-entries {
    if (
      type(entry) != dictionary
        or "term" not in entry
        or "definition" not in entry
    ) {
      panic(
        "Invalid glossary format. Expected: (term: \"...\", definition: \"...\", category: \"...\", related: (...))",
      )
    }
  }

  // Merge with existing
  let merged = glossary-entries + new-entries

  // Remove duplicates (keep last occurrence)
  let seen = (:)
  let deduped = ()
  for entry in merged.rev() {
    if entry.term not in seen {
      seen.insert(entry.term, true)
      deduped.push(entry)
    }
  }

  deduped.rev()
}

// Create glossary index for quick lookup
#let create-glossary-index() = {
  let index = (:)
  for entry in glossary-entries {
    index.insert(entry.term, entry)
  }
  index
}

// Quick lookup with caching
#let _glossary-cache = state("glossary-cache", none)

#let get-glossary-fast(term) = {
  locate(loc => {
    let cache = _glossary-cache.at(loc)
    if cache == none {
      cache = create-glossary-index()
      _glossary-cache.update(cache)
    }
    cache.at(term, default: none)
  })
}

// Enhanced abbreviation-glossary integration utilities

// Check if a term exists in either abbreviations or glossary
#let term-exists(term, check-abbrevs: true, check-glossary: true) = {
  let found = false
  if check-abbrevs {
    import "abbreviations.typ": abbreviations
    found = (
      found
        or (abbreviations.find(e => e.key == term or e.short == term) != none)
    )
  }
  if check-glossary {
    found = found or (glossary-entries.find(e => e.term == term) != none)
  }
  found
}

// Get comprehensive term information (from either system)
#let get-term-info(term) = {
  import "abbreviations.typ": abbreviations

  // Check abbreviations first
  let abbrev = abbreviations.find(e => e.key == term or e.short == term)
  if abbrev != none {
    return (
      type: "abbreviation",
      key: abbrev.key,
      short: abbrev.short,
      long: abbrev.long,
      definition: abbrev.long,
    )
  }

  // Check glossary
  let glossary = glossary-entries.find(e => e.term == term)
  if glossary != none {
    return (
      type: "glossary",
      term: glossary.term,
      definition: glossary.definition,
      category: glossary.at("category", default: "General"),
      related: glossary.at("related", default: ()),
    )
  }

  none
}

// Unified term reference (works with both abbreviations and glossary)
#let term(term, link: true, expand: true) = {
  let info = get-term-info(term)
  if info == none {
    text(fill: red, weight: "bold")[#term (?) ]
  } else if info.type == "abbreviation" {
    import "abbreviations.typ": abbrev
    abbrev(info.short, expand: expand)
  } else {
    glossary(info.term, link: link, expand: expand)
  }
}

// Create combined abbreviations and glossary index
#let create-combined-index() = {
  import "abbreviations.typ": abbreviations

  let index = (:)

  // Add abbreviations
  for entry in abbreviations {
    index.insert(entry.short, (type: "abbreviation", data: entry))
    index.insert(entry.key, (type: "abbreviation", data: entry))
  }

  // Add glossary terms
  for entry in glossary-entries {
    index.insert(entry.term, (type: "glossary", data: entry))
  }

  index
}

// Combined search across abbreviations and glossary
#let search-terms(pattern, sources: ("abbreviations", "glossary")) = {
  import "abbreviations.typ": abbreviations

  let results = ()

  if "abbreviations" in sources {
    let abbrev-results = abbreviations
      .filter(entry => {
        (
          entry.key.contains(pattern)
            or entry.short.contains(pattern)
            or entry.long.contains(pattern)
        )
      })
      .map(entry => (type: "abbreviation", data: entry))
    results += abbrev-results
  }

  if "glossary" in sources {
    let glossary-results = glossary-entries
      .filter(entry => {
        (
          entry.term.contains(pattern)
            or entry.definition.contains(pattern)
            or entry.at("category", default: "").contains(pattern)
        )
      })
      .map(entry => (type: "glossary", data: entry))
    results += glossary-results
  }

  results
}

// Get combined statistics
#let get-combined-stats() = {
  import "abbreviations.typ": abbreviations, get-abbreviation-stats

  let abbrev-stats = get-abbreviation-stats()
  let glossary-stats = get-glossary-stats()

  (
    abbreviations: abbrev-stats,
    glossary: glossary-stats,
    total-terms: abbrev-stats.total + glossary-stats.total,
    total-categories: glossary-stats.categories,
  )
}

// Generate automated glossary page with page references
#let generate-glossary-page(
  title: "Glossary",
  include-auto-extracted: true,
  include-page-refs: true,
  include-categories: true,
  sort-by: "term",
  // Backwards-compatible optional flags used by higher-level pages
  include-abbreviations: true,
  include-manual-glossary: true,
  include-extracted-terms: true,
  show-statistics: false,
  show-validation: false,
) = {
  locate(loc => {
    // Get all glossary terms
    let all-terms = generate-full-glossary(
      include-auto-extracted: include-auto-extracted,
      include-page-refs: include-page-refs,
    )

    // Sort terms
    let sorted-terms = all-terms.sorted(key: e => {
      if sort-by == "term" { e.term } else if sort-by == "category" {
        e.at("category", default: "ZZZ")
      } else { e.term }
    })

    // Create page
    set page(
      margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 3cm),
    )

    // Title
    align(center)[
      #text(size: 18pt, weight: "bold", fill: colors.primary)[#title]
    ]

    v(1cm)

    // Optional validation display
    if show-validation {
      let vres = validate-glossary()
      if vres.errors.len() > 0 {
        text(
          fill: red,
          weight: "bold",
        )["Glossary validation failed. Please fix the following errors:\n"]
        for e in vres.errors {
          [- #e "\n"]
        }
        return
      }
    }

    // Optional statistics display
    if show-statistics {
      let stats = get-combined-stats()
      text(size: 10pt, fill: gray)[
        *Statistics:* #stats.total-terms total terms; abbreviations: #stats.abbreviations.total; glossary terms: #stats.glossary.total
      ]
      v(0.5cm)
    }

    // Group by category if requested
    if include-categories {
      let categories = sorted-terms
        .map(e => e.at("category", default: "General"))
        .dedup()
        .sorted()

      for category in categories {
        let category-terms = sorted-terms.filter(e => (
          e.at("category", default: "General") == category
        ))

        if category-terms.len() > 0 {
          heading(category, level: 2, numbering: none)
          v(0.5cm)

          for entry in category-terms {
            generate-glossary-entry(entry, include-page-refs: include-page-refs)
            v(0.3em)
          }

          v(0.5cm)
        }
      }
    } else {
      // Single alphabetical list
      for entry in sorted-terms {
        generate-glossary-entry(entry, include-page-refs: include-page-refs)
        v(0.3em)
      }
    }
  })
}

// Generate individual glossary entry with formatting
#let generate-glossary-entry(entry, include-page-refs: true) = {
  // Create label for cross-referencing
  label("glossary-" + entry.term)

  block[
    // Term in bold
    text(weight: "bold", size: 11pt)[#entry.term]

    // Definition
    [: #entry.definition]

    // Page references
    if include-page-refs and "page-references" in entry {
    let pages = entry.page-references
    if pages.len() > 0 {
    text(style: "italic", size: 9pt)[ (pp. #pages.map(str).join(", ")) ]
    }
    }

    // Related terms
    if "related" in entry and entry.related.len() > 0 {
    text(fill: colors.secondary, size: 9pt)[
    \ *See also:* #entry.related.join(", ")
    ]
    }
  ]
}

// Enhanced term extraction with context awareness
#let extract-terms-from-content(content, context-patterns: ()) = {
  // This is a framework for term extraction
  // In practice, users would call this on specific content blocks

  // Default patterns for technical terms
  let default-patterns = (
    regex("\\b[A-Z][a-z]+(?:\\s+[A-Z][a-z]+)+\\b"), // Multi-word capitalized terms
    regex("\\b[A-Z]{2,}\\b"), // Acronyms
    regex("\\b[a-z]+(?:-[a-z]+)+\\b"), // Hyphenated technical terms
  )

  let patterns = if context-patterns.len() > 0 { context-patterns } else {
    default-patterns
  }

  // Note: Actual extraction would require content to be processed
  // This provides the framework for users to implement custom extraction

  (:) // Return empty dict as placeholder
}

// Batch add terms to glossary from a dictionary
#let add-glossary-terms(new-terms) = {
  for (term, data) in new-terms {
    if type(data) == dictionary and "definition" in data {
      let entry = (
        term: term,
        definition: data.definition,
        category: data.at("category", default: "General"),
        related: data.at("related", default: ()),
        auto-extracted: data.at("auto-extracted", default: false),
      )
      glossary-entries.push(entry)
    }
  }
}

// Create glossary index page
#let generate-glossary-index() = {
  set page(
    margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 3cm),
  )

  align(center)[
    #text(size: 16pt, weight: "bold", fill: colors.primary)[Glossary Index]
  ]

  v(1cm)

  let all-terms = generate-full-glossary()

  // Create two-column index
  let columns = 2
  let terms-per-column = calc.ceil(all-terms.len() / columns)

  table(
    columns: (1fr, 1fr),
    stroke: none,
    align: left,

    // Column 1
    ..for i in range(0, calc.min(terms-per-column, all-terms.len())) {
      let entry = all-terms.at(i)
      ([#link(label("glossary-" + entry.term))[#entry.term]],)
    },

    // Column 2
    ..for i in range(terms-per-column, all-terms.len()) {
      let entry = all-terms.at(i)
      ([#link(label("glossary-" + entry.term))[#entry.term]],)
    }
  )
}
