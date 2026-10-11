// chapters/0_Cover.typ
#import "config.typ": *

#set page(margin: (x: 2.5cm, y: 2.5cm))

#align(center)[
  #v(2em)
  #image("figures/Logo_groß.png", width: logo-width) 
  
  #v(3em)
  #text(size: cover-size-small)[#university] \
  #text(size: cover-size-small)[#program-name]

  #v(3em)
  #text(size: cover-size-large, weight: "bold")[#report-title] \
  #v(3em)
  #text(size: cover-size-large, weight: "bold")[#report-subject] \
  #v(3em)
  #text(size: cover-size-medium, weight: "bold")[#semester] \
  #text(size: cover-size-medium, weight: "bold")[submitted on: #report-date]

  #v(7em)
  #text(weight: "bold")[Supervisor:]\ #supervisor-name
  
  #v(2em)
  #text(weight: "bold")[Editor:] \
  #editors.join([\ ]) \
  #text(weight: "bold")[Student number:] \ #matrikelnr
]
