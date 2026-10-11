// diagrams.typ — Diagramas com cetz. Uso:
//   #diagram({ import cetz.draw: *; rect((0, 0), (2, 1), name: "a"); content("a", [A]) })
#import "@preview/cetz:0.4.2"
#let diagram(body) = cetz.canvas(body)
