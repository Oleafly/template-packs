// components/tables.typ
// Themed data tables featuring zebra alternating row fills, crisp slate borders, and bold headers.

#import "theme.typ": resolve-palette, current-theme

// Helper function returning alternating zebra row fills
#let zebra-fill(header-color: rgb("#f1f5f9"), even-color: rgb("#f8fafc"), odd-color: rgb("#ffffff")) = (x, y) => {
  if y == 0 {
    header-color
  } else if calc.even(y) {
    even-color
  } else {
    odd-color
  }
}

// Full styled table component
#let styled-table(
  columns: (1fr, 1fr),
  headers: (),
  rows: (),
  caption: none,
  stroke: none,
  inset: 8pt,
  ..cells
) = context {
  let p = resolve-palette(theme-override: current-theme.get())
  let table-stroke = if stroke != none { stroke } else { 0.5pt + p.table.border }

  let table-fill = (x, y) => {
    if y == 0 {
      p.table.header-bg
    } else if calc.even(y) {
      p.table.even-bg
    } else {
      p.table.odd-bg
    }
  }

  let table-content = table(
    columns: columns,
    stroke: table-stroke,
    fill: table-fill,
    inset: inset,
    if headers.len() > 0 {
      table.header(
        ..headers.map(h => [
          #set text(weight: "bold", fill: p.table.header-text)
          #h
        ])
      )
    },
    ..cells.pos()
  )

  if caption != none {
    figure(
      table-content,
      caption: caption,
    )
  } else {
    v(4pt)
    table-content
    v(4pt)
  }
}
