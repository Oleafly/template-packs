#import "raw.typ"

#set page(margin: (
  top: 5cm,
  bottom: 2.5cm,
  x: 3.5cm,
  y: 3.5cm,
))

#set text(font: "EB Garamond", weight: 500)
#set par(leading: 0.6em)

#smallcaps[
  #for el in raw.from [
    #el
    #if el != raw.from.last() [ $dot.c$ ]
  ]]

#block(above: 30pt)[#text(font: "Nimbus Sans", size: 0.9em)[
    #for el in raw.to [
      #el
      #if el != raw.to.last() [ \ ]
    ]]
]

#align(right)[#raw.city, #raw.date]

#v(25pt)

#raw

#v(10pt)

#align(right)[
  #image("assets/signature.svg", height: 2cm)
  #raw.from.first()]
