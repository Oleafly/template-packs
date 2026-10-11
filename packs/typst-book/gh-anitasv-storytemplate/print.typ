#let book_title = "Test Title"
#let book_author = "Test Author"

#set page(margin: 0pt)
#image("images/cover.png", width: 100%, height: 100%, fit: "cover")

#pagebreak()

#set page(margin: 1in)

// Title Page
#align(center)[
  #v(2in)
  #text(size: 24pt, weight: "bold")[#book_title]
  
  #v(0.5in)
  #text(size: 14pt)[by]
  
  #v(0.3in)
  #text(size: 18pt)[#book_author]
  
  #v(1fr)
]

#pagebreak()

#include "story.typ"
