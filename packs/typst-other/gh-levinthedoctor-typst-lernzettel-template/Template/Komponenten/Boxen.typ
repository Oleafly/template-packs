// =============================================================================
// Lernzettel: Kastenkomponenten
// =============================================================================
// Alle Farben kommen aus Config/Styles.typ; nichts ist hart kodiert.

#import "../../Config/Styles.typ": *

// -----------------------------------------------------------------------------
// Basis: Box mit optionalem Titel-Chip, der oben links über den Rahmen ragt
// (Nachbau von tcolorbox „attach boxed title to top left").
// Wird von infobox, warnbox, merksatz, beispiel und aufgabe verwendet.
// -----------------------------------------------------------------------------
#let titledbox(title: none, fill: white, frame: black, body) = {
  if title == none {
    block(
      width: 100%,
      fill: fill,
      stroke: 1pt + frame,
      radius: 4pt,
      inset: boxinnersep,
      breakable: true,
      above: 1.2em,
      below: 1.2em,
      body,
    )
  } else {
    block(
      width: 100%,
      inset: (top: 10pt), // Platz für den überstehenden Titel-Chip
      above: 1.4em,
      below: 1.2em,
      breakable: true,
      {
        block(
          width: 100%,
          fill: fill,
          stroke: 1pt + frame,
          radius: 4pt,
          inset: (x: boxinnersep, top: boxinnersep + 4pt, bottom: boxinnersep),
          breakable: true,
          above: 0pt,
          below: 0pt,
          body,
        )
        place(
          top + left,
          dx: 4mm,
          dy: -10pt, // Chip ragt über die Oberkante hinaus
          box(
            fill: frame,
            radius: 3pt,
            inset: (x: 7pt, y: 4.5pt),
            text(fill: white, weight: "bold", size: 0.9em, title),
          ),
        )
      },
    )
  }
}

// -----------------------------------------------------------------------------
// infobox — Farbige Infobox mit optionalem Titel
//
//  Verwendung:
//    #infobox(title: [Mein Titel])[ ... ]
//    #infobox[ ... ]                        // ohne Titel
// -----------------------------------------------------------------------------
#let infobox(title: none, body) = titledbox(
  title: title,
  fill: infocolor,
  frame: infoframe,
  body,
)

// -----------------------------------------------------------------------------
// warnbox — Warnbox / Tipp-Box mit optionalem Titel
// -----------------------------------------------------------------------------
#let warnbox(title: none, body) = titledbox(
  title: title,
  fill: warncolor,
  frame: warnframe,
  body,
)

// -----------------------------------------------------------------------------
// merksatz — Wichtiger Satz / Merkeintrag (Indigo)
//
//  Verwendung:
//    #merksatz(title: [Satz von Pythagoras])[
//      In einem rechtwinkligen Dreieck gilt: $a^2 + b^2 = c^2$.
//    ]
// -----------------------------------------------------------------------------
#let merksatz(title: none, body) = titledbox(
  title: title,
  fill: merksatzcolor,
  frame: merksatzframe,
  body,
)

// -----------------------------------------------------------------------------
// beispiel — Beispiel-Box (Smaragdgrün), Titel immer „Beispiel[: …]"
//
//  Verwendung:
//    #beispiel(title: [Quicksort auf [3,1,4,1,5]])[
//      Pivot = 3, links: [1,1], rechts: [4,5] …
//    ]
// -----------------------------------------------------------------------------
#let beispiel(title: none, body) = titledbox(
  title: if title == none { [Beispiel] } else { [Beispiel: #title] },
  fill: beispielcolor,
  frame: beispielframe,
  body,
)

// -----------------------------------------------------------------------------
// aufgabe — Aufgaben-Box mit automatischer Nummerierung (Goldgelb)
//           Zähler zurücksetzen: #resetaufgaben()
//
//  Verwendung:
//    #aufgabe(title: [Laufzeitanalyse])[
//      Bestimmen Sie die Zeitkomplexität von Bubblesort.
//    ]
// -----------------------------------------------------------------------------
#let aufgabe-zaehler = counter("aufgabe")
#let resetaufgaben() = aufgabe-zaehler.update(0)

#let aufgabe(title: none, body) = {
  aufgabe-zaehler.step()
  context {
    let n = aufgabe-zaehler.get().first()
    titledbox(
      title: if title == none { [Aufgabe #n] } else { [Aufgabe #n: #title] },
      fill: aufgabecolor,
      frame: aufgabeframe,
      body,
    )
  }
}
