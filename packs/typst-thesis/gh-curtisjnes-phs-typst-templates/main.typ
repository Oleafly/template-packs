// Vorlage für WABs der Provadis Hochschule
// Konvertiert zu Typst
// CC BY 4.0
//
// main.typ - Das ist das zentrale Dokument.

#import "template.typ": *

#show: phs-thesis.with(
  // Persönliche Daten
  fullname: "Max Mustermann",
  email: "max.mustermann@stud-provadis-hochschule.de",
  matnr: "12345",
  tel-mobil: "+49 170 1234567",
  fakultaet: "Informatik und Wirtschaftsinformatik",

  // Daten zur Arbeit
  titel: [Analyse der Auswirkungen von Lorem Ipsum \
          auf die moderne Softwareentwicklung],
  unternehmen: "Musterfirma GmbH",
  abgabedatum: "15.08.2026",
  studiengang: "Informatik",
  art: "Bachelorarbeit",
  akademischer-grad: "Bachelor of Science",
  abkuerzung-grad: "B.Sc.",

  // Betreuer
  ref-first: "Prof. Dr. Anna Schmidt",
  ref-second: "Prof. Dr. Thomas Müller",

  // Optionale Teile
  show-sperrvermerk: true,
  show-abstract: true,
  abstract-text: [
    Diese Arbeit untersucht die Auswirkungen von Lorem Ipsum auf die moderne Softwareentwicklung. Durch eine systematische Analyse werden die theoretischen Grundlagen dargestellt und empirisch überprüft. Die Ergebnisse zeigen, dass consectetur adipiscing elit eine signifikante Rolle bei der Entwicklung von sed do eiusmod tempor spielt.

    Die Arbeit leistet einen Beitrag zum Verständnis von ut labore et dolore magna aliqua und bietet praktische Implikationen für die Anwendung in der Industrie.
  ],

  // Glossar aus YAML-Datei (Standard: glossary.yaml)
  glossary-file: "glossary.yaml",

  // Logos (SVG oder PNG verwenden - PDF wird nicht unterstützt)
  // logo: "Bilder/Deckblatt/provadis-hochschule.svg",
  // logo-unternehmen: "Bilder/Deckblatt/unternehmen.svg",
)

// ============= KAPITEL =============
// Modulare Struktur: Jedes Kapitel in einer eigenen Datei
#glossary(
  title: "Glossar",
  sort: true,
  ignore-case: false,
  show-all: true,
)
#include "chapters/01-einfuehrung.typ"
#include "chapters/02-stand-der-forschung.typ"
#include "chapters/03-methodik.typ"
#include "chapters/04-untersuchung.typ"
#include "chapters/05-ergebnisse.typ"
#include "chapters/06-fazit.typ"


// ============= ANHANG =============

#pagebreak()
#set page(numbering: "I")
#counter(page).update(1)

// Literaturverzeichnis
#heading(level: 1, numbering: none)[Literaturverzeichnis]
#bibliography("referenzen.bib", style: "ieee")

#pagebreak()

// KI-Verzeichnis
#anhang([KI-Verzeichnis])[
  #ki-verzeichnis((
    (system: "ChatGPT 4", prompt: "Erkläre die Grundlagen von Lorem Ipsum", verwendung: "als Inspiration verwendet"),
    (system: "Claude", prompt: "Fasse die wichtigsten Aspekte von Dolor Sit zusammen", verwendung: "weiterentwickelt"),
  ))
]

#pagebreak()

// Selbstständigkeitserklärung
#selbststaendigkeitserklaerung("Max Mustermann")
