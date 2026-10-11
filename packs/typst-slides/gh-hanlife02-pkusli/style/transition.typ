#import "./subject/subject.typ": palette, subject-slide
#import "./shared/base.typ": soft-card

#let transition-page(
  title: none,
  description: none,
  number: [01],
  marker: [PART],
  left-width: 14.2em,
  column-gap: 1.6em,
  left-card-height: 20em,
  right-card-height: 20em,
  left-card-dx: 0pt,
  left-card-dy: 0pt,
  right-card-dx: 0pt,
  right-card-dy: 0pt,
  left-card-fill: none,
  right-card-fill: none,
  marker-size: 4.2em,
  marker-fill: palette.ink.transparentize(28%),
  number-size: 3.1em,
  number-fill: palette.primary,
  title-size: 2.45em,
  title-fill: palette.ink,
  title-leading: 0.72em,
  description-size: 1.02em,
  description-fill: palette.muted,
  description-width: 84%,
  description-gap: 0.38em,
) = subject-slide(
  title: auto,
  content: [
    #block(width: 100%, height: 100%)[
      #align(center + horizon)[
        #grid(
          columns: (left-width, 1fr),
          column-gutter: column-gap,
          [
            #block(width: 100%, height: left-card-height)[
              #place(
                center + horizon,
                dx: left-card-dx,
                dy: left-card-dy,
                soft-card(
                  inset: (x: 0.9em, y: 0.85em),
                  width: 100%,
                  height: left-card-height,
                  fill: left-card-fill,
                )[
                  #block(width: 100%, height: 100%)[
                    #align(center + horizon)[
                      #set align(center + horizon)
                      #text(size: marker-size, weight: "bold", fill: marker-fill)[#marker]
                      #v(-2.32em)
                      #text(size: number-size, weight: "bold", fill: number-fill)[#number]
                    ]
                  ]
                ],
              )
            ]
          ],
          [
            #block(width: 100%, height: right-card-height)[
              #place(
                center + horizon,
                dx: right-card-dx,
                dy: right-card-dy,
                soft-card(
                  inset: (x: 1.35em, y: 1.1em),
                  width: 100%,
                  height: right-card-height,
                  fill: right-card-fill,
                )[
                  #block(width: 100%, height: 100%)[
                    #align(left + horizon)[
                      #set par(leading: title-leading)
                      #text(size: title-size, weight: "bold", fill: title-fill)[#title]
                      #if description != none [
                        #v(description-gap)
                        #block(width: description-width)[
                          #set text(size: description-size, fill: description-fill)
                          #description
                        ]
                      ]
                    ]
                  ]
                ],
              )
            ]
          ],
        )
      ]
    ]
  ],
)
