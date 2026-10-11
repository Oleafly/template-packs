// /template/core/output-profiles.typ
// Output mode profiles: digital vs print
// Author: Sam Dinh
// Version: 0.2.0
// License: MIT
//
// Controls visual differences between screen-optimized PDFs and
// print-ready documents (e.g., hyperlink colors, accent tints).

// MARK: Profile Definitions

/// Returns a style profile dictionary for the given output mode.
///
/// - mode (str): "digital" or "print"
/// -> dictionary
#let output-profile(mode) = {
  if mode == "print" {
    (
      // Links & citations: no colored highlights for print
      link-color: black,
      cite-color: black,
      // Accent color for tables, TOC wrappers, etc.
      accent-color: gray,
      // Footer: hide clickable "Back to Top" in print
      show-back-to-top: false,
    )
  } else {
    // "digital" (default)
    (
      link-color: rgb("#0000EE"),
      cite-color: blue,
      accent-color: blue,
      show-back-to-top: true,
    )
  }
}
