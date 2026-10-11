// Imports
#import "../template.typ": *
#import "@preview/physica:0.9.5": *

= Titolo della sezione
== Titolo della sottosezione
=== Titolo della sotto-sottosezione

#lorem(40)

#linebreak()

Si può osservare un girasole in @sunflower.

#linebreak()

#figure(
  image("../figures/sunflower.jpg", width: 40%),
  caption: [
    Esempio di immagine.
  ],
) <sunflower>

#linebreak()

Esempio di citazione @scalinglaws. #lorem(50)

#linebreak()

Esempio di equazione

#linebreak()

$ derivative(, t) ( pdv(cal(L), dot(q)) ) - pdv(cal(L), q) = 0 $
