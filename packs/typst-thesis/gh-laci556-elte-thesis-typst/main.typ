#import "conf.typ": conf
#show: conf.with(
  title: "Dolgozat címe",
  department: [Programozáselmélet és Szoftvertechnológiai\ Tanszék],
  author: (name: "Hallgató Hanga", degree: "programtervező informatikus BSc"),
  supervisor: (name: "Témavezető Tamás", affiliation: "egyetemi tanársegéd"),
  ext-supervisor: none,
  city: "Budapest",
  year: 2025,
)

#import "template/backmatter.typ": create-outline

#outline()

#include "chapters/intro.typ"
#include "chapters/user.typ"
#include "chapters/impl.typ"
#include "chapters/sum.typ"
#include "chapters/ack.typ"

// Reset heading counter, otherwise appendices would not start from A.
#counter(heading).update(0)

#include "chapters/sim.typ"

#bibliography("./bibliography.bib")

#create-outline("Ábrák jegyzéke", figure.where(kind: image))
#create-outline("Táblázatok jegyzéke", figure.where(kind: table))
#create-outline("Algoritmusok jegyzéke", figure.where(kind: "algo"))
#create-outline("Forráskódok jegyzéke", figure.where(kind: raw))
