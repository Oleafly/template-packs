#import "templates/config.typ": config
#import "templates/kbd.typ": kbd

#show: config.with(
  title: "Awesome Title",
  description: "Description",
  authors: (
    (
      name: "Awesome Person",
      email: "mymail@mail.com",
    ),
  ),
  abstract: lorem(80),
)

// Content
#include "sections/introduction.typ"

// Bibliography
#pagebreak()
#bibliography("bibliography.bib")

// Appendix
#pagebreak()
#set heading(numbering: "A.1.1", supplement: [Appendix])
#counter(heading).update(0)
#text(size: 2em)[Appendix]
