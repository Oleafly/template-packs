// =============================================================================
// ABKUERZUNGEN
//
// Verwendung im Fliesstext (nach Import von glossarium):
//   #gls("API")    -> beim ersten Auftreten Langform, danach Kurzform
//   #glspl("API")  -> Pluralform
//
// Die Liste wird in main.typ registriert und im Abkuerzungsverzeichnis
// alphabetisch nach Kurzform ausgegeben.
// =============================================================================

#let entry-list = (
  (key: "API", short: "API", long: "Application Programming Interface",
   plural: "APIs", longplural: "Application Programming Interfaces"),
  (key: "HTML", short: "HTML", long: "Hypertext Markup Language"),
  (key: "PDF", short: "PDF", long: "Portable Document Format"),
)
