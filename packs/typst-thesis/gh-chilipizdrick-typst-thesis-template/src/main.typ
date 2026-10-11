#import "lib.typ": *

#show: template.with()
#include-pdf-page("assets/title.pdf")
#counter(page).update(2)
#outline()
#include "parts/task.typ"
// #show: enable-heading-numbering.with(h1-style: "Глава 1.", style: "1.1.")
#include "parts/theory.typ"
#include "parts/practice.typ"
// #show: disable-heading-numbering.with()
#include "parts/results.typ"
#bibliography("assets/bibliography.bib")
#include "parts/appendix.typ"
