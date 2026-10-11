#import "template/thesis.typ": *
#import "abstract.typ": *

#let title = (
  de: "Titel der Arbeit",
  eng: "Titel der Arbeit in Englisch",
)

#show: thesis.with(
  title: title,
  thesis-type: "Bachelorarbeit/Masterarbeit",
  author: "Vorname Nachname",
  prof: "Titel Name Erstgutachter:in",
  support: "Titel Name Betreuer:in",
  company: (
    show-company: true,
    name: "Firma Muster GmbH",
  ),
  print: true,
  one-sided: false,
  abstract: (abstract),
  keywords: (
    de: "Schlüsselwort 1, Schlüsselwort 2, Schlüsselwort 3, Schlüsselwort 4",
    eng: "Keyword 1, Keyword 2, Keyword 3, Keyword 4",
  ),
)

#include "chapter/introduction.typ"
#include "chapter/relatedwork.typ"
#include "chapter/furtherchapters.typ"
#include "chapter/conclusion.typ"
#include "chapter/tutorial.typ"
