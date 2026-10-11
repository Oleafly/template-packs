#import("../config.typ") as conf

#align(center)[
  #v(1in)
  #text(size: 36pt)[#conf.thesis_title] 

  #text(size: 24pt)[#conf.thesis_subtitle]

  by

  #text(size: 12pt, weight: "bold")[#conf.name]

  
  #v(1in)
  #text(size: 16pt)[A thesis submitted to the Office of Graduate Studies in partial fulfillment of the requirements for the degree of]


  #v(0.5in)
  #text(size: 16pt, weight: "bold")[#conf.degree_program]


  #v(2in)
  Carleton University | Ottawa, Ontario


  #sym.copyright #datetime.today().year() 
  #conf.name

  #pagebreak()
  
  #set page(numbering: "i")

  The undersigned recommened to the Office of Graduate Studies acceptance of the Thesis

  #text(size: 24pt)[#conf.thesis_title] 

  #text(size: 18pt)[#conf.thesis_subtitle]

  #v(0.25in)
  Submitted by #text(weight: "bold")[#conf.name] 

  in partial fulfilment of the requirements for the degree of 

  #text(weight: "bold")[#conf.degree]

  
  #v(0.25in)
  #for examiner in conf.examiners [
    #v(0.4in)
    #line(length: 50%)
    #text(baseline: -8pt)[#examiner]
  ]
  #v(0.25in)

  Carleton University

  #datetime.today().year() 

]

