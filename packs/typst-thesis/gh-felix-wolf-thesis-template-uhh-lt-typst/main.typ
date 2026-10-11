#import "template/lib.typ": *
#import "template/utils.typ": *

// SET TO false OR REMOVE LINE TO GET RID OF WORK IN PROGRESS CONTENT DEFINED WITH #wip_content() or #todo()
#wip_enabled.update(true)

#show: thesis(
  title: "Fancy Thesis Title",
  subtitle: "Also fancy subtitle",
  author: "Allan M. Turing",
  research-group: "Language Technology",
  department: "Department of Informatics",
  faculty: "Faculty of Mathematics, Informatics and Natural Sciences",
  university: "University Hamburg",
  city:  "Hamburg, Germany",
  thesis-type: "dissertation", // Must be one of 'bachelors', 'masters' , 'dissertation'
  field-of-study: "Computer Science",
  matriculation-number: 08154711,
  supervisor-label: "Supervisor(s):", // the German default supervisor label is the non-gendered "Betreuer", so you can override it here
  supervisors: ("John von Neumann, Universität Hamburg",),
  examiner-label: "Comittee",
  examiners: ("Prof. Dr. Chris Biemann, Universität Hamburg", "Dr. Konrad Zuse, Universität Hamburg"),
  date: datetime(year: 2055, month: 5, day: 25),
  title-width: 0.6,
  bibliography: bibliography("bibliography.bib"),
  language: "en",
)
// define glossary
#include "glossaries.typ"

// include abstract
#include "chapters/abstract.typ"

#todo-outline() // this is only shown if wip_enabled is set to true

// set main matter style
#show: main-matter()

// chapters

#include "chapters/introduction.typ"

#include "chapters/related-work.typ"
