// /template/core/utils.typ
// Common utility functions for reports and thesis
// Author: Sam Dinh
// Version: 0.1.0
// License: MIT

// MARK: Dictionary Merge
/// Shallow merge of two dictionaries. Values in `b` override `a`.
/// Used to overlay user overrides on top of class defaults.
///
/// - a (dictionary): Base dictionary
/// - b (dictionary): Override dictionary
/// -> dictionary
#let dict-merge(a, b) = {
  let result = a
  for (key, val) in b {
    result.insert(key, val)
  }
  result
}

// MARK: Unheading (Heading without numbering, for TOC entries)
#let unheading(body) = {
  heading(level: 1, numbering: none, outlined: true)[#body]
}

// MARK: Empty page
#let empty-page() = {
  pagebreak()
  set page(header: none, footer: none)
  align(center + horizon)[
    #text(fill: gray.lighten(50%))[Trang này được cố tình để trống.]
  ]
}

// MARK: Clear to odd page
// Inserts an empty page if the current page is even, so the next content starts on an odd page.
#let cleartoodd() = {
  pagebreak()
  context {
    if calc.even(here().page()) {
      set page(header: none, footer: none)
      align(center + horizon)[
        #text(fill: gray.lighten(50%))[Trang này được cố tình để trống.]
      ]
      pagebreak()
    }
  }
}

// MARK: Static Assets
// Define the root for static assets
#let static-root = "/static/"
#let static(path) = static-root + path

// MARK: Styled Link
// Link that respects text color but underlines, or specific color
#let styled-link(dest, content) = {
  link(dest)[#text(fill: blue)[#content]]
}

// MARK: TOC Section Wrapper
// Standardizes the appearance of TOC, List of Tables, etc.
// Args: color, body
#let toc-section-wrapper(color, body) = {
  block(
    radius: 8pt,
    fill: color.lighten(98%),
    stroke: 1pt + color.lighten(80%),
    inset: 1.5em,
    width: 100%,
    body,
  )
}
