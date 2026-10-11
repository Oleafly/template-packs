// Importar valores del análisis
#import "../typst/valores.typ": v

= Resultados

// Este archivo es editable por usuarios no técnicos.
// Usa valores del análisis con #v.seccion.variable
// Incluye figuras y tablas generadas automáticamente.

== Descripción de la muestra

La muestra incluyó #v.muestra.total participantes
(#v.muestra.hombres hombres y #v.muestra.mujeres mujeres).

// Incluir tabla de descriptivos generada por el análisis
#include "../output/tablas/tbl-descriptivos.typ"

== Análisis principal

// Descomentar cuando exista la figura generada por el análisis:
// #figure(
//   image("../output/figuras/fig-distribucion-edad.pdf", width: 80%),
//   caption: [Distribución de edad en la muestra],
// ) <fig-edad>
//
// Como se observa en @fig-edad, la distribución es aproximadamente normal.

El análisis mostró diferencias significativas
(Media = #v.resultados.media, DE = #v.resultados.desviacion,
_p_ = #v.resultados.p_valor).
