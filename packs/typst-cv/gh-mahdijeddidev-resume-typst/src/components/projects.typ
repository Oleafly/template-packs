#import "section.typ": section

#let projects(title ,projects) = section(title)[
  #for project in projects [

    #text(
      size: 8.8pt,
      weight: "semibold",
    )[
      #project.name
      #text(
        size: 8pt,
        fill: rgb("#1a73e8"),
      )[
       >>
        #link(project.url)[
          #underline[#project.preview]
        ]
      ]
    ]
 
    #text(size: 8pt)[
      #project.description
    ]

    #v(2pt)
  ]
]