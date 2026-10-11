#import "/layout/fonts.typ": *

#let declaration(
  author: "",
  location: "",
  submissionDate: datetime,
) = {
  set text(
    font: fonts.body, 
    size: 12pt, 
    lang: "en",
  )
  
  set par(leading: 1em)
  
  heading(level: 1)[Declaration]
  
  text[
    I hereby declare and confirm that this thesis is entirely the result of my own original 
    work. Where other sources of information have been used, they have been indicated as 
    such and properly acknowledged. I further declare that this or similar work has not been 
    submitted for credit elsewhere. This printed copy is identical to the submitted electronic 
    version.
  ]
  
  v(10mm)
  
  text[#location, #submissionDate.display("[month repr:long] [day], [year]")]
  
  v(10mm)
  
  text[#author]
  
  pagebreak()
} 