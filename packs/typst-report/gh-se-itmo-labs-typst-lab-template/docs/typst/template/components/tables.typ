// Таблица с общей рамкой, выделенной шапкой и повторением шапки при переносе.
#let report-table(
  columns: (),
  header: (),
  rows: (),
  align: left + top,
) = {
  // Эти значения отвечают только за внешний вид таблицы.
  let border = 0.6pt + rgb("8a8a8a")
  let header-fill = rgb("e8edf3")

  let header-cells = header.map(cell => table.cell(
    fill: header-fill,
    inset: (x: 5pt, y: 4pt),
    align: center + horizon,
    text(weight: "bold", cell),
  ))

  let body-cells = rows.flatten().map(cell => table.cell(
    inset: (x: 5pt, y: 4pt),
    align: align,
    cell,
  ))

  block(width: 100%)[
    #set text(size: 11pt)
    #set par(first-line-indent: 0pt, justify: false, leading: 0.35em)
    #table(
      columns: columns,
      stroke: border,
      table.header(repeat: true, ..header-cells),
      ..body-cells,
    )
  ]
}
