#import "template.typ": *
#import "@preview/glossarium:0.5.10": make-glossary, register-glossary, print-glossary, gls, glspl
#import "glossary.typ": glossary
#import "appendix.typ": appendix

// Title page and abstract
#show: project.with(
  title: "Arc42 Template",
  authors: (
    "Donald Duck",
  ),
  abstract: lorem(59),
  date: "June 18, 2026",
)

// Glossary
#heading(numbering: none)[Glossary]
#show: make-glossary
#register-glossary(glossary)
#print-glossary(
  glossary,
  deduplicate-back-references: true
)
#pagebreak()

// Chapters
#include "chapters/1_introduction_and_goals.typ"
#include "chapters/2_constraints.typ"
#include "chapters/3_context_and_scope.typ"
#include "chapters/4_solution_strategy.typ"
#include "chapters/5_building_block_view.typ"
#include "chapters/6_runtime_view.typ"
#include "chapters/7_deployment_view.typ"
#include "chapters/8_crosscutting_concepts.typ"
#include "chapters/9_architecture_decisions.typ"
#include "chapters/10_quality_requirements.typ"
#include "chapters/11_risks_and_technical_dept.typ"

// Appendix
#include "appendix.typ"

// References
#pagebreak()
#bibliography("references.bib", title: "References")
