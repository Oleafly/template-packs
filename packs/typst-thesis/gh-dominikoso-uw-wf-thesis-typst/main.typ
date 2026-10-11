// University of Warsaw - Faculty of Philosophy
// Thesis Template in Typst
// Template structure based on official UW requirements
// Last updated: 19.09.2025
// Author: Dominik Kostecki

#import "template.typ": *

#show ref: it => {
  footnote()[#cite(it.citation.key, form: "full")]
}

#show: thesis.with(
  title: "Polish Title Here",
  title-english: "English Title Here",
  author: "Author Name",
  student-id: "123456",
  degree-type: "licencjacka", // or "magisterska"
  field-of-study: "Filozofia", // or your specific field
  supervisor: "prof. dr hab. Supervisor Name",
  date: "Month 2026",
  abstract: [
    Your abstract here (minimum 1000 characters, maximum 3000 characters with spaces).
    This should be a comprehensive summary of your work, methodology, and conclusions.
  ],
  keywords: ("keyword1", "keyword2", "keyword3", "keyword4", "keyword5"),
)

#counter(page).update(4)

#include "chapters/0_introduction.typ"
#include "chapters/1_chapter_1.typ"
#include "chapters/2_chapter_2.typ"
#include "chapters/3_conclusion.typ"

#bibliography("bibliography/references.bib", style: "springer-humanities-author-date")
