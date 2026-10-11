#import "../core/preamble.typ": *

= References <sec-refs>

// Pass `color: none` to hide the left accent bar and section tag.
// `bibliography(path, title: none)` renders the full reference list without
// a heading (the slide title already serves as the heading).

#slide(title: "References", color: none)[
  #set text(size: 18pt)
  #bibliography("../references.bib", title: none)
]
