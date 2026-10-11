#import "utils/lib.typ": thesis
#import "@preview/glossarium:0.5.10": make-glossary, register-glossary
#import "utils/acronyms.typ": acronyms

#show: make-glossary
#register-glossary(acronyms)

#import "utils/lib.typ": thesis

#show: thesis.with(
  title: "Title of the Thesis",
  subtitle: "Optional Subtitle",
  author: "Firstname Lastname",
  student-id: "123456789",
  degree-program: "Medical Engineering & eHealth",
  supervisor_1: "FH-Prof. Dr. Supervisor",
  supervisor_2: "Dr. Supervisor",
  language: "en",
  
  abstract-de: [Deutsche Kurzfassung hier einfügen...],
  keywords-de: [Keyword 1, Keyword 2],
  
  abstract-en: [English abstract goes here...],
  keywords-en: [Keyword 1, Keyword 2],
  bib-file: "refs.bib",
)


#include "chapters/01_introduction.typ"
#pagebreak()
#include "chapters/02_methodology.typ"
#pagebreak()
#include "chapters/03_results.typ"
#pagebreak()
#include "chapters/04_discussion.typ"
#pagebreak()

#include "utils/back-matter.typ"