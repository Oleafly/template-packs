#import "src/project.typ": *

#show: body => project(
  title: "UCN Rapport",
  subtitle: "UCN Rapport skrevet i Typst",
  authors: (
    "Jonas",
    "Hans",
    "Bob",
  ),
  supervisors: (
    "Lars",
    "John",
  ),
  theme: "Semesterprojekt",
  projectperiod: "Forårssemestret",
  group-number: "Gruppe 1",
  rev-number: "1",
  resume: [
    #lorem(100)
  ],
  characters: 2083, // unfortunately i couldnt find a good way to this automatically
  repository: "https://github.com/jonasvbiegel/ucn-typst-template",
  body,
)

// main matter
#include "chapters/introduktion.typ"
#include "chapters/eksempler.typ"
#include "chapters/konklusion.typ"

// appendix
// make a appendix file and include it here
