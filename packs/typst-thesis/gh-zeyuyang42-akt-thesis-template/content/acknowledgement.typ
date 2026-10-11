#import "../metadata.typ": body-font, sans-font

#let acknowledgement() = {
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

  // --- Acknowledgements ---
  align(left, text(font: sans-font, 2em, weight: 700, "Acknowledgements"))
  v(10mm)

  // Replace the placeholder text below with your acknowledgements.
  text[
    #lorem(40)

    #lorem(30)
  ]
}
