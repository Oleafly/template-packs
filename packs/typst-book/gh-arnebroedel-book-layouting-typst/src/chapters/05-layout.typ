// chapters/05-layout.typ — Layout-Systeme

#import "../styles/theme.typ": fonts, gradients, palette, space, type-scale
#import "../components/spreads.typ": chapter-opener, section-break
#import "../components/blocks.typ": callout, card, key-concept
#import "../components/inline.typ": badge
#import "../components/layouts.typ": breakout, comparison-layout, magazine-layout, scientific-paper, sidebar-layout
#import "../components/grids.typ": stats-grid
#import "@preview/in-dexter:0.7.2": index

#chapter-opener(
  title: [Die Architektur der Seite],
  lead: [Wie verschiedene Layout-Muster die Informationsaufnahme steuern
    und welches Layout zu welchem Inhalt passt.],
)

== Sidebar-Layout

Das Sidebar-Layout#index[Sidebar-Layout] teilt die Seite in einen festen Navigationsbereich
und einen flexiblen Inhaltsbereich. In medizinischen Nachschlagewerken
kann die Seitenleiste#index[Seitenleiste] eine Kapitelübersicht, Schlüsselbegriffe oder
diagnostische Kriterien enthalten.

#sidebar-layout(
  sidebar: [
    *Differenzialdiagnose*\
    _Thoraxschmerz_

    #v(space.sm)
    - ACS / Myokardinfarkt
    - Lungenembolie
    - Pneumothorax
    - Aortendissektion
    - Perikarditis
    - Pleuritis
    - Muskuloskelettär
    - Gastrointestinal
  ],
  [
    Die Differenzialdiagnose des akuten Thoraxschmerzes gehört zu den
    anspruchsvollsten Aufgaben in der Notfallmedizin. Die zeitkritische
    Unterscheidung zwischen lebensbedrohlichen und harmlosen Ursachen
    erfordert ein systematisches Vorgehen.

    Die links dargestellte Liste zeigt die wichtigsten
    Differenzialdiagnosen in absteigender Dringlichkeit. Die ersten
    vier Diagnosen — akutes Koronarsyndrom, Lungenembolie, Pneumothorax
    und Aortendissektion — sind potenziell lebensbedrohlich und müssen
    innerhalb der ersten Minuten ausgeschlossen oder bestätigt werden.
  ],
)

#section-break()

== Magazin-Layout

Das Magazin-Layout#index[Magazinlayout] kombiniert einen visuell auffälligen Hero-Bereich#index[Hero-Bereich]
mit einem mehrspaltigen Textkörper#index[Spaltensatz]. Es eignet sich besonders für
Kapiteleinleitungen, Themenschwerpunkte und Sonderseiten.

#magazine-layout(
  block(
    width: 100%,
    height: 80pt,
    fill: gradient.linear(palette.primary, palette.primary-dark, angle: 135deg),
    radius: 4pt,
    align(center + horizon, text(
      fill: white,
      size: type-scale.h2,
      weight: "bold",
      font: fonts.sans,
    )[Visuelle Kommunikation in der Medizin]),
  ),
  [
    Die Wirkung visueller Elemente in medizinischen Lehrmaterialien
    ist durch zahlreiche Studien belegt. Richard Mayers
    Multimedia-Lerntheorie zeigt, dass die Kombination von Text und
    Bild den Lernerfolg gegenüber reinem Text signifikant steigert —
    vorausgesetzt, die visuelle Gestaltung folgt den Prinzipien der
    räumlichen Nähe, zeitlichen Synchronisation und Kohärenz.

    Ein gut gestaltetes Magazin-Layout nutzt den Hero-Bereich, um
    Aufmerksamkeit zu erzeugen, und den zweispaltigen Körper für
    detaillierte Erläuterungen. Dieses Muster findet sich in
    medizinischen Fachzeitschriften ebenso wie in klinischen
    Leitlinien.
  ],
)

#section-break()

== Wissenschaftliches Paper-Layout

Für akademische Inhalte bietet das Paper-Layout#index[Paper-Layout] eine vertraute Struktur
mit Volltitel, Autorenzeile, Abstract#index[Abstract] und zweispaltigem Haupttext.

#scientific-paper(
  title: [Wirksamkeit visuell strukturierter Lernmaterialien in der
    medizinischen Ausbildung — eine systematische Übersicht],
  authors: [Dr. med. A. Beispiel#super[1] · Prof. Dr. B. Muster#super[2] ·
    #super[1]Universitätsklinikum · #super[2]Institut für Medizindidaktik],
  abstract: [
    *Hintergrund:* Die kognitive Belastung durch schlecht gestaltete
    Lehrmaterialien ist ein unterschätztes Hindernis im Medizinstudium.
    *Methoden:* Systematische Literaturrecherche in PubMed, ERIC und
    PsycINFO für den Zeitraum 2010–2024. *Ergebnisse:* Von 847
    identifizierten Studien erfüllten 23 die Einschlusskriterien. Die
    Effektstärke visueller Strukturierung lag bei d = 0.62 zugunsten
    der Interventionsgruppe. *Schlussfolgerung:* Strukturierte visuelle
    Gestaltung verbessert den Lernerfolg messbar.
  ],
  [
    === Einleitung

    Die Qualität medizinischer Lehrmaterialien variiert erheblich.
    Während Inhalt und fachliche Korrektheit regelmäßig geprüft werden,
    bleibt die typografische und visuelle Gestaltung oft dem Zufall
    überlassen. Dabei zeigt die Forschung zur Cognitive Load Theory,
    dass die Präsentation von Information ebenso entscheidend ist wie
    ihr Inhalt.

    === Methoden

    Es wurde eine systematische Literaturrecherche nach PRISMA-Leitlinien
    durchgeführt. Einschlusskriterien waren: randomisierte oder
    quasi-randomisierte Studien, medizinische Ausbildung als Setting,
    visuelle Gestaltung als Intervention, Lernerfolg als primärer
    Endpunkt.

    === Diskussion

    Die gefundene Effektstärke von d = 0.62 ist vergleichbar mit
    etablierten didaktischen Interventionen wie Problem-Based Learning.
    Die heterogene Studienqualität limitiert jedoch die Generalisierbarkeit.

    #breakout[
      #callout(title: "Kernergebnis der Metaanalyse", tone: "success")[
        Visuell strukturierte Lehrmaterialien verbessern den Lernerfolg
        mit einer mittleren Effektstärke von *d = 0.62* (95%-KI: 0.41–0.83).
        Der Effekt ist besonders ausgeprägt bei komplexen Inhalten wie
        Pathophysiologie und Pharmakologie.
      ]
    ]
  ],
)

#section-break()

== Vergleichslayout

Direkte Gegenüberstellungen#index[Vergleichslayout] erleichtern die Bewertung von Alternativen.
In der medizinischen Didaktik#index[Medizindidaktik] sind Vorher-Nachher-Vergleiche,
Gegenüberstellungen von Therapieoptionen und Methodenvergleiche
häufige Anwendungsfälle.

#comparison-layout(
  left-title: [Traditionelle Lehre],
  right-title: [Kompetenzbasierte Lehre],
  [
    - Dozentenorientiert
    - Zeitbasierte Progression
    - Summative Prüfungen
    - Fächergetrennt
    - Passive Wissensaufnahme
  ],
  [
    - Lernerorientiert
    - Kompetenzbasierte Progression
    - Formative Assessments
    - Interdisziplinär integriert
    - Aktives, problembasiertes Lernen
  ],
)

== Kennzahlen im Überblick

#stats-grid((
  (value: "847", label: "Identifizierte Studien"),
  (value: "23", label: "Eingeschlossen"),
  (value: "0.62", label: "Effektstärke (d)"),
  (value: "94%", label: "Zustimmung"),
))

#callout(title: "Wann welches Layout?", tone: "info")[
  *Sidebar:* Referenzmaterial neben Erklärungstext \
  *Magazin:* Visueller Einstieg mit nachfolgendem Detailtext \
  *Paper:* Akademische Inhalte mit strukturiertem Abstract \
  *Vergleich:* Gegenüberstellung von zwei Optionen oder Zuständen
]
