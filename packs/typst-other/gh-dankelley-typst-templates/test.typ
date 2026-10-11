#set page(width:8.5in, height:11in,
numbering: "1 of 1",
margin:(top:1.5in,bottom:1in,left:0.5in,right:0.5in),
)

//#set text(font:"Libertinus serif", size: 12pt) // ERROR: boxes for some letters
#set text(size: 12pt) // ERROR: boxes for some letters
//#set text(font:"New Computer Modern", size: 12pt) // ERROR: boxes for some letters
//#set text(font:"Times", size: 12pt) // ERROR: box for 'd' in a derivative or e.g. $1$.

*TEST font: (unspecified), size: 12pt*
//*TEST font: "New Computer Modern", size: 12pt*
//*TEST font: "Times", size: 12pt*

Math-mode numbers (do numbers show up?): $0, 1, 2, 3, 4, 5, 6, 7, 8, 9$

Normal numbers (slightly different from above?): 0, 1, 2, 3, 4, 5, 6, 7, 8, 9

Inline differential equation (do we see e.g. 'dw'?): $( d w)/(d t) = -g - alpha w$

Separate-line version of above (is it similar but larger fonts?):

$ ( d w)/(d t) = -g - alpha w $

Separate-line version of above (is it similar but with upright 'd'?):

$ ( dif w)/(dif t) = -g - alpha w $

Integral equation (do we see a hat over the u, an integral sign, and a Greek tau?):
$ hat(u) = 1 / tau integral_0^tau u \d t $

Integral equation (as above but with overline instead of over-hat and upright 'd'?):
$ overline(u) = 1 / tau integral_0^tau u dif t $

