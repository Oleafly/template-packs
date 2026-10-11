// arc42 Template in Typst format
// Version 9.1-DE, Dezember 2025
// (basiert auf der AsciiDoc Version)
//
// Created, maintained and (C) by Dr. Peter Hruschka, Dr. Gernot Starke and contributors.
// See https://arc42.org

// ============================================================
// Configuration
// ============================================================

#import "lib.typ": arc42help, show-arc42-help

// ============================================================
// Document setup
// ============================================================

#set document(
  title: "arc42 Template",
  author: ("Dr. Peter Hruschka", "Dr. Gernot Starke"),
  keywords: ("software-architecture", "documentation", "template", "arc42"),
)

#set text(lang: "de", font: "Libertinus Serif", size: 11pt)
#set heading(numbering: "1.1")
#set par(justify: true)

// ============================================================
// Title page
// ============================================================

#align(center)[
  #image("images/arc42-logo.png", width: 30%)
  #v(1em)
  #text(size: 24pt, weight: "bold")[arc42 Template]
  #v(0.5em)
  #text(size: 12pt)[Version 9.1-DE \
  Dezember 2025 \
  (basiert auf der AsciiDoc Version)]
]

#v(2em)

// ============================================================
// About arc42
// ============================================================

#text(weight: "bold", size: 14pt)[Über arc42]

#text(size: 12pt)[arc42, das Template zur Dokumentation von Software- und Systemarchitekturen.]

Template Version 9.1-DE. (basiert auf der AsciiDoc Version), Dezember 2025

Created, maintained and (C) by Dr. Peter Hruschka, Dr. Gernot Starke and contributors.
Siehe #link("https://arc42.org").

#line(length: 100%)

#if show-arc42-help {
  block(
    width: 100%,
    inset: 12pt,
    stroke: 0.5pt + luma(180),
    fill: luma(245),
    radius: 4pt,
  )[
    *Hinweis:* Diese Version des Templates enthält Hilfen und Erläuterungen.
    Sie dient der Einarbeitung in arc42 sowie dem Verständnis der Konzepte.
    Für die Dokumentation eigener System verwenden Sie besser die _plain_ Version.
  ]
}

// ============================================================
// Table of contents
// ============================================================

#outline(title: "Inhaltsverzeichnis", depth: 3)

// ============================================================
// Chapters
// ============================================================

#pagebreak()
#include "chapters/01_introduction_and_goals.typ"

#pagebreak()
#include "chapters/02_architecture_constraints.typ"

#pagebreak()
#include "chapters/03_context_and_scope.typ"

#pagebreak()
#include "chapters/04_solution_strategy.typ"

#pagebreak()
#include "chapters/05_building_block_view.typ"

#pagebreak()
#include "chapters/06_runtime_view.typ"

#pagebreak()
#include "chapters/07_deployment_view.typ"

#pagebreak()
#include "chapters/08_concepts.typ"

#pagebreak()
#include "chapters/09_architecture_decisions.typ"

#pagebreak()
#include "chapters/10_quality_requirements.typ"

#pagebreak()
#include "chapters/11_technical_risks.typ"

#pagebreak()
#include "chapters/12_glossary.typ"
