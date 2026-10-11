#import "./subject/subject.typ": palette, subject-slide
#import "./shared/base.typ": soft-card

#let agenda-page(
  title: [目录],
  marker: [CONTENT],
  sections: (),
  left-width: 14.2em,
  column-gap: 1.6em,
  left-card-height: auto,
  right-card-height: auto,
  left-card-dx: 0pt,
  left-card-dy: 0pt,
  right-card-dx: 0pt,
  right-card-dy: 0pt,
  left-card-fill: none,
  right-card-fill: none,
  title-size: 2.35em,
  title-fill: palette.ink,
  marker-size: 0.96em,
  marker-fill: palette.primary,
  marker-tracking: 0.14em,
  section-size: auto,
  section-fill: palette.ink,
  section-muted-fill: palette.muted,
  section-gap: auto,
  row-inset: auto,
) = {
  let section-count = sections.len()
  let layout-count = if section-count < 3 {
    3
  } else if section-count > 6 {
    6
  } else {
    section-count
  }

  let auto-card-height = if layout-count == 3 {
    18.2em
  } else {
    20em
  }
  let actual-left-card-height = if left-card-height == auto {
    auto-card-height
  } else {
    left-card-height
  }
  let actual-right-card-height = if right-card-height == auto {
    auto-card-height
  } else {
    right-card-height
  }

  let auto-section-size = if layout-count == 3 {
    1.18em
  } else if layout-count == 4 {
    1.08em
  } else if layout-count == 5 {
    1.0em
  } else {
    0.94em
  }
  let actual-section-size = if section-size == auto {
    auto-section-size
  } else {
    section-size
  }

  let actual-section-gap = if section-gap == auto {
    1fr
  } else {
    section-gap
  }

  let auto-row-inset = if layout-count == 3 {
    (x: 0.2em, y: 0.72em)
  } else if layout-count == 4 {
    (x: 0.2em, y: 0.55em)
  } else if layout-count == 5 {
    (x: 0.2em, y: 0.42em)
  } else {
    (x: 0.2em, y: 0.32em)
  }
  let actual-row-inset = if row-inset == auto {
    auto-row-inset
  } else {
    row-inset
  }
  let right-card-inset = (x: 1.35em, y: 1.1em)

  subject-slide(
    title: auto,
    content: [
      #block(width: 100%, height: 100%)[
        #align(center + horizon)[
          #grid(
            columns: (left-width, 1fr),
            column-gutter: column-gap,
            [
              #block(width: 100%, height: actual-left-card-height)[
                #place(
                  center + horizon,
                  dx: left-card-dx,
                  dy: left-card-dy,
                  soft-card(
                    inset: (x: 0.9em, y: 0.85em),
                    width: 100%,
                    height: actual-left-card-height,
                    fill: left-card-fill,
                  )[
                    #block(width: 100%, height: 100%)[
                      #align(center + horizon)[
                        #text(size: title-size, weight: "bold", fill: title-fill)[#title]
                        #v(0.25em)
                        #text(
                          size: marker-size,
                          weight: "bold",
                          fill: marker-fill,
                          tracking: marker-tracking,
                        )[#marker]
                      ]
                    ]
                  ],
                )
              ]
            ],
            [
              #block(width: 100%, height: actual-right-card-height)[
                #place(
                  center + horizon,
                  dx: right-card-dx,
                  dy: right-card-dy,
                  soft-card(
                    inset: right-card-inset,
                    width: 100%,
                    height: actual-right-card-height,
                    fill: right-card-fill,
                  )[
                    #block(width: 100%, height: 100%)[
                      #if sections.len() == 0 [
                        #set text(size: actual-section-size, fill: section-muted-fill)
                        [请在 `sections` 中传入目录项。]
                      ] else [
                        #set text(size: actual-section-size, fill: section-fill)
                        #set par(leading: 0.68em)
                        #v(actual-section-gap)
                        #for (index, section) in sections.enumerate() [
                          #block(width: 100%, inset: actual-row-inset)[
                            #section
                          ]
                          #v(actual-section-gap)
                          #if index + 1 < section-count [
                            #line(length: 100%, stroke: 1pt + palette.line)
                            #v(actual-section-gap)
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
}
