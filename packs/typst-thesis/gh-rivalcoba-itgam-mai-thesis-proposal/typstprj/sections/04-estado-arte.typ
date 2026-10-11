= Marco teórico y estado del arte

Organice los antecedentes por enfoques, familias de métodos o etapas históricas, no como una sucesión aislada de resúmenes. Compare supuestos, datos, métricas, fortalezas y limitaciones @He2017.

#figure(
  table(
    columns: (
      1.2fr,
      1fr,
      1fr,
      1fr,
    ),
    fill: (x, y) => if y == 0 {
      rgb("#eaf0f8")
    } else {
      none
    },
    table.header(
      [*Trabajo*],
      [*Método*],
      [*Datos y métricas*],
      [*Limitación*],
    ),
    [Autor, año],
    [Enfoque A],
    [Conjunto y métrica],
    [Brecha identificada],
    [Autor, año],
    [Enfoque B],
    [Conjunto y métrica],
    [Brecha identificada],
  ),
  caption: [
    Matriz de comparación del estado del arte.
  ],
)

= Hipótesis o supuesto de investigación

Declare la hipótesis cuando el diseño permita contrastarla. En estudios exploratorios o de desarrollo tecnológico, sustituya esta sección por supuestos, proposiciones o criterios de éxito.