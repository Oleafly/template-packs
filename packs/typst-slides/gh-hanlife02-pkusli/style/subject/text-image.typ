#import "./subject.typ": palette
#import "./content.typ": subject-shell

#let text-image-layout(
  ..image-args,
  text-body: [],
  image-caption: none,
  text-width: 1fr,
  image-width: 1fr,
  swap-sides: false,
  column-gap: 1.05em,
  image-max-width: 96%,
  image-max-height: 88%,
  image-caption-size: 0.58em,
  image-caption-fill: palette.muted,
  image-caption-leading: 0.52em,
  image-caption-gap: 0.12em,
  text-size: 0.9em,
  text-fill: palette.ink,
  text-leading: 0.62em,
) = block(width: 100%, height: 100%)[
  #let text-column = [
    #block(width: 100%, height: 100%)[
      #align(left + horizon)[
        #set text(size: text-size, fill: text-fill)
        #set par(leading: text-leading)
        #text-body
      ]
    ]
  ]

  #let image-column = [
    #block(width: 100%, height: 100%)[
      #grid(
        rows: if image-caption == none { (1fr,) } else { (1fr, auto) },
        row-gutter: if image-caption == none { 0pt } else { image-caption-gap },
        [
          #align(center + horizon)[
            #image(
              ..image-args,
              width: image-max-width,
              height: image-max-height,
              fit: "contain",
            )
          ]
        ],
        if image-caption != none [
          #set text(size: image-caption-size, fill: image-caption-fill)
          #set par(leading: image-caption-leading)
          #align(center + top)[#image-caption]
        ],
      )
    ]
  ]

  #grid(
    columns: if swap-sides {
      (image-width, text-width)
    } else {
      (text-width, image-width)
    },
    column-gutter: column-gap,
    if swap-sides { image-column } else { text-column },
    if swap-sides { text-column } else { image-column },
  )
]

#let subject-text-image-page(
  ..image-args,
  title: none,
  subtitle: none,
  top-content: [],
  text-body: [],
  image-caption: none,
  header-left-offset: 0pt,
  swap-sides: false,
  column-gap: 1.05em,
  text-width: 1fr,
  image-width: 1fr,
  image-max-width: 96%,
  image-max-height: 88%,
  image-caption-size: 0.58em,
  image-caption-fill: palette.muted,
  image-caption-leading: 0.52em,
  image-caption-gap: 0.12em,
  text-size: 0.9em,
  text-fill: palette.ink,
  text-leading: 0.62em,
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
    #text-image-layout(
      ..image-args,
      text-body: text-body,
      image-caption: image-caption,
      text-width: text-width,
      image-width: image-width,
      swap-sides: swap-sides,
      column-gap: column-gap,
      image-max-width: image-max-width,
      image-max-height: image-max-height,
      image-caption-size: image-caption-size,
      image-caption-fill: image-caption-fill,
      image-caption-leading: image-caption-leading,
      image-caption-gap: image-caption-gap,
      text-size: text-size,
      text-fill: text-fill,
      text-leading: text-leading,
    )
  ],
)
