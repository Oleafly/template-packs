#import "config/environment.typ" as env
#import "config/state.typ": bib_state

#bib_state.update(none)

#let author1 = (
  name: "Max Mustermann",
  matr_nr: "123456",
  email: "max@mustermann.de",
)
#let author2 = (
  name: "Anna Mustermann",
  matr_nr: "123457",
  email: "anna@mustermann.de",
)

#let authors = (author1, author2)

#show: env.title_page.with(
  title: "Fantastic Title",
  authors: authors,
  first_corrector: "Matthias Mustermann", // can be commented out if not needed
  second_corrector: "Erika Mustermann", // can be commented out if not needed
  institution: "Template Universität",
  paper_kind: "Bachelorarbeit",
  showOutline: true,
  showTitlePage: true,
  // abstract: include("parts/0-abstract/main.typ") // can be commented out if not needed
)

// use multiple parts or write everything into one part for better ref handling through tinymist vscode extension
#include("parts/1-introduction/main.typ")

#colbreak(weak: true)

#include("parts/2-conclusion/main.typ")

#colbreak(weak: true)

= Literaturverzeichnis <bibliography>

#bibliography(
  "references.bib",
  title: none,
  style: "config/citation-style.csl",
)
