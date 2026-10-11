// Apply the three-line table style to a table.
#let three-line-table(
  top-stroke: .08em,
  middle-stroke: .05em,
  bottom-stroke: .08em,
  it,
) = context {
  if type(it) != content or it.func() != table {
    panic("three-line-table() expects a table as input.")
  }

  let (children, ..args) = it.fields()
  let first-child = children.first(default: [])
  if first-child.func() == table.hline {
    // First child is already a horizontal line, do nothing
    return it
  } else if first-child.func() == table.header {
    // Header row present, insert middle line after header
    children.insert(1, table.hline(stroke: middle-stroke))
  } else {
    // No header row, insert middle line after first row
    children.insert(0, table.hline(y: 1, stroke: middle-stroke))
  }

  table(
    ..args,
    table.hline(stroke: top-stroke),
    ..children,
    table.hline(stroke: bottom-stroke),
  )
}

// Show tables with three-line table style.
#let use-three-line-table(it, ..args) = {
  show table: set align(center)
  set table(stroke: none, align: center + horizon)
  show table: three-line-table.with(..args)
  it
}
