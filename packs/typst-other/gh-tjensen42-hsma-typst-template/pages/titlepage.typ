#import "../template.typ": *

#let titelpage-font-size = 14pt
#set text(size: titelpage-font-size)

#stack(
  dir: ltr,
  spacing: 1fr,
  if logo-left != none {
    set image(height: 2cm)
    logo-left
  },
  if logo-right != none {
    set image(height: 2cm)
    logo-right
  }
)

#v(4em)

#align(center,
  box(width: 85%,
    par(justify: false, linebreaks: "optimized",
      text(weight: "bold", font: heading-font, size: 18pt, hyphenate: false)[
        #title
      ]
    )
  )
)

#v(3.5em)

#for author in authors [
  #align(center, text(weight: "semibold", author))
]

#v(3em)

#align(center,
  if degree == "Bachelor" {
    par(leading: 0.9em)[
      #text(weight: "semibold")[Bachelor-Thesis] \
      #text(size: 12pt)[zur Erlangung des akademischen Grades Bachelor of Science (B.Sc.)] \
      Studiengang #course
    ]
  } else {
    par(leading: 0.8em)[
      #text(weight: "semibold")[Master-Thesis] \
      #text(size: 12pt)[zur Erlangung des akademischen Grades Master of Science (M.Sc.)] \
      Studiengang #course
    ]
  }
)

#v(3em)

#align(center)[
  #par(leading: 0.8em)[
    #faculty \
    #university
  ]
]

#v(2em)

#align(center, date.display("[day].[month].[year]"))


#v(2em)

#align(bottom + center)[
  #par(leading: 0.8em)[
    #text(weight: "semibold", "Betreuer") \
    #supervisor-hs \
    #supervisor-company
  ]
]

#pagebreak(weak: true)
