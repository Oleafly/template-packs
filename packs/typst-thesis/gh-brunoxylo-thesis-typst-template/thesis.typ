#import "thesis-config.typ": *
#import "thesis_typ/main_layout_config.typ": *
#import "thesis_typ/special_pages.typ": tableOfContents, tableOfTables, tableOfListings, tableOfFigures
#import "frontbackmatter/acronyms.typ": tableOfAcronyms
#import "@preview/glossarium:0.5.3": make-glossary, register-glossary, print-glossary, gls, glspl
#import "frontbackmatter/acronyms.typ": glossary-list

#show: make-glossary
#register-glossary(glossary-list)

#set document(title: title, author: author)

// Begin page numbering with roman letters
#show: set page(numbering: "(i)")

// Title page
#import "frontbackmatter/title_page.typ": titlePage
#titlePage(
  title: title,
  degree: degree,
  faculty: faculty,
  university: university,
  myProf: myProf,
  myOtherProf: myOtherProf,
  author: author,
  id: id,
  location: location,
  submissionDate: submissionDate,
)

// Second page
#import "thesis_typ/special_pages.typ": secondPage
#secondPage(
  title: title,
  author: author,
  submissionDate: submissionDate
)

// Declaration
#import "frontbackmatter/declaration.typ": declaration
#declaration(title: "Erklärung", layoutConfig: mainLayoutConfig, author, location, submissionDate)

// Blocking-Notice
#import "frontbackmatter/blocking_notice.typ": blockingNotice
#blockingNotice(layoutConfig: mainLayoutConfig)

// English Abstract
#import "frontbackmatter/abstract_en.typ": abstractEN
#abstractEN(layoutConfig: mainLayoutConfig)

// German Abstract
#import "frontbackmatter/abstract_de.typ": abstractDE
#abstractDE(layoutConfig: mainLayoutConfig)

// Various tables
#tableOfContents(title: "Inhaltsverzeichnis", layoutConfig: mainLayoutConfig)
#tableOfFigures(title: "Abbildungsverzeichnis", layoutConfig: mainLayoutConfig)
#tableOfTables(title: "Tabellenverzeichnis", layoutConfig: mainLayoutConfig)
#tableOfListings(title: "Listings", layoutConfig: mainLayoutConfig)
#tableOfAcronyms(title: "Abkürzungsverzeichnis", layoutConfig: mainLayoutConfig)

// Set layout config
#show: mainLayoutConfig

// Change page numbering back to normal
#show: set page(numbering: "1")
#counter(page).update(1)

// Include your chapters here
#include "chapters/01-introduction.typ"
#include "chapters/02-referencing-glossary.typ"
#include "chapters/03-listings-graphics.typ"
#include "chapters/04-appendix.typ"

#bibliography("./thesis.bib", title: "Literaturverzeichnis", style: "./thesis_typ/springer-lecture-notes-in-computer-science.csl")
