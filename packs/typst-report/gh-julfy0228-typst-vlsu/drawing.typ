#import "frame/config.typ": tables
#import "frame/utils.typ": frame, table-bottom-margin

#let drawing-sheet(
  fields,
  table: tables.form-1,
  flipped: false,
  doc
) = {
  show: frame.with(fields, table: table)

  set page(
    paper: "a4",
    flipped: flipped,
    margin: (
      left: 40mm,
      right: 25mm,
      top: 25mm,
      bottom: table-bottom-margin(table) + 20mm,
    ),
    footer: none,
  )

  set par(
    first-line-indent: 0pt,
    justify: false,
    leading: 0pt,
    spacing: 0pt,
  )

  show figure.caption: none
  show figure: set block(breakable: false)

  doc
}
