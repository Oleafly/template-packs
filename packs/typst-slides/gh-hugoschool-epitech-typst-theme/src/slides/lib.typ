#import "@preview/polylux:0.4.0": *
#import "../common/lib.typ"

#let slide-landing(
  content: context [
    #pad(
      top: 150pt,
      [
        #lib.epitech-title(document.title, underscore_color: lib.colors.orange)

        #if document.description != none {
          lib.epitech-subtitle(document.description)
        }
      ],
    )
  ],
  decoration: context [
    #let margin = 35pt;

    #lib.decoration.block(
      250pt,
      125pt,
      dx: margin,
      dy: -margin,
    )
    #lib.decoration.block(
      125pt,
      125pt,
      dx: margin - 250pt,
      dy: -margin + 125pt,
    )
  ],
  show-logo: true,
) = [
  #slide[
    #set page(fill: lib.colors.blue, numbering: none)
    #set text(fill: white)

    #if show-logo [
      #lib.utils.colorized-image("/assets/epitech.svg", width: 150pt, original_color: "#013afb", color: white)
    ]

    #decoration

    #set align(horizon)

    #content

    #context {
      // Ignore all "titled" pages for counting
      counter(page).update(n => n - 1)
    }
  ]
]

#let slide-title(title, underscore_color) = [
  #slide-landing(
    content: [
      #pad(
        top: 250pt,
        [
          = #lib.epitech-underscore(title, underscore_color: underscore_color)
        ],
      )
    ],
    show-logo: false,
  )
]

#let slide-final(
  content: none,
  version_text: none
) = [
  #if content == none {
    content = [
      #set align(center)

      #set text(size: 16pt)
      #lib.version-block(version_text: version_text)

      #lib.utils.colorized-image("/assets/epitech.svg", width: 300pt, original_color: "#013afb", color: white)
    ]
  }

  #slide-landing(
    content: content,
    decoration: [
      #let margin = 35pt;

      #lib.decoration.block(
        250pt,
        125pt,
        dx: margin,
        dy: -margin - margin,
      )
      #lib.decoration.block(
        125pt,
        125pt,
        dx: -680pt,
        dy: 350pt,
      )
    ],
    show-logo: false,
  )
]

#let slides-default(doc) = [
  #set page(paper: "presentation-16-9", margin: 35pt, numbering: none)
  #set text(size: 24pt, font: "IBM Plex Sans")

  #show title: set text(size: 86pt)
  #show link: set text(fill: lib.colors.blue)

  #show heading: set text(weight: "regular")
  #show heading.where(level: 1): set text(size: 52pt, font: "Anton")
  #show heading.where(level: 2): set text(size: 32pt)

  #lib.THEME_MODE.update(_ => "slides")
  #show: lib.default(doc)

  #doc
]
