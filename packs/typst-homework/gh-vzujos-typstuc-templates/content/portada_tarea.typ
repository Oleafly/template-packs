#import "../config/variables.typ": *

#show title: set text(size: 24pt, weight: "semibold")

#place(
  top + center,
  float: true,
  scope: "parent",
  )[
  #v(8em)
  #title()
  #text(tema, size: 14pt, weight: "semibold")\
  #author\
  #date
  #line(length: 100%)
  ]
