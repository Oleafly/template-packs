#let notebook-terms(it) = {
  set par(first-line-indent: 0pt, hanging-indent: it.hanging-indent, spacing: if it.spacing != auto {it.spacing} else {par.spacing})
  for item in it.children {
    let term = item.term
    let description = item.description
    [#strong(term)#it.separator#description]
  }
}