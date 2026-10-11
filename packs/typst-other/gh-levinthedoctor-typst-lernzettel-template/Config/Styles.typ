// =============================================================================
// Lernzettel: Zentrale Farben und Maße
// =============================================================================
// Alle Farb- und Layoutkonstanten stehen hier an genau einer Stelle. Die
// Komponenten unter Template/Komponenten/ greifen ausschließlich hierauf zu;
// in den Bausteinen selbst ist keine Farbe hart kodiert.

// --- Schrift -----------------------------------------------------------------
#let font = ("Helvetica Neue", "Helvetica", "Arial")
#let monofont = ("JetBrains Mono", "Menlo", "DejaVu Sans Mono", "Courier New")

// --- Farbschema nach Einsatzzweck --------------------------------------------
// `reason` schaltet die Grundfarben um. Wichtig: Die Zuweisung muss auf
// Modulebene stehen. Ein `let` innerhalb eines `if`-Blocks ist nur dort
// sichtbar und würde außerhalb (und damit in allen Komponenten) fehlen.
#let reason = "Berufschule" // "Berufschule" | "Uni" | "Arbeit"

#let _palette = if reason == "Uni" {
  (primary: rgb("#2E4057"), accent: rgb("#048A81"))
} else if reason == "Arbeit" {
  (primary: rgb("#191b1e"), accent: rgb("#292e72"))
} else {
  (primary: rgb("#191b1e"), accent: rgb("#e16d0e"))
}

#let primary = _palette.primary
#let accent = _palette.accent

// --- Boxen -------------------------------------------------------------------
// Einheitlicher Innenabstand aller Kastenkomponenten.
#let boxinnersep = 9pt

// Infobox (Blau)
#let infocolor = rgb("#EAF2FB") // Hintergrund
#let infoframe = rgb("#2F6FB3") // Rahmen und Titel-Chip

// Warnbox / Tipp (Bernstein)
#let warncolor = rgb("#FFF6E5")
#let warnframe = rgb("#D98A00")

// Merksatz (Indigo/Lila)
#let merksatzcolor = rgb("#F0EEFF")
#let merksatzframe = rgb("#5C4EC2")

// Beispiel (Smaragdgrün)
#let beispielcolor = rgb("#EAF7F0")
#let beispielframe = rgb("#1E8E5A")

// Aufgabe (Goldgelb)
#let aufgabecolor = rgb("#FFF9E0")
#let aufgabeframe = rgb("#B8860B")

// Konzeptkarte (neutraler Hintergrund, Titelleiste in `primary`)
#let konzeptcolor = rgb("#FAFAFB")

// --- Ablauf (process) --------------------------------------------------------
// Die Schrittnummern und der linke Rand; der Hintergrund wird daraus aufgehellt.
#let stepcolor = accent

// --- Gegenüberstellung (procon) ----------------------------------------------
#let procolor = rgb("#EAF7F0") // Vorteile: Hintergrund
#let proframe = rgb("#1E8E5A") // Vorteile: Rahmen und Kopfleiste
#let concolor = rgb("#FDEEEE") // Nachteile: Hintergrund
#let conframe = rgb("#C0392B") // Nachteile: Rahmen und Kopfleiste

// --- Tabellen ----------------------------------------------------------------
#let tableheader = primary // Kopfzeile
#let tableheadertext = white // Schrift in der Kopfzeile
#let tablerowalt = rgb("#F4F4F6") // jede zweite Zeile

// --- Code --------------------------------------------------------------------
#let codeblock = rgb("#F5F5F5") // Hintergrund
#let codeframe = rgb("#CCCCCC") // Rahmen

// --- Seitenlayout (Voreinstellungen) -----------------------------------------
// Kompaktes Lernzettel-Format. Jeder dieser Werte lässt sich in main.typ über
// das gleichnamige Argument von #lernzettel(...) überschreiben.
#let papier-standard = "a4"
#let raender-standard = (top: 2cm, bottom: 2cm, left: 2cm, right: 2cm)
#let schriftgroesse-standard = 11pt

// Zeilenabstand: Typst rechnet Grundlinienabstand = leading + Versalhöhe.
// 0.65em ergibt bei 11 pt einen dichten, aber gut lesbaren Satz.
#let zeilenabstand-standard = 0.65em
#let absatzabstand-standard = 0.65em + 6pt

// Abstände um Überschriften und Beschriftungen.
#let abstand-vor-ueberschrift = 1.4em
#let abstand-nach-ueberschrift = 0.7em

// Abbildungen und Tabellen brauchen unten mehr Luft als eine Überschrift: Dort
// steht die Quellenzeile, die sonst am Folgeabsatz klebt.
#let abstand-nach-abbildung = 1.3em

// --- Fußnoten ----------------------------------------------------------------
// Fußnoten tragen die Kurzbelege der Zitierweise "chicago".
#let fussnoten-groesse = 9pt
#let fussnoten-zeilenabstand = 0.45em

// --- Literaturverzeichnis ----------------------------------------------------
#let literatur-zeilenabstand = 0.45em
#let literatur-eintragsabstand = 0.9em
