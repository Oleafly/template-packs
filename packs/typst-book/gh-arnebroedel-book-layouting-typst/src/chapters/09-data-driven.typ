// chapters/09-data-driven.typ — Datengetriebene Dokumente
// Populated in Phase 2

#import "../styles/theme.typ": fonts, palette, space, type-scale
#import "../components/spreads.typ": chapter-opener, section-break
#import "../components/blocks.typ": callout, card, code-block, key-concept, pull-quote, side-note
#import "../components/inline.typ": badge
#import "../components/grids.typ": feature-grid, stats-grid
#import "../components/tables.typ": styled-table
#import "@preview/zero:0.6.1": ztable
#import "@preview/in-dexter:0.7.2": index

// ════════════════════════════════════════════════════════════════
// DATA LOADING
// ════════════════════════════════════════════════════════════════
#let patient-data = json("../data/sample-patients.json")
#let study-raw = csv("../data/sample-study.csv")
#let study-headers = study-raw.first()
#let study-rows = study-raw.slice(1)
// Readable column labels — the raw CSV headers contain unbreakable
// underscore tokens (e.g. Median_OS_Monate) that would overflow the page.
#let study-display-headers = (
  [Therapie],
  [N],
  [Ansprech-\ rate (%)],
  [Median OS\ (Mon.)],
  [NW Grad\ ≥3 (%)],
  [p-Wert],
)
// Proportional columns guarantee the 6-column table always fits the page.
#let study-cols = (2.2fr, 0.7fr, 1.3fr, 1.3fr, 1.4fr, 1fr)

// ════════════════════════════════════════════════════════════════
// CHAPTER OPENER
// ════════════════════════════════════════════════════════════════
#chapter-opener(
  title: [Datengetriebene Dokumente],
  lead: [
    Moderne Dokumente entstehen nicht mehr durch manuelles Tippen —
    sie werden aus strukturierten Daten generiert. Typst bietet
    leistungsfähige Werkzeuge, um JSON, YAML und CSV direkt in
    publikationsreife Inhalte zu verwandeln.
  ],
)

// ════════════════════════════════════════════════════════════════
== Die Philosophie datengetriebener Dokumente

In der medizinischen Dokumentation#index[medizinische Dokumentation] stehen Genauigkeit und
Reproduzierbarkeit#index[Reproduzierbarkeit] an erster Stelle. Datengetriebene Dokumente
trennen den _Inhalt_ von der _Darstellung_ und ermöglichen es,
dieselben Daten in unterschiedlichen Formaten auszugeben — ohne
erneute manuelle Erfassung.

#key-concept(term: [Datentrennung])[
  Das Prinzip _Separation of Concerns_ in der Dokumentenerstellung:
  Strukturierte Daten (JSON, CSV, YAML) werden unabhängig von
  Layout-Entscheidungen gepflegt. Änderungen an den Daten
  aktualisieren automatisch alle abhängigen Dokumente.
]

#callout(title: [Eingebaute Datenformate], tone: "info")[
  Typst unterstützt nativ — ohne externe Pakete:

  #styled-table(
    columns: (1fr, 2.5fr),
    table.header([*Funktion*], [*Beschreibung*]),
    [`json()`],
    [JavaScript Object Notation — verschachtelte Strukturen],
    [`csv()`],
    [Komma-getrennte Tabellendaten],
    [`yaml()`],
    [Konfigurationsdateien, Glossare, Metadaten],
    [`toml()`],
    [Tom's Obvious Minimal Language — Einstellungen],
    [`xml()`],
    [Extensible Markup Language — Austauschformate],
  )
]

// ════════════════════════════════════════════════════════════════
== JSON — Patientenberichte aus strukturierten Daten

Das Herzstück dieses Kapitels: Aus einer einzigen JSON#index[JSON]-Datei mit
Patientendaten erzeugen wir eine vollständige Stationsübersicht.
Die Datei `sample-patients.json` enthält #str(patient-data.patienten.len())
Patientenakten der Abteilung _#{ patient-data.abteilung }_.

=== Automatische Patientenübersicht

#styled-table(
  columns: (auto, 1.5fr, auto, 2fr, auto),
  table.header(
    [*ID*],
    [*Name*],
    [*Alter*],
    [*Diagnose*],
    [*Status*],
  ),
  ..patient-data
    .patienten
    .map(p => (
      p.id,
      p.name,
      str(p.alter),
      p.diagnose,
      p.status,
    ))
    .flatten(),
)

#callout(title: [Automatische Aktualisierung], tone: "success")[
  Diese Tabelle wird bei jeder Kompilierung direkt aus der JSON-Datei
  erzeugt. Wird ein Patient hinzugefügt oder entlassen, genügt eine
  Änderung in der Datenquelle — das Dokument passt sich automatisch an.
]

=== Individuelle Patientenkarten

Mithilfe einer Schleife erzeugen wir für jeden Patienten eine
strukturierte Karte mit Diagnose, Medikation und Vitalzeichen:

#for patient in patient-data.patienten {
  let status-color = if patient.status == "kritisch" {
    palette.danger
  } else if patient.status == "stabil" {
    palette.success
  } else if patient.status == "entlassen" {
    palette.text-light
  } else {
    palette.primary
  }

  card(
    title: [#patient.name (#patient.id)],
    accent: status-color,
  )[
    *Diagnose:* #patient.diagnose \
    *Alter:* #str(patient.alter) Jahre #h(1em)
    *Status:* #badge(patient.status, color: status-color) \
    *Medikamente:* #patient.medikamente.join(", ") \
    *Vitalzeichen:* BD #patient.vitalzeichen.blutdruck,
    Puls #str(patient.vitalzeichen.puls),
    SpO#sub[2] #str(patient.vitalzeichen.spo2)%,
    Temp #str(patient.vitalzeichen.temperatur)°C
  ]
}

=== Kritische Patienten-Erkennung

#{
  let critical = patient-data.patienten.filter(p => p.status == "kritisch")

  callout(title: [Kritische Patienten], tone: "danger")[
    #for p in critical [
      *#p.name* — SpO#sub[2]: #str(p.vitalzeichen.spo2)%,
      Puls: #str(p.vitalzeichen.puls)/min,
      BD: #p.vitalzeichen.blutdruck #linebreak()
    ]
    _Anzahl: #str(critical.len()) von #str(patient-data.patienten.len()) Patienten_
  ]
}

// ════════════════════════════════════════════════════════════════
== CSV — Studienergebnisse automatisch auswerten

CSV#index[CSV]-Dateien sind das Standardformat für tabellarische Forschungsdaten.
Typst liest sie mit `csv()` als verschachteltes Array und erlaubt
sowohl die direkte Darstellung als auch berechnete Analysen.

=== Ergebnistabelle

#figure(
  {
    set text(size: type-scale.small)
    styled-table(
      columns: study-cols,
      table.header(..study-display-headers.map(strong)),
      ..study-rows.flatten(),
    )
  },
  caption: [Klinische Studienergebnisse — automatisch aus CSV generiert.],
)

=== Dezimal-Ausrichtung mit Zero

Für numerische Tabellen ist die Ausrichtung am Dezimaltrennzeichen entscheidend
für die Lesbarkeit. Das Paket *Zero*#index[Zero] bietet mit `ztable` einen Drop-in-Ersatz für
`table`, der über den `format`-Parameter pro Spalte die Zahlenausrichtung aktiviert
(`auto` = ausrichten, `none` = unverändert):

#figure(
  {
    set text(size: type-scale.small)
    ztable(
      columns: study-cols,
      align: (left, right, right, right, right, right),
      inset: (x: 6pt, y: 5pt),
      fill: (x, y) => if y == 0 { palette.bg-subtle },
      stroke: (x, y) => if y == 0 { (bottom: 0.8pt + palette.primary) } else {
        (bottom: 0.4pt + palette.border-light)
      },
      // Spalte 0 (Therapie) und 5 (p-Wert mit "<0.001") als Text; 1–4 numerisch ausrichten.
      format: (none, auto, auto, auto, auto, none),
      table.header(..study-display-headers.map(strong)),
      ..study-rows.flatten(),
    )
  },
  caption: [Dieselben CSV-Daten mit Zero — die Zahlenspalten sind am Dezimalpunkt ausgerichtet.],
)

=== Berechnete Analyse

Typst kann direkt auf den geladenen Daten rechnen. Hier ermitteln wir
die Therapie mit der höchsten Ansprechrate:

#{
  // Index 2 = Ansprechrate
  let best = study-rows.sorted(key: r => float(r.at(2))).last()

  callout(title: [Ergebnis der Analyse], tone: "success")[
    Die höchste Ansprechrate zeigt *#best.at(0)* mit
    *#best.at(2)#sym.percent* bei N\=#best.at(1) Patienten
    (Median OS: #best.at(3) Monate, p\=#best.at(5)).
  ]
}

#side-note(title: [Statistische Grenzen])[
  Typst eignet sich hervorragend für die _Darstellung_ von
  Analyseergebnissen. Für komplexe statistische Berechnungen
  (Regression, Überlebenskurven) empfiehlt sich die Vorverarbeitung
  mit R oder Python — die Ergebnisse werden dann als CSV oder JSON
  an Typst übergeben.
]

// ════════════════════════════════════════════════════════════════
== sys.inputs — Externe Parametrisierung

Über das `sys.inputs`-Dictionary können Kommandozeilen-Parameter in
das Dokument injiziert werden — ideal für Build-Varianten#index[Build-Variante], Datumsangaben
oder Umgebungskonfigurationen.

#code-block(title: [Kommandozeile])[
  ```sh
  typst compile --input mode=final --input date=2026-02-15 main.typ
  ```
]

#{
  let build-mode = sys.inputs.at("mode", default: "draft")
  let report-date = sys.inputs.at("date", default: datetime.today().display())

  callout(title: [Build-Konfiguration], tone: "info")[
    *Modus:* #build-mode \
    *Datum:* #report-date
  ]
}

#callout(title: [Typhinweis], tone: "warning")[
  Alle Werte in `sys.inputs` sind *Strings*. Numerische oder boolesche
  Werte müssen explizit konvertiert werden: `int(sys.inputs.at("count"))`.
]

// ════════════════════════════════════════════════════════════════
== Muster — Bedingte und berechnete Inhalte

Datengetriebene Dokumente#index[datengetriebene Dokumente] ermöglichen leistungsfähige dynamische
Muster, die den Inhalt abhängig von den Daten variieren.

=== Abteilungsstatistik

#{
  let total = patient-data.patienten.len()
  let avg-age = calc.round(
    patient-data.patienten.map(p => p.alter).sum() / total,
    digits: 1,
  )
  let crit-count = patient-data.patienten.filter(p => p.status == "kritisch").len()
  let med-count = patient-data.patienten.map(p => p.medikamente.len()).sum()

  stats-grid((
    (value: [#total], label: [Patienten gesamt]),
    (value: [#avg-age], label: [Durchschnittsalter]),
    (value: [#crit-count], label: [Kritische Fälle]),
    (value: [#med-count], label: [Verordnungen]),
  ))
}

=== Bedingte Inhaltssteuerung

#{
  let build-mode = sys.inputs.at("mode", default: "draft")

  if build-mode == "draft" {
    callout(title: [Entwurf], tone: "warning")[
      Dieses Dokument ist ein Entwurf und nicht zur Veröffentlichung
      freigegeben. Build-Modus: _#{ build-mode }_.
    ]
  }
}

#feature-grid(
  column-count: 2,
  (
    (
      icon: sym.arrow.r.double,
      title: [Daten → Dokument],
      body: [JSON, CSV und YAML werden zur Kompilierzeit eingelesen
        und direkt in Typst-Inhalte umgewandelt.],
    ),
    (
      icon: sym.checkmark,
      title: [Reproduzierbarkeit],
      body: [Identische Datenquellen erzeugen identische Dokumente —
        unabhängig vom Zeitpunkt der Kompilierung.],
    ),
  ),
)

#v(space.lg)

#pull-quote(
  attribution: [— Grundsatz der klinischen Dokumentation],
)[
  Jede manuell übertragene Zahl ist eine potenzielle Fehlerquelle.
  Automatisierte Datenübernahme eliminiert Übertragungsfehler und
  sichert die Datenintegrität.
]
