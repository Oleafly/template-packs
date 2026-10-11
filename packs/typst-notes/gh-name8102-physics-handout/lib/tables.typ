#import "state.typ": theme-state
#import "theme.typ": default-theme

#let _table-kind(kind) = {
  assert(
    kind in ("data", "comparison", "record"),
    message: "physics-handout: data-table: kind must be data, comparison, or record; found "
      + repr(kind),
  )
}

#let _table-elements(headers, rows, kind, theme) = {
  let elements = ()
  if kind != "record" {
    elements.push(table.hline(stroke: theme.stroke.table-top + theme.colors.rule))
  }
  elements.push(table.header(
    ..headers.map(header => [
      #set par(justify: false)
      #text(weight: 700, fill: theme.colors.rule)[#header]
    ]),
  ))
  elements.push(table.hline(stroke: theme.stroke.table-header + theme.colors.rule))

  for (row-index, row) in rows.enumerate() {
    for cell in row { elements.push(cell) }
    if kind == "comparison" and row-index < rows.len() - 1 {
      elements.push(table.hline(stroke: theme.stroke.table-inner + theme.colors.rule))
    }
  }

  if kind != "record" {
    elements.push(table.hline(stroke: theme.stroke.table-top + theme.colors.rule))
  }
  elements
}

// 默认知识表格：三线表。无竖线，仅用顶线、表头下线和底线组织信息。
#let data-table(
  headers: (),
  rows: (),
  widths: auto,
  alignments: auto,
  columns: auto,
  align: auto,
  compact: false,
  caption: none,
  kind: "data",
) = context {
  _table-kind(kind)
  assert(
    type(headers) == array and headers.len() > 0,
    message: "physics-handout: data-table: headers must be a non-empty array",
  )
  assert(
    type(rows) == array,
    message: "physics-handout: data-table: rows must be an array",
  )
  let column-count = headers.len()
  for row in rows {
    assert(
      type(row) == array and row.len() == column-count,
      message: "physics-handout: data-table: every row must have " + str(column-count) + " cells",
    )
  }
  if widths != auto {
    assert(
      type(widths) == array and widths.len() == column-count,
      message: "physics-handout: data-table: widths must have one entry per column",
    )
  }
  if alignments != auto {
    assert(
      type(alignments) == array or type(alignments) == alignment,
      message: "physics-handout: data-table: alignments must be an alignment or an array",
    )
    if type(alignments) == array {
      assert(
        alignments.len() == column-count,
        message: "physics-handout: data-table: alignments must have one entry per column",
      )
    }
  }
  if columns != auto {
    assert(
      type(columns) == array and columns.len() == column-count,
      message: "physics-handout: data-table: columns must have one entry per column",
    )
  }
  if align != auto {
    assert(
      type(align) == array or type(align) == alignment,
      message: "physics-handout: data-table: align must be an alignment or an array",
    )
    if type(align) == array {
      assert(
        align.len() == column-count,
        message: "physics-handout: data-table: align must have one entry per column",
      )
    }
  }

  let theme = theme-state.get()
  if theme == none { theme = default-theme }
  let table-widths = if columns != auto {
    columns
  } else if widths != auto {
    widths
  } else {
    (1fr,) * column-count
  }
  let table-alignments = if align != auto {
    align
  } else if alignments != auto {
    alignments
  } else {
    (left,) * column-count
  }
  let table-inset = if kind == "record" {
    theme.tables.record-inset
  } else if compact {
    theme.tables.compact-inset
  } else {
    theme.tables.default-inset
  }
  let table-stroke = if kind == "record" {
    theme.stroke.table-grid + theme.colors.rule
  } else {
    none
  }
  let elements = _table-elements(headers, rows, kind, theme)

  block(width: 100%, above: theme.spacing.sm, below: theme.spacing.sm)[
    #if caption != none [
      #text(size: theme.text.caption-size, weight: 700, fill: theme.colors.rule)[#caption]
      #v(theme.spacing.xs)
    ]
    #table(
      columns: table-widths,
      align: table-alignments,
      inset: table-inset,
      stroke: table-stroke,
      ..elements,
    )
  ]
}

#let three-line-table(..args) = data-table(kind: "data", ..args)
#let comparison-table(..args) = data-table(kind: "comparison", ..args)
#let record-table(..args) = data-table(kind: "record", ..args)
