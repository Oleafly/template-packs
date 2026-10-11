#import "theme.typ": thesis-setup, title-page

#let meta = toml("meta.toml")

#show: thesis-setup.with(meta)

#title-page(meta)

#pagebreak()
#set page(numbering: "1")

#outline(title: [Contents])
#outline(title: [List of Figures], target: figure.where(kind: image))
#outline(title: [List of Tables], target: figure.where(kind: table))

#include "chapters/01-abstract.typ"
#include "chapters/02-introduction.typ"
#include "chapters/03-architecture.typ"
#include "chapters/04-results.typ"
#include "chapters/05-discussion.typ"
#include "chapters/99-appendix.typ"

#bibliography("refs.bib", style: "ieee")
