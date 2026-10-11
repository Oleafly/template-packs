#import "config.typ": *
#show title: set align(center)
#show title: set text(size: 24pt)
#show title: set block(below: 2em)

#set page(
  margin: (top: 4cm),
  header: align(right)[
    #pad(
      image("images/DHBW-Logo.svg"),
      top: 1cm
    )
  ]
)

#title()

#align(center)[
  #autor \
  Matrikelnummer: #matnr \
  #link("mailto:" + email)\
]