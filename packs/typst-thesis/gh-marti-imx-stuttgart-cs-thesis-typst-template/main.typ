#import "template/thesis-stuttgart.typ": thesis
#import "utils/global-imports.typ": *

#show: thesis.with(
  title: "Solving KidsARC with Cognitively-inspired Representations",
  author: "Martin Nagel",
  course-of-study: "Medieninformatik",
  examiner: "Prof. Dr. Andreas Bulling",
  supervisor: "Anna Penzkofer, M. Sc.",
  document-type: "Bachelorarbeit",
  commenced: datetime(day: 4, month: 11, year: 2025),
  completed: datetime(day: 4, month: 5, year: 2026),
  institute: (name: "Institute for Visualization and Interactive Systems", address: "Universitätsstraße 38", city: "70569 Stuttgart"),
  last-followed-links-date: datetime(day: 30, month: 4, year: 2026).display("[month repr:long] [day padding:none], [year]"),
  ai-usage: [No AI tools were used for generating any significant parts of this work.],
  show-list-of-figures: true,
  show-list-of-tables: true,
  show-list-of-algorithms: true,
  abstract: (
    en: [
      #blindtext(paragraphs: 3, length: "medium", lang: "en")
    ],
    de: [
      #set text(lang: "de")
  
      #blindtext(paragraphs: 3, length: "medium", lang: "de")     
    ]
  )
)

#include "introduction.typ"

#include "related_work.typ"

#include "methodology.typ"

#include "results.typ"

#include "discussion.typ"

#include "conclusion.typ"

