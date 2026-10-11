#import "src/preamble.typ": appendix, doc-style

#show: doc-style
#set par(first-line-indent: 0pt)

#include "src/sections/intro.typ"
#include "src/sections/methods.typ"
#include "src/sections/results.typ"

#bibliography("src/bib/references.bib")

#appendix((
  "appendix/appendix-a.typ",
  "appendix/appendix-a.typ",
  "appendix/appendix-a.typ",
  "appendix/appendix-a.typ",
))

