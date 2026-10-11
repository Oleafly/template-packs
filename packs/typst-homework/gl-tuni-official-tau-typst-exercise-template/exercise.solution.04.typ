
#import "template.typ": binaryOperationTable

After importing the `binaryOperationTable` from the
`template` module, we use it as follows to construct
the respective sum and product @tab.plus[Tables] and
@tab.times[] of the field.

#binaryOperationTable(
  operator: $plus$,
  setElements: ($0$, $1$),
  $0$, $1$,
  $1$, $0$,
)

<tab.plus>

#binaryOperationTable(
  operator: $times$,
  setElements: ($0$, $1$),
  $0$, $0$,
  $0$, $1$,
)

<tab.times>

You can verify that defining the operations $plus$ and
$times$ like this satisfies the field axioms.
