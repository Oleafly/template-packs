#import "../../globals.typ": page_author, lightblue, lighterblue, mainblue
#import "../../utils/work_packages.typ": work_package
#import "../../utils/cost_breakdown.typ": cost_breakdown
#import "../../utils/todo.typ": TODO

#page_author.update("First Last")

= Projektmanagement

== Grobplan

#show figure: set block(breakable: true)
#figure(
  kind: table,
  caption: [Grobplan],
  table(
    columns: (auto, 1fr),
    stroke: 0.5pt + gray,
    inset: 6pt,
    align: (left + top, left + top),
    fill: (x, _y) => if x == 0 { lightblue } else { lighterblue },

    [*Projekttitel*], [Titel der Diplomarbeit],
    [*Erstellt von*], [Vorname Nachname],
    [*Datum*], [DD. Monat JJJJ],
    [*Starttermin*], [DD.MM.JJJJ],
    [*Endtermin*], [DD.MM.JJJJ],

    [*Aufgabenstellung*],
    [#TODO[Gesamtziel des Projekts in 2–4 Sätzen beschreiben.]],

    [*Situationsanalyse*],
    [#TODO[Kenntnisse oder Ausrüstung auflisten, die für dieses Projekt erworben werden müssen.]],

    [*Projektziele*],
    [#TODO[
      + Ziel 1 (messbar)
      + Ziel 2 (messbar)
      + Ziel 3 (messbar)
    ]],

    [*Projektkosten*],
    [#TODO[
      *Materialkosten:* ca. X €

      *Personalkosten:* Y h × 10 €/h = Z €
    ]],

    [*Projektrisiken*],
    [#TODO[2–3 Risiken beschreiben und Maßnahmen zur Risikominimierung angeben.]],

    [*Projektorganisation*],
    [#TODO[
      - *Projektleitung:* Vorname Nachname
      - *Betreuer:* Prof. ...
    ]],
  ),
)<tab:Grobplan>

#show figure: set block(breakable: false)

== Projektstrukturplan

#TODO[PSP-Grafik hier einfügen:]
// #figure(
//   image("../../img/psp.png", width: 100%),
//   caption: [Projektstrukturplan],
// )<fig:psp>

// Arbeitspakete mit work_package() anlegen. Beispiel:
#work_package(
  1,
  [Projektmanagement],
  [Vorname Nachname],
  ([1.1 Projektplanung], [1.2 Dokumentation]),
  ([Vorname Nachname], [Vorname Nachname]),
  ([DD.MM.JJ], [DD.MM.JJ]),
  ([1.1 Projektplanung], [1.2 Dokumentation]),
  ([10 h], [5 h]),
  ([Projektplan fertiggestellt],),
)

== Meilensteinplan

#figure(
  caption: [Meilensteinplan],
)[
  #table(
    columns: (1fr, auto, auto),
    align: (left, right, right),
    inset: 4pt,
    stroke: 0.3pt + mainblue,
    fill: (x, y) => {
      if y == 0 { mainblue } else if calc.odd(y) { lightblue } else { lighterblue }
    },

    [*Meilenstein*], [*Datum-Soll*], [*Datum-Ist*],

    [Kickoff],              [DD.MM.JJ], [DD.MM.JJ],
    [Meilenstein 2],        [DD.MM.JJ], [offen],
    [Meilenstein 3],        [DD.MM.JJ], [offen],
    [Projekt abgeschlossen],[DD.MM.JJ], [offen],
  )
] <tab:meilensteine>

== Balken-Zeit-Diagramm

#TODO[Gantt-Diagramm hier einfügen:]
// #figure(
//   image("../../img/gantt.png", width: 100%),
//   caption: [Balken-Zeit-Diagramm],
// )

== Tagebuch

#TODO[Projekttagebuch hier eintragen:]
#table(
  columns: (auto, auto, auto, 1fr),
  stroke: 0.3pt + mainblue,
  inset: 6pt,
  fill: (x, y) => {
    if y == 0 { mainblue } else if calc.odd(y) { lightblue } else { lighterblue }
  },
  table.header([*Datum*], [*Von*], [*Bis*], [*Tätigkeit*]),
  [DD.MM.JJ], [HH:MM], [HH:MM], [Tätigkeit beschreiben],
  [DD.MM.JJ], [HH:MM], [HH:MM], [Tätigkeit beschreiben],
)

== Soll-Ist-Vergleich

// Kostenaufstellung mit cost_breakdown() erstellen. Beispiel:
#let items = (
  (name: "Komponente A", quantity: 2, unit: "Stück", price: 15.00),
  (name: "Komponente B", quantity: 1, unit: "Stück", price: 49.90),
  (name: "Entwicklungszeit", quantity: 20, unit: "Stunden", price: 10.00),
)
#cost_breakdown(
  "Hardware und Personal",
  "Titel der Diplomarbeit",
  items,
  ("Alle Preise inkl. MwSt.",),
)
