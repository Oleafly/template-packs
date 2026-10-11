#let __strings = (
  title: (
    en: "Declaration of Auxiliary Tools",
    de: "Hilfsmittelverzeichnis",
  ),
  intro: (
    en: "The following Artificial Intelligence (AI) based systems were used in the preparation of this thesis in the manner described:",
    de: "Die folgenden auf Künstlicher Intelligenz (KI) basierenden Systeme wurden bei der Anfertigung dieser Arbeit in der beschriebenen Weise eingesetzt:",
  ),
  col-step:        (en: "Work Step",                       de: "Arbeitsschritt"),
  col-systems:     (en: "AI System(s) Used",               de: "Verwendetes/e KI-System/e"),
  col-description: (en: "Description of Use",              de: "Beschreibung des Einsatzes"),
  col-parts:       (en: "Affected Parts",                  de: "Betroffene Teile"),
  row-ideation:    (en: "Idea generation and conception",  de: "Ideenfindung und Konzeption"),
  row-lit-search:  (en: "Literature search",               de: "Literaturrecherche"),
  row-lit-review:  (en: "Literature analysis",             de: "Literaturanalyse"),
  row-references:  (en: "Reference management and citation", de: "Literaturverwaltung und Zitation"),
  row-methods:     (en: "Selection of methods and models", de: "Auswahl von Methoden und Modellen"),
  row-data:        (en: "Data collection and analysis",    de: "Datenerhebung und -auswertung"),
  row-code:        (en: "Code generation",                 de: "Code-Generierung"),
  row-viz:         (en: "Creation of visualizations",      de: "Erstellung von Visualisierungen"),
  row-interpret:   (en: "Interpretation and validation",   de: "Interpretation und Validierung"),
  row-structure:   (en: "Structuring of thesis text",      de: "Strukturierung des Textes"),
  row-formulate:   (en: "Formulation of thesis text",      de: "Formulierung des Textes"),
  row-other:       (en: "Other",                           de: "Sonstiges"),
)

#let toolDeclarationWith(lang: "en") = [
  #let s(key) = __strings.at(key).at(lang)

  == #s("title") <hilfsmittelverzeichnis>

  #s("intro")

// Fill your KI usage Information here
  #table(
    columns: 4,
    table.header(
      [*#s("col-step")*], [*#s("col-systems")*], [*#s("col-description")*], [*#s("col-parts")*],
    ),
    [#s("row-ideation")],   [-], [-], [-],
    [#s("row-lit-search")], [-], [-], [-],
    [#s("row-lit-review")], [-], [-], [-],
    [#s("row-references")], [-], [-], [-],
    [#s("row-methods")],    [-], [-], [-],
    [#s("row-data")],       [-], [-], [-],
    [#s("row-code")],       [-], [-], [-],
    [#s("row-viz")],        [-], [-], [-],
    [#s("row-interpret")],  [-], [-], [-],
    [#s("row-structure")],  [-], [-], [-],
    [#s("row-formulate")],  [-], [-], [-],
    [#s("row-other")],      [-], [-], [-],
  )
]
