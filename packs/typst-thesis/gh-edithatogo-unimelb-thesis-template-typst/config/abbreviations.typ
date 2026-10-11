#let abbreviations = (
  (
    key: "Machine Learning",
    short: "ML",
    long: "A method of data analysis that automates analytical model building.",
  ),
  (
    key: "Deep Learning",
    short: "DL",
    long: "A subset of machine learning using neural networks with multiple layers.",
  ),
  (
    key: "Neural Network",
    short: "NN",
    long: "A computing system inspired by biological neural networks.",
  ),
  (
    key: "Algorithm",
    short: "Algo",
    long: "A procedure or formula for solving a problem.",
  ),
  (
    key: "Artificial Intelligence",
    short: "AI",
    long: "The simulation of human intelligence processes by machines.",
  ),
  (
    key: "Natural Language Processing",
    short: "NLP",
    long: "A subfield of AI focused on the interaction between computers and humans in natural language.",
  ),
  (
    key: "Computer Vision",
    short: "CV",
    long: "A field of AI that trains computers to interpret and understand visual information from the world.",
  ),
  (
    key: "Support Vector Machine",
    short: "SVM",
    long: "A supervised learning algorithm used for classification and regression tasks.",
  ),
  (
    key: "Random Forest",
    short: "RF",
    long: "An ensemble learning method that constructs multiple decision trees.",
  ),
  (
    key: "Gradient Boosting",
    short: "GB",
    long: "A machine learning technique for regression and classification problems.",
  ),
)

#let get-abbreviation(short) = {
  let entry = abbreviations.find(e => e.short == short)
  if entry != none {
    entry.key
  } else {
    short
  }
}

#let get-full-form(key) = {
  let entry = abbreviations.find(e => e.key == key)
  if entry != none {
    entry.long
  } else {
    key
  }
}

#let abbreviation-table() = {
  if abbreviations.len() == 0 {
    none
  } else {
    table(
      columns: 3,
      column-gutter: 1em,
      [*Term*, *Abbreviation*, *Definition*],
      ..abbreviations.map(entry => [
        entry.key,
        entry.short,
        entry.long
      ]),
    )
  }
}

#let validate-abbreviations() = {
  let shorts = abbreviations.map(e => e.short)
  let keys = abbreviations.map(e => e.key)

  // Check for duplicate abbreviations
  for (i, short) in shorts.enumerate() {
    for (j, other) in shorts.enumerate() {
      if i != j and short == other {
        panic("Duplicate abbreviation found: " + short)
      }
    }
  }

  // Check for duplicate keys
  for (i, key) in keys.enumerate() {
    for (j, other) in keys.enumerate() {
      if i != j and key == other {
        panic("Duplicate key found: " + key)
      }
    }
  }
}

// Enhanced Abbreviation Helper Utilities
// Provides advanced abbreviation management for academic writing

// State tracking for first-use expansion
#let _abbrev-used = state("abbrev-used", (:))

// Auto-expand abbreviation on first use (citation style)
#let abbrev(short, expand: true) = {
  if expand {
    locate(loc => {
      let used = _abbrev-used.at(loc)
      if short not in used {
        // First use - expand full form
        _abbrev-used.update(used => used + ((short): true))
        let entry = abbreviations.find(e => e.short == short)
        if entry != none {
          [#entry.key (#entry.short)]
        } else {
          // Unknown abbreviation - show as-is with warning
          text(fill: red, weight: "bold")[#short (?) ]
        }
      } else {
        // Subsequent use - show only abbreviation
        [#short]
      }
    })
  } else {
    [#short]
  }
}

// Get abbreviation with fallback
#let get-abbrev(short, fallback: none) = {
  let entry = abbreviations.find(e => e.short == short)
  if entry != none {
    entry
  } else {
    fallback
  }
}

// Search abbreviations by pattern
#let search-abbreviations(pattern, field: "key") = {
  abbreviations.filter(entry => {
    let value = if field == "key" { entry.key } else if field == "short" {
      entry.short
    } else if field == "long" { entry.long } else { "" }
    value.contains(pattern)
  })
}

// Get all abbreviations sorted by field
#let get-sorted-abbreviations(sort-by: "key", reverse: false) = {
  let sorted = abbreviations.sorted(key: e => {
    if sort-by == "key" { e.key } else if sort-by == "short" {
      e.short
    } else if sort-by == "long" { e.long } else { e.key }
  })
  if reverse {
    sorted.rev()
  } else {
    sorted
  }
}

// Enhanced validation with detailed reporting
#let validate-abbreviations-detailed() = {
  let errors = ()
  let warnings = ()

  // Check for duplicate abbreviations
  let shorts = abbreviations.map(e => e.short)
  for (i, short) in shorts.enumerate() {
    for (j, other) in shorts.enumerate() {
      if i < j and short == other {
        errors.push("Duplicate abbreviation: " + short)
      }
    }
  }

  // Check for duplicate keys
  let keys = abbreviations.map(e => e.key)
  for (i, key) in keys.enumerate() {
    for (j, other) in keys.enumerate() {
      if i < j and key == other {
        errors.push("Duplicate key: " + key)
      }
    }
  }

  // Check for empty fields
  for entry in abbreviations {
    if entry.key.trim() == "" {
      errors.push("Empty key found")
    }
    if entry.short.trim() == "" {
      errors.push("Empty abbreviation found for key: " + entry.key)
    }
    if entry.long.trim() == "" {
      warnings.push(
        "Empty definition for: " + entry.key + " (" + entry.short + ")",
      )
    }
  }

  // Check for inconsistent formatting
  for entry in abbreviations {
    if entry.short.match(regex("^[A-Z]{2,8}$")) == none {
      warnings.push(
        "Non-standard abbreviation format: "
          + entry.short
          + " (recommended: 2-8 uppercase letters)",
      )
    }
  }

  (errors: errors, warnings: warnings)
}

// Print validation report
#let print-validation-report() = {
  let report = validate-abbreviations-detailed()

  if report.errors.len() > 0 {
    text(fill: red, weight: "bold")[Validation Errors:\n]
    for error in report.errors {
      [- #error\n]
    }
  }

  if report.warnings.len() > 0 {
    text(fill: orange, weight: "bold")[Validation Warnings:\n]
    for warning in report.warnings {
      [- #warning\n]
    }
  }

  if report.errors.len() == 0 and report.warnings.len() == 0 {
    text(fill: green)[All abbreviations validated successfully.]
  }
}

// Export abbreviations to different formats
#let export-abbreviations(format: "typst") = {
  if format == "typst" {
    [#abbreviations]
  } else if format == "json" {
    // Note: This would require JSON serialization in Typst
    [#repr(abbreviations)]
  } else if format == "csv" {
    let csv-lines = (
      ("Key,Abbreviation,Definition",)
        + abbreviations.map(e => {
          (
            "\""
              + e.key.replace("\"", "\"\"")
              + "\",\""
              + e.short.replace("\"", "\"\"")
              + "\",\""
              + e.long.replace("\"", "\"\"")
              + "\""
          )
        })
    )
    csv-lines.join("\n")
  } else {
    panic("Unsupported export format: " + format)
  }
}

// Import abbreviations from array
#let import-abbreviations(new-abbrevs) = {
  // Validate format
  for entry in new-abbrevs {
    if (
      type(entry) != dictionary
        or not ("key" in entry and "short" in entry and "long" in entry)
    ) {
      panic(
        "Invalid abbreviation format. Expected: (key: \"...\", short: \"...\", long: \"...\")",
      )
    }
  }

  // Merge with existing
  let merged = abbreviations + new-abbrevs

  // Remove duplicates (keep last occurrence)
  let seen = (:)
  let deduped = ()
  for entry in merged.rev() {
    if entry.short not in seen {
      seen.insert(entry.short, true)
      deduped.push(entry)
    }
  }

  deduped.rev()
}

// Get abbreviation statistics
#let get-abbreviation-stats() = {
  let total = abbreviations.len()
  let avg-key-len = abbreviations.map(e => e.key.len()).sum(default: 0) / total
  let avg-short-len = (
    abbreviations.map(e => e.short.len()).sum(default: 0) / total
  )
  let avg-long-len = (
    abbreviations.map(e => e.long.len()).sum(default: 0) / total
  )

  (
    total: total,
    avg-key-length: calc.round(avg-key-len, digits: 1),
    avg-abbrev-length: calc.round(avg-short-len, digits: 1),
    avg-definition-length: calc.round(avg-long-len, digits: 1),
  )
}

// Create abbreviation index for quick lookup
#let create-abbrev-index() = {
  let index = (:)
  for entry in abbreviations {
    index.insert(entry.short, entry)
  }
  index
}

// Quick lookup with caching
#let _abbrev-cache = state("abbrev-cache", none)

#let get-abbrev-fast(short) = {
  locate(loc => {
    let cache = _abbrev-cache.at(loc)
    if cache == none {
      cache = create-abbrev-index()
      _abbrev-cache.update(cache)
    }
    cache.at(short, default: none)
  })
}

// Advanced abbreviation management utilities

// Create abbreviation groups/categories
#let create-abbrev-groups() = {
  let groups = (:)

  for entry in abbreviations {
    let category = entry.at("category", default: "General")
    if category not in groups {
      groups.insert(category, ())
    }
    groups.at(category).push(entry)
  }

  groups
}

// Get abbreviations by category
#let get-abbrevs-by-category(category) = {
  abbreviations.filter(entry => (
    entry.at("category", default: "General") == category
  ))
}

// Add category information to abbreviations (enhancement)
#let abbreviations-with-categories = abbreviations.map(entry => {
  let category = if (
    entry.key.contains("Learning") or entry.key.contains("Network")
  ) {
    "Machine Learning"
  } else if entry.key.contains("Language") or entry.key.contains("Vision") {
    "AI Applications"
  } else if (
    entry.key.contains("Algorithm")
      or entry.key.contains("Machine")
      or entry.key.contains("Forest")
  ) {
    "Algorithms"
  } else {
    "General"
  }
  entry.insert("category", category)
  entry
})

// Batch abbreviation operations
#let batch-abbrev-update(updates) = {
  let updated = abbreviations
  for update in updates {
    if "short" in update {
      // Find and update existing abbreviation
      let index = updated.position(e => e.short == update.short)
      if index != none {
        updated.at(index) = update
      } else {
        // Add new abbreviation
        updated.push(update)
      }
    }
  }
  updated
}

// Abbreviation usage tracking and analytics
#let _abbrev-usage-stats = state("abbrev-usage-stats", (:))

#let track-abbrev-usage(short) = {
  locate(loc => {
    let stats = _abbrev-usage-stats.at(loc)
    if short not in stats {
      stats.insert(short, 0)
    }
    stats.at(short) += 1
    _abbrev-usage-stats.update(stats)
  })
}

// Enhanced abbrev function with usage tracking
#let abbrev-tracked(short, expand: true) = {
  track-abbrev-usage(short)
  abbrev(short, expand: expand)
}

// Get usage statistics
#let get-abbrev-usage-stats() = {
  locate(loc => {
    _abbrev-usage-stats.at(loc)
  })
}

// Create abbreviation dependency graph
#let create-abbrev-dependency-graph() = {
  let graph = (:)

  for entry in abbreviations {
    graph.insert(entry.short, ())
    // Check if definition references other abbreviations
    for other in abbreviations {
      if other.short != entry.short and entry.long.contains(other.short) {
        graph.at(entry.short).push(other.short)
      }
    }
  }

  graph
}

// Validate abbreviation dependencies (no circular references)
#let validate-abbrev-dependencies() = {
  let graph = create-abbrev-dependency-graph()
  let errors = ()

  // Simple cycle detection (basic implementation)
  for (abbrev, deps) in graph.pairs() {
    for dep in deps {
      if dep in graph and abbrev in graph.at(dep) {
        errors.push("Circular dependency detected: " + abbrev + " <-> " + dep)
      }
    }
  }

  errors
}

// Smart abbreviation suggestions based on text content
#let suggest-abbreviations(text) = {
  let suggestions = ()

  for entry in abbreviations {
    if text.contains(entry.key) and not text.contains(entry.short) {
      suggestions.push(entry)
    }
  }

  suggestions
}

// Abbreviation consistency checker
#let check-abbrev-consistency(text) = {
  let issues = ()

  for entry in abbreviations {
    let full-form-count = text.matches(regex(entry.key)).len()
    let abbrev-count = text.matches(regex(entry.short)).len()

    if full-form-count > 0 and abbrev-count == 0 {
      issues.push(
        "Term '"
          + entry.key
          + "' used in full form but abbreviation '"
          + entry.short
          + "' not found",
      )
    } else if abbrev-count > 0 and full-form-count == 0 {
      issues.push(
        "Abbreviation '"
          + entry.short
          + "' used but full term '"
          + entry.key
          + "' not found",
      )
    }
  }

  issues
}

// Export abbreviations with metadata
#let export-abbrevs-with-metadata(format: "typst") = {
  let metadata = (
    total: abbreviations.len(),
    categories: abbreviations-with-categories.map(e => e.category).dedup(),
    export-date: datetime.today().display(),
    version: "1.0",
  )

  if format == "typst" {
    (metadata: metadata, abbreviations: abbreviations-with-categories)
  } else if format == "json" {
    (
      "(metadata: "
        + repr(metadata)
        + ", abbreviations: "
        + repr(abbreviations-with-categories)
        + ")"
    )
  } else {
    panic("Unsupported format: " + format)
  }
}

// Abbreviation migration utilities
#let migrate-abbrevs-from-csv(csv-content) = {
  // Basic CSV parser (expects: Key,Short,Long format)
  let lines = csv-content.split("\n").filter(l => l.trim() != "")
  if lines.len() < 2 {
    panic("Invalid CSV format")
  }

  let header = lines.at(0).split(",")
  if header.len() != 3 or header.at(0).trim() != "Key" {
    panic("Expected CSV header: Key,Short,Long")
  }

  let new-abbrevs = ()
  for line in lines.slice(1) {
    let parts = line.split(",")
    if parts.len() >= 3 {
      new-abbrevs.push((
        key: parts.at(0).trim().trim("\""),
        short: parts.at(1).trim().trim("\""),
        long: parts.at(2).trim().trim("\""),
      ))
    }
  }

  new-abbrevs
}

// Interactive abbreviation builder
#let build-abbrev-interactive(key, short: none, long: none) = {
  let short-form = if short != none { short } else {
    // Auto-generate abbreviation from key
    let words = key.split(" ")
    if words.len() == 1 {
      words.at(0).slice(0, calc.min(3, words.at(0).len())).upper()
    } else {
      words.map(w => w.slice(0, 1)).join("").upper()
    }
  }

  let definition = if long != none { long } else {
    // Prompt for definition
    "Definition needed for: " + key
  }

  (key: key, short: short-form, long: definition)
}
