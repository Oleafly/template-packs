
Perform long division on the rational function
$
  f(x)
  =
  frac(
    x^3 - 2 x ^ 2 - 4,
    x - 3,
  )
  thin .
$
Display the computation using the Typst function
`template.longDivisionTable`. You will need to import the
function into the solution file first:
```typst
#import "template.typ": longDivisionTable
#longDivisionTable(
  dividend : $x^3 - 2 x ^ 2 - 4$,
  divisor: $x - 3$,
  // Iteration 1.
  $"leading quotient"$,
  $"divisor × leading quotient"$,
  $"remainder"$,
  // Iteration 2.
  $"leading quotient"$,
  $"divisor × leading quotient"$,
  $"remainder"$,
  // Iteration 3.
  [...]
)
```
