#import "../template.typ": *

#heading(level: 1, numbering: none)[Acrónimos]

#let lista-acronimos = (
  "ETSIT": "Escuela Técnica Superior de Ingeniería de Telecomunicación",
)

#grid(
  columns: (6em, 1fr),
  gutter: 1.2em,
  row-gutter: 1.1em,
  
  ..lista-acronimos.pairs()
    .sorted(key: it => it.at(0))
    .map(par => (
      // Creamos una etiqueta dinámica para cada uno, ej: <acr_ALU>
      [*#par.at(0)* #label("acr_" + par.at(0))], 
      [#par.at(1)]
    ))
    .flatten()
)

#chapterend()