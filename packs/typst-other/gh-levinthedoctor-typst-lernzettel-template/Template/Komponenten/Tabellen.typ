// =============================================================================
// Lernzettel: Tabellen
// =============================================================================
// Alle Farben kommen aus Config/Styles.typ; nichts ist hart kodiert.

#import "../../Config/Styles.typ": *

// -----------------------------------------------------------------------------
// stdtable — Formatierte Tabelle mit farbiger Kopfzeile und alternierend
//            eingefärbten Zeilen.
//
//  Verwendung:
//    #stdtable(
//      columns: (auto, 1fr, 1fr),
//      header: ([Algorithmus], [Komplexität], [Notiz]),
//      [Bubble Sort], [$O(n^2)$], [Einfach],
//    )
//
//  Für eine nummerierte Tabelle mit Beschriftung und Quellenzeile die Tabelle
//  zusätzlich in #tabelle(...) aus Template/Elemente.typ einpacken – nur dann
//  erscheint sie im Tabellenverzeichnis.
// -----------------------------------------------------------------------------
#let stdtable(columns: (), header: (), ..cells) = block(
  width: 100%,
  above: 1.2em,
  below: 1.2em,
  table(
    columns: columns,
    stroke: none,
    inset: (x: 8pt, y: 6pt),
    fill: (x, y) => if y == 0 { tableheader } else if calc.odd(y) { tablerowalt } else { white },
    table.header(
      ..header.map(h => text(fill: tableheadertext, weight: "bold", h)),
    ),
    ..cells,
  ),
)
