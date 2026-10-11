// Polish locale (pl-PL) for invoice-pro
#import "@preview/invoice-pro:0.4.0": locale, tax

// Polish language translations
#let pl-lang = (
  meta: (
    lang: "pl",
  ),
  document: (
    invoice: "Faktura",
  ),
  address: (
    recipient: "Odbiorca",
    sender: "Sprzedawca",
  ),
  reference: (
    tax-number: "NIP",
    invoice-number: "Numer faktury",
    vat-id: "NIP UE",
  ),
  line-items: (
    position: "Lp.",
    description: "Opis",
    quantity: "Ilość",
    unit-price: "Cena jedn.",
    price: "Cena",
    total: "Wartość",
    vat: "VAT",
    net: "Netto",
    gross: "Brutto",
    discount: "Rabat",
    surcharge: "Dopłata",
    subtotal: "Suma częściowa",
  ),
  summary: (
    sum: "Razem netto",
    vat-tax: "podatek VAT",
    total: "Do zapłaty",
    including: "W tym",
    excluding: "bez VAT",
  ),
  global-info: (
    tax-statement: (tax-text, rate, vat-tax) => {
      [#tax-text #rate #vat-tax]
    },
    unit: "jedn.",
    quantity: "ilość",
    date: "data",
  ),
  units: (
    piece: "szt.",
    "set": "zestaw",
    pair: "para",
    lump-sum: "ryczałt",
    hour: "godz.",
    day: "dzień",
    month: "mies.",
    year: "rok",
    kilogram: "kg",
    gram: "g",
    tonne: "t",
    metre: "m",
    square-metre: "m²",
    millimetre: "mm",
    centimetre: "cm",
    kilometre: "km",
    litre: "l",
    cubic-metre: "m³",
  ),
  bank-details: (
    account-holder: "Właściciel rachunku",
    bank: "Bank",
    iban: "IBAN",
    bic: "BIC",
    reference: "Tytuł przelewu",
  ),
  payment: (
    text: (sum, deadline) => [Prosimy o zapłatę #sum w terminie #deadline.],
    deadline-date: (date) => [do #date],
    deadline-days: (days) => {
      if days == 1 {
        "w ciągu 1 dnia"
      } else {
        "w ciągu " + str(days) + " dni"
      }
    },
    deadline-soon: "płatne natychmiast",
  ),
  signature: (
    closing: "Z poważaniem",
  ),
  legal: (
    vat-exemption: "Zwolnienie z podatku VAT",
  ),
  errors: (
    name-missing: "Brak nazwy",
    address-missing: "Brak adresu",
    city-missing: "Brak miejscowości",
    ambiguous-tax: "Niejednoznaczna stawka VAT",
    invalid-tax: "Nieprawidłowa stawka VAT",
  ),
)

// Polish region builder
#let region-pl = (lang) => (
  meta: (
    region: "pl",
  ),
  currency: (
    code: "PLN",
    symbol: "zł",
    decimals: 2,
    decimals-fine: 2,
  ),
  normalize: (
    money: (val) => calc.round(val, digits: 2),
    money-fine: (val) => calc.round(val, digits: 2),
    infer-tax: (rate) => tax.vat(rate),
  ),
  format: (
    percent: (val) => {
      str(calc.round(val * 100, digits: 1)).replace(".", ",") + "%"
    },
    number: (val) => {
      let pad = (s, n) => {
        if s.len() >= n { s } else { "0" * (n - s.len()) + s }
      }
      let parts = str(calc.round(val, digits: 2)).split(".")
      let int = parts.at(0)
      let dec = if parts.len() > 1 {
        pad(parts.at(1), 2)
      } else {
        "00"
      }
      let fmt-int = (int-part) => {
        let result = ""
        let chars = int-part.len()
        for j in range(chars) {
          let pos = chars - j
          if j > 0 and calc.rem(pos, 3) == 0 {
            result += "\u{00A0}"
          }
          result += int-part.at(j)
        }
        result
      }
      fmt-int(int) + "," + dec
    },
    currency: (val) => {
      let pad = (s, n) => {
        if s.len() >= n { s } else { "0" * (n - s.len()) + s }
      }
      let rounded = calc.round(val, digits: 2)
      let parts = str(rounded).split(".")
      let int = parts.at(0)
      let dec = if parts.len() > 1 {
        pad(parts.at(1), 2)
      } else {
        "00"
      }
      let fmt-int = (int-part) => {
        let result = ""
        let chars = int-part.len()
        for j in range(chars) {
          let pos = chars - j
          if j > 0 and calc.rem(pos, 3) == 0 {
            result += "\u{00A0}"
          }
          result += int-part.at(j)
        }
        result
      }
      fmt-int(int) + "," + dec + "\u{00A0}zł"
    },
    currency-fine: (val) => {
      let pad = (s, n) => {
        if s.len() >= n { s } else { "0" * (n - s.len()) + s }
      }
      let rounded = calc.round(val, digits: 2)
      let parts = str(rounded).split(".")
      let int = parts.at(0)
      let dec = if parts.len() > 1 {
        pad(parts.at(1), 2)
      } else {
        "00"
      }
      let fmt-int = (int-part) => {
        let result = ""
        let chars = int-part.len()
        for j in range(chars) {
          let pos = chars - j
          if j > 0 and calc.rem(pos, 3) == 0 {
            result += "\u{00A0}"
          }
          result += int-part.at(j)
        }
        result
      }
      fmt-int(int) + "," + dec + "\u{00A0}zł"
    },
    date: (val) => {
      if val == none {
        "—"
      } else if type(val) == datetime {
        val.display("[day].[month].[year]")
      } else {
        val.first().display("[day].[month].[year]") + " – " + val.last().display("[day].[month].[year]")
      }
    },
    time: (val) => val.display("[hour]:[minute]"),
  ),
  tax: (
    default-vat: tax.vat(23%),
  ),
)

// Build and export the locale
#let pl-pl = locale.build-locale(pl-lang, region-pl)
