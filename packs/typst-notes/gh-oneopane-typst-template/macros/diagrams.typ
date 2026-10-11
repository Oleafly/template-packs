// Optional category-theory diagram helpers.
//
// This module depends on Fletcher. Import it only in notes that draw diagrams:
//   #import "../../macros/diagrams.typ": *
//
// Example:
//   #commdiag($
//     A edge("r", f, "->") edge("d", g, "->") & B edge("d", h, "->") \\
//     C edge("r", k, "->") & D
//   $)

#import "@preview/fletcher:0.5.8": diagram, node, edge

#let commdiag(..args) = diagram(..args)
#let pullback(..args) = diagram(..args)
#let pushout(..args) = diagram(..args)
