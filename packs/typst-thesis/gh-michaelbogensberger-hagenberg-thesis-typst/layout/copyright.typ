#import "/layout/fonts.typ": *

#let copyright(
  author: "",
  submissionDate: datetime,
) = {
  set page(
    margin: (left: 30mm, right: 30mm, top: 40mm, bottom: 40mm),
    numbering: "i")
  counter(page).update(1)
  
  set text(
    font: fonts.body, 
    size: 12pt, 
    lang: "en",
  )
  
  v(1fr)
  align(center)[
    #text(size: 12pt)[© Copyright #submissionDate.year() #author]
  ]
  
  v(5mm)
  
  text(size: 10pt)[
    This work is published under the conditions of the Creative Commons License 
    _Attribution-NonCommercial-NoDerivatives 4.0 International_ (CC BY-NC-ND 4.0) — see 
    #link("https://creativecommons.org/licenses/by-nc-nd/4.0/")[https://creativecommons.org/licenses/by-nc-nd/4.0/].
  ]
  
  v(1fr)
  pagebreak()
} 