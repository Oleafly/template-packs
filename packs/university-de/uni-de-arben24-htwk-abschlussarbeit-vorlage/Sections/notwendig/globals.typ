// ---------------------------------------------------------------------------
// Gemeinsame Hilfsfunktionen und Farbdefinitionen
//
// Diese Datei wird von jeder Kapiteldatei ueber
//   #import "notwendig/globals.typ": *
// eingebunden (Pfad jeweils relativ zur aufrufenden Datei).
// ---------------------------------------------------------------------------

// ---------------------------------------------------------------------------
// Flexible Bildunterschriften
//
// Im Fliesstext erscheint die ausfuehrliche Beschriftung, im Abbildungs- bzw.
// Tabellenverzeichnis nur die kurze Variante.
//   caption: flex-caption([lange Beschriftung ...], [kurze Beschriftung])
// ---------------------------------------------------------------------------
#let in-outline = state("in-outline", false)

#let flex-caption(long, short) = context if in-outline.get() {
  short
} else {
  long
}

// ---------------------------------------------------------------------------
// Einheitliche Farbgebung fuer selbst gezeichnete Abbildungen
// (Blockdiagramme, Flussdiagramme, Schemazeichnungen mit CeTZ)
// ---------------------------------------------------------------------------
#let diagram-line = rgb("#b3b3b3")        // Rahmen der Kaesten (dezent)
#let diagram-fill = rgb("#eef2ff")        // Fuellung der Kaesten
#let diagram-arrow = rgb("#7c7c7c")       // Verbindungslinien und Pfeilspitzen
#let diagram-accent = diagram-arrow       // Beschriftungen an den Pfaden

#let box-fill = diagram-fill
#let box-stroke = 0.8pt + diagram-line
#let arrow-stroke = 0.8pt + diagram-arrow
#let arrow-mark = (end: "stealth", fill: diagram-arrow, stroke: diagram-arrow)

// Achsen in selbst gezeichneten Diagrammen (cetz-plot)
#let axis-color = rgb("#7c7c7c")
#let axis-stroke = 0.8pt + axis-color

// ---------------------------------------------------------------------------
// Bildausschnitt (Crop)
// Schneidet an jeder Seite den angegebenen Prozentsatz des Bildes weg und
// skaliert den Rest auf die volle verfuegbare Breite. Dadurch lassen sich
// mehrere aehnliche Aufnahmen mit identischen Werten beschneiden.
//
// ACHTUNG Pfadangabe: Typst loest Pfade relativ zu der Datei auf, in der der
// image()-Aufruf steht, also relativ zu dieser globals.typ und NICHT relativ
// zur aufrufenden Section. Aus Sections/notwendig/ heraus beginnt der Pfad
// deshalb mit "../../".
//
// Beispiel: #crop-image("../../Abbildungen/beispiel/foo.svg", links: 10%)
// Die Parameter heissen bewusst nicht left/right/top/bottom, da diese Namen
// die gleichnamigen Typst-Ausrichtungen ueberdecken wuerden.
// ---------------------------------------------------------------------------
#let crop-image(path, links: 0%, rechts: 0%, oben: 0%, unten: 0%, breite: 100%, ..args) = layout(size => context {
  let fl = links / 100%
  let ft = oben / 100%
  let fw = 1.0 - fl - (rechts / 100%)
  let fh = 1.0 - ft - (unten / 100%)

  // Seitenverhaeltnis aus der natuerlichen Bildgroesse
  let nat = measure(image(path))
  let bw = size.width * (breite / 100%)   // Darstellungsbreite des Ausschnitts
  let iw = bw / fw                        // Breite des ungeschnittenen Bildes
  let ih = iw * (nat.height / nat.width)

  // Wichtig: dem Bild BEIDE Masse vorgeben. Mit "height: auto" passt Typst das
  // Bild an die verkleinerte Boxhoehe an, wodurch der Ausschnitt verrutscht.
  box(width: bw, height: ih * fh, clip: true,
    move(dx: -fl * iw, dy: -ft * ih, image(path, width: iw, height: ih, ..args)))
})
