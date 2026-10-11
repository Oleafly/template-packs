// Imports
#import "../template.typ": *
#import "@preview/physica:0.9.5": *

= Titolo della sezione
== Titolo della sottosezione
=== Titolo della sotto-sottosezione

#problem("Prova")[
  Dimostra che $1+1=2$.
]

#proof[
  Lasciata allo studente per esercizio.
]

#linebreak()

#theorem("Teorema di Pitagora")[
  $ c^2 = a^2 + b^2 $
]

#proof[
  Sia $a$ un numero, così come $b$ e $c$. Quindi, si ha
  $ c^2 = a^2 + b^2 $
]

#linebreak()

#corollary("Pitagora")[
  Segue dal teorema di Pitagora che
  $ c = sqrt(a^2 + b^2) $
]

#proof[
  Ovvio. #lorem(20)
]

#linebreak()

#proposition("Proposizione importante")[
  $ curl (grad f), tensor(T, -mu, +nu), pdv(f, x, y, [1,2]) $
]

#proof[
  Assolutamente ovvio. #lorem(20)
]

#linebreak()

#definition("Prova")[
  Questa è una definizione. #lorem(20)
]

#remark("Prova")[
  Questa è una nota. #lorem(20)
]

#observation("Prova")[
  Questa è una osservazione. #lorem(20)
]

#example("Prova")[
  Questo è un esempio.
]

#linebreak()

Si può osservare un gatto in @cat.

#figure(
  image("../figures/minimal_cat.jpg", width: 50%),
  caption: [
    Questo è un gatto.
  ],
) <cat>

#linebreak()

Esempio di citazione @scalinglaws. #lorem(110)
