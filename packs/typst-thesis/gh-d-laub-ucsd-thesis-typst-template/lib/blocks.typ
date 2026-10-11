// Single line spacing (Typst native single). The reusable carve-out for
// captions, bibliography, vita, and appendices.
#let single-spaced(body) = {
  set par(leading: 0.65em, spacing: 0.65em)
  body
}

// Long quotation (manual §II): single-spaced, indented 0.5in on BOTH sides,
// no inserted quotation marks.
#let long-quote(body) = {
  pad(left: 0.5in, right: 0.5in, single-spaced(body))
}
