#import "@preview/tapestry:0.0.4": *

#show: tapestry.with(
  title: "Tapestry Example",
  year: "2024-2025",
)

= Some Random Function

#let some_random_func(x) = {x * x + 2 * x + 1}

#figure(
  plot(
    funcs: (some_random_func,),
    step: (2, 10)
  ),
  caption: [Yamazaki T]
)

= Quantum Mechanics

== Wave Function

$ - hbar^2 / (2m) grad^2 psi + v(va(x)) psi = i hbar pdv(psi, t) $

$ integral_(-oo)^oo dd(x) psi^* psi = 1 $

= Table

#apply-table[
  #table(
    columns: (1fr, 1fr, 1fr),
    table.header[Observable][Operator][Operation],
    $x$, $hat(x)$, $ x dot psi(x, t) $,
    $p$, $p$, $ - i hbar dot pdv(,x) psi(x, t) $,
    $E$, $hat(H)$, $ [1 / (2m) hat(p)^2 + V(x)] psi $,
    $V(x)$, $hat(V)(x)$, $ V(x) psi $
  )
]
