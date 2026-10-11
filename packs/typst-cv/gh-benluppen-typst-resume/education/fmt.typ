#let edu-fmt(uni, grad, deg) = [

#set par(spacing: 0.5em)

=== #uni #h(1fr) Graduated #grad

#text(style: "italic", deg)
  
] 

/*----------------------*/
/*Import your education file below, and call the fmt function above.
  Remember to name your variables in each education file differently for importing purposes.*/
/*----------------------*/

#import "education.typ":*

#edu-fmt(uni,grad,deg)
