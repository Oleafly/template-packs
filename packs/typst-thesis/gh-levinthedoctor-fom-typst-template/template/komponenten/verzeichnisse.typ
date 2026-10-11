// =============================================================================
// FOM-Template: Verzeichnisse des Vorspanns (Leitfaden 2.2 bis 2.5)
// =============================================================================
// Alle Verzeichnisse erscheinen mit unnummerierter Überschrift und werden –
// mit Ausnahme des Inhaltsverzeichnisses selbst (Leitfaden 2.2) – in das
// Inhaltsverzeichnis aufgenommen. Abbildungs-, Tabellen- und
// Formelverzeichnis erscheinen automatisch nur, wenn entsprechende Elemente
// in der Arbeit existieren.

#import "abkuerzungen.typ": _abk-definitionen, _abk-verwendet

// Inhaltsverzeichnis (Leitfaden 2.2): erfasst alle Bestandteile außer
// Eigenständigkeitserklärung, Titelblatt und sich selbst.
#let inhaltsverzeichnis(titel: "Inhaltsverzeichnis", tiefe: 3) = {
  pagebreak(weak: true)
  heading(level: 1, numbering: none, outlined: false, titel)
  outline(title: none, depth: tiefe, indent: auto)
}

// Interne Hilfsfunktion für Verzeichnisse über Figure-Arten.
#let _figur-verzeichnis(art, titel) = context {
  let eintraege = query(figure.where(kind: art))
  if eintraege.len() > 0 {
    pagebreak(weak: true)
    heading(level: 1, numbering: none, outlined: true, titel)
    // Einträge im Format "Abbildung 1: Titel .... Seite" (Anhang 5 und 6)
    show outline.entry: it => it.indented([#it.prefix():], it.inner())
    outline(title: none, target: figure.where(kind: art))
  }
}

// Abbildungsverzeichnis (Leitfaden 2.3, Anhang 5).
#let abbildungsverzeichnis(titel: "Abbildungsverzeichnis") = {
  _figur-verzeichnis(image, titel)
}

// Tabellenverzeichnis (Leitfaden 2.3, Anhang 6).
#let tabellenverzeichnis(titel: "Tabellenverzeichnis") = {
  _figur-verzeichnis(table, titel)
}

// Formelverzeichnis (Leitfaden 2.5, Anhang 7).
#let formelverzeichnis(titel: "Formelverzeichnis") = {
  _figur-verzeichnis("fom-formel", titel)
}

// Abkürzungsverzeichnis (Leitfaden 2.4): führt automatisch alle im Text mit
// #abk(...) verwendeten Abkürzungen alphabetisch sortiert auf.
// Mit `alle: true` werden sämtliche definierten Abkürzungen aufgeführt.
#let abkuerzungsverzeichnis(titel: "Abkürzungsverzeichnis", alle: false) = context {
  let definitionen = _abk-definitionen.final()
  let kuerzel = if alle { definitionen.keys() } else { _abk-verwendet.final() }
  if kuerzel.len() > 0 {
    pagebreak(weak: true)
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

// Formel- und Symbolverzeichnis (Leitfaden 2.5): erläutert verwendete
// Symbole. Allgemein gebräuchliche Symbole (%, €) gehören nicht hinein.
// `symbole` ist ein Dictionary: ("m²": "Quadratmeter", ...)
#let symbolverzeichnis(symbole, titel: "Symbolverzeichnis") = {
  if symbole.len() > 0 {
    pagebreak(weak: true)
    heading(level: 1, numbering: none, outlined: true, titel)
    grid(
      columns: (auto, 1fr),
      column-gutter: 2.5em,
      row-gutter: 1em,
      align: left,
      ..symbole.pairs().map(((symbol, erklaerung)) => ([#symbol], [#erklaerung])).flatten(),
    )
  }
}
