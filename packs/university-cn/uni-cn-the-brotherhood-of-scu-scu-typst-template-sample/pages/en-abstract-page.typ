#import "../fonts/font-def.typ": *

#let en_abstract_page(title, author, mentor, major, abstract, keywords: (), anonymous: false) = {
  show <_en_abstract_>: {
    align(center)[
      #text(font: heiti, size: 18pt, "Abstract")
    ]
  }
  [Abstract <_en_abstract_>]

  set text(font: kaiti)

  align(center)[
    #text(size: 14pt)[
      #if not anonymous [
        Major #h(5pt) #major
        
        Author #h(5pt) #author #h(30pt) Mentor #h(5pt) #mentor
      ] else [
        Major #h(5pt) ███████

        Author #h(5pt) ███████ #h(30pt) Mentor #h(5pt) ███████
      ]

      #linebreak()
    ]
  ]

  text(size: 10.5pt,)[
    #text(weight: "bold", [[Abstract]])
    #abstract
  ]    
  
  linebreak()
  
  text(size: 10.5pt, )[
    #box(width: 2em)
    #text(weight: "bold", [[Key Words]])
    #keywords.join("；")
  ]    
}