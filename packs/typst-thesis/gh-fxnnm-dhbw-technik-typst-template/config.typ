// ============================================================
//  DHBW Stuttgart – Konfiguration
//  Hier alle persönlichen Daten und Einstellungen anpassen.
// ============================================================

// --- Art der Arbeit ---
// Mögliche Werte: "Bachelorarbeit", "Projektarbeit", "Studienarbeit", "Hausarbeit"
#let work-type = "Bachelorarbeit"

// Titel der Arbeit
#let work-title = "Titel der wissenschaftlichen Arbeit"

// --- Studiengang & Standort ---
#let study-program = "Informationstechnik"
#let dhbw-location  = "Stuttgart"

// --- Autor ---
#let author               = "Vorname Nachname"
#let matriculation-number = "1234567"
#let course               = "TIT22"

// --- Zeitangaben ---
#let submission-date   = "01. Januar 2025"
#let processing-period = "12 Wochen"        // alternativ: "01.10.2024 – 01.01.2025"

// --- Dualer Partner ---
#let dual-partner-name = "Firmenname, Stadt"

// Logo des Dualen Partners: none  oder  image("company-logo.png", height: 1.5cm)
#let dual-partner-logo = none

#let dual-partner-supervisor = "Titel Vorname Nachname"
#let dhbw-supervisor         = "Titel Vorname Nachname"

// Betreuer-/Gutachter-Zeilen ein-/ausblenden
// (bei Praxisprojekt I und III typischerweise beide auf false)
#let show-partner-supervisor = true
#let show-dhbw-supervisor    = true

// --- Optionale Abschnitte ---
#let has-confidentiality-notice = false
#let confidentiality-duration   = "zwei Jahre"  // Befristung des Sperrvermerks

// Bei rein elektronischer Abgabe auf true setzen (entfernt den Satz über
// die Übereinstimmung von elektronischer und gedruckter Fassung)
#let electronic-only-submission = false

#let uses-ai-tools = false
// KI-Werkzeuge: Liste von (Name, Beschreibung)-Paaren
#let ai-tools = (
  ("ChatGPT",            "Formulierungshilfe (gesamt)"),
  ("Microsoft Copilot",  "Korrekturhilfe und Übersetzung (gesamt)"),
)

// --- Sprache ---
// "de" → deutsche Beschriftungen  |  "en" → englische Beschriftungen
#let document-language = "de"
