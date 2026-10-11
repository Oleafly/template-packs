#import "template.typ": project

#show: project.with(
  title: "Your Thesis Title Here",
  subtitle: "",
  authors: ("Author One", "Author Two"),
)

#include "titlepage.typ"
#pagebreak()
#include "title2.typ"
#pagebreak()

#set page(numbering: "i")
#counter(page).update(1)

#include "summary.typ"
#pagebreak()
#include "affirmation.typ"
#pagebreak()

#outline(indent: 2em)
#pagebreak()

#set page(numbering: "1")
#counter(page).update(1)
#set heading(numbering: "1.1")

#include "chapters/introduction.typ"

#pagebreak()
#bibliography("references.bib", style: "ieee")

#pagebreak()
#include "glossary.typ"
