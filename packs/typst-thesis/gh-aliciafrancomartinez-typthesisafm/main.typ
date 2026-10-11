#import "lib.typ": typthesisAFM, empty-page

#let metadata = yaml("metadata.yaml")

// 1. Front Page
#include "content/0_frontpage.typ"
#empty-page()

// Load the template
#show: typthesisAFM.with(
    metadata,
    datetime.today()
)
#empty-page()


// Notes 
#include "content/0_notes.typ"
#empty-page()


// Quotes
#include "content/0_quotes.typ"
#empty-page()

// Table of contents
#outline()

#counter(page).update(0)  // Resets the count to 1
#pagebreak()

// 2. Abstracts
#include "content/00_abstract.typ"
#pagebreak()

// 3. Chapters

#include "content/1_introduction.typ"
#include "content/2_study1.typ"
#include "content/3_study2.typ"
#include "content/4_discussion.typ"
#pagebreak()

// 4. References
#bibliography("references.bib", title: "References", style: "apa")
#pagebreak()
#pagebreak()

// 5. Appendices
#include "content/5_appendix.typ"


// 6. Agradecimientos
#include "content/0_acknowledgements.typ"
#empty-page()

// 7. Contraportada
#page(margin: 0pt)[
  #image("assets/0_contraportada.png", width: 100%, height: 100%, fit: "cover")
]