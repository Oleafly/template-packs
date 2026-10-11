/// Erstellt ein indirektes Zitat mit Fußnote
///
/// Diese Funktion generiert eine hochgestellte Fußnotenmarkierung mit "Vgl."
/// Präfix im deutschen akademischen Stil.
///
/// Parameter:
/// - key (str): Bibliografie-Schlüssel aus bibliography.bib
///   Verfügbare Schlüssel: "smith2020", "graca2024"
/// - page (str, optional): Seitenzahl oder -bereich
///   Beispiele: "23", "23-25", "23f.", "23ff."
///
/// Rückgabe: Fußnote mit Zitat
///
/// Beispiele:
/// ```typst
/// // Grundlegende Verwendung
/// Textinhalt#vgl("graca2024").
///
/// // Mit Seitenzahl
/// Textinhalt#vgl("smith2020", page: "123").
///
/// // Mit Seitenbereich
/// Textinhalt#vgl("graca2024", page: "15-20").
/// ```
#let vgl(key, page: none) = {
  if page != none {
    footnote([Vgl. #cite(label(key), form: "prose"), S. #page])
  } else {
    footnote([Vgl. #cite(label(key), form: "prose")])
  }
}
