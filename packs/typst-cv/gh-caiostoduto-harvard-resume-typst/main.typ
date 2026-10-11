#set text(lang: "en", region: "us", font: "Calibri")
#set page("us-letter", margin: (top: 1.27cm, right: 0.48cm, bottom: 1.07cm, left: 1.07cm))
#set par(justify: true)

#align(center)[
  #text(size: 11pt)[*FirstName LastName*]
  #line(length: 500pt, stroke: (thickness: 1.5pt))

  #text(size: 11pt)[Home or Campus Street Address • City, State Zip • youremail\@college.harvard.edu • phone number]
]

// Education Section
#v(11.5pt)
#include "./sections/education.typ"

// Experience Section
#v(11.5pt)
#include "./sections/experience.typ"

// Leadership and Activities Section
#v(11.5pt)
#include "./sections/leadership-and-activities.typ"

// Skills and Interests Section
#v(11.5pt)
#include "./sections/skills-and-interests.typ"