// =============================================================================
// Lernzettel: Layout-Komponenten (Ablauf, Gegenüberstellung, Spalten, Karte)
// =============================================================================
// Alle Farben kommen aus Config/Styles.typ; nichts ist hart kodiert.

#import "../../Config/Styles.typ": *

// -----------------------------------------------------------------------------
// process — Nummerierter Schritt-für-Schritt-Ablauf mit farbigem linken Rand.
//           Jedes Argument ist ein Schritt.
//
//  Verwendung:
//    #process(
//      [Erster Schritt],
//      [Zweiter Schritt],
//    )
// -----------------------------------------------------------------------------
#let process(..steps) = block(
  width: 100%,
  fill: stepcolor.lighten(94%),
  stroke: (left: 3pt + stepcolor),
  radius: (top-right: 3pt, bottom-right: 3pt),
  inset: (left: 10pt, right: 8pt, top: 8pt, bottom: 8pt),
  breakable: true,
  above: 1.2em,
  below: 1.2em,
  {
    for (i, s) in steps.pos().enumerate() {
      block(
        above: if i == 0 { 0pt } else { 8pt },
        below: 0pt,
        grid(
          columns: (auto, 1fr),
          column-gutter: 6pt,
          box(
            fill: stepcolor,
            radius: 2pt,
            inset: (x: 5pt, y: 2.5pt),
            baseline: 2.5pt,
            text(fill: white, weight: "bold", size: 0.8em, str(i + 1)),
          ),
          s,
        ),
      )
    }
  },
)

// -----------------------------------------------------------------------------
// procon — Zwei-Spalten-Gegenüberstellung Vorteile / Nachteile
//
//  Verwendung:
//    #procon(
//      pro: ([Vorteil 1], [Vorteil 2]),
//      con: ([Nachteil 1], [Nachteil 2]),
//    )
// -----------------------------------------------------------------------------
#let procon(pro: (), con: ()) = {
  let seite(titel, items, bg, frame) = block(
    width: 100%,
    stroke: 1pt + frame,
    radius: 4pt,
    fill: bg,
    clip: true,
    above: 0pt,
    below: 0pt,
    {
      block(
        width: 100%,
        fill: frame,
        inset: (x: 8pt, y: 5pt),
        above: 0pt,
        below: 0pt,
        text(fill: white, weight: "bold", titel),
      )
      block(
        width: 100%,
        inset: (x: 8pt, top: 6pt, bottom: 8pt),
        above: 0pt,
        below: 0pt,
        list(tight: true, spacing: 6pt, ..items),
      )
    },
  )
  block(
    width: 100%,
    above: 1.2em,
    below: 1.2em,
    grid(
      columns: (1fr, 1fr),
      column-gutter: 5%,
      align: top,
      seite([Vorteile], pro, procolor, proframe), seite([Nachteile], con, concolor, conframe),
    ),
  )
}

// -----------------------------------------------------------------------------
// zweispaltig — Zwei beliebige Inhalte nebeneinander
//
//  Verwendung:
//    #zweispaltig([Inhalt links], [Inhalt rechts])
// -----------------------------------------------------------------------------
#let zweispaltig(links, rechts) = block(
  width: 100%,
  above: 1.2em,
  below: 1.2em,
  grid(
    columns: (1fr, 1fr),
    column-gutter: 5%,
    align: top,
    links, rechts,
  ),
)

// -----------------------------------------------------------------------------
// konzeptkarte — Strukturierte Übersichtskarte mit Titelleiste.
//                Innen können alle anderen Komponenten und #zweispaltig
//                verwendet werden.
//
//  Verwendung:
//    #konzeptkarte(title: [Quicksort])[
//      Kurze Beschreibung.
//      #zweispaltig([...], [...])
//    ]
// -----------------------------------------------------------------------------
#let konzeptkarte(title: [], body) = block(
  width: 100%,
  stroke: 0.8pt + primary.lighten(65%),
  radius: 5pt,
  fill: konzeptcolor,
  clip: true,
  breakable: true,
  above: 1.2em,
  below: 1.2em,
  {
    block(
      width: 100%,
      fill: primary,
      inset: (x: 10pt, y: 7pt),
      above: 0pt,
      below: 0pt,
      text(fill: white, weight: "bold", size: 1.1em, title),
    )
    block(
      width: 100%,
      inset: (x: 10pt, top: 8pt, bottom: 10pt),
      above: 0pt,
      below: 0pt,
      body,
    )
  },
)
