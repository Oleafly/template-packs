#import "@preview/invoice-pro:0.4.0": *

#import "typst/locale-pl.typ": pl-pl
#import "typst/logo.typ": logo-it

#show: invoice.with(
  theme: themes.DIN-5008(form: "B"),
  locale: pl-pl,
  sender: (
    name: "Your Company / Name",
    address: "1 Example Street",
    city: "12345 Example City",
    tax-nr: "123/456/789",
  ),
  recipient: (
    name: "Customer Name",
    address: "5 Customer Street",
    city: "98765 Customer City",
  ),
  invoice-nr: "2026-01",
  tax-mode: "inclusive",
)

// Place logo. Set path: none to disable
#logo-it(
  img: image("assets/img/logo.svg", width: 1.5cm),
  corner: top + left,
  offset: (x: 0cm, y: 1cm)
)

// Add Invoice Items inside a scoped block
#line-items[
  #item(
    [Consulting & Concept],
    price: 85.00,
    quantity: 5,
    unit: "hrs"
  )

  #item(
    [Web Design Layout (Flat Rate)],
    price: 1200.00,
  )

  #item(
    [Stock Licenses (Images)],
    price: 25.00,
    quantity: 4,
  )

  #discount([Project Discount (Regular Customer)], amount: 10%)
]

// Payment Terms
#payment-goal(days: 14)

// Bank Details with QR Code
#bank-details(
  bank: "Example Bank",
  iban: "DE07100202005821158846",
  bic: "EXAMPLEBICX",
)

#signature()
