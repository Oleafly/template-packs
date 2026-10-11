
Write the sum and product tables for the smallest possible
field, with the identities of addition and multiplication
denoted by $0$ and $1$, respectively. Use the function
`template.binaryOperationTable` to display the results:
```typst
#import "template.typ": binaryOperationTable

#binaryOperationTable(
  operator: $plus$,
  setElements: ($0$, $1$),
  "output 1",
  "output 2",
  "output 3",
  "output 4",
)

#binaryOperationTable(
  operator: $times$,
  setElements: ($0$, $1$),
  "output 1",
  "output 2",
  "output 3",
  "output 4",
)
```
