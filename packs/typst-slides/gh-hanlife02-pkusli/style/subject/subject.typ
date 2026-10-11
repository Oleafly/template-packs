#import "@preview/touying:0.6.1": *
#import "../shared/base.typ": page-background, page-footer, palette, soft-card

#let top-visual-slot(height: 9em) = block(
  width: 100%,
  height: height,
)[]

#let top-side-panel(
  title,
  kicker: none,
  body: none,
) = soft-card(
  inset: (x: 1em, y: 0.86em),
  radius: 18pt,
  width: 100%,
  height: 100%,
  fill: none,
)[
  #if kicker != none [
    #text(size: 0.56em, weight: "bold", fill: palette.primary, tracking: 0.12em)[#kicker]
    #v(0.12em)
  ]
  #text(size: 1.08em, weight: "bold", fill: palette.ink)[#title]
  #if body != none [
    #v(0.3em)
    #line(length: 100%, stroke: 1pt + palette.line)
    #v(0.26em)
    #set text(size: 0.62em, fill: palette.muted)
    #set par(leading: 0.5em)
    #body
  ]
]

#let main-stage(body) = block(width: 100%, height: 100%)[
  #body
]

#let subject-slide(
  title: auto,
  kicker: none,
  side-panel: auto,
  content: [],
) = touying-slide-wrapper(self => {
  if title != auto {
    self.store.title = title
  }

  let panel-body = if side-panel == auto { none } else { side-panel }

  self = utils.merge-dicts(
    self,
    config-page(
      background: page-background(),
      margin: (top: 1.2em, bottom: 1.25em, x: 1.35em),
      header: self => [],
      footer: self => page-footer(self),
    ),
  )

  touying-slide(
    self: self,
    block(width: 100%)[
      #if title != auto [
        #grid(
          rows: (9em, 1fr),
          row-gutter: 0.78em,
          [
            #grid(
              columns: (1fr, 18.4em),
              column-gutter: 0.78em,
              [#top-visual-slot()], [#top-side-panel(title, kicker: kicker, body: panel-body)],
            )
          ],
          [#main-stage(content)],
        )
      ] else [
        #main-stage(content)
      ]
    ],
  )
})
