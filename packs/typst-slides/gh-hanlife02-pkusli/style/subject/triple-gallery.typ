#import "./subject.typ": palette, soft-card, subject-slide
#import "./content.typ": subject-title-card

#let normalize-gallery-image-path(path) = if (
  type(path) == str and not path.starts-with("/") and not path.starts-with(".")
) {
  "../../" + path
} else {
  path
}

#let gallery-image-slot(
  body,
  caption: none,
  max-height: 8.6em,
  caption-size: 0.58em,
  caption-fill: palette.muted,
  caption-leading: 0.52em,
  caption-gap: 0.4em,
) = block(width: 100%)[
  #grid(
    rows: if caption == none { (auto,) } else { (auto, auto) },
    row-gutter: if caption == none { 0pt } else { caption-gap },
    [
      #block(width: 100%, height: max-height)[
        #align(center + horizon)[
          #block(width: 100%, height: 100%)[
            #if type(body) == str or type(body) == bytes [
              #image(
                normalize-gallery-image-path(body),
                width: 100%,
                height: 100%,
                fit: "contain",
              )
            ] else [
              #body
            ]
          ]
        ]
      ]
    ],
    if caption != none [
      #set text(size: caption-size, fill: caption-fill)
      #set par(leading: caption-leading)
      #align(center + top)[#caption]
    ],
  )
]

#let subject-triple-gallery-page(
  image-one: [],
  image-two: [],
  image-three: [],
  image-one-caption: none,
  image-two-caption: none,
  image-three-caption: none,
  title: none,
  subtitle: none,
  text-body: [],
  header-left-offset: 0pt,
  body-gap: 0.58em,
  image-gap: 0em,
  image-height: 8.6em,
  content-row-gap: 1.8em,
  body-width: 94%,
  body-text-size: 0.82em,
  body-text-fill: palette.ink,
  body-text-leading: 0.62em,
  caption-size: 0.58em,
  caption-fill: palette.muted,
  caption-leading: 0.52em,
  caption-gap: 0.4em,
  title-card-fill: none,
  title-card-stroke: none,
  title-card-inset: (x: 0.95em, y: 0.38em),
  title-card-height: 3.8em,
  title-size: 1.48em,
  title-weight: "bold",
  title-fill: palette.ink,
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
          #soft-card(
            inset: 0.95em,
            width: 100%,
            height: 100%,
            fill: none,
            stroke: none,
          )[
            #block(width: 100%, height: 100%)[
              #align(center + horizon)[
                #block(width: 100%)[
                  #grid(
                    rows: (auto, auto),
                    row-gutter: content-row-gap,
                    [
                      #grid(
                        columns: (1fr, 1fr, 1fr),
                        column-gutter: image-gap,
                        [#gallery-image-slot(
                          image-one,
                          caption: image-one-caption,
                          max-height: image-height,
                          caption-size: caption-size,
                          caption-fill: caption-fill,
                          caption-leading: caption-leading,
                          caption-gap: caption-gap,
                        )],
                        [#gallery-image-slot(
                          image-two,
                          caption: image-two-caption,
                          max-height: image-height,
                          caption-size: caption-size,
                          caption-fill: caption-fill,
                          caption-leading: caption-leading,
                          caption-gap: caption-gap,
                        )],
                        [#gallery-image-slot(
                          image-three,
                          caption: image-three-caption,
                          max-height: image-height,
                          caption-size: caption-size,
                          caption-fill: caption-fill,
                          caption-leading: caption-leading,
                          caption-gap: caption-gap,
                        )],
                      )
                    ],
                    [
                      #align(center + top)[
                        #block(width: body-width)[
                          #set text(size: body-text-size, fill: body-text-fill)
                          #set par(leading: body-text-leading)
                          #set align(center)
                          #text-body
                        ]
                      ]
                    ],
                  )
                ]
              ]
            ]
          ]
        ],
      )
    ]
  ],
)
