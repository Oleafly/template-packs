// Label sets, one per language.
//
// The template never contains a literal word. Every string a reader sees that
// is furniture rather than argument comes from here, which is what lets one
// `formal-doc` render an RTL Hebrew original and an LTR English translation
// with the same page geometry.
//
// `page-of` is a function rather than a format string because Hebrew puts the
// total in a construction ("עמוד 1 מתוך 5") that no printf-style template
// expresses without pulling the numerals apart.

#let he = (
  regards: "בכבוד רב,",
  id: "ת\"ז",
  phone: "טלפון",
  email: "דוא\"ל",
  address: "כתובת",
  ours: "אסמכתא",
  date: "תאריך",
  to: "אל",
  cc: "העתק",
  subject: "הנדון",
  enclosures: "מסמכים מצורפים",
  page-of: (n, total) => "עמוד " + str(n) + " מתוך " + str(total),
)

#let en = (
  regards: "Yours faithfully,",
  id: "ID",
  phone: "Telephone",
  email: "Email",
  address: "Address",
  ours: "Our ref.",
  date: "Date",
  to: "To",
  cc: "Copy",
  subject: "Re",
  enclosures: "Enclosures",
  page-of: (n, total) => "Page " + str(n) + " of " + str(total),
)
