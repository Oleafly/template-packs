#import "../translations.typ": translations

#let dark_blue = color.rgb(8, 31, 92)

#let linebreak_n(n) = {
  let i = 0
  while i < n {
    linebreak()
    i = i + 1
  }
}

#let blue_cell(content) = table.cell(
  fill: dark_blue,
  text(weight: "bold", fill: white, content),
)

#let cover(transfermodule-number, matriculation-number, transfermodule-topic, centurion) = {
  import "header.typ": header
  set page(
    header: header,
  )
  set text(font: "New Computer Modern Sans")

  text(weight: "bold", fill: dark_blue, size: 15pt)[#translations.cover-title #transfermodule-number]
  linebreak_n(2)
  table(
    columns: (1fr, 2fr),
    blue_cell([#translations.matriculation-number:#linebreak_n(2)]), str(matriculation-number),
    blue_cell([#translations.transfermodule-topic: #linebreak_n(5)]), transfermodule-topic,
    blue_cell([#translations.centurion:]), centurion,
  )
  
  pagebreak()
}
