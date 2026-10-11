// #import "@local/ensimag-nificent-thesis:0.1.0": template, load-bibliography
#import "../src/lib.typ": template, load-bibliography
#import "abstract.typ": abstract-en, abstract-fr
#import "acknowledgements.typ": acknowledgements

#show: template.with(
  specialization: "<Your Specialization>",
  title: "<Project Title>",
  defense-date: datetime(year: 2025, month: 9, day: 1),
  name: "<Your Name>",
  lab: "<Your Lab>",
  supervisor: "<Your Supervisor(s)>",
  jury: (
    president: "<President of the Jury>",
    members: ("<Jury Member 1>", "<Jury Member 2>", "<Jury Member 3>"),
  ),
  abstract: (en: abstract-en, fr: abstract-fr),
  acknowledgements: acknowledgements,
  bib-func: load-bibliography(read("works.bib", encoding: none)),
  list-of-figures: true,
  list-of-tables: true,
  list-of-listings: true,
  glossary-entries: yaml("glossary.yaml")
)

= Evaluation of the Performance Improvements in the Proposed Changes
== a
=== Hybridizable Discontinuous Galerkin Methods Applied to the Acoustic Wave Problem
==== Compiling HAWEN with NVFortran and Taking Advantage of GPU Offloading
==== Treatment of the Stiffness Matrix for Elastic Wave Propagation

#include "chapters/introduction.typ"

#include "chapters/sota.typ"

#include "chapters/theory.typ"

#include "chapters/implementation.typ"

#include "chapters/evaluation.typ"

#include "chapters/results.typ"

#include "chapters/conclusion.typ"