#let contents-page() = {
  pagebreak()

  show outline.entry.where(level: 1): it => {
    set text(weight: "bold")
    set block(above: 2em)
    it
  }

  outline(title: "Contents")
}
