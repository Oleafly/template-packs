#import "config.typ": page_settings, typography, palette, strokes, dimensions

#let text_cell(value, size: typography.body_size, weight: "regular", fill: palette.text) = {
  set text(size: size, weight: weight, fill: fill)
  value
}

#let maybe_text(value, size: typography.body_size, weight: "regular", fill: palette.text) = {
  if value == none or value == "" { [] } else { text_cell(value, size: size, weight: weight, fill: fill) }
}

#let gap_row(columns, padding) = table.cell(colspan: columns, inset: (y: padding))[]

#let row_cells(row) = (
  if row.kind == "detail" {
    pad(left: dimensions.detail_indent)[
      #maybe_text(row.service, size: typography.small_size)
    ]
  } else {
    maybe_text(row.service)
  },
  maybe_text(row.rate),
  maybe_text(row.quantity),
  maybe_text(row.discount),
  maybe_text(row.payment_due),
)

#let render_header(data) = grid(
  columns: (auto, 1fr, auto),
  column-gutter: dimensions.header_column_gap,
  align: top,
  image(data.issuer.logo_path, height: dimensions.logo_height),
  [
    #text_cell(data.issuer.name, weight: "bold") \
    #text_cell(data.issuer.contact) \
    #text_cell(data.issuer.url) \
    #text_cell(data.issuer.phone) \
    #text_cell(data.issuer.email)
  ],
  align(right)[
    #set text(size: typography.small_size, fill: palette.text)
    *#data.meta.title* \
    #data.meta.number \
    *#data.meta.date_label* \
    #data.meta.date_value \
    *#data.meta.due_label* \
    #data.meta.due_value
  ],
)

#let render_bill_to(data) = [
  #set par(leading: dimensions.bill_to_leading)
  #text_cell(data.bill_to.label) \
  #text_cell(data.bill_to.customer, size: typography.section_title_size, weight: "bold")
]

#let render_table(data) = {
  table(
    columns: dimensions.table_columns,
    stroke: none,
    align: (left, center, center, center, right),
    inset: (x: 0pt, y: dimensions.table_inset_y),
    table.hline(stroke: strokes.thin),
    gap_row(5, dimensions.table_rule_padding),
    table.cell(align: center)[#text_cell(data.table.headers.service, weight: "bold")],
    table.cell(align: center)[#text_cell(data.table.headers.rate, weight: "bold")],
    table.cell(align: center)[#text_cell(data.table.headers.quantity, weight: "bold")],
    table.cell(align: center)[#text_cell(data.table.headers.discount, weight: "bold")],
    table.cell(align: right)[#text_cell(data.table.headers.payment_due, weight: "bold")],
    gap_row(5, dimensions.table_rule_padding),
    table.hline(stroke: strokes.thin),
    gap_row(5, dimensions.table_rule_padding),
    ..data.table.rows.map(row => row_cells(row)).flatten(),
    gap_row(5, dimensions.table_rule_padding),
    table.hline(stroke: strokes.thin),
  )
}

#let render_summary(data) = align(
  right,
  box(
    width: dimensions.summary_width,
    table(
      columns: (1fr, auto),
      stroke: none,
      align: (left, right),
      inset: (x: 0pt, y: dimensions.summary_inset_y),
      text_cell(data.summary.total_label, weight: "bold"),
      text_cell(data.summary.total_amount),
      gap_row(2, dimensions.summary_rule_padding),
      table.hline(stroke: strokes.thin),
      gap_row(2, dimensions.summary_rule_padding),
      text_cell(data.summary.payment_label, weight: "bold"),
      text_cell(data.summary.payment_amount),
      gap_row(2, dimensions.summary_rule_padding),
      table.hline(stroke: strokes.thin),
      gap_row(2, dimensions.summary_rule_padding),
      text_cell(data.summary.balance_label, weight: "bold"),
      text_cell(data.summary.balance_amount),
      gap_row(2, dimensions.summary_rule_padding),
      table.hline(stroke: strokes.thin),
      gap_row(2, dimensions.summary_double_rule_gap),
      table.hline(stroke: strokes.thin),
    ),
  ),
)

#let render_payment_instructions(data) = [
  #text(size: typography.section_title_size, weight: "bold")[#data.payment.title] \
  #text(weight: "bold")[#data.payment.transfer_label] \
  #data.payment.transfer_value \
  #text(weight: "bold")[#data.payment.paypal_label] \
  #link(data.payment.paypal_url)[
    #text(fill: palette.link)[#data.payment.paypal_text]
  ]
]

#let render_invoice(data) = {
  set page(paper: page_settings.paper, margin: page_settings.margin)
  set text(font: typography.font, size: typography.body_size, fill: palette.text)

  render_header(data)
  v(dimensions.header_gap)
  render_bill_to(data)
  v(dimensions.bill_to_section_gap)
  render_table(data)
  v(dimensions.table_summary_gap)
  render_summary(data)
  v(dimensions.summary_payment_gap)
  render_payment_instructions(data)
}
