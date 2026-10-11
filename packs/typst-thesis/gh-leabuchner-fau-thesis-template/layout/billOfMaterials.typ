#import "/layout/fonts.typ": *

#let billOfMaterials(
    body: "",
 ) = {

  set page(
    margin: (left: 30mm, right: 30mm, top: 40mm, bottom: 40mm),
    numbering: none,
    number-align: center,
  )

  set text(
    font: fonts.body,
    size: 11pt,
  )

  set par(
    leading: 1em,
    justify: true
  )

  // --- Bill Of Materials ---

        align(left, text(font: fonts.sans, size: 1em, weight: "regular", body))
    v(10mm)
}