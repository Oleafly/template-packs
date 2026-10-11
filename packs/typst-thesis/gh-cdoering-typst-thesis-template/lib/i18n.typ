// =============================================================================
// SPRACHTABELLE
//
// Alle vom Template erzeugten Texte. Weitere Sprache: Block kopieren,
// Schluessel uebersetzen, cfg.lang entsprechend setzen. Kein Layout-Code
// muss dafuer angefasst werden.
//
// Beschriftungen von Abbildungen und Tabellen ("Abbildung"/"Figure") setzt
// Typst selbst anhand von cfg.lang und sind hier bewusst nicht enthalten.
// =============================================================================

#import "../config.typ": cfg

#let strings = (
  de: (
    // Titelblatt
    degree_intro: "zur Erlangung des akademischen Grades",
    in_program: "im Studiengang",
    submitted_to: "Vorgelegt am",
    by: "von",
    matr_label: "Matrikelnummer",

    // Verzeichnisse
    chapter: "Kapitel",
    appendix: "Anhang",
    abstract: "Abstract",
    confidentiality: "Sperrvermerk",
    acknowledgements: "Danksagung",
    toc: "Inhaltsverzeichnis",
    acronyms: "Abkürzungsverzeichnis",
    symbols: "Symbolverzeichnis",
    figures: "Abbildungsverzeichnis",
    tables: "Tabellenverzeichnis",
    listings: "Quelltextverzeichnis",
    bibliography: "Literaturverzeichnis",
    listing: "Quelltext",

    // Schlussteile
    ai_disclosure: "Erklärung zur Nutzung generativer KI und weiterer Hilfsmittel",
    declaration: "Eidesstattliche Erklärung",
    place_date: "Ort, Datum",

    // Kapitelüberschriften — neutrales Skelett
    ch: (
      introduction: "Einleitung",
      motivation: "Motivation und Ausgangslage",
      problem: "Problemstellung",
      objective: "Zielsetzung",
      questions: "Forschungsfragen",
      contribution: "Beitrag und Abgrenzung der Arbeit",
      structure: "Aufbau der Arbeit",

      foundations: "Grundlagen",
      terms: "Begriffliche Grundlagen",
      state_of_art: "Stand der Technik",
      related_work: "Verwandte Arbeiten",
      research_gap: "Forschungslücke",
      delimitation: "Abgrenzung",

      method: "Methodik",
      research_design: "Forschungsdesign",
      data_basis: "Datengrundlage",
      procedure: "Vorgehen",
      quality_criteria: "Gütekriterien",

      concept: "Konzeption",
      requirements: "Anforderungen",
      architecture: "Architektur",
      design_decisions: "Entwurfsentscheidungen",

      implementation: "Umsetzung",
      realisation: "Implementierung",
      tooling: "Eingesetzte Werkzeuge",
      challenges: "Herausforderungen",

      evaluation: "Evaluierung",
      eval_design: "Evaluationsdesign",
      eval_setup: "Versuchsaufbau",
      eval_results: "Ergebnisse der Evaluierung",

      discussion: "Diskussion",
      interpretation: "Interpretation der Ergebnisse",
      comparison: "Einordnung in verwandte Arbeiten",
      limitations: "Limitationen",
      implications: "Implikationen",

      conclusion: "Fazit",
      summary: "Zusammenfassung",
      answers: "Beantwortung der Forschungsfragen",
      scientific_contribution: "Wissenschaftlicher Beitrag",
      outlook: "Ausblick",

      appendix_intro: "Ergänzende Materialien",
    ),
  ),

  en: (
    degree_intro: "in partial fulfilment of the requirements for the degree",
    in_program: "in the programme",
    submitted_to: "Submitted to",
    by: "by",
    matr_label: "Student ID",

    chapter: "Chapter",
    appendix: "Appendix",
    abstract: "Abstract",
    confidentiality: "Sperrvermerk",
    acknowledgements: "Danksagung",
    toc: "Contents",
    acronyms: "List of Abbreviations",
    symbols: "List of Symbols",
    figures: "List of Figures",
    tables: "List of Tables",
    listings: "List of Listings",
    bibliography: "References",
    listing: "Listing",

    ai_disclosure: "Declaration on the Use of Generative AI and Other Tools",
    declaration: "Statutory Declaration",
    place_date: "Place, Date",

    ch: (
      introduction: "Introduction",
      motivation: "Motivation and Background",
      problem: "Problem Statement",
      objective: "Objective",
      questions: "Research Questions",
      contribution: "Contribution and Scope",
      structure: "Structure of the Thesis",

      foundations: "Theoretical Background",
      terms: "Definitions",
      state_of_art: "State of the Art",
      related_work: "Related Work",
      research_gap: "Research Gap",
      delimitation: "Scope and Delimitation",

      method: "Methodology",
      research_design: "Research Design",
      data_basis: "Data Basis",
      procedure: "Procedure",
      quality_criteria: "Quality Criteria",

      concept: "Conceptual Design",
      requirements: "Requirements",
      architecture: "Architecture",
      design_decisions: "Design Decisions",

      implementation: "Implementation",
      realisation: "Realisation",
      tooling: "Tools Used",
      challenges: "Challenges",

      evaluation: "Evaluation",
      eval_design: "Evaluation Design",
      eval_setup: "Experimental Setup",
      eval_results: "Evaluation Results",

      discussion: "Discussion",
      interpretation: "Interpretation of Results",
      comparison: "Comparison with Related Work",
      limitations: "Limitations",
      implications: "Implications",

      conclusion: "Conclusion",
      summary: "Summary",
      answers: "Answering the Research Questions",
      scientific_contribution: "Scientific Contribution",
      outlook: "Outlook",

      appendix_intro: "Supplementary Material",
    ),
  ),
)

#if cfg.lang not in strings {
  panic("config.typ: lang = \"" + cfg.lang + "\" ist nicht in lib/i18n.typ definiert. Verfügbar: " + strings.keys().join(", "))
}

#let t = strings.at(cfg.lang)
