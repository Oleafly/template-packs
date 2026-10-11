#import "/layout/fonts.typ": *

#let abstract(
    body: "",
    lang: "en"
 ) = {
  let title = (en: "Abstract", de: "Zusammenfassung")

  set page(
    margin: (left: 30mm, right: 30mm, top: 40mm, bottom: 40mm),
    numbering: none,
    number-align: center,
  )

  set text(
    font: fonts.body,
    size: 11pt,
    lang: lang
  )

  set par(
    leading: 1em,
    justify: true
  )

  // --- Abstract ---
  v(20mm)  // Top margin
      align(left, text(font: fonts.sans, size: 2.3em, weight: "semibold", title.at(lang)))
  v(10mm)
        align(left, text(font: fonts.sans, size: 1em, weight: "regular", body))
    v(10mm)
}