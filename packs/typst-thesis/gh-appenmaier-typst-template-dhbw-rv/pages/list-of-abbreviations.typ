/// Renders the list of abbreviations page.
/// Only rendered when at least one abbreviation is defined.
/// - labels (dict): UI label dictionary
/// -> none
#let list-of-abbreviations(labels: (:)) = {
  import "../user/abbreviations.typ": abbreviations

  if abbreviations.len() > 0 {
    heading(level: 1, numbering: none)[#labels.abbreviations]
    set par(spacing: 0.65em)
    for (abbr, desc) in abbreviations.sorted(key: entry => entry.first()) {
      grid(
        columns: (0.25fr, 1fr),
        gutter: 0pt,
        pad(right: 4pt)[#abbr #box(width: 1fr, repeat[.])],
        desc,
      )
    }
    pagebreak()
  }
}
