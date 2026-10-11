#import "/src/lib.typ" as ups

#show: ups.template.with(
  // Document metadata
  title: "<DISSERTATION TITLE>",
  author: "<YOUR FULL NAME>",
  degree: "<YOUR COURSE NAME>",
  school: "Escola Superior _______________",
  document-type: "Dissertação",
  logo: "/src/UPS.png",
  supervisor: "<SUPERVISOR NAME>",
  second-supervisor: "<SECOND SUPERVISOR NAME>", // Optional, use none if not applicable

  // Dates and copyright
  thesis-date: none, // Will use current date
  copyright-notice: "<YOUR NAME>, <YEAR OF PUBLICATION>",

  // Visual elements
  additional-front-text: none,

  // Committee information (example for final version), use none otherwise
  committee-text: "Approved in oral examination by the committee:",
  committee-members: (
    (role: "President", name: "<COMMITTEE PRESIDENT NAME>"),
    (role: "Referee", name: "<COMMITTEE MEMBER NAME>"),
    (role: "Referee", name: "<COMMITTEE MEMBER NAME>"),
  ),
  signature: false,

  // Configuration options
  stage: none, // none, "jury", "final"
  language: "pt", // "en", "pt"
  on-paper: false, // if true, links are not shown (for paper versions)
)

// Optional, remove this if you don't want a dedication
#ups.dedication(
  text("Dedication text, if you want to.", hyphenate: false),
)

#set page(numbering: "i", number-align: bottom + center)
#counter(page).update(1)

// Acknowledgments
#include "prologue/acknowns.typ"

// List of Acronyms
#ups.acronym-list((
  ("AI", "Artificial Intelligence"),
  ("API", "Application Programming Interface"),
  ("CNN", "Convolutional Neural Network"),
  ("CPU", "Central Processing Unit"),
  ("GPU", "Graphics Processing Unit"),
  ("ML", "Machine Learning"),
  ("NLP", "Natural Language Processing"),
  ("RNN", "Recurrent Neural Network"),
  ("SGD", "Stochastic Gradient Descent"),
  ("UI", "User Interface"),
))

// Resumo
#include "prologue/resumo.typ"

// Abstract
#include "prologue/abstract.typ"

// Table of Contents
#ups.table-of-contents()

// Start main body with arabic numbering
<main-content>
#show: ups.main-content-wrapper

// CHAPTERS - Include your chapter files here
// Follow the chapter-template.typ structure

#include "chapters/1-introduction.typ"
#include "chapters/2-literature-review.typ"
#include "chapters/3-theoretical-foundations.typ"
#include "chapters/4-methodology.typ"
#include "chapters/5-result-and-analysis.typ"
#include "chapters/6-conclusions-and-future-work.typ"

// Bibliography
// Use the appropriate style
// Options: "ieee", "apa", "elsevier-vancouver", etc.
#ups.make-bibliography("elsevier-vancouver")

#set heading(numbering: "A.1", level: 1)
#counter(heading).update(0)

// Appendices
#include "appendixes/A-implementation-details.typ"
#include "appendixes/B-additional-results.typ"

// End of document
