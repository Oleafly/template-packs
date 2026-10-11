// =============================================================================
// SYMBOLVERZEICHNIS
//
// Gruppen mit jeweils einer Liste aus (Symbol, Bedeutung).
// Das Symbol wird als Typst-Mathematik interpretiert, also z. B. "alpha"
// fuer die griechische Kleinbuchstabenform oder "overline(x)" fuer x quer.
//
// Reine Zahlwerte, Indizes ohne eigenstaendige Bedeutung und allgemein
// bekannte Operatoren gehoeren ueblicherweise nicht ins Symbolverzeichnis.
//
// Leere Liste () -> Verzeichnis bleibt leer. Ganz abschalten ueber
// cfg.sections.symbols in config.typ.
// =============================================================================

#let symbol-groups = (
  (
    "Beispielgruppe",
    (
      ("n", [Anzahl der Beobachtungen]),
      ("overline(x)", [arithmetisches Mittel]),
      ("sigma", [Standardabweichung]),
    ),
  ),
)
