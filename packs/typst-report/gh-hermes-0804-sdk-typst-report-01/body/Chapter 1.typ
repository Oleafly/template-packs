= Capítulo 1 <Capítulo_1>

#lorem(100)

- Element of list 1
- Element of list 2
- Element of list 3

+ Numbered List 1
+ Numbered List 2


#lorem(50)

== Subtítulo 1 <Subtítulo_1>

En esta parte puede ver 


Un dibujo de *Bernoulli* se puede ver en la @fig_Beornoulli #footnote([Ver ecuación de Bernoulli en @Capítulo_2]).

#figure(
  caption: [Daniel Bernoulli], 
  image("../assets/logo_client.png", width: 30%),
)<fig_Beornoulli>

#lorem(50)

=== Subtítulo 2 <Subtítulo_2>

#lorem(100)

#figure(
  caption: [Datos de presión de fluido], 
  table(
    columns: 4,
    align: (center, center, center, center),
      [], [Pestática(Pa)], [Ptotal(Pa)], [Pdinámica(Pa)],
      [P1], [2352], [1000,62], [-1353,78],
      [P2], [2381,4], [990,81], [-1393,02],
      [P3], [2028,6], [990,81], [-1039,86],
      [P4], [2195,2], [985,905], [-1211,535],
      [P5], [2185,4], [981], [-1206,63],
      [P6], [2224,6], [990,81], [-1236,06],

  )
)<tab_datos_fluido>

==== Subtítulo 3 <Subtítulo_2>

#lorem(50)

A partir de ello, tener en cuenta que los datos se pueden observar en la @tab_datos_fluido#footnote([Información generada por el diseñador.]).