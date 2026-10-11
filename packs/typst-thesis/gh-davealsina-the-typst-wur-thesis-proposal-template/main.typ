#import "template.typ": wur-thesis, stylized-page

#show: wur-thesis.with(
  title: "Project Proposal",
  subtitle: "MSc Thesis — Agricultural Biosystems Engineering",
  author: "David Santiago Flórez Alsina",
  degree: "MSc Biosystems Engineering",
  date: "July 2026",
  cover-image: "images/foto-nota-uchuva.png", 
  cover-style: "full",
  //paper-texture: "close-up-recycled-paper.jpg", 
  paper-texture: none, 
  chapter-pagebreaks: true,
)

// Frontmatter
#include "sections/00_acknowledgements.typ"

#pagebreak()
#outline(depth: 3, indent: 0.5em)
#pagebreak()
#outline(title: "List of Figures", target: figure.where(kind: image))
#pagebreak()
#outline(title: "List of Tables", target: figure.where(kind: table))
#pagebreak()

// Mainmatter
#set page(numbering: "1")
#counter(page).update(1)

#include "sections/01_summary.typ"
#include "sections/02_introduction.typ"
#include "sections/03_background.typ"
#include "sections/04_work_plan.typ"
#include "sections/05_report_outline.typ"
#include "sections/06_references.typ"
#include "sections/07_contacts.typ"

#pagebreak()
#set heading(numbering: "A.1")
#counter(heading).update(0)

#include "sections/08_appendix.typ"
