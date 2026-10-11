#import "@preview/touying:0.7.4": slide, touying-slide-wrapper, touying-slide, touying-slides, components, utils, config-page, config-common, config-colors, config-store
#import "../colors.typ": primary, primary-light, primary-dark, primary-darkest, secondary, tertiary

#let slide-margin = 7mm


// Define a function slide() to call at each slide
#let slide-normal(title:auto, ..args) = touying-slide-wrapper( self => {
  let header(self) = {
    show: components.cell.with(inset: 1em)
    if title != auto {
      place(
        top + left,
        dx: slide-margin,
        dy: slide-margin,
        text(
          weight: "bold",
          size: 24pt,
          fill: self.colors.primary-dark,
          title,
        )
      )
        }
  }

  self = utils.merge-dicts(
    self,
    config-page(
      header: header
    )
  )


  touying-slide(self: self, ..args)

})


#let title-slide(..args) = touying-slide-wrapper( self => {
  let info = self.info + args.named()
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(
      numbering: none,
      footer: none,
      fill: self.colors.primary-darkest,
    ),
  )
  let body = {
    set text(font: "JetBrains Mono")

    let title-text = text(
      size: 34pt,
      weight: "bold",
      fill: self.colors.primary,
      info.title,
    )
    let subtitle-text = text(size: 19pt, fill: self.colors.primary, info.subtitle)
    let author-text = text(size: 17pt, fill: primary-light, info.author)
    let institution-text = text(size: 17pt, fill: primary-light, info.institution)

    // A format for extra info
    let detail-text(body) = text(size: 15pt, fill: primary-light, body)

    align(left + horizon)[
      #title-text
      #if info.subtitle != [] [
        #v(4mm)
        #subtitle-text
      ]
      #v(8mm)
      #author-text
      #v(8mm)
      #institution-text
    ]
    place(bottom + left)[#detail-text(info.extra.venue)]
    place(bottom + right)[#detail-text(info.date)]
  }


  touying-slide(self: self, body)
  }
)


#let new-section-slide(body) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(
      numbering: none,
      footer: none,
      fill: self.colors.primary-dark,
    ),
  )

  touying-slide(self: self, {
    set text(font: "JetBrains Mono")

    context {
      let current-heading = utils.current-heading(level: 1)
      let number = utils.display-current-heading-number(level: 1)
      let title = utils.display-current-heading(
        level: 1,
        numbered: false,
      )

      align(left + horizon)[
        #if current-heading.numbering != none [
          #text(
            size: 34pt,
            weight: "bold",
            fill: self.colors.primary,
            [Part #number:],
          )

          #v(8mm)
        ]

        #text(size: 19pt, fill: primary-light, title)

        #v(5mm)

        #align(center)[
          #line(
            length: 70%,
            stroke: self.colors.primary + 5pt,
          )
        ]
      ]
    }

    body
  })
})




#let new-subsection-slide(body) = touying-slide-wrapper(self => {
  self = utils.merge-dicts(
    self,
    config-common(freeze-slide-counter: true),
    config-page(
      numbering: none,
      footer: none,
      fill: self.colors.primary-darkest.transparentize(10%),
    ),
  )

  touying-slide(self: self, {
    let section-title = text(fill: self.colors.primary, utils.display-current-heading(
      level:1,
      numbered: false,
    ))
    let subsection-title = text(fill:primary-light, utils.display-current-heading(
      level:2,
      numbered: false,
    ))


    let horizon-bar = align(center)[
      #line(length: 50%, stroke:self.colors.primary + 5pt)
    ]

    align(left + horizon)[
      #section-title
      #v(8mm)
      #subsection-title
      #v(5mm)
      #horizon-bar
    ]

    body
  })
})


// Registration of the theme with some defaults to be applied to all slides
#let crx-theme(
    ..args,
    body
) = {

  set text(font: "STIX Two Text", size: 23pt, fill: primary-dark)
  set align(center + horizon)
  // Touying hides the source headings, but Typst still needs a numbering
  // pattern for the heading counter to advance.
  set heading(numbering: "1.1")


  show: touying-slides.with(
    config-page(
      paper: "presentation-16-9",
      margin: slide-margin,
      fill: primary-light,
      footer: align(right)[
        #text(size: 11pt, fill: primary-dark)[
          #context utils.slide-counter.display() / #context utils.last-slide-number #h(10pt))
        ]
      ],
      foreground: {
        rect(
          width: 100%,
          height: 100%,
          fill: none,
          stroke: 10pt + primary,
        )
      }
    ),
    config-common(
      breakable:false,
      detect-overflow: true,
      slide-fn: slide-normal,
      new-section-slide-fn: new-section-slide,
      new-subsection-slide-fn: new-subsection-slide
    ),
    config-colors(
      primary: primary,
      primary-light: primary-light,
      primary-dark: primary-dark,
      primary-darkest: primary-darkest,
      secondary: secondary,
      tertiary: tertiary
    ),
    // To manage title
    config-store(
    ),
    ..args,
  )

  body
}
