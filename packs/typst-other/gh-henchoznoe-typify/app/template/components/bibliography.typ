// -------------------------------------------------------------------------
// File: template/components/bibliography.typ
// Authors : Noé Henchoz & Yoan Gilliand
// Date: 2025-12-02
// Description: Bibliography generation for Typify template.
// License: MIT
// Copyright: (c) 2025 Noé Henchoz & Yoan Gilliand
// -------------------------------------------------------------------------

// Generate bibliography section
#let generate-bibliography(file) = {
  pagebreak()
  heading(level: 1, numbering: "1.", outlined: true)[Bibliographie]
  // Resolve path from components/ directory to document root
  std.bibliography("../../" + file, style: "ieee", title: none)
}
