// Reference and citation utilities

/// Unwraps a sequence of citations into "Author, Year; Author, Year" format.
///
/// Useful for narrative citations where you want to list multiple sources
/// in a more readable format than standard parenthetical citations.
///
/// #example(```
/// #unwrap[@smith2020 @jones2021]
/// // produces: Smith, 2020; Jones, 2021
/// ```)
///
/// - body (content): One or more citation references
///
/// -> content
#let unwrap(body) = {
  let children = if body.func() == [].func() {
    body.children
  } else {
    (body,)
  }.filter(x => x.func() != [ ].func())

  let keys = children.map(x => {
    if x.func() == ref { x.target } else if x.func() == cite { x.key }
  })

  keys.map(key => [#cite(key, form: "author"), #cite(key, form: "year")]).join([; ])
}

/// Creates an APA-style bibliography section with proper formatting.
///
/// This wrapper:
/// - Adds a "References" heading styled as level 2
/// - Applies hanging indent (0.5in) per APA guidelines
/// - Sets proper paragraph spacing
///
/// - body (content): The print-bibliography call
#let bib-section(body) = {
  show heading.where(level: 2): it => {
    pagebreak(weak: true)
    v(90pt) // Match frontmatter positioning

    block(
      above: 0pt,
      below: 50.5pt,
      text(size: 25pt, weight: "bold")[#it.body],
    )
  }

  [== References]

  // APA 7th requires hanging indent of 0.5 inches
  // and double-spacing (handled by document-level settings)
  set par(
    first-line-indent: 0pt,
    hanging-indent: 0.5in,
    justify: false,
  )

  body
}

#let citemissing(body) = {
  text(fill: red)[#body]
}
