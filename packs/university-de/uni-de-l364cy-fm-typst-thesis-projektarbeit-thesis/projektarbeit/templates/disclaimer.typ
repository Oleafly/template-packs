#let disclaimer(
  title: "",
  degree: "",
  author: "",
  location: "",
  submissionDate: none,
) = {
  set document(title: title, author: author)  
  set page(
    margin: (left: 30mm, right: 30mm, top: 40mm, bottom: 40mm),
    numbering: none,
    number-align: center,
  )

  let body-font = "Source Sans Pro"
  let sans-font = "Source Sans Pro"

  set text(
    font: body-font, 
    size: 12pt, 
    lang: "de"
  )

  set par(leading: 1em)

  
  // --- Disclaimer ---
  v(70%)
  text(
"Hiermit erkläre ich, dass ich die vorliegende Arbeit selbstständig verfasst und keine anderen als die angegebenen Quellen und Hilfsmittel benutzt habe.

Alle sinngemäß und wörtlich übernommenen Textstellen aus fremden Quellen wurden kenntlich gemacht.")

  v(15mm)
  grid(
      columns: 2,
      gutter: 1fr,
      location + ", " + submissionDate, author
  )

  pagebreak()
}
