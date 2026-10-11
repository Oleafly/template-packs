/// Renders two signature lines with labels below them.
/// - left-label (content): Text under the left line (e.g. "Ort, Datum")
/// - right-label (content): Text under the right line (e.g. "Unterschrift")
/// -> none
#let signature-grid(left-label, right-label) = {
  grid(
    columns: (1fr, 1fr),
    line(length: 7cm),
    line(length: 7cm),
  )
  grid(
    columns: (1fr, 1fr),
    left-label,
    right-label,
  )
}

/// Renders a centered level-1 heading for declaration-style pages.
/// Not numbered, not outlined.
/// - title (content): Heading text
/// -> none
#let centered-declaration-heading(title) = {
  show heading: it => align(center, it)
  heading(level: 1, numbering: none, outlined: false)[#title]
}

/// Renders a numbered outline page (figures, tables, listings, etc.).
/// Only rendered when at least one matching figure exists in the document.
/// - title (content): Section heading text
/// - kind (any): Figure kind to target (image, table, raw, …)
/// -> none
#let outline-page(title, kind) = context {
  if query(figure.where(kind: kind)).len() > 0 {
    heading(level: 1, numbering: none)[#title]
    outline(title: none, target: figure.where(kind: kind))
    pagebreak()
  }
}
