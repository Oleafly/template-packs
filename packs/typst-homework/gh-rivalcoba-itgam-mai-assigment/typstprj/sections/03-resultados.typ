#import "../styles.typ": navy, paper
#import "../components.typ": result-card

= Resultados

Presente los hallazgos en el mismo orden de los objetivos o preguntas. Describa lo observado sin adelantar una interpretación extensa, la cual corresponde a la discusión.

== Resultados principales

#grid(
  columns: (1fr, 1fr, 1fr),
  column-gutter: 4mm,
  result-card(
    [Métrica 1],
    [Valor],
    [Descripción breve del resultado.],
  ),
  result-card(
    [Métrica 2],
    [Valor],
    [Descripción breve del resultado.],
  ),
  result-card(
    [Métrica 3],
    [Valor],
    [Descripción breve del resultado.],
  ),
)

== Tabla de resultados

#figure(
  table(
    columns: (1.35fr, 1fr, 1fr, 1.4fr),
    align: (left, center, center, left),
    fill: (x, y) => if y == 0 {
      navy
    } else if calc.odd(y) {
      paper
    } else {
      none
    },
    table.header(
      text(fill: white, weight: "bold")[Condición],
      text(fill: white, weight: "bold")[Métrica A],
      text(fill: white, weight: "bold")[Métrica B],
      text(fill: white, weight: "bold")[Observación],
    ),
    [Línea base], [—], [—], [Resultado de referencia],
    [Propuesta], [—], [—], [Resultado obtenido],
  ),
  caption: [Comparación de los resultados principales.],
)

== Figuras

#figure(
  rect(
    width: 100%,
    height: 55mm,
    fill: paper,
    stroke: 0.6pt + rgb("#d9dee7"),
  )[
    #align(center + horizon)[
      Sustituya este bloque por una gráfica, diagrama o imagen.
    ]
  ],
  caption: [Título informativo de la figura y descripción de sus elementos esenciales.],
)