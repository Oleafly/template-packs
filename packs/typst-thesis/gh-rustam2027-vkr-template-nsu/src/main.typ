#import "share/header.typ": template
#import "metadata.typ": metadata

#show: it => template(metadata, it)

#include "parts/abstract.typ"

#outline(depth: 2)
#pagebreak()

#include "parts/introduction.typ"

#include "parts/chapter-1.typ"

#include "parts/chapter-2.typ"

#include "parts/conclusion.typ"

#bibliography("bibliography/references.bib")
