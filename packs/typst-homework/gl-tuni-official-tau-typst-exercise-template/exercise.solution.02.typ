
#import "template.typ": longDivisionTable

We will perform long division as suggested, using
`template.longDivisionTable`. The result is seen in
@tab-long-division.

#[
  #longDivisionTable(
    dividend: $x^3 - 2 x ^ 2 - 4$,
    divisor: $x - 3$,
    // Iteration 1.
    $x^2$,
    $x^3 - 3 x^2$,
    $x^2 - 4$,
    // Iteration 2.
    $x$,
    $x^2 - 3 x$,
    $3 x - 4$,
    // Iteration 3.
    $3$,
    $3x - 9$,
    $5$,
  )
  <tab-long-division>
]
Since the degree of the remainder is less than the degree
of the divisor, the algorithm ends here. The total quotient
is the sum of the leading quotient column terms, which
is $q(x) = x^2 + x + 3$. The final remainder is $r(x) = 5
/ (x - 3)$. Therefore we have
$
  f(x)
  &=
  frac(
    x^3 - 2 x ^ 2 - 4,
    x - 3,
  )
  \
  &=
  q(x) + r(x)
  \
  &=
  x^2 + x + 3 + 5 / (x - 3)
  thin .
$
