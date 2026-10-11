#import "lib.typ": *

#show: doc => conf(
  title:[Un titre super bien],
  author: [Vincent Caujolle, Albert Einstein],
  abstract: [#lorem(40)],
  columns: 2,
  doc
)

= Section
== Sous Section

#lorem(20) *#lorem(5)* #lorem(10)
$ 
limits(integral)_100^b sum_(i in NN) frac(12, 3x + y^i) mat(1,2;x,y;dots.v, dots.v;0,1;)
$ 
#lorem(10)
$ 
limits(integral)_100^b sum_(i in NN) frac(12, 3x + y^i) mat(1,2;x,y;dots.v, dots.v;0,1;)
$ <a>
#lorem(50)
#def[
  #lorem(30)
]
#lorem(30)
#prop[
  #lorem(100)
]
#thm[
  #lorem(50)
]
#demo(type: thm)[
  #lorem(20)
]
#lorem(50)
#expl[
  #lorem(10)
]
#rem[
  #lorem(50)
]
#lorem(50)
#enc[
  $
  E = m c^2
  $
]
#lorem(50)
#cor[#lorem(20)]
#demo(type:cor)[azaz]
#lorem(500)
