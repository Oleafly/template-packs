#import "template/basic-thesis.typ": *

#show: basic-thesis.with(
  logo: image("assets/images/hslu-logo.svg", width: 30%),
  title: "Titel der Arbeit",
  students: (
    "Student 1",
    "Student 2",
  ),
  year: "2026",
  institution: "HSLU",
  study-program: "BSc Informatik",
  supervisor: "Supervisor Name",
  expert: "Expert Name",
  client: "Client/Company Name",
  public: false,
  secret: true,
  language: "de",
  thesis-type: "Wirtschaftsprojekt",
  bibliography: include "outlines/bibliography.typ",
  abbreviations: include "outlines/abbreviations.typ",
  figure-outline: include "outlines/figure-outline.typ",
  table-outline: include "outlines/table-outline.typ",
  code-outline: include "outlines/code-outline.typ",
  abstract: include "chapters/00-abstract.typ",
  gratitude: include "chapters/01-expression-of-gratitude.typ",
)

// TODO: Remove example chapter before final submission
#include "chapters/99-example.typ"

#include "chapters/10-problem-statement.typ"
#include "chapters/20-state-of-the-art.typ"
#include "chapters/30-ideas-and-concepts.typ"
#include "chapters/40-methods.typ"
#include "chapters/50-implementation.typ"
#include "chapters/60-validation-and-evaluation.typ"
#include "chapters/70-future-work.typ"
#include "chapters/80-appendix.typ"
