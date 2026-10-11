#import "styles.typ": burgundy, line-gray, muted, navy, paper-gray

#let tracking-label(body) = text(
  size: 10pt,
  weight: "bold",
  tracking: 1.4pt,
  fill: burgundy,
)[
  #body
]

#let info-card(label, primary, secondary: none, height: 30mm, inset-y: 4.5mm) = block(
  width: 100%,
  height: height,
  fill: paper-gray,
  stroke: 0.55pt + line-gray,
  radius: 2.5mm,
  inset: (
    x: 6mm,
    y: inset-y,
  ),
)[
  #grid(
    columns: (1.5mm, 1fr),
    column-gutter: 4mm,
    rect(
      width: 1.2mm,
      height: 8mm,
      fill: burgundy,
      radius: 0.6mm,
    ),
    [
      #tracking-label(label)
      #v(0.0mm)

      #text(
        size: 10.5pt,
        weight: "bold",
        fill: navy,
      )[
        #primary
      ]

      #if secondary != none [
        #v(0mm)
        #text(
          size: 8.3pt,
          fill: muted,
        )[
          #secondary
        ]
      ]
    ],
  )
]
