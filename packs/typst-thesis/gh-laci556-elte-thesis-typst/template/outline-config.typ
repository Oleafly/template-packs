#let outline-config(content) = {
  show outline.entry.where(level: 1): set block(above: 1.5em)
  show outline.entry.where(level: 1): set text(weight: "bold")
  show outline.entry.where(level: 1): set outline.entry(fill: none)
  set outline.entry(fill: pad(left: 0.2em, right: 1em, repeat(gap: 0.50em, ".")))

  show outline.entry: it => link(
    it.element.location(),
    if it.prefix() == none {
      it.indented(none, it.inner())
    } else {
      it.indented(it.prefix() + h(0.4em), it.inner())
    },
  )


  content
}
