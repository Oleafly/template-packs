// chapters/08-packages.typ — Pakete & Ökosystem

#import "../styles/theme.typ": fonts, palette, space, type-scale
#import "../components/spreads.typ": chapter-opener, section-break
#import "../components/blocks.typ": callout, card, code-block, key-concept, pull-quote, side-note
#import "../components/inline.typ": badge, icon-text, tag
#import "../components/grids.typ": feature-grid, gallery-grid
#import "../components/layouts.typ": comparison-layout
#import "../components/tables.typ": styled-table
#import "@preview/in-dexter:0.7.2": index

// ── Package imports ────────────────────────────────────────────
#import "@preview/cetz:0.5.2": canvas, draw
#import "@preview/fletcher:0.5.8" as fletcher: diagram, edge, node

#chapter-opener(
  title: [Pakete & Ökosystem],
  lead: [
    Typst bietet eine mächtige Grundausstattung — doch die wahre Stärke
    eines modernen Satzsystems liegt in seiner Erweiterbarkeit. In diesem
    Kapitel erkunden wir das Typst Universe und demonstrieren, wie
    Community-Pakete die Möglichkeiten der Dokumentenerstellung
    dramatisch erweitern.
  ],
)

// ════════════════════════════════════════════════════════════════
== Das Typst Universe

Das _Typst Universe_#index[Typst Universe] ist die zentrale Paketregistrierung für Typst. Hier
veröffentlicht die Community wiederverwendbare Bibliotheken für Grafiken,
Tabellenlayouts, Vorlagen und vieles mehr. Pakete werden beim ersten Import
automatisch heruntergeladen — eine separate Installation ist nicht nötig.

#callout(title: [Der `\@preview`-Namensraum], tone: "info")[
  Alle Community-Pakete leben unter dem `\@preview`-Namensraum. Jeder
  Import folgt dem Schema: \
  `\#import "\@preview/paketname:version": funktion` \
  Die Version wird _immer_ angepinnt, um reproduzierbare Builds zu
  garantieren.
]

Pakete decken ein breites Spektrum ab:

#gallery-grid(
  (
    [*Grafik & Diagramme* \ CeTZ, fletcher, Touying],
    [*Code & Syntax* \ codly, codelst, sourcerer],
    [*Tabellen & Daten* \ tablem, tablex, oxifmt],
    [*Vorlagen & Stile* \ showybox, charged-ieee, modern-cv],
  ),
  column-count: 2,
)

#v(space.md)

// ════════════════════════════════════════════════════════════════
== Grafiken & Diagramme mit CeTZ

CeTZ#index[CeTZ] (_Canvas for Typst_) ist die leistungsfähigste Grafikbibliothek im
Typst-Ökosystem. Sie bietet ein koordinatenbasiertes Zeichensystem mit
Pfaden, Formen, Transformationen und benannten Ankerpunkten — vergleichbar
mit TikZ#index[TikZ] in der LaTeX-Welt, aber mit modernerer Syntax.

=== Vitalzeichenverlauf

Ein typisches Anwendungsszenario in der Klinik: die Darstellung von
Patientendaten über die Zeit.

#figure(
  canvas(length: 1cm, {
    import draw: *

    // ── Achsen ──
    set-style(stroke: 0.6pt + palette.text-muted)
    line((0, 0), (7.5, 0))
    line((0, 0), (0, 5.5))

    // Achsenbeschriftungen
    content((3.75, -0.7), text(size: type-scale.small, fill: palette.text-muted, [Zeit (Stunden)]))
    content((-1.2, 2.75), angle: 90deg, text(size: type-scale.small, fill: palette.text-muted, [Puls (bpm)]))

    // Y-Achse: Ticks (60–100 bpm, skaliert: 60→0, 100→5)
    for (val, label) in ((0, "60"), (1.25, "70"), (2.5, "80"), (3.75, "90"), (5, "100")) {
      line((-0.15, val), (0, val))
      content((-0.5, val), text(size: type-scale.micro, fill: palette.text-muted, label))
    }

    // X-Achse: Stunden
    for h in range(1, 8) {
      let x = float(h)
      line((x, 0), (x, -0.15))
      content((x, -0.35), text(size: type-scale.micro, fill: palette.text-muted, str(h)))
    }

    // Normalbereich (60–100 bpm) als subtiler Hintergrund
    rect((0, 0), (7.5, 5), fill: palette.success.transparentize(92%), stroke: none)

    // Datenpunkte: Puls 72, 78, 85, 82, 76, 74, 71 bpm
    // Skalierung: (bpm - 60) / 8 = y
    let data = ((1, 1.5), (2, 2.25), (3, 3.125), (4, 2.75), (5, 2.0), (6, 1.75), (7, 1.375))

    // Linie zeichnen
    for i in range(data.len() - 1) {
      line(data.at(i), data.at(i + 1), stroke: 1.8pt + palette.primary)
    }

    // Punkte
    for pt in data {
      circle(pt, radius: 0.1, fill: palette.primary, stroke: 0.5pt + white)
    }
  }),
  caption: [Pulsverlauf eines Patienten über 7 Stunden — erstellt mit CeTZ.],
  alt: "Liniendiagramm des Pulsverlaufs über sieben Stunden, durchgehend im Normalbereich von 60 bis 100 bpm.",
)

#side-note(title: [CeTZ-Tipp])[
  CeTZ nutzt ein eigenes Koordinatensystem. Der `length`-Parameter auf
  dem `canvas` steuert die Skalierung — mischen Sie CeTZ-Koordinaten
  nicht mit Typst-Layouteinheiten.
]

=== Organsystem-Schema

Auch vereinfachte anatomische Schemata lassen sich als
Blockdiagramme darstellen:

#figure(
  canvas(length: 0.9cm, {
    import draw: *

    // ZNS
    rect(
      (1.5, 4.5),
      (5.5, 5.5),
      fill: palette.primary.lighten(80%),
      stroke: 0.8pt + palette.primary,
      radius: 4pt,
      name: "zns",
    )
    content("zns", text(size: type-scale.small, weight: "bold", fill: palette.primary-dark, [Zentrales Nervensystem]))

    // Herz
    rect(
      (0, 2.5),
      (3, 3.5),
      fill: palette.danger.lighten(85%),
      stroke: 0.8pt + palette.danger,
      radius: 4pt,
      name: "herz",
    )
    content("herz", text(size: type-scale.small, weight: "bold", fill: palette.danger, [Herz]))

    // Lunge
    rect((4, 2.5), (7, 3.5), fill: palette.info.lighten(85%), stroke: 0.8pt + palette.info, radius: 4pt, name: "lunge")
    content("lunge", text(size: type-scale.small, weight: "bold", fill: palette.info, [Lunge]))

    // Niere
    rect(
      (1.5, 0.5),
      (5.5, 1.5),
      fill: palette.warning.lighten(85%),
      stroke: 0.8pt + palette.warning,
      radius: 4pt,
      name: "niere",
    )
    content("niere", text(size: type-scale.small, weight: "bold", fill: palette.accent-dark, [Niere]))

    // Verbindungen
    set-style(stroke: 0.8pt + palette.text-muted, mark: (end: ">", size: 0.25))
    line("zns.south", "herz.north")
    line("zns.south", "lunge.north")
    line("herz.south", "niere.north")
    line("lunge.south", "niere.north")
    line("herz.east", "lunge.west", mark: (end: ">", start: ">", size: 0.25))
  }),
  caption: [Vereinfachtes Organsystem-Schema mit CeTZ — Blöcke und Verbindungen.],
  alt: "Blockschema vernetzter Organsysteme — zentrales Nervensystem, Herz, Lunge und Niere — mit verbindenden Pfeilen.",
)

// ════════════════════════════════════════════════════════════════
== Flussdiagramme mit Fletcher

Für klinische Entscheidungsbäume#index[Entscheidungsbaum] und Prozessdiagramme ist _Fletcher_#index[Fletcher] das
Werkzeug der Wahl. Es baut auf CeTZ auf und bietet eine deklarative
Syntax für Knoten und Kanten.

#figure(
  diagram(
    spacing: (12mm, 14mm),
    node-stroke: 0.8pt + palette.text-muted,
    node-inset: 4pt, // fletcher 0.5.8: inset-Halbierungs-Fix (war effektiv 4pt bei 8pt-Angabe)

    node((0, 0), [*Brustschmerz*], shape: fletcher.shapes.pill, fill: palette.primary.lighten(80%)),

    edge((0, 0), (0, 1), "-|>", label: [Anamnese], label-side: right),
    node((0, 1), align(center)[EKG-\ Veränderung?], shape: fletcher.shapes.diamond, fill: palette.warning.lighten(85%)),

    edge((0, 1), (-1, 2), "-|>", label: [Ja], label-side: left),
    node((-1, 2), [Troponin\ bestimmen], fill: palette.danger.lighten(85%)),

    edge((0, 1), (1, 2), "-|>", label: [Nein], label-side: right),
    node((1, 2), [Belastungs-\ EKG], fill: palette.success.lighten(85%)),

    edge((-1, 2), (-1, 3), "-|>"),
    node((-1, 3), [Kardiologie-\ Konsil], shape: fletcher.shapes.pill, fill: palette.danger.lighten(70%)),

    edge((1, 2), (1, 3), "-|>"),
    node((1, 3), [Ambulante\ Kontrolle], shape: fletcher.shapes.pill, fill: palette.success.lighten(70%)),
  ),
  caption: [Klinischer Entscheidungsbaum: Brustschmerz-Triage — erstellt mit Fletcher.],
)

#callout(title: [Fletcher-Hinweis], tone: "info")[
  Fletcher verwendet `(Spalte, Zeile)`-Koordinaten — Zeilen wachsen
  _nach unten_. Der `spacing`-Parameter steuert den Abstand zwischen
  Knoten. Nutzen Sie `label-side` für die Platzierung von
  Kantenbeschriftungen.
]

// ════════════════════════════════════════════════════════════════
== Code-Darstellung mit Codly

Wenn technische Dokumentation Code-Beispiele enthält — sei es für
Datenprotokolle, Konfigurationsdateien oder Analyseskripte — bietet
_Codly_#index[Codly] professionelle Syntax-Hervorhebung mit Zeilennummern und
visueller Struktur.

#{
  import "@preview/codly:1.3.0": codly, codly-init
  show: codly-init

  codly(
    zebra-fill: palette.bg-subtle,
    stroke: 0.5pt + palette.border-light,
    number-format: n => text(fill: palette.text-light, size: type-scale.small, str(n)),
  )

  figure(
    ```json
    {
      "patient_id": "PAT-2026-001",
      "diagnose": "Hypertonie Grad II",
      "medikamente": [
        {"name": "Ramipril", "dosis": "5mg", "frequenz": "1x täglich"},
        {"name": "Amlodipin", "dosis": "10mg", "frequenz": "1x täglich"}
      ],
      "vitalzeichen": {
        "blutdruck": "145/92",
        "puls": 78,
        "spo2": 97
      }
    }
    ```,
    caption: [Strukturiertes Patientendatenprotokoll im JSON-Format — dargestellt mit Codly.],
  )
}

#callout(title: [Codly-Hinweis], tone: "success")[
  Codly unterstützt Zeilennummern, Zebra-Streifen und automatische
  Spracherkennung. Die Konfiguration wird _einmal_ gesetzt und gilt
  für alle nachfolgenden Code-Blöcke im selben Geltungsbereich.
]

// ════════════════════════════════════════════════════════════════
== Erweiterte Container mit Showybox

Während die eingebauten Callouts und Cards für die meisten Szenarien
ausreichen, bietet _Showybox_#index[Showybox] erweiterte Gestaltungsmöglichkeiten
für besonders auffällige Hinweisboxen.

#{
  import "@preview/showybox:2.0.4": showybox

  showybox(
    frame: (
      border-color: palette.danger,
      title-color: palette.danger.lighten(80%),
      body-color: palette.danger.lighten(95%),
      thickness: 2pt,
      radius: 4pt,
    ),
    title-style: (
      color: palette.danger.darken(20%),
      weight: "bold",
    ),
    title: [Arzneimittelinteraktion],
    [
      *Warfarin + NSAR:* Die gleichzeitige Gabe von Warfarin und
      nicht-steroidalen Antirheumatika erhöht das Blutungsrisiko
      signifikant. INR-Kontrolle innerhalb von 3 Tagen erforderlich.
    ],
  )

  v(space.md)

  showybox(
    frame: (
      border-color: palette.success,
      title-color: palette.success.lighten(80%),
      body-color: palette.success.lighten(95%),
      thickness: 1.5pt,
      radius: 4pt,
    ),
    title-style: (
      color: palette.success.darken(20%),
      weight: "bold",
    ),
    title: [Klinischer Merksatz],
    [
      Bei Verdacht auf akutes Koronarsyndrom gilt die Regel: *Zeit ist
      Muskel.* Die Door-to-Balloon-Zeit sollte 90 Minuten nicht
      überschreiten.
    ],
  )
}

#side-note(title: [Wann Showybox?])[
  Verwenden Sie die eingebauten `callout`- und `card`-Komponenten für
  den Standardfall. Showybox eignet sich besonders für hervorgehobene
  Warnhinweise mit individueller Gestaltung.
]

// ════════════════════════════════════════════════════════════════
== Markdown-Tabellen mit Tablem

Für schnelle Tabellen bietet _Tablem_#index[Tablem] eine Markdown-kompatible Syntax
direkt in Typst:

#{
  import "@preview/tablem:0.3.0": tablem

  figure(
    tablem[
      | Vitalzeichen | Wert | Normalbereich | Status |
      |---|---|---|---|
      | Blutdruck | 145/92 mmHg | \<140/90 | Erhöht |
      | Puls | 78/min | 60–100 | Normal |
      | SpO#sub[2] | 97% | \>95% | Normal |
      | Temperatur | 36.8°C | 36.0–37.5 | Normal |
    ],
    caption: [Vitalzeichen-Übersicht — erstellt mit Tablem-Markdown-Syntax.],
  )
}

// ════════════════════════════════════════════════════════════════
== Schnellreferenz — Weitere Pakete

Das Typst Universe#index[Paketregistrierung] wächst stetig. Hier eine Auswahl weiterer nützlicher
Pakete, die den Arbeitsalltag erleichtern:

#styled-table(
  columns: (1.5fr, 2fr, 2fr),
  table.header(
    [*Paket*],
    [*Zweck*],
    [*Import*],
  ),
  [CeTZ],
  [Vektordiagramme, Plots, Koordinatensysteme],
  [`\@preview/cetz`],
  [fletcher],
  [Flussdiagramme, Zustandsautomaten],
  [`\@preview/fletcher`],
  [codly],
  [Syntax-Hervorhebung mit Zeilennummern],
  [`\@preview/codly`],
  [showybox],
  [Erweiterte dekorative Boxen],
  [`\@preview/showybox`],
  [tablem],
  [Markdown-Tabellensyntax],
  [`\@preview/tablem`],
  [fontawesome],
  [Professionelle Icons (Font Awesome 6) → Kapitel 12],
  [`\@preview/fontawesome`],
  [glossarium],
  [Strukturierte Glossarverwaltung → Kapitel 11],
  [`\@preview/glossarium`],
  [Touying],
  [Präsentationsfolien → Kapitel 14],
  [`\@preview/touying`],
)

#v(space.lg)

#pull-quote(
  attribution: [— Typst Community],
)[
  Open-Source-Zusammenarbeit in der wissenschaftlichen Publikation
  bedeutet, dass jede gelöste Herausforderung allen zugutekommt.
]
