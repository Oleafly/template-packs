#import "../template.typ": *

= Código
#minitoc()

#lorem(10)

== Estructura de carpetas
Aquí se detalla la jerarquía del proyecto como se menciona en @Intel4004

#figure(
  rect(
    width: 4cm,
    height: 3cm,
    fill: blue,
    radius: 2pt // Opcional: bordes ligeramente redondeados
  ),
  caption: [Este es un rectángulo azul],
) <fig2>


#figure(
  table(
    columns: 2,
    align: center + horizon,
    [A], [A],
    [B], [B],
  ),
  caption: [Título TABLA], 
) <tabla>

Como se ve en la tabla @tabla y en la figura @fig2

== Otra

#figure(
  grid(
    columns: 2,
    gutter: 10pt,
    rect(width: 4cm, height: 3cm, fill: blue, radius: 2pt),
    rect(width: 4cm, height: 3cm, fill: blue, radius: 2pt)
  ),
  caption: [Resultados de la simulación.],
) <fig-simulacion>

Como vemos en la figura @fig-simulacion...


#chapterend()
