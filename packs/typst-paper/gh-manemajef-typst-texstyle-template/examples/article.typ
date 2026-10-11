#import "../style.typ": *
#import "@preview/mitex:0.2.6": *
#show: article
#maketitle(date: "today", author: "Some Author")[Title]


= Heading one
#lorem(16)

#lorem(29)

$
  e^1 approx T_0(x)
$

#lorem(20)
= One thing
#lorem(28)
== One point one
#lorem(60)
$
  f(x) = sum_i^oo 1/n_i
$

numbered:
$
  g(x) = integral_0^1 f(x) " "d\x
$<eq1>

The second equation is numbered and therefore can be referenced. @eq1

#lorem(40)


= Hey
#mitex(`\frac{x}{g}`)


