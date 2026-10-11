// Inhalts-, Abbildungs-, Tabellen- und Abkürzungsverzeichnis.
//
// Die Überschriften der Verzeichnisse setzt `layout.typ`; hier steht nur ihr Inhalt.
// Die Richtlinie schreibt die Überschriften wörtlich vor (§2.5 und §2.8).

#import "config.typ" as cfg

// Zeilenabstand der Verzeichnisse — siehe `verzeichnis-zeile` in config.typ.
#let verzeichnis-satz(body) = {
  set par(
    leading: cfg.verzeichnis-zeile - 1em,
    spacing: cfg.verzeichnis-zeile - 1em,
    justify: false,
  )
  body
}

// Die Tabellen 7 und 8 sowie die Richtlinienbeispiele schreiben Einträge der Form "Abbildung 1: Titel".
// Typst setzt standardmäßig "Abbildung 1 Titel".
#let mit-doppelpunkt(body) = {
  show outline.entry: it => {
    let bezeichnung = it.prefix()
    link(
      it.element.location(),
      it.indented(
        if bezeichnung != none { [#bezeichnung:] },
        it.inner(),
      ),
    )
  }
  body
}

// §2.5 und Tabelle 6 verlangen alle Überschriften und maximal drei Gliederungsebenen.
// Hauptkapitel stehen linksbündig und Unterkapitel eingerückt.
// Typst setzt die Seitenzahlen rechtsbündig und füllt den Abstand mit Punkten.
#let inhaltsverzeichnis() = verzeichnis-satz(outline(
  title: none,
  depth: cfg.verzeichnis-tiefe,
  indent: auto,
))

// §2.6 und Tabelle 7
#let abbildungsverzeichnis() = verzeichnis-satz(mit-doppelpunkt(outline(
  title: none,
  target: figure.where(kind: image),
)))

// §2.7 und Tabelle 8
#let tabellenverzeichnis() = verzeichnis-satz(mit-doppelpunkt(outline(
  title: none,
  target: figure.where(kind: table),
)))

// §2.8 verlangt zwei Spalten mit Kurzform und zugehöriger Langform.
// Alle im Text oder in Beschriftungen verwendeten Abkürzungen werden aufgenommen.
#let abkuerzungsverzeichnis(abkuerzungen) = context {
  if abkuerzungen.len() == 0 { return }

  let verwendet = query(<hfu-abkuerzung-verwendung>).map(element => element.value)
  for kurz in verwendet {
    assert(
      abkuerzungen.any(eintrag => eintrag.kurz == kurz),
      message: "hfu-vorlage: Die verwendete Abkürzung `" + kurz + "` ist nicht definiert.",
    )
  }

  let sortiert = abkuerzungen
    .filter(eintrag => eintrag.kurz in verwendet)
    .sorted(key: eintrag => upper(eintrag.kurz))

  if sortiert.len() > 0 {
    verzeichnis-satz(table(
      columns: (auto, 1fr),
      column-gutter: 1.5em,
      row-gutter: cfg.verzeichnis-zeile - 1em,
      align: (left, left),
      stroke: none,
      inset: 0pt,
      ..sortiert.map(eintrag => (eintrag.kurz, eintrag.lang)).flatten(),
    ))
  }
}
