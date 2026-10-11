#import "@preview/polylux:0.4.0": *
#import "@preview/metropolis-polylux:0.1.0" as metropolis
#import metropolis: new-section, focus

#show: metropolis.setup

#show emph: it => {
  text(style: "italic", it.body)
}

#slide[
  #set page(header: none, footer: none, margin: 3em)
 
  #text(size: 1.3em)[*Title*]

  Subtitle

  #metropolis.divider
  
  #set text(size: .8em, weight: "light")
  Person1, Person2, Person3

  DD/MM/YYYY
]

#slide[
  #show: focus

  #set text(size: 32pt)
  
  Topic 1
]

#slide[
  #set text(size: 32pt)

  = Objectives
  
  - Objective 1
  - Objective 2
  - Objective 3
  - Objective 4
  - Objective 5
  - Objective 6
]

#slide[
  #set text(size: 32pt)

  = Image

  #image("imgs/ex.png", width: 100%)
]

#slide[
  #set page(header: none, footer: none, margin: 3em)
 
  #text(size: 1.3em)[*Title*]

  Subtitle

  #metropolis.divider
  
  #set text(size: .8em, weight: "light")
  Person1, Person2, Person3

  DD/MM/YYYY
]
