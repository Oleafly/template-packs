#import "./subject.typ": palette, soft-card, subject-slide

#let subject-title-card(
  title: none,
  subtitle: none,
  fill: palette.card,
  stroke: none,
  inset: (x: 0.95em, y: 0.38em),
  height: 3.8em,
  title-size: 1.48em,
  title-weight: "bold",
  title-fill: palette.ink,
  page-center-offset: 0pt,
) = soft-card(
  inset: inset,
  height: height,
  fill: fill,
  stroke: stroke,
)[
  #if title != none [
    #block(width: 100%, height: 100%)[
      #place(
        center + horizon,
        dx: -page-center-offset / 2,
        block(width: 100% - page-center-offset, height: 100%)[
          #align(center + horizon)[
            #set text(top-edge: "bounds", bottom-edge: "bounds")
            #block(width: 100%)[
              #set align(center)
              #text(size: title-size, weight: title-weight, fill: title-fill)[#title]
            ]
          ]
        ],
      )
    ]
  ]
]

#let subject-content-card(
  body,
  fill: palette.card,
  stroke: none,
) = soft-card(
  fill: fill,
  stroke: stroke,
  inset: 0.95em,
  width: 100%,
  height: 100%,
)[
  #body
]

#let subject-summary-card(
  body: [],
  height: 2.35em,
  fill: palette.card,
  stroke: none,
  inset: (x: 0.95em, y: 0.58em),
  text-size: 0.78em,
  text-fill: palette.muted,
  text-leading: 0.5em,
) = soft-card(
  fill: fill,
  stroke: stroke,
  inset: inset,
  width: 100%,
  height: height,
)[
  #align(center + horizon)[
    #block(width: 100%)[
      #set align(center)
      #set text(size: text-size, fill: text-fill)
      #set par(leading: text-leading)
      #body
    ]
  ]
]

#let subject-shell(
  title: none,
  subtitle: none,
  top-content: [],
  body: [],
  header-left-offset: 0pt,
  body-gap: 0.58em,
  inner-gap: 0.58em,
  top-card-height: 2.35em,
  title-card-fill: palette.card,
  title-card-stroke: none,
  title-card-inset: (x: 0.95em, y: 0.38em),
  title-card-height: 3.8em,
  title-size: 1.48em,
  title-weight: "bold",
  title-fill: palette.ink,
  summary-card-fill: palette.card,
  summary-card-stroke: none,
  summary-card-inset: (x: 0.95em, y: 0.58em),
  top-content-size: 0.78em,
  top-content-fill: palette.muted,
  top-content-leading: 0.5em,
  content-card-fill: palette.card,
  content-card-stroke: none,
) = subject-slide(
  title: auto,
  content: [
    #block(width: 100%, height: 100%)[
      #grid(
        rows: (auto, 1fr),
        row-gutter: body-gap,
        [
          #if title != none or subtitle != none [
            #block(width: 100%, inset: (left: header-left-offset))[
              #subject-title-card(
                title: title,
                subtitle: subtitle,
                fill: title-card-fill,
                stroke: title-card-stroke,
                inset: title-card-inset,
                height: title-card-height,
                title-size: title-size,
                title-weight: title-weight,
                title-fill: title-fill,
                page-center-offset: header-left-offset,
              )
            ]
          ]
        ],
        [
          #grid(
            rows: (top-card-height, 1fr),
            row-gutter: inner-gap,
            [
              #subject-summary-card(
                body: top-content,
                height: top-card-height,
                fill: summary-card-fill,
                stroke: summary-card-stroke,
                inset: summary-card-inset,
                text-size: top-content-size,
                text-fill: top-content-fill,
                text-leading: top-content-leading,
              )
            ],
            [
              #subject-content-card(
                fill: content-card-fill,
                stroke: content-card-stroke,
              )[#body]
            ],
          )
        ],
      )
    ]
  ],
)

#let subject-content-page(
  title: none,
  subtitle: none,
  top-content: [],
  content: [],
  header-left-offset: 0pt,
  body-gap: 0.58em,
  inner-gap: 0.58em,
  top-card-height: 2.35em,
  title-card-fill: palette.card,
  title-card-stroke: none,
  title-card-inset: (x: 0.95em, y: 0.38em),
  title-card-height: 3.8em,
  title-size: 1.48em,
  title-weight: "bold",
  title-fill: palette.ink,
  summary-card-fill: palette.card,
  summary-card-stroke: none,
  summary-card-inset: (x: 0.95em, y: 0.58em),
  top-content-size: 0.78em,
  top-content-fill: palette.muted,
  top-content-leading: 0.5em,
  content-card-fill: palette.card,
  content-card-stroke: none,
  content-text-size: 0.82em,
  content-text-fill: palette.ink,
  content-text-leading: 0.62em,
) = subject-shell(
  title: title,
  subtitle: subtitle,
  top-content: top-content,
  header-left-offset: header-left-offset,
  body-gap: body-gap,
  inner-gap: inner-gap,
  top-card-height: top-card-height,
  title-card-fill: title-card-fill,
  title-card-stroke: title-card-stroke,
  title-card-inset: title-card-inset,
  title-card-height: title-card-height,
  title-size: title-size,
  title-weight: title-weight,
  title-fill: title-fill,
  summary-card-fill: summary-card-fill,
  summary-card-stroke: summary-card-stroke,
  summary-card-inset: summary-card-inset,
  top-content-size: top-content-size,
  top-content-fill: top-content-fill,
  top-content-leading: top-content-leading,
  content-card-fill: content-card-fill,
  content-card-stroke: content-card-stroke,
  body: [
    #set text(size: content-text-size, fill: content-text-fill)
    #set par(leading: content-text-leading)
    #content
  ],
)
