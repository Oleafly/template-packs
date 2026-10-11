// =============================================================================
// Lernzettel: Verzeichnisse
// =============================================================================
// Abbildungs- und Tabellenverzeichnis erscheinen automatisch nur dann, wenn es
// im Dokument überhaupt Abbildungen bzw. Tabellen gibt. Damit ein Element dort
// auftaucht, muss es über #abbildung(...) bzw. #tabelle(...) aus
// Template/Elemente.typ gesetzt sein.

#import "../Config/Styles.typ": literatur-eintragsabstand, literatur-zeilenabstand
#import "Abkuerzungen.typ": _abk-definitionen, _abk-verwendet
#import "Zitieren.typ": _zitierweise

// Inhaltsverzeichnis: erfasst alle Kapitel sowie die übrigen Verzeichnisse,
// nicht aber sich selbst.
#let inhaltsverzeichnis(titel: "Inhaltsverzeichnis", tiefe: 3) = {
  pagebreak(weak: true)
  heading(level: 1, numbering: none, outlined: false, titel)
  outline(title: none, depth: tiefe, indent: auto)
}

// Interne Hilfsfunktion für Verzeichnisse über Figure-Arten.
// `seitenumbruch: false` lässt das Verzeichnis dort stehen, wo es aufgerufen
// wird – so passen mehrere kurze Verzeichnisse auf eine Seite.
#let _figur-verzeichnis(art, titel, seitenumbruch) = context {
  let eintraege = query(figure.where(kind: art))
  if eintraege.len() > 0 {
    if seitenumbruch { pagebreak(weak: true) }
    heading(level: 1, numbering: none, outlined: true, titel)
    // Einträge im Format "Abbildung 1: Titel .... Seite"
    show outline.entry: it => it.indented([#it.prefix():], it.inner())
    outline(title: none, target: figure.where(kind: art))
  }
}

// Abbildungsverzeichnis.
#let abbildungsverzeichnis(titel: "Abbildungsverzeichnis", seitenumbruch: true) = {
  _figur-verzeichnis(image, titel, seitenumbruch)
}

// Tabellenverzeichnis.
#let tabellenverzeichnis(titel: "Tabellenverzeichnis", seitenumbruch: true) = {
  _figur-verzeichnis(table, titel, seitenumbruch)
}

// Abkürzungsverzeichnis: führt automatisch alle im Text mit #abk(...)
// verwendeten Abkürzungen alphabetisch sortiert auf.
// Mit `alle: true` werden sämtliche in main.typ definierten aufgeführt.
#let abkuerzungsverzeichnis(titel: "Abkürzungsverzeichnis", alle: false, seitenumbruch: true) = context {
  let definitionen = _abk-definitionen.final()
  let kuerzel = if alle { definitionen.keys() } else { _abk-verwendet.final() }
  if kuerzel.len() > 0 {
    if seitenumbruch { pagebreak(weak: true) }
    heading(level: 1, numbering: none, outlined: true, titel)
    grid(
      columns: (auto, 1fr),
      column-gutter: 2.5em,
      row-gutter: 1em,
      align: left,
      ..kuerzel
        .sorted(key: k => lower(k))
        .map(k => ([#k], [#definitionen.at(k)]))
        .flatten(),
    )
  }
}

// Literaturverzeichnis.
//   - Format der Einträge über die mitgelieferten CSL-Stile in Template/csl/,
//     passend zur in main.typ gewählten Zitierweise.
//   - Einfacher Zeilenabstand innerhalb der Einträge, Abstand zwischen den
//     Einträgen, hängender Einzug ab der zweiten Zeile.
//
// `datei` ist ein einzelner Pfad oder eine Liste von Pfaden; ein führendes "/"
// bezieht sich auf das Projektverzeichnis.
//
// `zusaetzlich` nimmt Zitierschlüssel auf, die im Verzeichnis stehen sollen,
// ohne im Text belegt zu sein – typischerweise der Herausgeberband zu einem
// zitierten Sammelwerkbeitrag. Typst nimmt sonst nur zitierte Werke auf;
// `cite(..., form: none)` meldet den Eintrag an, ohne etwas zu setzen.
#let literaturverzeichnis(
  datei: "/Bibliography/literatur.bib",
  zusaetzlich: (),
  titel: "Literaturverzeichnis",
  stil: auto,
) = {
  pagebreak(weak: true)
  heading(level: 1, numbering: none, outlined: true, titel)
  set par(justify: false, leading: literatur-zeilenabstand, spacing: literatur-eintragsabstand)
  context {
    let zitierweise = if stil == auto { _zitierweise.get() } else { stil }
    let csl = if zitierweise == "harvard" {
      "/Template/csl/lernzettel-harvard.csl"
    } else if zitierweise == "apa" {
      "/Template/csl/lernzettel-apa.csl"
    } else {
      "/Template/csl/lernzettel-chicago.csl"
    }
    // Setzt nichts, meldet die Werke aber an die Bibliographie an.
    for schluessel in zusaetzlich {
      cite(schluessel, form: none)
    }
    bibliography(datei, title: none, style: csl)
  }
}
