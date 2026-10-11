#let index() = {
  show outline.entry.where(level: 1): it => {
    v(12pt)
    text(size: 12pt, it)
  }

  show outline.entry.where(level: 2): it => {
    text(size: 12pt, it)
  }

  v(10mm)
  outline(
    indent: 2em,
    title: box([
      #text(size: 24pt)[目~~次]
      #v(10mm)
    ]),
  )
}