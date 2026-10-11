// This was just an LLM workaround to issues between math and text mode formatting I kept running into.
// If someone has a better idea, let me know.
#let money(n) = {
  let rounded = calc.round(n * 100) / 100
  let s = str(rounded)

  if s.contains(".") {
    let parts = s.split(".")
    let frac = parts.at(1)
    if frac.len() == 1 {
      "$" + s + "0"
    } else {
      "$" + s
    }
  } else {
    "$" + s + ".00"
  }
}

#let conf(
  title: "Invoice",
  date: none,
  invoice: (),
  services: (),
  materials: (),
  abstract: [],
  doc,
) = {
  // Document formatting and logo.
  set page(
    paper: "us-letter",
    header: grid(
      columns: (1fr, 1fr),
      align(left + horizon, image("../logo.png", width: 50%)), align(right + horizon)[#title],
    ),
    margin: (top: 1.25in, rest: .25in),
  )
  set par(justify: true)
  set text(font: "Noto Sans", size: 10pt)

  // Biller and client information in header.
  place(
    top,
    float: true,
    scope: "parent",
    clearance: 2em,
    {
      let count = invoice.len()
      let ncols = calc.min(count, 3)

      block(text(weight: "bold", date))
      v(1em)

      grid(
        columns: (1fr,) * ncols,
        row-gutter: 24pt,
        ..invoice
          .enumerate()
          .map(((i, inv)) => [
            #text(weight: "bold", if i == 0 [Recipient] else if i == 1 [Contractor] else [Contact]) \
            #inv.name \
            #inv.business \
            #link("mailto:" + inv.email) \
            #link("tel:" + inv.phone)
          ]),
      )

      v(1em)
      par(justify: false)[
        *Description* \
        #abstract
      ]

      // Calculate service and material totals.
      let service_total = services.map(i => i.hours * i.rate).sum(default: 0)
      let material_total = materials.map(m => m.rate).sum(default: 0)
      v(1em)
      // Handle service table.
      if services.len() > 0 {
        table(
          columns: (1fr, auto, auto),
          inset: 10pt,
          fill: (col, row) => if row > 0 and calc.even(row) { luma(95%) } else { white },
          stroke: (x, y) => if y == 0 { (bottom: 1pt + black) } else { (bottom: 0.5pt + gray) },
          align: (left, center, right),

          [*Service Rendered*], [*Hours*], [*Total*],

          ..services
            .map(service => (
              service.service,
              str(service.hours),
              money(service.hours * service.rate),
            ))
            .flatten(),

          table.cell(colspan: 2, align: right)[*Total:*],
          [*#money(service_total)*],
        )
      }
      v(1em)
      // Handle materials table.
      if materials.len() > 0 {
        table(
          columns: (1fr, auto),
          inset: 10pt,
          fill: (col, row) => if row > 0 and calc.even(row) { luma(95%) } else { white },
          stroke: (x, y) => if y == 0 { (bottom: 1pt + black) } else { (bottom: 0.5pt + gray) },
          align: (left, center, right),

          [*Materials*], [*Total*],

          ..materials
            .map(material => (
              material.item,
              money(material.rate),
            ))
            .flatten(),

          table.cell(colspan: 1, align: right)[*Total:*],
          [*#money(material_total)*],
        )
      }

      // Display grand total.
      v(1em)
      align(right)[
        #block(width: 30%)[
          #set align(left)
          #grid(
            columns: (1fr, auto),
            gutter: 1em,
            [*Grand Total:*], [#text(size: 1.2em)[*#money(service_total + material_total)*]],
          )
          #line(length: 100%, stroke: 1.5pt)
        ]
      ]
    },
  )

  doc
}
