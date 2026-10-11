#import "../../macros/type-theory.typ": *

== Type theory and logic notation

The type-theory module provides judgment, definitional equality, substitution, lambda, dependent product, and dependent sum helpers.

$Type$, $Prop$, and $Judg(Gamma)$.

#hastype($Gamma$, $x$, $A$)

#defeq($x$, $y$)

#subst($t$, $x$, $a$)

#lam($x$, $t$)

#Pi($x$, $A$, $B(x)$)

#Sigma($x$, $A$, $B(x)$)

=== Multiline dependent sums

A larger dependent type can use the same macro with a display-style body:

#let Base = math.op("Base")
#let Fiber = math.op("Fiber")
#let Witness = math.op("Witness")

#Sigma($x$, $Base$)[
  #align(left)[
    $Fiber(x)$ \
    $times Witness(x)$
  ]
]
