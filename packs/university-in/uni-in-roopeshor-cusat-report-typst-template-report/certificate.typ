#import "settings.typ": addToPDFBookmark
#set page(margin: 1.2in)
#place(center + horizon)[
  #text(size: 16pt)[
    DIVISION OF ELECTRONICS ENGINEERING\
    SCHOOL OF ENGINEERING\
    COCHIN UNIVERSITY OF SCIENCE AND\
    TECHNOLOGY\
    KOCHI-682022
  ]

  #v(10pt)
  #image("images/cusat.svg", width: 4cm)
  #v(10pt)
  #text(size: 17pt)[*CERTIFICATE*]
  #addToPDFBookmark("Certificate")
  #v(10pt)

  #par(justify: true, leading: 1em)[
    #text(
      size: 13pt,
    )[_Certified that the mini project report entitled *“DISTRIBUTED COMMUNICATION NETWORK”* is a bonafide work of *Person 1, Person 2, ...* towards the partial fulfillment for the award of the degree of B.Tech in Electronics and Communication of Cochin University of Science and Technology, Kochi-682022._]
  ]

  #v(4cm)

  #place(left)[#text(size: 13pt)[*Mini Project Guide*]]
  #place(right)[#text(size: 13pt)[*Head of the Division*]]
]

#pagebreak()
