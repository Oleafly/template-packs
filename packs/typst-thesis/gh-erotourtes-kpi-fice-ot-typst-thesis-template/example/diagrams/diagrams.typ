#import "@preview/fletcher:0.5.8": diagram, edge, node

#let label-node(pos, body) = node(
  pos,
  body,
  stroke: none,
  fill: none,
)

#let clock-event(pos, name) = node(
  pos,
  [],
  name: name,
  radius: 1.7mm,
  stroke: 1pt,
  fill: rgb("#ead7cf"),
)

#let clock-label(pos, body) = label-node(pos, text(size: 8pt, body))

#let diagrams = (
  lamport-clocks: diagram(
    spacing: (14mm, 11mm),
    edge-stroke: 1pt,
    label-size: 9pt,

    label-node((-0.7, 0), [X]),
    label-node((-0.7, 1), [Y]),
    label-node((-0.7, 2), [Z]),

    clock-event((1.6, 0), <a1>),
    clock-event((2.4, 0), <a2>),
    clock-event((3.6, 0), <a3>),

    clock-event((3.2, 1), <b1>),
    clock-event((4.0, 1), <b2>),

    clock-event((0, 2), <c1>),
    clock-event((0.8, 2), <c2>),
    clock-event((4.8, 2), <c3>),

    edge(<a1>, <a2>, "-|>"),
    edge(<a2>, <a3>, "-|>"),
    edge(<b1>, <b2>, "-|>"),
    edge(<c1>, <c2>, "-|>"),
    edge(<c2>, <c3>, "-|>"),

    edge(
      <c2>,
      <a3>,
      [$m_1$, $t=2$],
      "-|>",
      label-side: center,
      label-pos: 0.15,
    ),
    edge(<a2>, <b1>, [$m_2$, $t=2$], "-|>", label-side: center, label-pos: 0.3),
    edge(<b2>, <c3>, [$m_3$, $t=4$], "-|>", label-side: center, label-pos: 0.3),

    clock-label((1.6, -0.34), [$x$: local\ $C=1$]),
    clock-label((2.4, -0.34), [send\ $C=2$]),
    clock-label((3.6, -0.34), [receive\ $max(2, 2)+1=3$]),

    clock-label((3.2, 1.34), [receive\ $max(0, 2)+1=3$]),
    clock-label((4.0, 0.6), [send\ $C=4$]),

    clock-label((0, 2.34), [local\ $C=1$]),
    clock-label((0.8, 2.34), [$y$: send\ $C=2$]),
    clock-label((4.8, 2.34), [receive\ $max(2, 4)+1=5$]),
  ),
)
