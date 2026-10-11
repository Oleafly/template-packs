#import "../config.typ": *
#import "../lib.typ": *

#page(margin: 3cm, header: none, footer: none)[
  #set align(center)
  
  #v(1fr)
  #image("../gfx/ScienceTokyo_Primary logo_RGB_L.png", width: 8.6cm) 
  #v(1cm)
  
  #text(font: font_sans_jp, size: 11pt)[20XX年度]
  #parbreak()
  #text(font: font_sans_jp, size: 11pt)[○○論文]
  
  #v(6cm)
  
  #text(font: font_serif, weight: "bold", size: 17pt, fill: cmyk(100%, 82%, 8%, 16%))[#myTitle]
  #v(1em)
    
  #text(font: font_serif, weight: "regular", size: 13pt, fill: cmyk(100%, 82%, 8%, 16%))[#mySubtitle]
  #v(1em)
  
  #text(font: font_serif, size: 11pt)[#myName]
  
  #v(5cm)

  #text(font: font_serif, size: 11pt)[20xx年xx月xx日提出]
  
  #text(font: font_serif, size: 11pt)[指導教員　#mySupervisor]
  #v(2em)
  #text(font: font_serif, size: 11pt)[
    #myUni#myFaculty#myDepartment \
    #myTime
  ]
  
  #v(1fr)
]
