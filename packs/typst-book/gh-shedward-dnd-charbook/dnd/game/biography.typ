#import "../core/core.typ": *

#let biographySection(title, body) = [
  #framed(fitting: expand-h, insets: paddings(2))[
    #align(left)[
      #abilityHeader(title)\
      #body
    ]
  ]
]

#let biographySubsection(title, body) = [
  #abilitySubsection(title)
  #block[
    #set par(first-line-indent: 0.5em, justify: true)
    #body
  ]
]
