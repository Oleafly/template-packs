#import "cambridge.typ": *

#show: doc => thesis(
  author: "John Jane Doe",
  short-author: "J. J. Doe",
  department: "Department of Placeholder",
  college: "Fitzwilliam College",
  college-shield: "CollegeShields/Fitzwilliam.svg",
  title: lorem(15),

  short-title: "Cambridge thesis",
  date: [September 2025],
  summary: include "01.abstract.typ",
  acknowledgements: include "02.acknowledgements.typ",
  compact: false,
  doc,
  biblio: "Referencing/ref.bib",
  style: "Referencing/nature.csl",
  appendix: [
    #include "06.appendix-A.typ"
    #include "07.appendix-B.typ"
  ]
)



#include "03.ch1.introduction.typ"
#include "04.ch2.typ"
#include "05.ch3.typ"

