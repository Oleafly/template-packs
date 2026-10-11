// ---------------------------------------------------------------------------
// Zentrale Metadaten der Arbeit
//
// Dies ist die EINZIGE Datei, in der personenbezogene Angaben stehen.
// Alle anderen Dateien (Titelblatt, Aufgabenstellung, Erklaerung, Kopfzeile)
// greifen auf die hier definierten Variablen zu.
//
// TODO: Alle Werte durch die eigenen Angaben ersetzen.
// ---------------------------------------------------------------------------

#let name = "Mustermann"
#let vorname = "Max"
#let matrikelnummer = "123456"

// "Bachelorarbeit" oder "Masterarbeit"
#let arbeit = "Masterarbeit"

#let studiengang = "[PLATZHALTER Studiengang]"
#let studienprofil = "[PLATZHALTER Studienprofil]"
#let faculty = "Fakultät Ingenieurwissenschaften"

#let thema = "Titel der Abschlussarbeit"

// Verantwortlicher Hochschullehrer bzw. Erstgutachter:in
#let professor = "Prof. Dr. Erika Musterfrau"
// Zweitgutachter:in oder betrieblicher Betreuer bzw. betriebliche Betreuerin
#let chef = "M.Sc. Max Mustermann"

// Firma oder Kooperationspartner (leer lassen, falls nicht zutreffend)
#let unternehmen = "[PLATZHALTER Kooperationspartner]"

// Termine
#let ausgabetermin = "01. April 2026"
#let abgabetermin = "30. September 2026"

// Datum auf Titelblatt und Erklaerung.
// Variante A (automatisch, heutiges Datum):
#let datum = [#datetime.today().display("[day].[month].[year]")]
// Variante B (fest): #let datum = "30.09.2026"

#let ort = "Leipzig"
