/// Renders the table of contents page.
/// - labels (dict): UI label dictionary
/// -> none
#let table-of-contents(labels: (:)) = {
  // The ToC heading must not appear as an entry in itself.
  heading(level: 1, numbering: none, outlined: false)[#labels.toc]

  outline(
    title: none,
    indent: auto,
    depth: 3,
  )

  pagebreak()
}
