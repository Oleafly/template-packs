#import "../lib/lib.typ": *
#import "acronyms.typ": acronyms

#show: supercharged-dhbw.with(
  title: "Der Titel dieser Arbeit",
  authors: (
    (name: "Max Mustermann", student-id: "1234567", course: "ABC26DE", course-of-studies: "Wirtschaftsinformatik - Software Engineering", company: (name: "ABC SE", post-code: "12345", city: "Stadthausen")),
  ),
  acronyms: acronyms, // displays the acronyms defined in the acronyms dictionary
  at-university: false, // if true the company name on the title page and the confidentiality statement are hidden
  show-confidentiality-statement: false,
  help-from-ai-disclaimer-content: "../template/assets/AI_Hilfsmittelangabe.pdf",
  bibliography: bibliography("sources.bib"),
  bib-style: "ieee",//bib-style: "../template/assets/styles/ieee.csl",
  date: datetime.today(),
  language: "de", // en, de
  supervisor: (company: "Simon Siemert", university: "Prof. Dr. Felix Federlix"),

  university: "Duale Hochschule Baden-Württemberg",
  university-location: "Mannheim",
  university-short: "DHBW",
  university-declined: "Dualen Hochschule Baden-Württemberg",
  completion_period: (
    datetime(year: 2026, month: 2, day: 16),
    datetime(year: 2026, month: 5, day: 11)
  ),
  submission_date: datetime(year: 2026, month: 5, day: 11),
  type-of-thesis: "Bachelor Thesis",
  abstract: include "chapters/00_abstract.typ",
  // for more options check the package documentation (https://typst.app/universe/package/supercharged-dhbw)
)
#state("acronym-state-API").update(false)

#include "chapters/01_Einleitung.typ"
// include "chapters/02_....typ"
