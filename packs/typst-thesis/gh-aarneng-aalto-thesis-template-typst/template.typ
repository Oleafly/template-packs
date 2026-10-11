#import "modules/main.typ": project

#let pages = context [
  #let doc-start = counter(page).at(label("start")).at(0)
  #let bib-start = counter(page).at(label("bibliography")).at(0)
  #let appendix-start = counter(page).at(label("appendix")).at(0)
  #let allpages = counter(page).final().at(0)
  #{bib-start - doc-start} + #{allpages - appendix-start + 1}
]



#show: project.with(
  title: "Title",
  subtitle: "Subtitle",
  author: "Author",
  year: "year",
  programme: "Programme",
  major: "Major",
  supervisor: "Prof. Supervisor",
  advisors: ("Advisor 1",),
  collabpartner: none,
  date: "date",
  pages: pages,
  language: "Language",
  abstract: lorem(50),
  keywords: ("Keyword 1","Keyword 2","Keyword 3",),
  foreword: "Foreword",
  loc: "Location",
)


= Chapter<start>
#lorem(400)
== Subchapter
#lorem(800)

= Chapter
#lorem(500)




#bibliography("sources.bib")<bibliography>



= Appendix<appendix>
#lorem(500)
