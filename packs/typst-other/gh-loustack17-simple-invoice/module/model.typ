#let fmt_currency(n) = {
  let cents = calc.round(n * 100)
  let sign = if cents < 0 { "-" } else { "" }
  let abs_cents = int(calc.abs(cents))
  let whole = calc.quo(abs_cents, 100)
  let frac = calc.rem(abs_cents, 100)
  let frac_str = if frac < 10 { "0" + str(frac) } else { str(frac) }
  sign + "$" + str(whole) + "." + frac_str
}

#let resolve_date(meta) = {
  let override = meta.at("date_override", default: none)
  if override == none {
    upper(datetime.today().display("[month repr:long] [day], [year]"))
  } else {
    override
  }
}

#let service_amount(service) = service.rate * service.quantity - service.discount

#let service_row(service) = (
  kind: "service",
  service: service.description,
  rate: fmt_currency(service.rate) + " / " + service.rate_unit,
  quantity: str(service.quantity),
  discount: fmt_currency(service.discount),
  payment_due: if service.at("details", default: ()).len() == 0 {
    fmt_currency(service_amount(service))
  } else {
    none
  },
)

#let detail_row(detail, rate, marker) = (
  kind: "detail",
  service: marker + " " + detail.text,
  rate: none,
  quantity: str(detail.quantity),
  discount: none,
  payment_due: fmt_currency(rate * detail.quantity),
)

#let service_rows(service, marker) = (
  service_row(service),
  ..service.at("details", default: ()).map(d => detail_row(d, service.rate, marker)),
)

#let build_table_rows(table_data) = {
  table_data.services
    .map(service => service_rows(service, table_data.detail_marker))
    .flatten()
}

#let calc_total(services) = {
  services.map(service_amount).sum(default: 0)
}

#let build_invoice_view(data) = {
  let total = calc_total(data.table.services)
  let balance = total - data.summary.payment_amount
  (
    ..data,
    meta: (
      ..data.meta,
      date_value: resolve_date(data.meta),
    ),
    table: (
      ..data.table,
      rows: build_table_rows(data.table),
    ),
    summary: (
      total_label: data.summary.total_label,
      total_amount: fmt_currency(total),
      payment_label: data.summary.payment_label,
      payment_amount: fmt_currency(data.summary.payment_amount),
      balance_label: data.summary.balance_label,
      balance_amount: fmt_currency(balance),
    ),
  )
}
