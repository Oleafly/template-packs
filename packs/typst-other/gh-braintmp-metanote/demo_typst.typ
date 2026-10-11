#import "Typst/metanote.typ": *

//  If you have created the local package, change this to 
//  #import "@local/MetaNote:0.0.1": *

#show: doc => MetaNote(
  title: [
    MetaNote: Demo of Typst Template
  ],
  authors: (
    (
      name: "Impact",
      affiliation: "University of Genshin",
      email: "genshinimpact@gmail.com",
    ),
        (
      name: "Genshin",
      affiliation: "Teyvat Health University",
      email: "GenshinTHU@gmail.com",
    ),
  ),
  print: true,
  doc,
)

= Theorem Environment

With `showybox` and `great-theorems` packages, one can create a theorem environment with a title and a proof. Theorems are numbered automatically, and theorems can be referenced in the text. Numeration is on the second level, i.e. theorems are numbered in the form of 1.1, 1.2, etc.

#theorem(title: "Generalized Fubini Theorem")[
  Let $Omega$ be a Jordan measurable set in $RR^n$, and $f$ be continuous on $Omega$. Then

  $ & integral_(X times Y) f(x_1,dots,x_m;y_1,dots,y_n) dif x_1 dots dif x_m dif y_1 dots dif y_n \ =& integral_X (integral_Y f(x_1,dots,x_m;y_1,dots,y_n) dif y_1 dots dif y_n) dif x_1 dots dif x_m. $
] <thm1>

#proof(of: <thm1>)[
  wow this is a proof
]

#theorem(title: "Another Theorem")[
  Yet another theorem
] <thm2>
