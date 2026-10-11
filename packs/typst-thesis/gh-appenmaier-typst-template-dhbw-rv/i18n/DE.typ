// ================================ //
//           UI LABELS              //
// Translate or adjust display text //
// without touching layout files.   //
// ================================ //

#let labels = (
  // ---- Section headings ---- //
  toc:           "Inhaltsverzeichnis",
  abstract:      "Abstract",
  abstract-title: "Abstract",
  abbreviations: "Abkürzungsverzeichnis",
  figures:       "Abbildungsverzeichnis",
  tables:        "Tabellenverzeichnis",
  listings:      "Listingverzeichnis",
  bibliography:  "Literaturverzeichnis",
  appendix:      "Anhang",
  // Singular supplements for cross-references (@fig, @tab, @lst)
  supplement-figure:  "Abbildung",
  supplement-table:   "Tabelle",
  supplement-listing: "Listing",

  // ---- Document type names ---- //
  doc-names: (
    project:       "Projektarbeit",
    project-doc:   "Projektdokumentation",
    term-paper:    "Studienarbeit",
    bachelor:      "Bachelorarbeit",
    seminar:       "Seminararbeit",
  ),

  // ---- Title page – metadata labels ---- //
  meta-course:             "Kurs:",
  meta-mat-number:         "Matrikelnummer:",
  meta-partner:            "Dualer Partner:",
  meta-company-supervisor: "Projektbetreuer:",   // company-side supervisor (toggleable)
  meta-supervisor:         "Gutachter DHBW:",
  meta-date:               "Abgabedatum:",

  // ---- Title page – institutional text ---- //
  program-prefix: "des Studienganges",
  university:     "an der DHBW Ravensburg",
  by:             "von",

  // ---- Confidentiality notice & declaration – shared ---- //
  place-date: "Ort, Datum",
  signature:  "Unterschrift",

  // ---- Confidentiality notice ---- //
  confidentiality-title: "Sperrvermerk",
  confidentiality-law:   [gemäß Ziffer 1.1.13 der Anlage 1 zu §§ 3, 4 und 5 der
    Studien- und Prüfungsordnung für die Bachelorstudiengänge der
    Dualen Hochschule Baden-Württemberg vom 29.09.2017:],
  confidentiality-body:  [Der Inhalt dieser Arbeit darf weder als Ganzes noch in Auszügen Personen
    außerhalb des Prüfungsprozesses und des Evaluationsverfahrens zugänglich
    gemacht werden, sofern keine anderslautende Genehmigung des Dualen Partners
    vorliegt.],

  // ---- Declaration of independence ---- //
  declaration-title: "Selbständigkeitserklärung",
  declaration-intro: "Ich versichere hiermit, dass ich die vorliegende",
  declaration-theme: "mit dem Thema",
  declaration-body:  [selbständig verfasst und keine anderen als die angegebenen
    Quellen und Hilfsmittel verwendet habe und diese Arbeit bei keiner anderen
    Prüfung mit gleichem oder vergleichbarem Inhalt vorgelegt habe und diese
    bislang nicht veröffentlicht wurde. Des Weiteren versichere ich,
    dass die eingereichte elektronische Fassung
    mit der gedruckten Ausfertigung übereinstimmt.],

  // ---- Appendix – AI tools table (data/ai-tools.typ) ---- //
  appendix-ai-heading: "A1: Übersicht eingesetzter KI-Werkzeuge",
  appendix-ai-caption: "Übersicht über die Nutzung von KI-basierten Werkzeugen",
  appendix-ai-col1:    "Werkzeug",
  appendix-ai-col2:    "Beschreibung der Nutzung",

  // ---- AI declaration (pages/ai-declaration.typ) ---- //
  ai-declaration-title: "Erklärung und Nutzungsdokumentation zum Einsatz von KI-basierten Werkzeugen bei der Anfertigung von wissenschaftlichen Arbeiten als Prüfungsleistungen",
  ai-declaration-intro: [Zur Verwendung KI-gestützter Werkzeuge #underline[erkläre ich in Kenntnis des Hinweisblatts] "Hinweise zum Einsatz von KI-basierten Werkzeugen bei der Anfertigung von wissenschaftlichen Arbeiten als Prüfungsleistungen im prüfungsrechtlichen Kontext" Folgendes:],
  ai-declaration-items: (
    [Ich habe mich aktiv über die Leistungsfähigkeit und Beschränkungen der in meiner Arbeit eingesetzten KI-Werkzeuge informiert.],
    [Bei der Anfertigung der Arbeit habe ich durchgehend eigenständig und beim Einsatz KI-gestützter Werkzeuge maßgeblich steuernd gearbeitet.],
    [Insbesondere habe ich die Inhalte entweder aus wissenschaftlicher oder anderen zugelassenen Quellen entnommen und diese gekennzeichnet oder diese unter Anwendung wissenschaftlicher Methoden selbst entwickelt.],
    [Mir ist bewusst, dass ich als Verfasser:in der Arbeit die volle Verantwortung für die in ihr gemachten Angaben und Aussagen trage.],
    [Soweit ich KI-gestützte Werkzeuge zur Erstellung der Arbeit eingesetzt habe, sind diese zu den Produktnamen, den formulierten Eingaben (Prompts), den Einsatzzwecken und der entsprechenden Seiten-/Bereichsreferenzierung auf die Arbeit im KI-Verzeichnis am Ende der Arbeit #underline[vollständig] ausgewiesen und im Text belegt (z.B. als Fußnote).],
  ),
)
