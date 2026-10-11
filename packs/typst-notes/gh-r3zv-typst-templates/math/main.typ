#import "template.typ": *

#let date = datetime.today().display("[month repr:long] [day], [year]")
#show: template.with(
  title: "Graphs",
  authors: (
    "Razvan Maracine",
  ),
  date: date,
  heading-color: rgb("#0c0fad"),
)

= Graphs basics
#lorem(500)

= Trees
#lorem(500)

= MST

== Kruskal
#lorem(500)

== Prim
#lorem(500)
