#include "meta.typ"
#include "cover.typ"

#show selector(heading.where(level: 2)): set heading(numbering: "1.", level: 1)

#show heading.where(depth: 2): body => {
  pagebreak(weak: true)
  body
}

#set align(top)
#set quote(block: true)

= Ebook

#outline()
