// =============================================================
// glossary.typ – Glossar-Anzeige
// =============================================================

#import "@preview/glossarium:0.5.10": print-glossary
#import "glossary-entries.typ": glossary-entries

#heading(level: 1, outlined: true)[Glossar]

#print-glossary(
  glossary-entries,
  show-all: true, // Alle Einträge anzeigen (auch nicht referenzierte)
  disable-back-references: false, // Rückverweise auf Fundstellen im Text anzeigen
)
