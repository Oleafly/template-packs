#import "../../macros/diagrams.typ": commdiag, pullback, pushout, edge

== Diagrams

The diagrams module is opt-in because it imports Fletcher. It exposes `commdiag`, `pullback`, `pushout`, and Fletcher's `edge` helper.

=== Commutative square

#align(center)[
  #commdiag($
    A edge("r", f, "->") edge("d", g, "->") & B edge("d", h, "->") \
    C edge("r", k, "->") & D
  $)
]

=== Pullback-style square

#align(center)[
  #pullback($
    P edge("r", p_2, "->") edge("d", p_1, "->") & Y edge("d", g, "->") \
    X edge("r", f, "->") & Z
  $)
]

=== Pushout-style square

#align(center)[
  #pushout($
    A edge("r", f, "->") edge("d", g, "->") & B edge("d", i, "->") \
    C edge("r", j, "->") & Q
  $)
]
