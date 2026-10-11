#import "modules/environment.typ" as env
#import "modules/state.typ": bib_state

#bib_state.update(none)

#show: env.title_page.with(
  title: "Template",
  author: "Max Mustermann",
  first_corrector: "Matthias Mustermann",
  second_corrector: "Erika Mustermann",
  matr_nr: "xxxxxx",
  place_date: datetime.today().display("Muserstadt, den [day].[month].[year]"),
  institution: "Template Universität",
  thesis_kind: "Bachelorarbeit",
)

#include("parts/0-abstract/main.typ")

#outline()

#pagebreak(weak: true)

#include("parts/1-introduction/main.typ")

#pagebreak(weak: true)

#include("parts/2-conclusion/main.typ")

#pagebreak(weak: true)

= Bibliography <bibliography>

#bibliography(
  "references.bib",
  title: none,
  style: "modules/citation-style.csl",
)
