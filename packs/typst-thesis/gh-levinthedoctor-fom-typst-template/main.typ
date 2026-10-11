// =============================================================================
// FOM Wissenschaftliche Arbeit – Haupteinstiegspunkt (Minimal-Variante)
// =============================================================================
// Kompilieren:  typst compile --font-path fonts main.typ thesis.pdf
// oder:         make build   |   Live-Vorschau: make watch
//
// Ausführliche Anleitung: Doku-Webseite im Branch `webapp` (/docs-app) bzw.
// vollständiges Beispiel im Branch `example-seminararbeit`.

#import "template/fom.typ": *
#import "@preview/wordometer:0.1.5": total-words, word-count

#show: fom-arbeit.with(
  // --- Titelblatt (Leitfaden 2.1) --------------------------------------------
  titel: [Titel der Arbeit],
  autor: "Vorname Nachname",
  typ: "Bachelor-Thesis", // "Master-Thesis", "Seminararbeit", "Hausarbeit"
  studiengang: "Business Administration",
  grad: "Bachelor of Arts (B.A.)",
  erstgutachter: "Prof. Dr. …",
  matrikelnummer: "000000",
  abgabedatum: "TT.MM.JJJJ",
  // Für Seminararbeiten zusätzlich:
  // studienzentrum: "Hochschulzentrum …",
  // modul: "Wissenschaftliches Arbeiten",
  //
  // Logo auf dem Titelblatt (Anhang 4 des Leitfadens zeigt es mittig oben):
  logo: image("abbildungen/fom-logo.svg", width: 2.2cm),

  // --- Formale Konfiguration --------------------------------------------------
  zitierweise: "chicago", // "chicago" (Fußnoten), "harvard" oder "apa" (im Text)
  schriftart: "Times New Roman", // "Arial" setzt automatisch 11,5 pt
  abkuerzungen: (
    // "HRM": "Human Resource Management",
  ),
  // symbole: ("m²": "Quadratmeter"),
  // sperrvermerk: (ort: "Essen", datum: "TT.MM.JJJJ"),
)

// --- Textteil -----------------------------------------------------------------
// #word-count zählt nur den Fließtext: Fußnoten sowie Abbildungen und
// Tabellen (Titel, Inhalt und Quellenzeile) bleiben außen vor. Das Ergebnis
// steht über die Marke <word-count> für das Titelblatt (wortanzahl: auto)
// und `make wordcount` bereit.
#word-count(
  total => [
    #include "content/01-einleitung.typ"
    #include "content/02-hauptteil.typ"

    #metadata(total.words) <word-count>
  ],
  exclude: (footnote, figure, table),
)

// --- Anhang (optional, Leitfaden 2.8) ------------------------------------------
// #anhang[
//   #anhang-abschnitt([Verwendeter Fragebogen])[...]
// ]

// --- Literaturverzeichnis (Leitfaden 2.6) --------------------------------------
#literaturverzeichnis(datei: "/literatur/literatur.bib")

// --- KI-Hilfsmittelverzeichnis (Leitfaden 2.9) ---------------------------------
#ki-hilfsmittelverzeichnis((
  // (tool: "ChatGPT", version: "4o", nutzung: "…", teile: "Kapitel …", datum: "TT.MM.JJJJ"),
))

// --- Eigenständigkeitserklärung (Leitfaden 2.10, ohne Seitenzahl) --------------
#eigenstaendigkeitserklaerung(ort: "Ort", datum: "TT.MM.JJJJ")
