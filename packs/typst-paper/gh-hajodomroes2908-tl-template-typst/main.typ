#import "cover.typ":  *
#import "config.typ": language
#import "constants.typ": font_size

#set text(lang: language)
// nak logo as page header
#set page(
  margin: (x: 1.8cm, y: 4cm),
  header: image("headers/header_" + language + ".png")
)
#set text(size: font_size)
#set heading(numbering: none)

// cover page
#create_cover()
#pagebreak()

#set page(numbering: "I")
// table of contents
#outline()
#pagebreak()

= List of Figures
#outline(title: "", target: figure.where(kind: image))
#pagebreak()
// use arabic page numbering
#set page(numbering: "1")
#counter(page).update(1)
// use arabic numbering of chapters
#set heading(numbering: "1.")
// youre content goes here
= Introduction
#include "content/1_introduction.typ"
image
= Fundamentals
#include "content/2_fundamentals.typ"

= Analysis
#include "content/3_analysis.typ"

= Discussion
#include "content/4_discussion.typ"

= Conclusion
#include "content/5_conclusion.typ"

#pagebreak()
// use roman page numbering
#set heading(numbering: none)
#set page(numbering: "I")
#counter(page).update(1)




#bibliography(
  "bibliography.bib"
)
#pagebreak()

= Appendix
#set heading(numbering: "1.")
#include "content/6_appendix.typ"
