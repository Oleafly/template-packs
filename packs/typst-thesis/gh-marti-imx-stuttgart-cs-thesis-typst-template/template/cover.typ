
#let show-title-page(
  title: "Is Oil the Future?",
  name: "Martin Nagel",
  course-of-study: "Medieninformatik",
  examiner: "Prof. Dr. Andreas Bulling",
  document-type: "Bachelorarbeit",
  supervisor: "Anna Penzkofer, M. Sc.",
  commenced: datetime(day: 4, month: 11, year: 2025),
  completed: datetime(day: 4, month: 5, year: 2026),
  institute: (name: "Institute for Visualization and Interactive Systems", address: "Universitätsstraße 38", city: "70569 Stuttgart")
) = page(
  margin: (left: 1cm, rest: 0em),
)[
#set text(font: "TeX Gyre Heros")
#set par(leading: 0mm, spacing: 0cm)
#set align(center)
  
#v(1in)    
#image("graphics/logos/USTUTT_logo.pdf", height: 1.4cm)
#v(0.29in)
#set text(size: 10.25pt)
#set par(leading: 6pt)

#institute.name \
#institute.address \
#institute.city

#v(1.644in)

#set text(size: 11.2pt)
#set par(leading: 0.67em)
#document-type

#v(1cm)
#block(width: 90mm, text(size: 16.2pt, weight: "bold", title))
#set par(leading: 0em)
#v(7.5mm)
#name


#set align(left + bottom)
#set text(size: 10.2pt)

#show grid.cell.where(x: 0): strong


#pad(
  left: 45.6mm,
  grid(
    columns: (47mm, 47mm),
    row-gutter: (.5in, .2in, 34.7mm, .2in),
    [Course of Study:], course-of-study,
    [Examiner:], examiner,
    [Supervisor:], supervisor,
    [Commenced:], commenced.display("[month repr:long] [day padding:none], [year]"),
    [Completed:], completed.display("[month repr:long] [day padding:none], [year]")
  )
)
#v(45mm)
]


#show-title-page(title: "Solving KidsARC with Cognitvely-inspired Represenations")