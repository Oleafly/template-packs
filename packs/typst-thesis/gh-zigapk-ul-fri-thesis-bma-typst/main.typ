// =============================================================================
// UL FRI – Magistrsko delo (Typst)
// Sample document — compile this to compare with the official LaTeX template.
// =============================================================================

#import "template/lib.typ": *

// ============================================================================
// CONFIGURATION
// ============================================================================

#let config = (
  title: "Vzorec zaključnega dela",
  title-en: "Thesis template",
  author: "Mojster Jaka",
  email: "mojster.jaka@gmail.com",
  year: "2016",
  keywords: "računalnik, računalnik, računalnik",
  keywords-en: "computer, computer, computer",
  supervisor: "doc. dr. Peter Klepec",
  cosupervisor: none,
  program: "MAGISTRSKI ŠTUDIJSKI PROGRAM DRUGE STOPNJE\nRAČUNALNIŠTVO IN INFORMATIKA",
  track: "Računalništvo in Informatika",
  code-published: true,
  code-url: "https://LINK-to-sourcecode-on-GIT",
)

// ============================================================================
// DOCUMENT
// ============================================================================

#show: thesis.with(config: config)

// --- Front pages -------------------------------------------------------------

#title-page(config: config)
#copyright-page(config: config)

#acknowledgments-page()[
  _Na tem mestu zapišite, komu se zahvaljujete za izdelavo magistrske naloge. V zahvali se poleg mentorja spodobi omeniti vse, ki so s svojo pomočjo prispevali k nastanku vašega izdelka._

  #v(0.5cm)
  #h(1fr) #config.author, #config.year
]

#dedication-page()[
  Vsem rožicam tega sveta.

  _"The only reason for time is so that everything doesn't happen at once."_

  #align(right)[--- Albert Einstein]
]

// --- Table of contents -------------------------------------------------------

#set page(numbering: none, header: none, footer: none)

#outline(
  title: "Kazalo",
  depth: 2,
  indent: 1.5em,
)

#clear-empty-double-page()

// --- Abbreviations -----------------------------------------------------------

#abbreviations-page((
  ("CA", [classification accuracy], [klasifikacijska točnost]),
  ("DBMS", [database management system], [sistem za upravljanje podatkovnih baz]),
  ("SVM", [support vector machine], [metoda podpornih vektorjev]),
))

// --- Abstracts ---------------------------------------------------------------

#povzetek(config: config)[
  V vzorcu je predstavljen postopek priprave magistrskega dela z uporabo okolja #LaTeX. Vaš povzetek mora sicer vsebovati približno 100 besed, ta tukaj je odločno prekratek. Dober povzetek vključuje: (1) kratek opis obravnavanega problema, (2) kratek opis vašega pristopa za reševanje tega problema in (3) (najbolj uspešen) rezultat ali prispevek magistrske naloge.
]

#abstract-page(config: config)[
  This sample document presents an approach to typesetting your BSc thesis using #LaTeX. A proper abstract should contain around 100 words which makes this one way too short. A good abstract contains: (1) a short description of the tackled problem, (2) a short description of your approach to solving the problem, and (3) (the most successful) result or contribution in your thesis.
]

// ============================================================================
// MAIN MATTER
// ============================================================================

#set page(
  numbering: "1",
  header: mainmatter-header,
  footer: mainmatter-footer,
)
#counter(page).update(1)

#set heading(numbering: "1.1")
#set ref(supplement: none)

#include "chapters/uvod.typ"
#include "chapters/sklicevanje.typ"
#include "chapters/plovke.typ"
#include "chapters/razno.typ"
#include "chapters/literatura.typ"
#include "chapters/sklepne.typ"

// ============================================================================
// APPENDIX
// ============================================================================

#set heading(numbering: "A.1")
#counter(heading).update(0)

#set figure(numbering: dependent-numbering("A.1"))
#set math.equation(numbering: dependent-numbering("(A.1)"), supplement: none)

#include "chapters/appendix.typ"

// ============================================================================
// BIBLIOGRAPHY
// ============================================================================

#set heading(numbering: none, outlined: false)

#bibliography(
  "bibliography.bib",
  title: "Literatura",
  style: "template/elsevier-with-titles.csl",
  full: true,
)
