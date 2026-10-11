// =============================================================================
// Lernzettel: Abkürzungen
// =============================================================================
// Abkürzungen werden zentral definiert (in main.typ über das Feld
// `abkuerzungen`) und im Text mit `#abk("KI")` verwendet.
//
//  - Erste Verwendung:   "Künstliche Intelligenz (KI)"
//  - Folgeverwendungen:  "KI"
//  - Das Abkürzungsverzeichnis führt automatisch nur die tatsächlich
//    verwendeten Abkürzungen alphabetisch sortiert auf.

#let _abk-definitionen = state("lz-abk-definitionen", (:))
#let _abk-verwendet = state("lz-abk-verwendet", ())

// Wird vom Template beim Dokumentstart aufgerufen.
#let abk-definiere(definitionen) = _abk-definitionen.update(definitionen)

// Verwendet eine Abkürzung im Text.
//   #abk("KI")            -> "Künstliche Intelligenz (KI)" bzw. "KI"
//   #abk("KI", lang: true) -> erzwingt die Langform mit Klammerzusatz
#let abk(kuerzel, lang: false) = context {
  let definitionen = _abk-definitionen.get()
  if kuerzel not in definitionen {
    panic("Abkürzung '" + kuerzel + "' ist nicht definiert. Bitte in main.typ unter 'abkuerzungen' ergänzen.")
  }
  let langform = definitionen.at(kuerzel)
  let bereits-verwendet = kuerzel in _abk-verwendet.get()
  _abk-verwendet.update(liste => if kuerzel in liste { liste } else { liste + (kuerzel,) })
  if bereits-verwendet and not lang { kuerzel } else [#langform (#kuerzel)]
}
