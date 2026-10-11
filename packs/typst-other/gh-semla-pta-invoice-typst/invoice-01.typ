#set page("a4")

// Parse an amount string that may be like "3900.00 SEK", "€3,900.00", or "3900,00 €"
#let parse-money = (s) => {
  // Handle empty or invalid input
  if s == none or s == "" {
    return (amount: 0.0, currency: "")
  }
  
  // Normalize whitespace
  let t = s.trim()
  
  // Handle empty string after trim
  if t == "" {
    return (amount: 0.0, currency: "")
  }

  // If there's an internal space, assume suffix currency like "3900.00 SEK"
  if t.contains(" ") {
    let parts = t.split(" ")
    // amount may include grouping commas; remove them
    let amount-str = parts.slice(0, parts.len() - 1).join(" ").replace(",", "")
    let currency = parts.last()
    if amount-str == "" {
      (amount: 0.0, currency: currency)
    } else {
      (amount: float(amount-str), currency: currency)
    }
  } else {
    // No space – handle prefix/suffix symbol (€, $, etc.)
    // Find first/last digit to isolate the numeric part
    let digits = "0123456789"
    let first = 0
    while first < t.len() {
      if digits.contains(t.at(first)) { break }
      first += 1
    }
    let last = t.len() - 1
    while last >= 0 {
      if digits.contains(t.at(last)) { break }
      last -= 1
    }

    if first == 0 and last == t.len() - 1 {
      // Pure numeric – no currency
      let clean-amount = t.replace(",", "")
      if clean-amount == "" {
        (amount: 0.0, currency: "")
      } else {
        (amount: float(clean-amount), currency: "")
      }
    } else {
      let amount-str = t.slice(first, last + 1).replace(",", "")
      let prefix = t.slice(0, first).trim()
      let suffix = t.slice(last + 1).trim()
      let currency = if suffix.len() > 0 { suffix } else { prefix }
      if amount-str == "" {
        (amount: 0.0, currency: currency)
      } else {
        (amount: float(amount-str), currency: currency)
      }
    }
  }
}

#let static_data = toml("static_data.toml")
#let client_data = toml("clients.toml")

// Infer format from file extension
#let balance_file_path = static_data.invoice.data_dir + "/" + static_data.invoice.balance_file
#let report_file_path = static_data.invoice.data_dir + "/" + static_data.invoice.report_file

#let balance_from_pta_export = if balance_file_path.ends-with(".csv") {
  csv(balance_file_path)
} else {
  json(balance_file_path)
}

#let report_from_pta_export = if report_file_path.ends-with(".csv") {
  csv(report_file_path)
} else {
  json(report_file_path)
}

// Extract individual amounts from balance data for totals section
#let net_amount = 0
#let vat_amount = none
#let total_amount = none
#let currency = ""

#if balance_file_path.ends-with(".csv") {
  // CSV format: parse each account row
  if type(balance_from_pta_export) == array and balance_from_pta_export.len() > 1 {
    // Skip header row (first row) by using slice(1)
    for row in balance_from_pta_export.slice(1) {
      let account = row.at(0)
      let parsed = parse-money(row.at(1))
      
      if account == "Total:" {
        total_amount = parsed.amount // Already positive with --invert
      } else if account.contains(static_data.VAT.hledger_account_name_for_vat) {
        vat_amount = parsed.amount // Already positive with --invert
      } else {
        // All other accounts are treated as revenue/net amount
        net_amount += parsed.amount // Already positive with --invert
        if currency == "" { currency = parsed.currency }
      }
    }
  }
}

// Legacy balance_data for compatibility
#let balance_data = "Not found or array empty"
#if balance_file_path.ends-with(".csv") {
  // For legacy compatibility, use total amount
  if total_amount != none {
    balance_data = ((delta: str(total_amount), commodity: currency),)
  }
} else {
  // JSON format (original tackler format)
  if "deltas" in balance_from_pta_export and type(balance_from_pta_export.deltas) == array and balance_from_pta_export.deltas.len() > 0 {
    balance_data = balance_from_pta_export.deltas
  }
}

#let registry_data = "Not found or array empty"
#if report_file_path.ends-with(".csv") {
  // CSV format: array of arrays, first row is header
  if type(report_from_pta_export) == array and report_from_pta_export.len() > 1 {
    // Convert CSV rows to structure compatible with existing code
    // CSV columns: "txnidx","date","code","description","account","amount","total"
    registry_data = report_from_pta_export.slice(1).map(row => {
      let parsed = parse-money(row.at(5)) // "amount" column
      let account = row.at(4) // account column
      let description = row.at(3) // original description
      
      // Use configurable VAT account and text
      let display_description = if account.contains(static_data.VAT.hledger_account_name_for_vat) {
        static_data.VAT.hledger_vat_text
      } else {
        description
      }
      
      (
        displayTime: row.at(1), // date
        txn: (description: display_description), // customized description
        postings: ((amount: str(parsed.amount), commodity: parsed.currency),) // amount
      )
    })
  }
} else {
  // JSON format (original tackler format)
  if "transactions" in report_from_pta_export and type(report_from_pta_export.transactions) == array and report_from_pta_export.transactions.len() > 0 {
    registry_data = report_from_pta_export.transactions
  }
}

#let invoice_date_str = datetime.today().display()


#if static_data.invoice.invoice_date.len() > 1 {
  invoice_date_str = static_data.invoice.invoice_date
}

#if static_data.sender.company_name.len() > 1 {
  static_data.invoice.invoice_title += " " +static_data.sender.company_name
}
#set page(
  header: [
    #static_data.invoice.invoice_title
    #h(1fr)
    #invoice_date_str
    #h(1fr)
    #context counter(page).display(
      "1/1",
      both: true,
    )
  ],
)

#set page(
  margin: (bottom: 8cm),
  footer: 
line(start:(-1cm, 0cm), end: (17cm, 0cm), stroke: (thickness: 0.1mm)) + block(
    width: 100%,
    inset: 0pt,
    grid(
      columns: (1fr, 1.4fr, 1.8fr),
      inset: 0pt,
      rect(fill: luma(245), inset: (x:2mm,y:3mm))[
        #static_data.sender.company_name \
        #static_data.sender.personal_name \
        #static_data.sender.address 
      ],

      rect(fill: luma(245),inset: (x:2mm,y:3mm))[
        #link("mailto:" + static_data.sender.email)[#static_data.sender.email] \
        #static_data.sender.phone \
        #link(static_data.sender.web)
      ],

       rect(fill: luma(245),inset: (x:2mm,y:3mm))[
        #for (key, value) in static_data.bank {
          strong(key) +": "+ value +"\n"
        }
       ]
    ),
  ),
)

#let client = client_data.clients.find(item => item.id == client_data.client_id_to_use)

// placement for sending a printed copy in a c5 envelope with "window" h2
#let address_placement_y = 44 - 25
// 297 / 2 + 83 + 25
#let address_placement_x = 114

#if static_data.sender.logo_path.len() > 1 {
  v(address_placement_y*1mm)
  image(static_data.sender.logo_path, alt:static_data.sender.company_name, fit: "contain")
} 




#place(
  top + left,
  dx: address_placement_x * 1mm,
  dy: address_placement_y * 1mm,
  [#client.name \
    #client.address],
)

// #let amount_str = invoice_tx.postings.find(item => item.account == static_data.invoice.account_name_for_amount).runningTotal
#let amount_str = balance_data.at(0).delta
#let amount = float(amount_str)
#let commodity = balance_data.at(0).commodity

/*
#let vat = 0

 #let vat_str = invoice_tx.postings.find(item => item.account == static_data.invoice.account_name_for_vat)
#if vat_str != none {
  // && if vat_str.amount != none {
  vat = float(vat_str.amount)
} 

#let total = amount + vat
*/
#align(horizon)[
    #for (key, value) in client {
      if(key != "id" and key != "name" and key != "address") {
          key +": "+ value +"\n"
        }
  }

    Invoice number: #static_data.invoice.invoice_number \
    Due date: #strong(static_data.invoice.due_date)
]


#align(horizon)[
== Specification
  #table(
    columns: 3,
    table.header([*Date*], [*Description*], [*Amount*]),
    //..invoice_tx.map(v => (v.displayTime,v.txn.description,v.postings.at(0).amount)),
         ..for (value) in registry_data {
      (value.displayTime, value.txn.description, value.postings.at(0).amount +" "+ value.postings.at(0).commodity)
    } 
  )
  
  #if net_amount != none and vat_amount != none and total_amount != none {
    v(0.5em)
    table(
      columns: (1fr, auto),
      stroke: none,
      align: (left, right),
      [#static_data.VAT.total_ex_vat:], [#str(net_amount) #currency],
      [#static_data.VAT.hledger_vat_text:], [#str(vat_amount) #currency],
      table.hline(),
      [*#static_data.invoice.total_word:*], [*#str(total_amount) #currency*],
    )
  }
]

// Push Summary to bottom of page above footer
#align(bottom)[
  #align(right)[
    #rect(fill: luma(245), inset: (x:2mm,y:3mm))[
      #align(left)[
        == Summary
        Total: #strong(amount_str) #strong(commodity) \
        Due date: #strong(static_data.invoice.due_date)
      ]
    ]
  ]
]

