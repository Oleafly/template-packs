// =============================================================================
// CONFIG.TYP - Central configuration system for typst-book-template
// =============================================================================
// This module provides a unified configuration system that all templates
// and components can use for consistent settings.

/// Default book configuration
/// Use this as a base and override specific values
#let default-config = (
  // Document metadata
  meta: (
    title: "Untitled Book",
    subtitle: none,
    author: "Unknown Author",
    date: datetime.today(),
    edition: "First Edition",
    isbn: none,
    publisher: none,
    language: "en",
    keywords: (),
  ),
  
  // Page setup
  page: (
    size: "a5",              // "a4", "a5", "letter", "6x9"
    margin-inner: 2.5cm,
    margin-outer: 2cm,
    margin-top: 3cm,
    margin-bottom: 3cm,
    binding: "left",         // "left" for LTR, "right" for RTL
  ),
  
  // Typography settings
  typography: (
    body-font: "Linux Libertine O",
    heading-font: "Linux Libertine O",
    mono-font: "JetBrains Mono",
    body-size: 11pt,
    line-height: 0.65em,
    paragraph-indent: 1.5em,
    justify: true,
  ),
  
  // Theme selection
  theme: (
    name: "light",
    custom: none,
  ),
  
  // Feature toggles
  features: (
    show-chapter-numbers: true,
    show-page-numbers: true,
    show-running-headers: true,
    show-toc: true,
    draft-mode: false,
    print-mode: false,
  ),
  
  // Front matter settings
  front-matter: (
    show-half-title: true,
    show-title-page: true,
    show-copyright: true,
    show-dedication: false,
    show-epigraph: false,
    show-toc: true,
    show-preface: false,
  ),
  
  // Back matter settings
  back-matter: (
    show-appendices: false,
    show-glossary: false,
    show-bibliography: false,
    show-index: false,
    show-colophon: false,
  ),
)

/// Merge user config with defaults
/// - base: The default configuration dictionary
/// - overrides: User-provided overrides (partial config)
/// Returns: Merged configuration dictionary
#let merge-config(base, overrides) = {
  let result = base
  for (key, value) in overrides {
    if type(value) == dictionary and key in base and type(base.at(key)) == dictionary {
      // Recursively merge nested dictionaries
      result.insert(key, merge-config(base.at(key), value))
    } else {
      result.insert(key, value)
    }
  }
  result
}

/// Create a configuration from user options
/// - options: User-provided configuration overrides
/// Returns: Complete configuration dictionary
#let make-config(..options) = {
  let user-config = options.named()
  merge-config(default-config, user-config)
}

/// Get a nested config value by path
/// - config: Configuration dictionary
/// - path: Dot-separated path (e.g., "colors.primary")
/// - default: Default value if path not found
#let config-get(config, path, default: none) = {
  let parts = path.split(".")
  let current = config
  for part in parts {
    if type(current) == dictionary and part in current {
      current = current.at(part)
    } else {
      return default
    }
  }
  current
}

/// Validate configuration against schema
/// - config: Configuration to validate
/// Returns: Array of (field, error) tuples, empty if valid
#let validate-config(config) = {
  let errors = ()
  
  // Required fields
  if config.meta.title == none or config.meta.title == "" {
    errors.push(("meta.title", "Title is required"))
  }
  
  // Type checks
  if type(config.typography.body-size) != length {
    errors.push(("typography.body-size", "body-size must be a length (e.g., 11pt)"))
  }
  
  // Value ranges
  if config.typography.body-size < 8pt or config.typography.body-size > 24pt {
    errors.push(("typography.body-size", "body-size should be between 8pt and 24pt"))
  }
  
  errors
}

// =============================================================================
// Template-specific configuration presets
// =============================================================================

/// Novel/fiction preset
#let novel-preset = (
  typography: (
    body-font: "Linux Libertine O",
    body-size: 11pt,
    line-height: 0.65em,
    paragraph-indent: 1.5em,
    justify: true,
  ),
  page: (
    size: "a5",
    margin-inner: 2.5cm,
    margin-outer: 2cm,
  ),
  features: (
    show-chapter-numbers: false,
    show-running-headers: true,
  ),
)

/// Technical book preset
#let technical-preset = (
  typography: (
    body-font: ("Inter", "Helvetica Neue", "Arial"),
    body-size: 10pt,
    line-height: 0.7em,
    paragraph-indent: 0pt,
    justify: true,
  ),
  page: (
    size: "a4",
    margin-inner: 3cm,
    margin-outer: 2.5cm,
  ),
  features: (
    show-chapter-numbers: true,
    show-running-headers: true,
  ),
)

/// Academic thesis preset
#let academic-preset = (
  typography: (
    body-font: "Times New Roman",
    body-size: 12pt,
    line-height: 1.5em,
    paragraph-indent: 0pt,
    justify: true,
  ),
  page: (
    size: "a4",
    margin-inner: 3.5cm,
    margin-outer: 2.5cm,
    margin-top: 3cm,
    margin-bottom: 3cm,
  ),
  features: (
    show-chapter-numbers: true,
    show-running-headers: true,
  ),
)

/// Textbook preset
#let textbook-preset = (
  typography: (
    body-font: ("Charter", "Georgia", "serif"),
    heading-font: ("Gill Sans", "Helvetica Neue", "sans-serif"),
    body-size: 11pt,
    line-height: 0.75em,
    paragraph-indent: 0pt,
    justify: true,
  ),
  page: (
    size: "letter",
    margin-inner: 2.5cm,
    margin-outer: 2.5cm,
    margin-top: 2.5cm,
    margin-bottom: 2.5cm,
  ),
  features: (
    show-chapter-numbers: true,
    show-running-headers: true,
  ),
)

/// Apply configuration preset to default config
/// - preset-name: "novel", "technical", "academic", "textbook"
/// - overrides: Additional overrides to apply
#let apply-preset(preset-name, ..overrides) = {
  let preset = if preset-name == "novel" {
    novel-preset
  } else if preset-name == "technical" {
    technical-preset
  } else if preset-name == "academic" {
    academic-preset
  } else if preset-name == "textbook" {
    textbook-preset
  } else {
    (:)
  }
  
  let config = merge-config(default-config, preset)
  merge-config(config, overrides.named())
}
