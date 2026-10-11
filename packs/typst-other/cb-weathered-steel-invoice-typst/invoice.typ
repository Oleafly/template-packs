#import "./invoice-maker.typ": *
#import "./fixtures/billing.typ": *
#import "./fixtures/data.typ": *

#show: invoice.with(
  language: "en",
  invoice-id: "<Invoice-ID>",
  issuing-date: "2025-01-01",
  delivery-date: "2025-01-01",
  due-date: "2025-01-15",
  biller: biller,
  hourly-rate: 0.0,
  recipient: recipient,
  items: table-data,
  styling: ( font: none ),
)
