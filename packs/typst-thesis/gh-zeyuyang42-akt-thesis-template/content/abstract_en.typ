#import "../metadata.typ": body-font, sans-font

#let abstract_en() = {
  set page(
    margin: (left: 30mm, right: 30mm, top: 40mm, bottom: 40mm),
    numbering: "I",
    number-align: center,
  )

  set text(
    font: body-font,
    size: 12pt,
    lang: "en"
  )

  set par(
    leading: 1em,
    justify: true
  )

  // --- Abstract (EN) ---
  align(left, text(font: sans-font, 2em, weight: 700, "Abstract"))
  v(10mm)

  // Replace the placeholder text below with your English abstract.
  text[
    #lorem(50)

    #lorem(40)

    #lorem(35)
  ]

  v(1fr)
}
