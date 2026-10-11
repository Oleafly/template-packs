#import "@preview/codelst:2.0.2": sourcecode

#let report-title(title, number, author) = [
  #align(center)[
    #text(size: 32pt)[#title]
    #v(0.3cm)
    #set align(right)
    #text(size: 18pt)[#number]
    #h(0.5cm)
    #text(size: 18pt)[#author]
    #v(0.3cm)
  ]
]
