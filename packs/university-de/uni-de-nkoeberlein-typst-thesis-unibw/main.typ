
// ===================================================================
// main.typ – Hauptdokument
// Moderne Typst-Vorlage für wissenschaftliche Arbeiten
// Universität Regensburg
// ===================================================================
//
// KOMPILIERUNG:
//   typst compile --font-path fonts main.typ
//
// AUTOMATISCHES NEU-KOMPILIEREN BEI ÄNDERUNGEN:
//   typst watch --font-path fonts main.typ
//
// Hinweis: Der Font-Pfad ist notwendig, damit Bookerly aus dem /fonts-Ordner erkannt wird.

// === Importe ===
#import "metadata.typ": *
#import "lib/template.typ": appendix-start, loc, lof, lot, template, this-page-empty, toc
#let is-print = false // Doppelseiten-Layout: true = Druck, false = Bildschirm/PDF
#let is-draft = false // ENTWURF-Wasserzeichen: true = sichtbar, false = kein Wasserzeichen
#import "lib/styles.typ": *
#import "lib/colors.typ": *
#import "@preview/glossarium:0.5.10": gls, glspl, make-glossary, print-glossary, register-glossary
#import "chapters/anhang/glossary-entries.typ": glossary-entries
#import "bibliography/image-sources.typ": image-sources-data

// Alle set/show-Regeln aus lib/template.typ werden aktiv
#show: template.with(meta: meta, is-print: is-print, is-draft: is-draft)

// === Glossarium: NACH den Figure-Show-Rules des Templates aktivieren ===
// (Verhindert Konflikte mit show figure-Regeln laut Glossarium-Dokumentation)
#show: make-glossary
#register-glossary(glossary-entries)


// ===================================================================
// FRONTMATTER (Römische Seitennummerierung)
// ===================================================================

#set page(numbering: "I")
#counter(page).update(1)

// --- Titelseite ---
#include "pages/title-page.typ"

// --- Aufgabenstellung (optional, auskommentieren falls nicht benötigt) ---
// #include "pages/task-description.typ"

// --- Abstract (empfohlen) ---
#include "pages/abstract.typ"

// --- Danksagung (optional) ---
// #include "pages/acknowledgments.typ"

// ===================================================================
// VERZEICHNISSE
// ===================================================================

// Inhaltsverzeichnis (erforderlich)
#toc()

// Abbildungsverzeichnis (aktivieren falls Abbildungen vorhanden)
#lof()

// Tabellenverzeichnis (aktivieren falls Tabellen vorhanden)
#lot()

// Codeverzeichnis (aktivieren falls Code-Listings vorhanden)
#loc()

// ===================================================================
// HAUPTTEIL (Arabische Seitennummerierung, beginnt bei 1)
// ===================================================================

#if is-print { pagebreak(to: "odd") } else { pagebreak(weak: true) }
#set page(numbering: "1")
#counter(page).update(1)

// === Hauptkapitel der Arbeit ===
// Passen Sie diese an Ihre Arbeit an!

#include "chapters/einleitung.typ"
#pagebreak()

#include "chapters/grundlagen.typ"
#pagebreak()

#include "chapters/hauptteil.typ"
#pagebreak()

// Weitere Kapitel nach Bedarf hinzufügen:
// #include "content/evaluation.typ"
// #pagebreak()
// #include "content/related-work.typ"
// #pagebreak()

#include "chapters/schluss.typ"

// ===================================================================
// LITERATURVERZEICHNIS
// ===================================================================

#set heading(numbering: none)

#bibliography(
  "bibliography/references.bib",
  title: "Literaturverzeichnis",
  style: "ieee", // Alternativen: "apa", "chicago-author-date", "mla"
  full: false, // true = alle Quellen anzeigen, auch nicht zitierte
)

#pagebreak()

// ===================================================================
// BILDQUELLENVERZEICHNIS (System 2: römische Ziffern [I], [II], ...)
// Zitierung im Text: source: [#imgcite("schluessel")]
// Quellendaten in bibliography/image-sources.typ pflegen.
// ===================================================================

#print-img-sources(image-sources-data)

#pagebreak()
#this-page-empty()

// ===================================================================
// ANHANG
// ===================================================================

#show: appendix-start

// Abkürzungsverzeichnis und Glossar
#include "chapters/anhang/glossary.typ"

// Code-Beispiele
#include "chapters/anhang/code-examples.typ"

// Weitere Anhänge nach Bedarf:
// #include "content/anhang-zusatzdaten.typ"

// ===================================================================
// EIDESSTATTLICHE ERKLÄRUNG
// ===================================================================

#include "pages/declaration.typ"
