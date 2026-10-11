// ============================================================
//  DHBW Stuttgart – Hauptdokument (Assembler)
//  Persönliche Daten in config.typ anpassen.
//  Kapitelinhalte in content/*.typ bearbeiten.
// ============================================================

#import "config.typ": *
#import "template.typ": dhbw-document, dhbw-red, formel, skript
#import "title-page.typ": dhbw-title-page
#import "declarations.typ": confidentiality-notice, declaration-of-honor, ai-usage-section
#import "acronyms.typ": acr, acrs, acrl

#show: dhbw-document

// ══════════════════════════════════════════════════════════════
//  VORSPANN  (römische Seitenzahlen I, II, III …)
// ══════════════════════════════════════════════════════════════

#counter(page).update(0)
#dhbw-title-page()

#if has-confidentiality-notice {
  confidentiality-notice()
}

#declaration-of-honor()

#include "content/kurzfassung.typ"

// Vorwort (Kommentar entfernen, falls benötigt – optional laut Leitlinien §4.1)
// #include "content/vorwort.typ"

// Inhaltsverzeichnis
#outline(
  title:  "Inhaltsverzeichnis",
  depth:  3,
  indent: auto,
)

// Abbildungsverzeichnis (kann auskommentiert werden falls es nicht gebraucht wird)
#heading(level: 1, numbering: none)[Abbildungsverzeichnis]
#outline(title: none, target: figure.where(kind: image))

// Tabellenverzeichnis (kann auskommentiert werden falls es nicht gebraucht wird)
#heading(level: 1, numbering: none)[Tabellenverzeichnis]
#outline(title: none, target: figure.where(kind: table))

// Formelverzeichnis (kann auskommentiert werden falls es nicht gebraucht wird)
#heading(level: 1, numbering: none)[Formelverzeichnis]
#outline(title: none, target: figure.where(kind: "formel"))

// Skriptverzeichnis (kann auskommentiert werden falls es nicht gebraucht wird)
#heading(level: 1, numbering: none)[Skriptverzeichnis]
#outline(title: none, target: figure.where(kind: "skript"))

// Abkürzungsverzeichnis (Kommentar entfernen, falls benötigt)
#include "content/abkuerzungen.typ"

// ══════════════════════════════════════════════════════════════
//  HAUPTTEIL  (arabische Seitenzahlen 1, 2, 3 … ab hier)
// ══════════════════════════════════════════════════════════════

#set page(numbering: "1")
#counter(page).update(1)
#counter(heading).update(0)

#include "content/01_einleitung.typ"
#include "content/02_grundlagen.typ"
#include "content/03_methodik.typ"
#include "content/04_ergebnisse.typ"
#include "content/05_fazit.typ"

// ══════════════════════════════════════════════════════════════
//  NACHSPANN
// ══════════════════════════════════════════════════════════════

// Quellenverzeichnis (IEEE-Stil)
#bibliography("references.bib", style: "ieee", title: "Quellenverzeichnis")

// Anhang (Kommentar entfernen, falls benötigt)
// #include "content/anhang.typ"

// KI-Anmerkung (erscheint automatisch, wenn uses-ai-tools = true in config.typ)
#if uses-ai-tools {
  ai-usage-section()
}
