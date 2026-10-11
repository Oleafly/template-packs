#let template(text_name: "", author: "", date: "", body) = [
  #set text(font: "Courier Prime")
  #set par(justify: true)
  #show title: set align(center)
  #show title: set text(weight: "regular", size: 12pt)

  #title(text_name) \

  #body  

  #align(right)[
    \
    #date

    #author
  ]
]
