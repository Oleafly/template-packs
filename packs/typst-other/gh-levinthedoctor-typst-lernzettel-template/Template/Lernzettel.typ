// =============================================================================
// Lernzettel-Template
// =============================================================================
// Verwendung in main.typ:
//
//   #import "Template/Lernzettel.typ": *
//   #show: lernzettel.with(titel: [Mein Thema], autor: "Vorname Nachname")
//
// Diese Datei re-exportiert sämtliche Bausteine. main.typ und die Kapitel in
// Content/ importieren deshalb nur sie – nicht die Einzeldateien.
//
// Aufbau:
//   Config/Styles.typ            Farben und Maße (einzige Stelle für Maße)
//   Template/Cover.typ           Deckblatt
//   Template/Zitieren.typ        #vgl / #zit / #zitat – Fußnoten-Kurzbelege
//   Template/Abkuerzungen.typ    #abk – erste Nutzung mit Langform
//   Template/Verzeichnisse.typ   Inhalt / Abbildungen / Tabellen / Abkürzungen
//   Template/Elemente.typ        #abbildung, #tabelle (mit Quellenzeile)
//   Template/Komponenten/        Boxen, Layout-Bausteine, Tabellen

#import "../Config/Styles.typ": *
#import "Cover.typ": deckblatt as _deckblatt
#import "Abkuerzungen.typ": abk, abk-definiere
#import "Zitieren.typ": (
  ebd-setze, kette-unterbrechen, vgl, vgl-kap, vgl-nach, vgl-nach-kap, zit, zit-kap, zit-nach, zit-nach-kap, zitat,
  zitat-kap, zitat-nach, zitat-nach-kap, zitierweise-setze,
)
#import "Elemente.typ": abbildung, tabelle
#import "Verzeichnisse.typ": (
  abbildungsverzeichnis, abkuerzungsverzeichnis, inhaltsverzeichnis, literaturverzeichnis, tabellenverzeichnis,
)
#import "Komponenten/Boxen.typ": aufgabe, beispiel, infobox, merksatz, resetaufgaben, titledbox, warnbox
#import "Komponenten/Layout.typ": konzeptkarte, process, procon, zweispaltig
#import "Komponenten/Tabellen.typ": stdtable

// -----------------------------------------------------------------------------
// Haupt-Template
// -----------------------------------------------------------------------------
#let lernzettel(
  // --- Angaben zum Lernzettel (Deckblatt) ------------------------------------
  titel: [Lernzettel],
  subtitel: none,
  subject: none,
  description: none,
  autor: "",
  datum: none,
  // --- Seitenlayout (alles in main.typ überschreibbar) ------------------------
  papier: papier-standard, // "a4", "a5", "us-letter", ...
  raender: raender-standard, // (top:, bottom:, left:, right:) oder (x:, y:)
  schriftgroesse: schriftgroesse-standard,
  schriftart: auto, // auto = `font` aus Config/Styles.typ
  zeilenabstand: zeilenabstand-standard,
  absatzabstand: auto, // auto = zeilenabstand + 6pt
  spalten: 1, // 2 = zweispaltiger Fließtext
  blocksatz: false,
  sprache: "de",
  // --- Struktur ---------------------------------------------------------------
  deckblatt: true,
  inhaltsverzeichnis-anzeigen: true,
  abbildungsverzeichnis-anzeigen: true,
  tabellenverzeichnis-anzeigen: true,
  abkuerzungsverzeichnis-anzeigen: true,
  verzeichnis-tiefe: 3,
  // --- Zitieren ---------------------------------------------------------------
  zitierweise: "chicago", // "chicago" = Fußnoten, "harvard"/"apa" = im Text
  ebd: true, // "ebd." statt Kurzbeleg bei direkt wiederholter Quelle
  abkuerzungen: (:), // ("KI": "Künstliche Intelligenz", ...)
  body,
) = {
  let schrift = if schriftart == auto { font } else { schriftart }
  let par-abstand = if absatzabstand == auto { zeilenabstand + 6pt } else { absatzabstand }

  // --- Dokument- und Seiteneinstellungen -------------------------------------
  set document(title: titel, author: autor)
  set page(
    paper: papier,
    margin: raender,
    numbering: "1",
    number-align: center + bottom,
  )
  set text(
    font: schrift,
    size: schriftgroesse,
    lang: sprache,
    region: "DE",
    hyphenate: true,
    fill: primary,
  )
  set par(
    justify: blocksatz,
    leading: zeilenabstand,
    spacing: par-abstand,
    first-line-indent: 0pt,
  )

  // --- Überschriften ----------------------------------------------------------
  set heading(numbering: "1.1")
  show heading: set block(above: abstand-vor-ueberschrift, below: abstand-nach-ueberschrift)
  show heading: set par(justify: false)
  show heading.where(level: 1): set text(size: 1.6em, weight: "bold", fill: primary)
  show heading.where(level: 2): set text(size: 1.25em, weight: "bold", fill: primary)
  show heading.where(level: 3): set text(size: 1.1em, weight: "bold", fill: accent)
  show heading.where(level: 4): set text(size: 1em, weight: "bold", fill: accent)

  // --- Abbildungen und Tabellen ------------------------------------------------
  // Beschriftung oberhalb, fett, linksbündig; fortlaufende Nummerierung.
  set figure.caption(position: top, separator: ": ")
  show figure: set align(left)
  show figure: set block(above: abstand-vor-ueberschrift, below: abstand-nach-abbildung, breakable: false)
  // Lange Tabellen dürfen umbrechen – sonst überlagert der Seitenumbruch die
  // Quellenzeile.
  show figure.where(kind: table): set block(breakable: true)
  show figure.caption: set align(left)
  show figure.caption: set text(weight: "bold")
  show figure.caption: set par(justify: false)

  // --- Code --------------------------------------------------------------------
  // Typst bringt das Syntax-Highlighting mit; hier kommt nur das Styling dazu.
  //   Codeblock:   ```python ... ```
  //   Inline-Code: `quicksort(arr)`
  show raw: set text(font: monofont, size: 0.9em)
  show raw.where(block: true): it => block(
    width: 100%,
    fill: codeblock,
    stroke: 0.8pt + codeframe,
    radius: 4pt,
    inset: (x: 10pt, y: 8pt),
    breakable: true,
    above: 1.2em,
    below: 1.2em,
    it,
  )
  // Die Textfarbe wird hier bewusst fest gesetzt und nicht geerbt: Steht Inline-
  // Code in einer farbigen Titelleiste (Titel-Chip einer Box, Kopfzeile von
  // #procon oder #konzeptkarte), ist die Schrift dort weiß – auf dem hellen
  // Chip-Hintergrund wäre der Code sonst unsichtbar.
  show raw.where(block: false): it => box(
    fill: codeblock,
    stroke: 0.5pt + codeframe,
    radius: 2pt,
    inset: (x: 3pt, y: 1pt),
    outset: (y: 2pt),
    text(fill: primary, it),
  )

  // --- Hochgestellte Ziffern ------------------------------------------------------
  // Manche Schriften – Helvetica Neue ist der prominenteste Fall – bringen zwar
  // echte `sups`-Glyphen mit, die aber winzig sind: Fußnotenziffern erscheinen
  // dann als kaum sichtbare Pünktchen. `typographic: false` erzwingt, dass Typst
  // die Ziffern selbst verkleinert und anhebt, statt die Glyphen der Schrift zu
  // nehmen. Das betrifft jede Fußnotenziffer und damit jeden Beleg.
  set super(typographic: false, size: 0.65em)

  // --- Fußnoten -----------------------------------------------------------------
  // `kette-unterbrechen` ist zwingend: Jede Fußnote beendet die "ebd."-Kette,
  // damit sich "ebd." immer auf die unmittelbar vorangehende Fußnote bezieht
  // (siehe die Konvergenz-Hinweise in Template/Zitieren.typ).
  show footnote: kette-unterbrechen
  show footnote.entry: set text(size: fussnoten-groesse)
  show footnote.entry: set par(
    justify: false,
    leading: fussnoten-zeilenabstand,
    spacing: fussnoten-zeilenabstand,
  )

  // --- Zustände initialisieren ----------------------------------------------------
  zitierweise-setze(zitierweise)
  ebd-setze(ebd)
  abk-definiere(abkuerzungen)

  // --- Deckblatt --------------------------------------------------------------------
  if deckblatt {
    _deckblatt(
      titel: titel,
      subtitel: subtitel,
      subject: subject,
      description: description,
      autor: autor,
      datum: datum,
    )
  }

  // --- Vorspann ----------------------------------------------------------------------
  // Das Inhaltsverzeichnis bekommt eine eigene Seite. Die drei kurzen
  // Verzeichnisse teilen sich die folgende – jedes einzeln auf eine eigene zu
  // setzen, verschenkt bei einem Lernzettel zu viel Platz. Jedes von ihnen
  // erscheint ohnehin nur, wenn es etwas zu listen gibt.
  if inhaltsverzeichnis-anzeigen { inhaltsverzeichnis(tiefe: verzeichnis-tiefe) }
  pagebreak(weak: true)
  if abbildungsverzeichnis-anzeigen { abbildungsverzeichnis(seitenumbruch: false) }
  if tabellenverzeichnis-anzeigen { tabellenverzeichnis(seitenumbruch: false) }
  if abkuerzungsverzeichnis-anzeigen { abkuerzungsverzeichnis(seitenumbruch: false) }

  // --- Textteil ----------------------------------------------------------------------
  // Mehrspaltig über `set page(columns: …)` und nicht über `columns(…, body)`:
  // `columns` ist ein Container, und in Containern sind Seitenumbrüche verboten.
  // Der Textteil braucht sie aber – jedes #literaturverzeichnis() und jedes
  // manuelle #pagebreak() im Kapitel würde sonst mit "pagebreaks are not allowed
  // inside of containers" abbrechen.
  if spalten > 1 {
    set page(columns: spalten)
    pagebreak(weak: true)
    body
  } else {
    pagebreak(weak: true)
    body
  }
}
