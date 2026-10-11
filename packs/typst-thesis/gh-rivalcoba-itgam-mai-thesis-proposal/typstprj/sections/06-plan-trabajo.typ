#import "../styles.typ": navy, paper-gray

= Plan de trabajo

#figure(
  table(
    columns: (
      2fr,
      0.55fr,
      0.55fr,
      0.55fr,
      0.55fr,
      0.55fr,
      0.55fr,
    ),
    align: center + horizon,
    fill: (x, y) => if y == 0 {
      navy
    } else if calc.odd(y) {
      paper-gray
    } else {
      none
    },
    table.header(
      text(fill: white, weight: "bold")[Actividad],
      text(fill: white, weight: "bold")[M1],
      text(fill: white, weight: "bold")[M2],
      text(fill: white, weight: "bold")[M3],
      text(fill: white, weight: "bold")[M4],
      text(fill: white, weight: "bold")[M5],
      text(fill: white, weight: "bold")[M6],
    ),
    [Revisión del estado del arte], [●], [●], [], [], [], [],
    [Preparación de datos], [], [●], [●], [], [], [],
    [Diseño e implementación], [], [], [●], [●], [], [],
    [Evaluación y análisis], [], [], [], [●], [●], [],
    [Redacción y revisión], [], [], [], [], [●], [●],
  ),
  caption: [
    Cronograma general; adapte los meses y las actividades al proyecto@Zou2014.
  ],
)