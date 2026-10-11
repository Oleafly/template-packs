#import "@preview/theorion:0.6.0": *
#import cosmos.simple: *
#show: show-theorion

= Links

Descriviamo come produciamo i link in questo esempio.

== Citazioni di bibliografia

Nonostante si possa creare manualmente il record da inserire nel file di
bibliografia, per uniformità di formattazione si può far riferimento a #link(
  "https://scholar.google.com/",
)[Google Scholar] oppure a #link("https://dblp.org/")[DBLP].

#example[
  Alcune ottimizzazioni per la moltiplicazione tradue due polinomi si possono
  trovare in @cenk2015some. Quelle migliori tuttavia sono state sviluppate da
  René Peralta @find2018better.
]

Se usassimo il formato DBLP, non cambierebbe nulla nell'aspetto. Si apra il file
di bibliografia per capire meglio la formattazione usata da Google Scholar.

Se invece, non avessimo bisogno di citare nessun libro ma volessimo includerlo
nella bibliografia, basta usare il parametro `full` nel comando di bibliografia
del main.

== Verso l'esterno

Introdurre un url è facile!
#align(center)[
  #link("https://www.google.it/?gws_rd=ssl")
]
Oppure si possono nascondere url dentro parole.
#align(center)[
  Guarda un #link("https://www.youtube.com/")[video]!
]
Oppure si può anche creare la mail diretta.
#align(center)[
  L'indirizzo è fasullo, ma puoi testarlo #link(
    "mailto:gelataio\@gelateria.gelato",
  )[QUI]!
]

== Lorem Ipsum

#lorem(160)
