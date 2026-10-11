#let biller = (
    name: "<Biller Company Name>",
    title: "<Biller Company Type>",
    company: "<Biller Company Name>",
    // international bank account number + VAT ID, if applicable
    iban: "<IBAN>",
    vat-id: "<VAT-ID>",
    // bank routing + account number, if applicable
    routing-number: "<Routing>",
    account-number: "<Account>",
    address: (
      country: "<Country>",
      city: "<City>",
      postal-code: "<Postal-Code>",
      street: "<Street-Address>",
    ),
  )

#let recipient = (
    name: "<Recipient-Name>",
    title: "<Recipient-Title>",
    company: "<Recipient-Company>",
    // VAT ID, if applicable
    vat-id: "<VAT-ID>",
    address: (
      country: "<Country>",
      city: "<City>",
      postal-code: "<Postal-Code>",
      street: "<Street-Address>",
    )
  )
