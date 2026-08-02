#let abstract-page(
  font-body,
  abstract: none,
) = {
  page(
    margin: (left: 1.2in, right: 1.0in, top: 1.0in, bottom: 1.0in),
    numbering: "i",
  )[
    #set text(font: font-body)
    
    #heading(outlined: false, numbering: none)[Abstract]
    
    #v(0.5cm)
    
    #abstract
  ]
}
