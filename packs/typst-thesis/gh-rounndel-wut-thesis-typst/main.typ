#import "template/wut-thesis.typ": wut_thesis

#show: wut_thesis.with(
  [Niepotrzebnie długi i skomplikowany tytuł pracy \ trudny do przeczytania, zrozumienia i wymówienia],
  [Unnecessarily long and complicated thesis' title \ difficult to read, understand and pronounce],
  author: "Imię i Nazwisko",
  supervisor: "XXXXXX",
  institute: "XXXXXX",
  field: "XXXXXX",
  album: "XXXXXX",
  keywords: "XXXXXX",
  keywords_en: "XXXXXX",
  acronyms: (
    ("API", "Application Programming Interface"),
  ),
  lang: "pl",
  short_references: false // Rys. Tab.
)[
  To jest polskie streszczenie
][
  This is the english abstract
]

#include "sections/1-wstep.typ"

#bibliography("bibliografia.bib")
