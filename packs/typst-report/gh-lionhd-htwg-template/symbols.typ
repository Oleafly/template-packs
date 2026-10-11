// filepath: c:\Projekte\temp\htwg_template\symbols.typ

#let symbols = (
  // Format: Formelzeichen, Einheit, Bedeutung
  (symbol: "A", unit: "m²", description: "Fläche, Oberfläche"),
  (symbol: "AC", unit: "—", description: "Beschleunigungsparameter"),
  (symbol: "a", unit: "—", description: "Konstruktions-Konstante"),
  (symbol: "b", unit: "m", description: "Breite"),
  (symbol: "c", unit: "m", description: "axiale Sehnenlänge"),
  (symbol: "C_L", unit: "€/a", description: "Lizenzkosten pro Jahr"),
  (symbol: "C_I", unit: "€", description: "Initiale Investitionskosten"),
  (symbol: "C_M", unit: "€/a", description: "Wartungskosten pro Jahr"),
  (symbol: "C_T", unit: "€", description: "Gesamtkosten über Laufzeit"),
  (symbol: "d", unit: "—", description: "Konstruktions-Konstante"),
  (symbol: "n", unit: "a", description: "Nutzungsdauer in Jahren"),
  (symbol: "ROI", unit: "%", description: "Return on Investment"),
  (symbol: "R_L", unit: "—", description: "Lizenzkostenreduktionsfaktor"),
  (symbol: "α", unit: "Grad", description: "Zuströmwinkel"),
  (symbol: "β", unit: "Grad", description: "Schaufel-Austrittswinkel"),
  (symbol: "Γ", unit: "—", description: "Zirkulation"),
  (symbol: "δ₁", unit: "—", description: "Verdrängungsdicke"),
  (symbol: "δ₂", unit: "—", description: "Impulsverlustdicke"),
  (symbol: "η", unit: "—", description: "Wirkungsgrad"),
  (symbol: "η_L", unit: "—", description: "Lizenznutzungseffizienz"),
  (symbol: "η", unit: "Pa·s", description: "dynamische Viskosität"),
  (symbol: "σ", unit: "—", description: "Standardabweichung")
)

// Funktion zum Formatieren der Formeltabelle
#let format-symbols-table(symbols-list, title: "") = {
  // Tabellentitel mit Nummer erstellen (optional)
  if title != "" {
    heading(level: 2, numbering: none, outlined: false)[#title]
  }
  
  // Einfache Tabelle ohne Figure/Caption (wird nicht im Inhaltsverzeichnis angezeigt)
  table(
    columns: (auto, auto, 1fr),
    inset: 8pt,
    align: (left, left, left),
    stroke: 0.5pt,
    // Kopfzeile
    [*Zeichen*], [*Einheit*], [*Bedeutung*],
    // Tabellendaten
    ..symbols-list.map(sym => (
      math.italic(sym.symbol),
      sym.unit,
      sym.description
    )).flatten()
  )
}
