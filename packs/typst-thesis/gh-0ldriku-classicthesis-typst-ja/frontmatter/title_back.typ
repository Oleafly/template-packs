#import "../config.typ": *
#import "../lib.typ": *

#page(header: none, footer: none)[
  #v(1fr)
  
  #grid(
    columns: (1fr, 1fr),
    align(left)[
      #set text(size: 9pt)
      *#myTitle* #mySubtitle\
      #v(0.5em)
      #sym.copyright #myTime #myName \
      #v(0.5em)
      #myUni#myFaculty#myDepartment \
      #v(1em)
      _All rights reserved._
    ],
    align(right)[
    ]
  )
  #v(2cm)
]
