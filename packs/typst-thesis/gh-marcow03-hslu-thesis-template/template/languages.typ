// Language configuration for the thesis template
// Supports: "de" (German) and "en" (English)

#let translations = (
  de: (
    // Title page
    department: "Departement Informatik",
    institution: "Hochschule Luzern (Schweiz)",
    submitted: "vorgelegt am Departement Informatik der Hochschule Luzern (Schweiz)",
    by: "von",
    from: "von",
    name-combine: "und",
    place: "Luzern (Schweiz)",
    // Signature page
    title: "Titel",
    student: "Student",
    program: "Studiengang",
    year: "Jahr",
    supervisor: "Betreuungsperson",
    expert: "Expertenperson",
    client: "Auftraggeberin / Auftraggeber",
    classification: "Codierung / Klassifizierung der Arbeit:",
    public: "Öffentlich (Normalfall)",
    confidential: "Vertraulich",
    declaration: "Eidesstattliche Erklärung",
    declaration-text: "Ich erkläre hiermit, dass ich/wir die vorliegende Arbeit selbständig und ohne unerlaubte fremde Hilfe angefertigt habe/n. Alle verwendeten Quellen, Literatur und Hilfsmittel (insbesondere künstliche Intelligenz oder sonstige verwendete Instrumente) wurden urheberrechts- und datenschutzkonform verwendet und wörtlich oder inhaltlich entnommene Stellen als solche kenntlich gemacht. Das Vertraulichkeitsinteresse des Auftraggebers wurde gewahrt und die Urheberrechtsbestimmungen der Hochschule Luzern respektiert.",
    place-date-signature: "Ort / Datum, Unterschrift",
    intellectual-property: [Geistiges Eigentum gemäss der #link(
        "https://srl.lu.ch/app/de/texts_of_law/521/versions/3884",
      )[Studienordnung] für die Ausbildung an der Hochschule Luzern, FH Zentralschweiz],
    page-number-format: "1 von 1",
    // Outlines
    table-of-contents: "Inhaltsverzeichnis",
    abbreviations: "Abkürzungsverzeichnis",
    bibliography: "Literaturverzeichnis",
    figures: "Abbildungsverzeichnis",
    tables: "Tabellenverzeichnis",
    code: "Code-Verzeichnis",
  ),
  en: (
    // Title page
    department: "School of Computer Science and Information Technology",
    institution: "Lucerne University of Applied Sciences and Arts (Switzerland)",
    submitted: "submitted to the Department of Computer Science at Lucerne University of Applied Sciences and Arts (Switzerland)",
    by: "by",
    from: "from",
    name-combine: "and",
    place: "Lucerne (Switzerland)",
    // Signature page
    title: "Title",
    student: "Student",
    program: "Degree Program",
    year: "Year",
    supervisor: "Main Advisor",
    expert: "Expert",
    client: "Industry partner/provider",
    classification: "Code/Thesis Classification:",
    public: "Public (Standard)",
    confidential: "Confidential",
    declaration: "Declaration",
    declaration-text: "I hereby declare that I have completed this work alone, independently, and without any unauthorized or external help. All cited sources, literature, and aids (in particular artificial intelligence or other instruments) have been used in compliance with copyright and data protection laws, and passages taken verbatim or in substance have been identified as such. The client’s confidentiality interests have been preserved, and the intellectual property rights of the Lucerne University of Applied Sciences and Arts have been respected.",
    place-date-signature: "Place / Date, Signature",
    intellectual-property: [Intellectual property of the degree programs of the Lucerne University of Applied Sciences
      and Arts, FH Zentralschweiz, in accordance with Student Regulations:
      #link("https://srl.lu.ch/app/de/texts_of_law/521/versions/3884")[Studienordnung]],
    page-number-format: "1 of 1",
    // Outlines
    table-of-contents: "Table of Contents",
    abbreviations: "List of Abbreviations",
    bibliography: "Bibliography",
    figures: "List of Figures",
    tables: "List of Tables",
    code: "List of Code",
  ),
)

/// Get a translated string
/// - language: "de" or "en"
/// - key: the translation key
#let t(language: "de", key: "") = {
  if key in translations.at(language, default: (:)) {
    translations.at(language).at(key)
  } else {
    "[Missing translation: " + key + "]"
  }
}

/// Get all translations for a language
#let lang(language: "de") = {
  translations.at(language, default: (:))
}
