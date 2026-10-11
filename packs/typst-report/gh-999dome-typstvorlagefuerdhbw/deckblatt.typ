#set align(center)

#set page(numbering: none)

#let title = "Ich bin ein Titel: Umsetzung einer Beispiel Typst Vorlage"
#let uni = "Duale Hochschule Baden-Württemberg Mannheim"
#let type = "Projektarbeit"

#let degree_program = "Sithinforamtik"
#let field_of_study = "TIE Fighter Engineering"

#let name = "Luke Skywalker"
#let mat_nr = "123457"
#let company = "Seperatisten GmbH"
#let department = "Development"
#let course = "ABCD24SE"
#let course_director = "Prof. Dr. Darth Sidious"
#let science_supervisor = "Darth Vader"
#let company_supervisor = "Anakin Skywalker"
#let processing_period = "01.01.2015 - 31.12.2025"

#let uni_logo = "public/logos/dhbwlogo.jpg"
#let company_logo = "public/logos/firmenlogo_bsp.svg"

#figure(
  grid(
    columns: 2,
    gutter: 1fr,
    align: horizon,
    image(company_logo, width: 5cm),
    image(uni_logo)
  ), outlined: false, numbering: none
)

\

#text(size: 14.4pt)[
  #uni
]

\

#text(size: 14.4pt, weight: "bold")[
  #type
]

#text(size: 17.3pt, weight: "bold")[
  #title
]

\

#text(size: 14.4pt, weight: "bold")[
  #degree_program 
]

\
#text(size: 12pt, weight: "bold")[
  #field_of_study
]

#v(10%)

#let data = (
  ("Verfasser:", name),
  ("Matrikelnummer:", mat_nr),
  ("Firma:", company),
  ("Abteilung:", department),
  ("Kurs:", course),
  ("Studiengangsleiter:", course_director),
  ("Wissenschaftlicher Betreuer:", science_supervisor),
  ("Betreuer:", company_supervisor),
  ("Bearbeitungszeitraum:", processing_period)
)

#grid(
  columns: (2),   
  column-gutter: 2.5em,             
  align: left,
  for (label, value) in data {
    [#label]
    linebreak()
  },
  for (label, value) in data {
    [#value]
    linebreak()
  }
)