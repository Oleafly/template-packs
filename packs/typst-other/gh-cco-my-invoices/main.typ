#import "/templates/invoice.typ": conf
// Set your date, invoice numbering, and work description here.
#let invoice_date = "02-04-2026"
#let invoice_number = "INV-26-A0001"
#let work_summary = "Project work for the Q1 system migration."


#show: doc => conf(
  title: invoice_number,
  date: invoice_date,
  abstract: work_summary,
  // Add your billing and client information.
  invoice: (
    (
      name: "Jane Doe",
      business: "Big Brain Industries LLC",
      email: "jane@bigbrainindustries.com",
      phone: "123-456-7890",
    ),
    (
      name: "John Smith",
      business: "Smug Cat Law Firm", 
      email: "john@smugcatlawfirm.com", 
      phone: "123-456-7890"
    ),
  ),
  // Add your services.
  services: (
    (service: "Database Migration.", hours: 6, rate: 80),
    (service: "Inventory Cleanup.", hours: 3, rate: 80),
    (service: "Deploy RMM tooling.", hours: 2, rate: 80),
  ),
  // Add your materials. You can remove these entries and the document will render w/o them.
  materials: (
    (item: "CAT6", rate: 123.45),
    (item: "UPS Battery", rate: 123.45),
  ),
  doc,
)

// Payment terms etc.
== Terms and Conditions
#lorem(150)
