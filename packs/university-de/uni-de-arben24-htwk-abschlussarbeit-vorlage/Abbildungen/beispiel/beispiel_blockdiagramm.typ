// ---------------------------------------------------------------------------
// Beispiel fuer eine selbst gezeichnete Abbildung mit CeTZ.
//
// Solche Zeichnungen werden in eine eigene Datei ausgelagert und im Kapitel
// ueber #include eingebunden. Dadurch bleibt der Fliesstext lesbar.
// Die Farben stammen aus Sections/notwendig/globals.typ, sodass alle
// gezeichneten Abbildungen einheitlich aussehen.
//
// Achtung: Pfade in dieser Datei werden relativ zu DIESER Datei aufgeloest.
// ---------------------------------------------------------------------------

#import "@preview/cetz:0.3.4": canvas, draw
#import "../../Sections/notwendig/globals.typ": *

#figure(
  canvas(length: 1cm, {
    import draw: *

    let kasten(pos, name, label) = {
      rect(
        (pos.at(0) - 1.6, pos.at(1) - 0.6),
        (pos.at(0) + 1.6, pos.at(1) + 0.6),
        name: name,
        fill: box-fill,
        stroke: box-stroke,
      )
      content(pos, text(size: 9pt)[#label])
    }

    kasten((0, 0), "a", [Eingang])
    kasten((5, 0), "b", [Verarbeitung])
    kasten((10, 0), "c", [Ausgang])

    line("a.east", "b.west", stroke: arrow-stroke, mark: arrow-mark)
    line("b.east", "c.west", stroke: arrow-stroke, mark: arrow-mark)

    content((7.5, 0.9), text(size: 8pt, fill: diagram-accent)[Signal])
  }),
  caption: flex-caption(
    [Beispiel für ein mit CeTZ gezeichnetes Blockdiagramm, das die einheitliche Farbgebung der Vorlage verwendet. (Quelle: Eigene Darstellung)],
    [Beispiel für ein gezeichnetes Blockdiagramm]
  ),
  alt: "Blockdiagramm aus drei Kästen mit den Beschriftungen Eingang, Verarbeitung und Ausgang, die durch Pfeile verbunden sind."
)<fig:beispiel_blockdiagramm>
