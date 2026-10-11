// chapters/06-advanced.typ — Fortgeschrittene Techniken

#import "../styles/theme.typ": fonts, palette, space, type-scale
#import "../components/spreads.typ": chapter-opener, section-break
#import "../components/blocks.typ": callout, card, key-concept
#import "../components/inline.typ": badge, highlight-text
#import "../components/layouts.typ": adaptive-layout
#import "../components/grids.typ": comparison-grid, feature-grid, gallery-grid, stats-grid
#import "@preview/in-dexter:0.7.2": index

#chapter-opener(
  title: [Dynamische Dokumente],
  lead: [Fortgeschrittene Techniken für adaptive Layouts, datengetriebene
    Inhalte und berechnete Visualisierungen.],
)

== Adaptive Layouts

Modernes Dokumentendesign#index[Dokumentendesign] reagiert auf seinen Kontext. Ein Layout#index[Adaptives Layout], das
sich der verfügbaren Breite anpasst, funktioniert gleichermaßen in einer
schmalen Spalte wie auf einer breiten Einzelseite.

#key-concept(term: "Responsive Document Design")[
  Analog zum Responsive Web Design passt sich ein adaptives Dokument
  seiner Umgebung an. In Typst ermöglicht die `layout()`-Funktion
  Entscheidungen basierend auf der tatsächlichen Inhaltsbreite — nicht
  der konfigurierten Seitenbreite.
]

#adaptive-layout(
  sidebar: [
    *Kontextmenü*

    #text(size: type-scale.small)[
      Dieses Panel erscheint nur, wenn die verfügbare Breite
      ausreichend ist. Bei schmaler Darstellung wird der Inhalt
      gestapelt.
    ]
  ],
  [
    Die adaptive Layout-Komponente nutzt `layout(size => ...)`, um
    die tatsächliche Breite des Inhaltsbereichs abzufragen. Liegt
    die Breite über dem definierten Schwellenwert, wird ein
    Zwei-Spalten-Layout mit fixierter Seitenleiste gerendert.
    Unterschreitet sie den Schwellenwert, werden die Elemente
    untereinander gestapelt.

    Diese Technik ist besonders nützlich für Materialien, die sowohl
    gedruckt als auch digital verwendet werden, oder für Inhalte
    innerhalb verschachtelter Layouts, wo die verfügbare Breite
    nicht vorab bekannt ist.
  ],
)

#section-break()

== Datengetriebene Visualisierungen

Typst ermöglicht die Erzeugung visueller Elemente aus strukturierten
Daten. Anstatt Tabellen#index[Tabelle] und Diagramme#index[Diagramm] manuell zu erstellen, können
Funktionen Datenquellen#index[Datenquelle] auslesen und automatisch formatierte
Darstellungen erzeugen.

=== Klinische Ergebnisse

#stats-grid((
  (value: "1.247", label: "Entlassungen"),
  (value: "98.3%", label: "Patientenzufriedenheit"),
  (value: "4.1", label: "Ø Verweildauer (Tage)"),
  (value: "< 2%", label: "Komplikationsrate"),
))

=== Vorher-Nachher-Analyse

#comparison-grid(
  left-title: "Vor Intervention",
  right-title: "Nach Intervention",
  [
    - Prüfungserfolg: 71 %
    - Lernzeit: 12 h / Woche
    - Zufriedenheit: 3.2 / 5
    - Dropout-Rate: 8 %
  ],
  [
    - Prüfungserfolg: 86 %
    - Lernzeit: 9 h / Woche
    - Zufriedenheit: 4.4 / 5
    - Dropout-Rate: 3 %
  ],
)

#section-break()

== Berechnete Grids

Galerie-Grids#index[Galerie-Grid] generieren ihre Darstellung dynamisch aus einer
Datenliste. Farben rotieren automatisch durch die Palette#index[Farbpalette], und die
Spaltenzahl#index[Spaltenzahl] ist frei konfigurierbar.

=== Medizinische Kompetenzbereiche

#gallery-grid(
  column-count: 3,
  (
    [*Wissen*\ Biomedizinisches Grundlagenwissen und klinische Kenntnisse],
    [*Können*\ Praktische Fertigkeiten in Diagnostik und Therapie],
    [*Haltung*\ Ethische Reflexion und professionelles Verhalten],
    [*Kommunikation*\ Gesprächsführung mit Patienten und im Team],
    [*Wissenschaft*\ Kritische Bewertung und Anwendung von Evidenz],
    [*Management*\ Organisation und Qualitätssicherung im Gesundheitswesen],
  ),
)

=== Lernziel-Taxonomie nach Bloom

#feature-grid(
  column-count: 3,
  (
    (
      icon: [1],
      title: [Erinnern],
      body: [Fakten abrufen und wiedergeben],
    ),
    (
      icon: [2],
      title: [Verstehen],
      body: [Konzepte erklären und interpretieren],
    ),
    (
      icon: [3],
      title: [Anwenden],
      body: [Wissen in neuen Situationen nutzen],
    ),
    (
      icon: [4],
      title: [Analysieren],
      body: [Zusammenhänge erkennen und differenzieren],
    ),
    (
      icon: [5],
      title: [Evaluieren],
      body: [Begründet beurteilen und bewerten],
    ),
    (
      icon: [6],
      title: [Erschaffen],
      body: [Neues aus Gelerntem entwickeln],
    ),
  ),
)

#card(title: "Zusammenfassung")[
  Dynamische Dokumente nutzen die Programmierbarkeit von Typst, um
  aus Daten automatisch konsistente Darstellungen zu erzeugen.
  Änderungen an einer Stelle — etwa einer Farbpalette oder einem
  Datensatz — propagieren sich durch das gesamte Dokument.
  Dieses Prinzip reduziert Fehler und sichert visuelle Konsistenz.
]
