// ---------------------------------------------------------------------------
// Globale Formatvorlage der Arbeit
//
// Hier wird das komplette Layout definiert (Seitenformat, Schrift, Nummerierung
// von Ueberschriften und Gleichungen, Beschriftungen, Inhaltsverzeichnis).
// Inhalt gehoert NICHT in diese Datei, sondern in Sections/.
// ---------------------------------------------------------------------------

#import "Daten.typ": *
#import "Sections/notwendig/globals.typ": *
#import "@preview/hydra:0.6.2": hydra

#let project(body) = {
  set document(author: vorname + " " + name, title: thema)

  set text(font: "Times New Roman", lang: "de", size: 11.5pt)
  set par(justify: true, leading: 0.8em, first-line-indent: 0em)
  set heading(numbering: "1.1")
  set math.equation(numbering: "(1)")

  // Verweise auf Gleichungen nur als eingeklammerte Nummer, z. B. "(6)",
  // ohne das Wort "Gleichung". Alle anderen Verweise bleiben unveraendert.
  show ref: it => {
    let el = it.element
    if el != none and el.func() == math.equation {
      link(el.location(), numbering(el.numbering, ..counter(math.equation).at(el.location())))
    } else {
      it
    }
  }

  show figure.caption: it => align(left, text(size: 9pt)[*#it.supplement #it.counter.display():* #it.body])

  // Tabellen erhalten ihre Beschriftung oberhalb (Tabellenueberschrift),
  // Abbildungen behalten die Beschriftung unterhalb.
  show figure.where(kind: table): set figure.caption(position: top)

  // Einheitliche Schriftgroesse fuer alle Tabellen im Dokument.
  // Die Beschriftung bleibt davon unberuehrt, da die Caption-Regel
  // ihre Groesse explizit setzt.
  show figure.where(kind: table): set text(size: 10pt)

  // 1.5em Abstand zwischen Ueberschrift und folgendem Text
  show heading: set block(above: 2em, below: 1.5em)

  set page(
    paper: "a4",
    margin: (x: 25mm, top: 25mm, bottom: 35mm),
    numbering: "i",
    header: context [
      #line(length: 100%, stroke: 0.5pt)
      #v(1.5mm)
      #align(right, text(fill: luma(50%), hydra(1, skip-starting: false)))
    ],
    footer: context [
      #line(length: 100%, stroke: 0.5pt)
      #v(2mm)
      #align(center)[#counter(page).display()]
    ],
  )

  // Im Inhaltsverzeichnis werden nur die Hauptkapitel (Ebene 1) fett gesetzt,
  // Unterkapitel sowie Abbildungs- und Tabellenverzeichnis bleiben normal.
  // Hauptkapitel erhalten zusaetzlich einen groesseren Abstand nach oben und
  // keine Fuellpunkte, damit sie sich klar von den Unterkapiteln absetzen.
  show outline.entry: it => {
    if it.element != none and it.element.func() == heading and it.level == 1 {
      block(
        above: 1.2em,
        below: 1.0em,
        text(weight: "bold", it.indented(it.prefix(), it.body() + h(1fr) + it.page())),
      )
    } else {
      it
    }
  }

  show outline: it => {
    in-outline.update(true)
    it
    in-outline.update(false)
  }

  counter(page).update(1)

  body
}
