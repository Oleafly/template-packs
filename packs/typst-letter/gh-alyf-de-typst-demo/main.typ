// 1) Load and parse JSON from doc.json
#let doc = json("doc.json")

// Access dictionary data with .at("key")
#let company = doc.at("company")
#let items = doc.at("items")

#set page(
  width: 210mm,
  height: 297mm,
  margin: (
    left: 25mm,
    right: 20mm,
    top: 45mm,
    bottom: 40mm,
  ),
  header: [
    #set align(right)
    #image("company-logo.png", width: 30mm)
  ],
  footer: context [
    #set text(8pt)
    #set align(right)
    Page #counter(page).display(
      "1 of 1",
      both: true,
    )
    #set align(left)
    #table(
      columns: (1fr, 1fr, 1fr),
      stroke: none,
      row-gutter: -.5em,
      company.at("name"),
      [Managing director:],
      company.at("bank_name"),
      company.at("address"),
      company.at("ceo"),
      company.at("iban"),
      [Phone: ] + company.at("phone"),
      [VAT ID.: ] + company.at("tax_id"),
      [BIC: ] + company.at("bic"),
      [Email: ] + company.at("email"),
      [Register Court: ] + company.at("register_court"),
      [Register Number: ] + company.at("register_number"),
    )
  ]
)

#set text(font: "DM Sans")

#let vcentered_text(chars) = text(
  baseline: -.5em,
  chars
)

// Folding mark (top)
#place(
  dy: 60mm,
  dx: -13%,
  vcentered_text([---]),
)

// Folding mark (center)
#place(
  dy: 148.5mm - 45mm,
  dx: -13%,
  vcentered_text([-]),
)

// Folding mark (bottom)
#place(
  dy: 160mm,
  dx: -13%,
  vcentered_text([---]),
)

#grid(
  columns: (3fr, 2fr),
  rows: (auto),
  grid(
    rows: auto,
    gutter: 1em,
    text(size: 6pt, company.at("name") + " - " + company.at("address")),
    doc.at("customer_name"),
    doc.at("address_display")
  ),
  table(
    stroke: none,
    columns: (1fr, 1fr),
    align: (left, right),
    text("Invoice Date:"), doc.at("invoice_date"),
    text("Due Date:"), doc.at("due_date"),
    text("Our VAT ID:"), company.at("tax_id"),
  )
)

#v(7.5em)

#text(
  weight: "bold",
  [Invoice No.] + " " + doc.at("invoice_number")
)
#v(1em)

Dear Sir or Madam

Please allow us to invoice our services as follows:

#v(1em)
#table(
  columns: (3fr, 1fr, 1fr, 1fr),
  align: (left, left, right, right),
  row-gutter: 1em,
  column-gutter: 0.5em,
  stroke: none,
  table.header(
  [*Description*], [*Qty*], [*Price*], [*Amount*]),
  table.hline(),
  ..items.map(
    row => (
      grid(
        gutter: 1em,
        text(weight: "bold", row.at("item_name")), row.at("description"),
      ),
      row.at("quantity"), row.at("unit_price"), row.at("line_amount")
    )
  ).flatten(),
)
#table(
  columns: (1fr, 1fr),
  align: (left, right),
  row-gutter: 0em,
  column-gutter: 0.5em,
  stroke: none,
  table.hline(),
  [*Net total*], doc.at("subtotal"),
  [*VAT*], doc.at("tax"),
  [*Grand total*], doc.at("total"),
  table.hline(),
)
