// chapters/10-tooling.typ — Werkzeuge & Workflows
// Populated in Phase 3

#import "../styles/theme.typ": fonts, palette, space, type-scale
#import "../components/spreads.typ": chapter-opener, section-break
#import "../components/blocks.typ": callout, card, code-block, key-concept, pull-quote, side-note
#import "../components/inline.typ": badge
#import "../components/grids.typ": feature-grid, gallery-grid
#import "../components/tables.typ": styled-table
#import "../components/layouts.typ": comparison-layout
#import "@preview/in-dexter:0.7.2": index

// ════════════════════════════════════════════════════════════════
// CHAPTER OPENER
// ════════════════════════════════════════════════════════════════
#chapter-opener(
  title: [Werkzeuge & Workflows],
  lead: [
    Ein Satzsystem ist nur so gut wie die Werkzeuge, die es umgeben.
    Von der intelligenten IDE-Unterstützung über automatisierte
    Build-Pipelines bis hin zur barrierefreien PDF-Erzeugung — dieses
    Kapitel zeigt den professionellen Arbeitsablauf rund um Typst.
  ],
)

// ════════════════════════════════════════════════════════════════
== IDE & Sprachserver — Tinymist

Tinymist#index[Tinymist] ist der Standard-Sprachserver für Typst und verwandelt jeden
kompatiblen Editor in eine vollwertige Typst-Entwicklungsumgebung.

#feature-grid(
  column-count: 3,
  (
    (
      icon: sym.hash,
      title: [Autovervollständigung],
      body: [Funktionen, Parameter und Importe werden in Echtzeit
        vorgeschlagen.],
    ),
    (
      icon: sym.arrow.r,
      title: [Go-to-Definition],
      body: [Springe direkt zur Definition jeder Funktion — auch
        projektübergreifend.],
    ),
    (
      icon: sym.circle.filled,
      title: [Live-Vorschau],
      body: [Änderungen werden in Millisekunden kompiliert und sofort
        angezeigt.],
    ),
    (
      icon: sym.bar.h,
      title: [Profiling],
      body: [Identifiziere Performance-Engpässe mit
        `tinymist.profileCurrentFile`.],
    ),
    (
      icon: sym.quest,
      title: [Workspace-Symbole],
      body: [Suche nach Definitionen im gesamten Projekt mit
        einem Tastendruck.],
    ),
    (
      icon: sym.dash.em,
      title: [Syntax-Modus],
      body: [Ressourcenschonend: nur Syntaxprüfung ohne
        Layout-Berechnung.],
    ),
  ),
)

#side-note(title: [Editor-Unterstützung])[
  Tinymist unterstützt VS Code, Neovim, Helix und weitere Editoren
  über das Language Server Protocol (LSP).
]

// ════════════════════════════════════════════════════════════════
== Code-Formatierung — typstyle

Konsistenter Code-Stil ist in Team-Projekten unverzichtbar. _typstyle_#index[typstyle]
formatiert Typst-Quellcode automatisch nach einheitlichen Regeln.

#comparison-layout(
  left-title: [Vor Formatierung],
  right-title: [Nach Formatierung],
  code-block(title: none)[
    ```typst
    #let f(a,b,c)={
    grid(columns:(1fr,2fr),
    a,b,c)}
    ```
  ],
  code-block(title: none)[
    ```typst
    #let f(a, b, c) = {
      grid(
        columns: (1fr, 2fr),
        a, b, c,
      )
    }
    ```
  ],
)

#callout(title: [Integration], tone: "info")[
  typstyle lässt sich als Format-on-Save in Tinymist einbinden.
  Damit wird jede Datei beim Speichern automatisch formatiert —
  ohne manuellen Aufwand.
]

// ════════════════════════════════════════════════════════════════
== CI/CD-Pipelines — Automatisierte Builds

In professionellen Umgebungen werden Dokumente nicht manuell kompiliert,
sondern durch automatisierte Pipelines#index[CI/CD] erzeugt. Typst eignet sich
hierfür hervorragend: der gesamte Compiler ist unter 40#sym.space.thin MB groß
und in Sekunden einsatzbereit.

#code-block(title: [GitHub Actions — Typst Build Pipeline])[
  ```yaml
  name: Build Document
  on: [push, pull_request]
  jobs:
    build:
      runs-on: ubuntu-latest
      steps:
        - uses: actions/checkout@v4
        - uses: typst-community/setup-typst@v4
          with:
            typst-version: latest
        - run: typst compile main.typ output.pdf
        - uses: actions/upload-artifact@v4
          with:
            name: document
            path: output.pdf
  ```
]

#gallery-grid(
  (
    [*1. Checkout* \ Code auschecken],
    [*2. Setup* \ Compiler installieren],
    [*3. Kompilieren* \ PDF erzeugen],
    [*4. Prüfen* \ Fehler abfangen],
    [*5. Bereitstellen* \ Artefakte hochladen],
  ),
  column-count: 5,
)

#callout(title: [Performance], tone: "success")[
  Typst kompiliert typische Dokumente in unter einer Sekunde.
  CI-Builds dauern selten länger als 30 Sekunden — inklusive
  Setup und Artefakt-Upload.
]

// ════════════════════════════════════════════════════════════════
== Barrierefreie PDFs — PDF/UA-Konformität

Barrierefreiheit#index[Barrierefreiheit] ist keine optionale Eigenschaft, sondern eine
gesetzliche Anforderung. Der European Accessibility Act#index[European Accessibility Act] (EAA)
verpflichtet öffentliche Einrichtungen zur Bereitstellung
zugänglicher digitaler Dokumente.

#key-concept(term: [PDF/UA])[
  Der Standard _PDF/Universal Accessibility_ definiert Anforderungen
  an die Struktur von PDF-Dokumenten, damit Screenreader und
  assistive Technologien den Inhalt korrekt interpretieren können.
]

Typst erzeugt beim Export semantisch korrekte PDF-Tags#index[PDF/UA]. Die folgende
Tabelle zeigt die Zuordnung:

#styled-table(
  columns: (1fr, 1fr, 2fr),
  table.header([*Typst-Element*], [*PDF-Tag*], [*Hinweis*]),
  [`heading`],
  [H1–H6],
  [Automatisch nach Ebene],
  [`table`],
  [Table],
  [Inkl. Header mit `table.header`],
  [`figure`],
  [Figure],
  [`alt`-Text für Barrierefreiheit erforderlich],
  [`list` / `enum`],
  [L / LI],
  [Automatisch korrekt getaggt],
  [`link`],
  [Link],
  [URI wird im Tag gespeichert],
)

#code-block(title: [PDF/UA-Export])[
  ```sh
  typst compile --pdf-standard a-2b main.typ
  ```
]

#callout(title: [Häufige Fehler], tone: "danger")[
  Jedes Bild ohne `alt`-Text ist ein Barrierefreiheits-Verstoß.
  Dekorative Elemente sollten mit `role: "artifact"` markiert werden,
  um sie von der semantischen Struktur auszuschließen.
]

// ════════════════════════════════════════════════════════════════
== Enterprise-Muster

Für den Einsatz in Organisationen bietet Typst strukturierte
Paket- und Template-Verwaltung#index[Template-Verwaltung].

#card(title: [Package-Manifest: typst.toml])[
  #code-block(title: none)[
    ```toml
    [package]
    name = "klinikum-brand"
    version = "1.2.0"
    entrypoint = "lib.typ"
    authors = ["IT-Abteilung Universitätsklinikum"]
    description = "Corporate Design des Klinikums"
    ```
  ]
]

#feature-grid(
  column-count: 3,
  (
    (
      icon: sym.square,
      title: [Foundation],
      body: [Basis-Tokens: Farben, Schriften, Abstände — unabhängig
        vom Einsatzzweck.],
    ),
    (
      icon: sym.diamond,
      title: [Branding],
      body: [Organisationsidentität: Logo, Farbschema, Typografie —
        importiert Foundation.],
    ),
    (
      icon: sym.pilcrow,
      title: [Templates],
      body: [Konkrete Dokumenttypen: Briefe, Berichte, Poster —
        importieren Branding.],
    ),
  ),
)

// ════════════════════════════════════════════════════════════════
== Integration mit Quarto

Für Teams aus den Datenwissenschaften bietet Quarto#index[Quarto] eine Brücke
zwischen Code-basierter Analyse und Typst-basiertem Satz.

#callout(title: [Quarto + Typst], tone: "info")[
  Quarto orchestriert R- oder Python-Code, erzeugt Analyseergebnisse
  und übergibt sie an Typst für den finalen PDF-Satz. Mit `_brand.yml`
  wird ein einheitliches Design über alle Ausgabeformate sichergestellt.
]

#side-note(title: [Debugging-Tipp])[
  Mit `quarto render --keep-typ` bleibt die generierte `.typ`-Datei
  erhalten — hilfreich für die Fehlersuche im Layout.
]

// ════════════════════════════════════════════════════════════════

#v(space.lg)

#pull-quote(
  attribution: [— Prinzip der inklusiven Gestaltung],
)[
  Barrierefreiheit ist kein Feature — sie ist eine Grundvoraussetzung.
  Jedes Dokument, das nicht zugänglich ist, schließt Menschen aus.
]
