#import "styles.typ": (
  navy,
  burgundy,
  gold,
  muted,
  paper,
  pale-blue,
  line-gray,
)

#let tracking-label(body) = text(
  size: 7.2pt,
  weight: "bold",
  tracking: 1.2pt,
  fill: burgundy,
)[#body]

#let info-card(label, primary, secondary: none) = block(
  width: 100%,
  height: 30mm,
  fill: paper,
  stroke: 0.55pt + line-gray,
  radius: 2.5mm,
  inset: (x: 5mm, y: 4mm),
)[
  #grid(
    columns: (1.3mm, 1fr),
    column-gutter: 3.5mm,
    rect(
      width: 1.2mm,
      height: 9mm,
      fill: gold,
      radius: 0.6mm,
    ),
    [
      #tracking-label(label)
      #v(1.8mm)
      #text(
        size: 10pt,
        weight: "bold",
        fill: navy,
      )[#primary]

      #if secondary != none [
        #v(1mm)
        #text(
          size: 8pt,
          fill: muted,
        )[#secondary]
      ]
    ],
  )
]

#let note-box(title, body) = block(
  width: 100%,
  fill: pale-blue,
  stroke: (left: 2pt + navy),
  inset: 4.5mm,
  radius: (right: 2mm),
)[
  #text(weight: "bold", fill: navy)[#title]
  #v(1.5mm)
  #body
]

#let result-card(metric, value, detail) = block(
  width: 100%,
  fill: paper,
  stroke: 0.55pt + line-gray,
  radius: 2mm,
  inset: 4mm,
)[
  #text(size: 7.5pt, weight: "bold", fill: burgundy)[#upper(metric)]
  #v(1.5mm)
  #text(size: 17pt, weight: "bold", fill: navy)[#value]
  #v(1mm)
  #text(size: 8pt, fill: muted)[#detail]
]