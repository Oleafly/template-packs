#import "template.typ": *

#show: ieee.with(
  title: [Title of paper],
  abstract: [
    This is abstract...
  ],
  authors: (
    (
      name: "Author name",
      organization: [Organisation name],
      email: "Author email"
    ),
  ),
  bibliography: bibliography("literature.bib"),
)

// Uncomment the following lines and add further chapters below
#include "./chapters/introduction.typ"
// #include "./chapters/some-other-chapter.typ"
#include "./chapters/conclusion.typ"

// hacky way of doing this, but oh well
= Acronyms
