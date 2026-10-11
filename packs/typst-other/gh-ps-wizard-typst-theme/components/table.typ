#import "../tokens.typ": *

#let etable(header, rows, columns: none, aligns: none) = {
  let n = header.len()
  let cols = if columns != none { columns } else { range(n).map(_ => 1fr) }
  let cell-align(col, row) = {
    if aligns != none {
      if type(aligns) == array { aligns.at(col) } else { aligns }
    } else { left }
  }
  block(
    radius: 6pt,
    clip: true,
    stroke: 0.5pt + border,
    width: 100%,
    breakable: true,
  )[
    #table(
      columns: cols,
      stroke: (x, y) => (bottom: 0.4pt + border),
      fill: (col, row) => if row == 0 { ink } else if calc.odd(row) { white } else { surface },
      inset: (x: 10pt, y: 7pt),
      align: cell-align,
      table.header(
        ..header.map(h => text(size: 8.5pt, weight: 700, fill: white)[#h]),
        repeat: true,
      ),
      ..rows.flatten().map(c => text(size: 9pt, fill: ink)[#c])
    )
  ]
}
