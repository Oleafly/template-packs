#import "../theme.typ": *

#let table-style(body) = {
  show table.cell: set text(font: f-sans, size: 6pt, fill: c-ink)
  show table.cell.where(y: 0): it => text(font: f-sans-bold, it)

  set table(
    stroke: (x, y) => if y == 0 { (bottom: 0.6pt + table-stroke) },
    inset: 3pt,
    fill: (_, row) => if calc.even(row) { bg-table-even } else { none },
  )

  body
}
