#import "@preview/glossarium:0.5.10": make-glossary, register-glossary
#import "template.typ": *
#import "glossary.typ": entry-list

// ─── Document setup ──────────────────────────────────────────────────────────
#show: setup-page
#show: make-glossary
#register-glossary(entry-list)

// ─── Title Page (no page number) ─────────────────────────────────────────────
#title-page(
  title: [Thesis Title],
  subtitle: [A catchy subtitle],
  author: "John Doe",
  student-number: "S2123456",
  supervisor: "Dr Jane Smith",
  supervisor-affiliation: "University of Groningen",
  month-year: "May 2026",
)

// ─── Frontmatter — roman numerals ────────────────────────────────────────────

// Blank verso of title page (not numbered)
#page(numbering: none)[]

#set page(numbering: "i", number-align: right)
#counter(page).update(1)

#include "frontmatter/abstract.typ"

#pagebreak()

// Dedication (self-contained page with its own layout)
#include "frontmatter/dedication.typ"

// Blank verso after dedication — left empty by convention
#page(numbering: none)[]

#include "frontmatter/acknowledgements.typ"

#pagebreak()

#outline(
  title: [Table of Contents],
  depth: 3,
  indent: auto,
)

#pagebreak()

#heading(level: 1, numbering: none, outlined: true)[List of Figures]
#outline(title: none, target: figure.where(kind: image))

#pagebreak()

#heading(level: 1, numbering: none, outlined: true)[List of Tables]
#outline(title: none, target: figure.where(kind: table))

#pagebreak()

#include "frontmatter/abbreviations.typ"

#pagebreak()

#include "frontmatter/concepts.typ"

// ─── Chapters — arabic numerals ──────────────────────────────────────────────
#pagebreak()
#set page(numbering: "1", number-align: right)
#counter(page).update(1)

#include "chapters/01_introduction.typ"
#include "chapters/02_theory.typ"
#include "chapters/03_empirical.typ"
#include "chapters/04_discussion.typ"
#include "chapters/05_conclusions.typ"
#include "chapters/examples.typ"

// ─── Bibliography ─────────────────────────────────────────────────────────────
#bibliography("references.bib", style: "apa", title: "Bibliography")

// ─── Appendices ───────────────────────────────────────────────────────────────
#set heading(numbering: "A.1.1")
#counter(heading).update(0)

#include "appendices/appendix-a.typ"
#include "appendices/appendix-b.typ"
#include "appendices/appendix-c.typ"
