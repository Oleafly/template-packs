#let date = datetime(
  year: 2024,
  month: 01,
  day: 29,
)


#let template(
  title: none,
  subtitle: none,
  subsubtitle: none,
  authors: (),
  supervisors: (),
  abstract: [],
  doc,
) = {
  set page(numbering: "1/1")
  set text(font: "Linux Libertine", lang: "en", size: 11pt)
  set heading(numbering: "1.1", outlined: true)
  set align(center)

grid(
  columns: (1fr, 1fr, 1fr),
  align(left+horizon)[
    #image("images/logo.png", width: 100%)
  ],
  align(center+horizon)[],
  align(right + horizon)[
    #image("images/logo.png", width: 100%)
  ]
)

align(
  center,
  text(24pt)[
  #subtitle
  ]
)
align(
  center,
  text(18pt)[#subsubtitle]
)
  

  line(length: 100%)
  align(center, text(32pt, title))
  line(length: 100%)

  v(1em)

  grid(columns: (1fr, 1fr),
  align(center, box(align(start, text(16pt)[
      *Author :* \
      #for author in (authors) {
        [#author.name\ ]
      }
    ]))),
  align(center, box(align(end, text(16pt)[
      *Supervisors :* \
      #for supervisor in (supervisors) {
        [#supervisor.name\ ]
      }      
    ])))
)

if(abstract != none){
  v(1em)
  align(center, box(align(start, text(16pt)[
      *Abstract:* \
    ])))
  [#abstract]
}
  
  align(center + bottom, text(16pt)[#date.display("[month repr:long] [day], [year]")])
  set par(justify: true)
  set align(left)
  
  columns(1, doc)
}


