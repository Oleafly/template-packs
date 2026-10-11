#import "@preview/fletcher:0.5.8" as fletcher: edge, node
// === Diagramms ===
// schraffieren
#let hatch(color) = tiling(size: (5pt, 5pt))[
  #place(line(start: (0%, 100%), end: (100%, 0%), stroke: 1pt + color))
]

// normal diagramm node (htw-color scheme)
#let blob(pos, label, tint: rgb("FFDD00"), width: 25mm, ..args) = node(
  pos,
  align(center, label),
  width: width,
  fill: tint.lighten(60%),
  stroke: 1pt + tint,
  corner-radius: 5pt,
  ..args,
)



// Classdiagrtamm UML
#let uml-class(pos, name, attr: none, meth: none, ..args) = node(
  pos,
  // Wir nutzen eine Tabelle für die klassischen UML-Trennlinien
  table(
    columns: 1,
    stroke: (x, y) => if y > 0 { (top: 0.5pt + luma(150)) } else { none },
    inset: 8pt,
    align: left,
    fill: none,

    // Name (zentriert und fett)
    align(center)[*#name*],

    // Attribute
    if attr != none { attr } else { v(0pt) },

    // Methoden
    if meth != none { meth } else { v(0pt) },
  ),
  shape: rect,
  fill: rgb("BDC1D0"),
  stroke: 1pt + black,
  corner-radius: 3pt,
  inset: 0pt,
  width: 4cm,
  ..args,
)

#let uml-interface(pos, name, attr: none, meth: none, ..args) = uml-class(
  pos,
  [<<Interface>> \ #name],
  attr: attr,
  meth: meth,
  fill: rgb("BDC1D0"),
  stroke: 1pt + black,
  ..args,
)

#let record(pos, label, ..args) = node(
  pos,
  align(center)[<<Record>> \ *#label*],
  fill: rgb("BDC1D0"),
  stroke: 1pt + black,
  corner-radius: 3pt,
  ..args,
)
