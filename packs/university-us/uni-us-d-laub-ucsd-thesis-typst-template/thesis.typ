#import "lib/template.typ": dissertation
#import "lib/pagination.typ": front-matter, main-matter, back-matter
#import "lib/frontmatter.typ": title-page, copyright-page, approval-page, vita, abstract
#import "lib/lists.typ": table-of-contents, list-of-figures, list-of-tables
#import "lib/floats.typ": floats-rules
#import "lib/backmatter.typ": backmatter-rules

#show: dissertation
#show: floats-rules
#show: backmatter-rules

#let meta = (
  title: [TODO: dissertation title],
  degree: [Doctor of Philosophy],
  degree-field: [TODO: degree field],
  author: [David Laub],
  year: [2026],
  committee: (
    chair: [TODO: chair last name],
    co-chair: none,
    members: ([TODO: member], [TODO: member]),
  ),
)

// If any chapter is co-authored/published, store the acknowledgement once here
// and reuse it on the Acknowledgements page AND at the end of that chapter:
//   #let coauthor-ack = [...]   (put in a chapters-importable module, e.g. ack.typ)

#front-matter()
#title-page(meta)
#copyright-page(meta)
#approval-page(meta)
#table-of-contents()
#list-of-figures()
#list-of-tables()
#vita(
  entries: (
    // TODO: real degrees/appointments. Use "Master" not "Masters".
    (year: [2026], body: [Ph.D. in TODO, University of California San Diego]),
  ),
)
#abstract(meta)[
  // TODO: real abstract, doctoral limit 350 words.
  Placeholder abstract.
]

#main-matter()
#include "chapters/01-introduction.typ"

#back-matter()
#bibliography("references.bib", style: "styles/ieee-full-authors.csl")
