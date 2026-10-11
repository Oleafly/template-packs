#import "../lib.typ": abstract, acknowledgments, backmatter, dedication, mainmatter, sap-red, sapthesis

#show: sapthesis.with(
  title: [My thesis],
  subtitle: [A Typst port of the Sapienza thesis style],
  author: "Francesco Biccari",
  id_number: "123456",
  course: "Dottorato di Ricerca in Filologia",
  course_organizer: [Scuola di Dottorato in Scienze Filologiche],
  cycle: "XXXVII",
  academic_year: "2021/2022",
  advisors: ([Prof. Caio],),
  coadvisors: ([Dr. Sempronio],),
  author_email: "pippo@example.com",
  copyyear: "2022",
  thesis_type: "PhD thesis",
  binding: 6mm,
  language: "english",
)

#dedication[Dedicated to\\ Donald Knuth]

#abstract[
  This thesis demonstrates the Typst implementation of the Sapienza thesis style.
  It includes title pages, front matter, numbered chapters, and the Sapienza red
  color: #text(fill: sap-red)[sap-red].
]

#acknowledgments[
  I thank everyone who helped with this work.
]

#outline(title: [Contents])

#mainmatter()

= Introduction

#lorem(90)

== Motivation

#lorem(70)

= Methods

#lorem(100)

#backmatter()

= Bibliography

Add your Typst bibliography with `#bibliography("refs.yml")` or write a manual list here.
