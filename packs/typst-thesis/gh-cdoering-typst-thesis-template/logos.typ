// =============================================================================
// LOGOS
//
// Vordefinierte Logo-Einstellungen, damit in config.typ nur ein Kuerzel steht:
//
//   university_logo: logo("platzhalter")
//   company_logo:    logo("platzhalter", width: 30%)
//   university_logo: none                          // kein Logo
//
// Mitgeliefert ist nur ein neutraler Platzhalter. Logos von Hochschulen und
// Unternehmen sind marken- und urheberrechtlich geschuetzt und werden mit
// dieser Vorlage bewusst nicht verteilt. Fuer die eigene Arbeit ist die
// Verwendung des Hochschullogos ueblich und zulaessig -- die Datei ist selbst
// zu beschaffen, in der Regel ueber das Corporate-Design-Portal der
// Hochschule. Viele Hochschulen fuehren mehrere Fassungen (nach Standort,
// Fachbereich, ein- oder mehrfarbig); massgeblich ist die fuer Abschluss-
// arbeiten vorgesehene Variante.
//
// Eigenes Logo registrieren: Datei nach assets/ legen und unten einen Eintrag
// ergaenzen. Danach genuegt in config.typ das Kuerzel. Wer nur ein einziges
// Logo braucht, kann diese Datei auch ignorieren und in config.typ direkt
// image("assets/datei.png", width: 60%) schreiben.
//
// Dateiformate: PNG, JPEG, GIF, SVG und WebP. Fuer Logos ist SVG vorzuziehen
// (verlustfrei skalierbar); bei PNG auf ausreichende Aufloesung und einen
// transparenten Hintergrund achten.
//
// Fehlt eine hinterlegte Datei, meldet Typst beim Kompilieren "file not found"
// mit dem erwarteten Pfad.
//
// Pfade werden relativ zu DIESER Datei aufgeloest, also relativ zum
// Wurzelverzeichnis des Repositorys.
// =============================================================================

#let presets = (
  // Kuerzel: (Datei in assets/, Breite auf dem Titelblatt, Klarname)
  platzhalter: (
    file: "assets/logo-placeholder.svg",
    width: 55%,
    label: "Neutraler Platzhalter (mitgeliefert)",
  ),

  // Beispiel fuer einen eigenen Eintrag -- Kommentarzeichen entfernen und
  // Kuerzel, Dateinamen und Breite anpassen:
  //
  // meine-hochschule: (
  //   file: "assets/logo-hochschule.png",
  //   width: 80%,
  //   label: "Name der Hochschule",
  // ),
)

// Liefert fertigen Bild-Content oder none.
// width ueberschreibt bei Bedarf die im Preset hinterlegte Breite.
#let logo(key, width: auto) = {
  if key == none { return none }
  if key not in presets {
    panic(
      "logos.typ: Kein Preset \"" + key + "\". Verfügbar: "
        + presets.keys().join(", ")
        + ". Eigenes Logo entweder als Preset ergänzen oder direkt als "
        + "image(\"assets/datei.png\", width: 60%) in config.typ setzen."
    )
  }
  let p = presets.at(key)
  image(p.file, width: if width == auto { p.width } else { width })
}
