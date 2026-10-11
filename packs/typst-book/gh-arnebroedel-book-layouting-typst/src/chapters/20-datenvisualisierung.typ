// chapters/20-datenvisualisierung.typ — Medizinische Datenvisualisierung

#import "../styles/theme.typ": fonts, palette, space, type-scale
#import "../components/spreads.typ": chapter-opener, section-break
#import "../components/blocks.typ": callout, side-note
#import "../components/charts.typ": bar-chart, box-plot, forest-plot, km-curve, percentile-chart, roc-curve
#import "@preview/in-dexter:0.7.2": index

#chapter-opener(
  title: [Medizinische Datenvisualisierung],
  lead: [
    Evidenzbasierte Medizin lebt von Zahlen — und Zahlen brauchen klare
    Bilder. Dieses Kapitel zeigt die wichtigsten Diagrammtypen des
    klinischen und epidemiologischen Alltags, alle auf CeTZ aufgebaut und
    in das Farb- und Token-System des Buches integriert.
  ],
)

// ════════════════════════════════════════════════════════════════
== Vergleich und Verteilung

Das Balkendiagramm ist die einfachste Form des Gruppenvergleichs — etwa
für Ansprechraten verschiedener Therapieschemata:

#figure(
  bar-chart(
    ([Schema A], [Schema B], [Schema C]),
    (42, 61, 55),
    ylabel: [Ansprechrate (%)],
    xlabel: [Therapieschema],
  ),
  caption: [Ansprechraten dreier Therapieschemata im Vergleich.],
  alt: "Balkendiagramm der Ansprechraten von Schema A (42 %), B (61 %) und C (55 %).",
)

Wo die _Streuung_ der Daten interessiert, zeigt der Box-Plot Median,
Quartile und Spannweite auf einen Blick:

#figure(
  box-plot(
    (
      ([Plazebo], (2, 5, 8, 11, 15)),
      ([Verum], (4, 7, 9, 13, 18)),
    ),
    ylabel: [Symptomscore],
  ),
  caption: [Verteilung des Symptomscores: Median, Interquartilbereich und Whisker.],
  alt: "Box-Plot des Symptomscores für Plazebo und Verum mit Median, Quartilen und Whiskern.",
)

#side-note(title: [Box-Plot lesen])[
  Die Box umfasst das mittlere Quartil (Q1–Q3), die Linie den Median; die
  Whisker reichen bis Minimum und Maximum.
]

#section-break()

// ════════════════════════════════════════════════════════════════
== Zeit-zu-Ereignis: Kaplan-Meier

Überlebenszeitanalysen sind das Herz onkologischer und kardiologischer
Studien. Die Kaplan-Meier-Kurve#index[Kaplan-Meier-Kurve] zeigt die
geschätzte Überlebensfunktion als rechtsstetige Treppenfunktion:

#figure(
  km-curve((
    ([Therapie], palette.primary, ((0, 100), (6, 100), (6, 82), (12, 82), (12, 64), (24, 64))),
    ([Kontrolle], palette.danger, ((0, 100), (4, 100), (4, 70), (10, 70), (10, 45), (24, 45))),
  )),
  caption: [Kaplan-Meier-Überlebenskurven zweier Behandlungsarme über 24 Monate.],
  alt: "Kaplan-Meier-Treppenkurven: der Therapiearm liegt durchgehend über dem Kontrollarm; Überleben nach 24 Monaten etwa 64 % gegenüber 45 %.",
)

#callout(title: [Interpretation], tone: "info")[
  Jede Stufe markiert ein Ereignis (z. B. Tod oder Progress). Ein
  flacherer Verlauf bedeutet besseres Überleben — hier liegt der
  Therapiearm durchgehend über der Kontrolle.
]

#section-break()

// ════════════════════════════════════════════════════════════════
== Testgüte: ROC-Kurve

Die ROC-Kurve bewertet die diagnostische Trennschärfe eines Tests über
alle Schwellenwerte. Die Fläche unter der Kurve (AUC) fasst die Güte in
einer Zahl zusammen:

#figure(
  roc-curve(
    ((0, 0), (0.08, 0.55), (0.22, 0.80), (0.45, 0.92), (0.7, 0.97), (1, 1)),
    auc: 0.88,
  ),
  caption: [ROC-Kurve eines Biomarkers; die Diagonale entspricht dem Zufall (AUC = 0,5).],
  alt: "ROC-Kurve eines Biomarkers, deutlich oberhalb der Zufallsdiagonale, mit einer Fläche unter der Kurve von 0,88.",
)

#section-break()

// ════════════════════════════════════════════════════════════════
== Referenzkurven und Metaanalyse

Perzentilkurven ordnen einen Messwert in die alters- und
geschlechtsspezifische Norm ein — unverzichtbar in der Pädiatrie:

#figure(
  percentile-chart(
    (0, 2, 4, 6, 8, 10),
    (
      ([P97], palette.warning, (52, 92, 104, 117, 130, 142)),
      ([P50], palette.primary, (50, 87, 99, 110, 122, 133)),
      ([P3], palette.info, (47, 82, 93, 103, 114, 124)),
    ),
    ylabel: [Körpergröße (cm)],
  ),
  caption: [Wachstums-Perzentilen (P3/P50/P97) der Körpergröße.],
  alt: "Perzentilkurven der Körpergröße über das Alter von 0 bis 10 Jahren mit den Bändern P3, P50 und P97.",
)

Der Forest-Plot#index[Forest-Plot] fasst die Ergebnisse mehrerer Studien
einer Metaanalyse#index[Metaanalyse] zusammen; die gestrichelte Linie
markiert den Effekt-Nullwert:

#figure(
  forest-plot((
    ([Studie A], 0.82, 0.65, 1.03),
    ([Studie B], 1.15, 0.90, 1.47),
    ([Studie C], 0.71, 0.55, 0.92),
    ([Gepoolt], 0.88, 0.78, 0.99),
  )),
  caption: [Forest-Plot einer Metaanalyse (Odds Ratios mit 95 %-Konfidenzintervall).],
  alt: "Forest-Plot mit Odds Ratios und Konfidenzintervallen für drei Studien und den gepoolten Effekt von 0,88; gestrichelte Nulllinie bei 1.",
)

#callout(title: [Konsistenz durch Komponenten], tone: "success")[
  Alle sechs Diagrammtypen stammen aus `components/charts.typ` und teilen
  Achsen-, Tick- und Farblogik. Neue Diagramme erben das Erscheinungsbild
  automatisch.
]
