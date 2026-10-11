// =============================================================================
// FOM-Template für wissenschaftliche Arbeiten (Typst)
// =============================================================================
// Setzt die formalen Vorgaben des FOM-Leitfadens zur formalen Gestaltung von
// Seminar- und Abschlussarbeiten (Stand Januar 2024) um.
//
// Verwendung in main.typ:
//
//   #import "template/fom.typ": *
//   #show: fom-arbeit.with(
//     titel: [Analyse der Einflussfaktoren ...],
//     autor: "Vorname Nachname",
//     typ: "Bachelor-Thesis",
//     ...
//   )
//
// Alle Layout-Konstanten liegen in template/styles.typ, die einzelnen
// Bausteine in template/komponenten/.

#import "styles.typ": *
#import "komponenten/abkuerzungen.typ": abk, abk-definiere
#import "komponenten/zitieren.typ": (
  ebd-setze, kette-unterbrechen, vgl, vgl-kap, vgl-nach, vgl-nach-kap, zit, zit-kap, zit-nach, zit-nach-kap, zitat,
  zitat-kap, zitat-nach, zitat-nach-kap, zitierweise-setze,
)
#import "komponenten/elemente.typ": abbildung, formel, tabelle
#import "komponenten/ki.typ": ki-hilfsmittelverzeichnis, ki-nachweis
#import "komponenten/erklaerungen.typ" as erklaerungen
#import "komponenten/erklaerungen.typ": eigenstaendigkeitserklaerung
#import "komponenten/titelblatt.typ": titelblatt-abschlussarbeit, titelblatt-seminararbeit
#import "komponenten/verzeichnisse.typ": (
  abbildungsverzeichnis, abkuerzungsverzeichnis, formelverzeichnis, inhaltsverzeichnis, symbolverzeichnis,
  tabellenverzeichnis,
)
#import "komponenten/nachspann.typ": anhang, anhang-abschnitt, literaturverzeichnis

// -----------------------------------------------------------------------------
// Haupt-Template
// -----------------------------------------------------------------------------
#let fom-arbeit(
  // --- Angaben zur Arbeit (Titelblatt, Leitfaden 2.1) ------------------------
  titel: [Titel der Arbeit],
  autor: "Vorname Nachname",
  typ: "Bachelor-Thesis", // "Master-Thesis", "Seminararbeit", "Hausarbeit"
  studiengang: none,
  grad: none, // z. B. "Bachelor of Arts (B.A.)"
  erstgutachter: none, // bei Seminararbeiten: Betreuer(in)
  matrikelnummer: none,
  abgabedatum: none, // Zeichenkette oder datetime(...)
  studienzentrum: none,
  // nur Seminararbeit: auto = Wortzahl aus der Marke <word-count> im Textteil
  // (wordometer, siehe main.typ), none = keine Zeile, Zahl/Text = feste Angabe
  wortanzahl: auto,
  modul: none, // nur Seminararbeit: "Seminararbeit in <modul>"
  hochschule: "FOM Hochschule für Oekonomie & Management",
  logo: none, // z. B. image("abbildungen/logo.png", width: 3cm)
  // --- Formale Konfiguration --------------------------------------------------
  sprache: "de",
  zitierweise: "chicago", // "chicago" (Fußnoten), "harvard" oder "apa" (im Text)
  ebd: true, // "ebd." statt Kurzbeleg bei direkt wiederholter Quelle (Leitfaden 3.2)
  schriftart: "Times New Roman", // "Arial" setzt automatisch 11,5 pt
  seitenzahl-position: "mitte", // "mitte" oder "rechts" (Leitfaden 1.2 Nr. 10)
  verzeichnis-tiefe: 3,
  abkuerzungen: (:), // ("KI": "Künstliche Intelligenz", ...)
  symbole: (:), // ("m²": "Quadratmeter", ...) -> Symbolverzeichnis
  sperrvermerk: none, // z. B. (ort: "Essen", datum: "01.08.2026")
  body,
) = {
  let groesse = schriftgroesse-fuer(schriftart)

  // --- Grundlegende Dokument- und Seiteneinstellungen (Leitfaden 1.2) --------
  set document(title: titel, author: autor)
  set page(
    paper: "a4", // Leitfaden 1.2 Nr. 1: DIN A4, Hochformat
    margin: seitenraender, // Nr. 9: oben 4, unten 2, links 4, rechts 2 cm
    numbering: none, // Titelblatt zählt mit, erhält aber keine Zahl
    number-align: top + (if seitenzahl-position == "rechts" { right } else { center }),
    header-ascent: kopfzeilen-abstand, // Seitenzahl in der Kopfzeile (Nr. 10)
  )
  set text(
    font: (schriftart,) + schrift-fallbacks,
    size: groesse,
    lang: sprache,
    region: "DE",
    hyphenate: true, // Nr. 5: automatische Silbentrennung
  )
  set par(
    justify: true, // Nr. 3: Blocksatz
    leading: zeilenabstand, // Nr. 2a: 1,5-zeilig
    spacing: absatzabstand, // Nr. 2a: 6 pt Abstand nach Absatz
    first-line-indent: 0pt,
  )

  // --- Überschriften (Nr. 2b und Nr. 8): fett, linksbündig, dekadisch --------
  set heading(numbering: "1.1")
  show heading: set text(size: groesse, weight: "bold")
  show heading: set par(justify: false)
  show heading: set block(above: abstand-vor-ueberschrift, below: abstand-nach-ueberschrift)

  // --- Abbildungen, Tabellen, Formeln (Leitfaden 2.3 und 2.5) ----------------
  // Beschriftung oberhalb, fett, linksbündig; fortlaufende Nummerierung.
  set figure.caption(position: top, separator: ": ")
  show figure: set align(left)
  show figure: set block(above: abstand-vor-ueberschrift, below: abstand-nach-ueberschrift, breakable: false)
  // Tabellen dürfen länger als eine Seite sein (z. B. Tabelle 2 in Kapitel 3) –
  // ohne diese Ausnahme überlagert Typst den Seitenumbruch mit der Quellenzeile.
  show figure.where(kind: table): set block(breakable: true)
  show figure.caption: set align(left)
  show figure.caption: set text(weight: "bold")
  show figure.caption: set par(justify: false)

  // --- Fußnoten (Nr. 2c, 6, 7): 10 pt, einzeilig, linksbündig, Trennstrich ---
  // Jede Fußnote unterbricht zusätzlich die "ebd."-Kette, damit sich "ebd."
  // immer auf die unmittelbar vorangehende Fußnote bezieht (siehe
  // komponenten/zitieren.typ).
  show footnote: kette-unterbrechen
  show footnote.entry: set text(size: fussnoten-groesse-fuer(schriftart))
  show footnote.entry: set par(
    justify: false,
    leading: fussnoten-zeilenabstand,
    spacing: fussnoten-zeilenabstand,
  )

  // --- Zustände initialisieren ------------------------------------------------
  zitierweise-setze(zitierweise)
  ebd-setze(ebd)
  abk-definiere(abkuerzungen)

  // --- Titelblatt (Seite I, ohne Seitenzahl) ----------------------------------
  if typ in ("Seminararbeit", "Hausarbeit") {
    titelblatt-seminararbeit(
      hochschule: hochschule,
      typ: typ,
      studiengang: studiengang,
      grad: grad,
      modul: modul,
      titel: titel,
      autor: autor,
      betreuer: erstgutachter,
      matrikelnummer: matrikelnummer,
      abgabedatum: abgabedatum,
      logo: logo,
      studienzentrum: studienzentrum,
      wortanzahl: wortanzahl,
    )
  } else {
    titelblatt-abschlussarbeit(
      hochschule: hochschule,
      typ: typ,
      studiengang: studiengang,
      grad: grad,
      titel: titel,
      autor: autor,
      erstgutachter: erstgutachter,
      matrikelnummer: matrikelnummer,
      abgabedatum: abgabedatum,
      logo: logo,
    )
  }

  // --- Vorspann: römische Nummerierung, beginnend mit II (Nr. 10) ------------
  set page(numbering: "I")
  inhaltsverzeichnis(tiefe: verzeichnis-tiefe)
  abbildungsverzeichnis()
  tabellenverzeichnis()
  abkuerzungsverzeichnis()
  formelverzeichnis()
  symbolverzeichnis(symbole)
  if sperrvermerk != none {
    erklaerungen.sperrvermerk(..sperrvermerk)
  }

  // --- Textteil: arabische Nummerierung, neu beginnend mit 1 (Nr. 10) --------
  // Die Seitenzahl in der Kopfzeile wird am Seitenanfang aufgelöst, bevor
  // Aktualisierungen auf derselben Seite wirken. Deshalb wird der Zähler noch
  // am Ende des Vorspanns auf 0 gesetzt; der Seitenwechsel zählt dann auf 1.
  counter(page).update(0)
  set page(numbering: "1")
  body
}
