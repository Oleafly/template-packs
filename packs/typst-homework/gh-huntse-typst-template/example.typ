#import "tma-template.typ": *

#show: tma.with(
  name: "Joeseph Bloggs",
  pin: "T0001234",
  course: "M666",
  number: 5,
)

= Q1

== a)

=== i)

$
"To prove that"  lim_(x -> 1) (x^3 - x^2 + 3x - 3) / (x^2 + x - 2) &= 4/3, \
"notice that"  x^3 - x^2 + 3x - 3 &= (x^2+3)(x-1),\
"and"  x^2 + x - 2 &= (x+2)(x-1), $

and hence the domain of $f$ is $RR - {1, -2}$.
$ "Let" f(x) = (x^3 - x^2 + 3x - 3) / (x^2 + x - 2), quad x in.not {1, -2}, $
so $f$ is defined on the punctured neighbourhood $N_1(1)$.

Now, whenever $x != 1$ and $x != -2$,
$ f(x) = ((x^2+3)(x-1)) / ((x+2)(x-1)) = (x^2+3) / (x+2). $

Thus, if $(x_n)$ is a sequence in $N_1(1)$ with $x_n --> 1$, then
$ f(x_n) = (x_n^2 + 3) / (x_n + 2) -> ((1)^2 + 3) / (1 + 2) &= 4/3. \
 "Hence" lim_(x -> 1) (x^3 - x^2 + 3x - 3) / (x^2 + x - 2) &= 4/3 "as required."
 quad square $

=== ii)

To prove there are no positive integers $a, b, "and" c$ such that $a^n + b^n = c^n$,
with $n>2$ I have a very elegant proof which this tma template is sadly too
narrow to contain.
#todo("Come back and finish this.")

#block(breakable:false)[
== b)
To make a block appear on a single page without a  page break in the middle,
you can enclose it in a `block(breakable:false)` like this.
]

= Q2

== a)

The aliens all agree to paint their ears yellow and never speak of this, or the
outsider, ever again.#footnote[@bookA[pg 42]]

#pagebreak(weak: true)
#bibliography("refs.bib", style: "./short-title.csl")
