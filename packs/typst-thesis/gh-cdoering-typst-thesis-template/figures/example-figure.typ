// Empfohlenes Muster fuer Abbildungen: eine .typ-Datei neben der Bilddatei,
// aus dem Kapitel per #include eingebunden.
//
//   // im Kapitel
//   #include "../figures/example-figure.typ"
//
// Vorteil: der image()-Pfad steht direkt neben dem Bild und bleibt kurz, weil
// Typst Pfade relativ zu der Datei aufloest, in der der Aufruf steht. Mit
// einer echten Bilddatei sieht das so aus:
//
//   #figure(
//     image("architektur.svg", width: 90%),
//     caption: [Systemarchitektur.],
//   ) <fig-architektur>
//
// Diese Beispielabbildung kommt ohne Bilddatei aus und ist mit Typst-
// Primitiven gezeichnet, damit das Repository binaerfrei bleibt.

#figure(
  block(
    width: 75%,
    inset: 14pt,
    stroke: 0.5pt + luma(160),
    radius: 4pt,
    grid(
      columns: 5,
      align: center + horizon,
      column-gutter: 6pt,
      circle(radius: 13pt, fill: luma(225)),
      line(length: 1.4cm, stroke: 0.7pt),
      rect(width: 2.4cm, height: 1.1cm, radius: 3pt, fill: luma(225)),
      line(length: 1.4cm, stroke: 0.7pt),
      circle(radius: 13pt, fill: luma(225)),
    ),
  ),
  caption: [Beispielabbildung, mit Typst-Primitiven gezeichnet.],
  kind: image,
) <fig-example>
