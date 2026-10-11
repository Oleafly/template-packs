#import "../globals.typ": lightblue, lighterblue, mainblue

#let analyse_function_table(
  title1: [Rückgabetyp],
  title2: [Methode],
  title3: [Beschreibung],
  ..rows,
) = table(
  columns: (auto, auto, auto),
  stroke: none,
  inset: 6pt,
  align: (left, left, left),
  fill: (x, y) => if y == 0 { mainblue } else if calc.odd(y) { lighterblue } else { lightblue },

  table.header(
    table.cell(fill: mainblue)[#text(weight: "bold")[#title1]],
    table.cell(fill: mainblue)[#text(weight: "bold")[#title2]],
    table.cell(fill: mainblue)[#text(weight: "bold")[#title3]],
  ),

  ..rows,
)

#let analyse_attribute_table(
  title1: [Datentyp],
  title2: [Attribut],
  title3: [Beschreibung],
  ..rows,
) = table(
  columns: (auto, 1fr, 1.6fr),
  stroke: none,
  inset: 6pt,
  align: (left, left, left),
  fill: (x, y) => if y == 0 { mainblue } else if calc.odd(y) { lighterblue } else { lightblue },

  table.header(
    table.cell(fill: mainblue)[#text(weight: "bold")[#title1]],
    table.cell(fill: mainblue)[#text(weight: "bold")[#title2]],
    table.cell(fill: mainblue)[#text(weight: "bold")[#title3]],
  ),

  ..rows,
)
