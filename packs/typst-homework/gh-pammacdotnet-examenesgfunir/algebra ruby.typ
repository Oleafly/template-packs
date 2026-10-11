#set page("a4", margin: 3mm)
#set text(lang: "es", size: 18pt)
#title[Examen de Álgebra PER Ruby]

#set heading(numbering: "1")
#show heading: it => {
  if (it.level == 1) {
    box(it.body, fill: luma(80%), outset: 30%)
  } else {
    context str(counter(heading).get().at(1)) + " " + it.body
  }
}



= Preguntas multiopción

== ¿Cuál es el resultado del producto entre el vector fila $v = \[ 2 \, 1 \, 4 \]$ y el vector columna $w = mat(delim: "[", 3; - 1; 2)$?
+ $8$.
+ $12$.
+ $9$.
+ Ninguna de las demás respuestas es correcta.

== ¿Cuál de las siguientes afirmaciones es necesaria para que un conjunto con dos operaciones sea un espacio vectorial?
+ Que la suma sea distributiva respecto del producto escalar.
+ Que exista un elemento neutro para la suma.
+ Que el producto escalar sea conmutativo.
+ Que todos los elementos tengan inverso multiplicativo.

== ¿Cuándo se dice que dos matrices cuadradas $A$ y $A'$ son semejantes?
+ Cuando tienen el mismo determinante.
+ Cuando existe una matriz $P$ tal que $A' = P^(- 1) A P$.
+ Cuando tienen los mismos autovalores.
+ Cuando son ambas diagonales.

== ¿Cuál de las siguientes condiciones define una aplicación lineal $f : E arrow.r F$?
+ $f(x + y) = f(x) + f(y)$ y $f(lambda x) = lambda f(x)$.
+ $f(x + y) = f(x y)$.
+ $f(lambda x) = f(x) + lambda$.
+ $f(x) = x^2$.


== ¿Qué caracteriza a un espacio afín respecto a un espacio vectorial?
+ Tiene un origen fijo.
+ No tiene origen fijo.
+ No admite coordenadas.
+ No admite vectores.

== ¿Qué es un espacio afín?
+ Un conjunto de puntos con estructura métrica.
+ Un conjunto de puntos con estructura de grupo.
+ Un conjunto de puntos con noción de dirección y traslación.
+ Un conjunto de puntos con estructura topológica.

= Ejercicios de desarrollo

== Considere el siguiente sistema de ecuaciones lineales:
$
  5 x + 3 y + 2 z & = 37 \
  7 x + 2 y + 4 z & = 45 \
  6 x + 4 y + 3 z & = 41
$
+ Utilice operaciones elementales de fila para convertir el sistema en
  forma triangular superior.
+ Determine el tipo de solución del sistema a partir del rango de la
  matriz de coeficientes y de la matriz ampliada.
+ Obtenga la solución del sistema.

== Sea el espacio vectorial euclídeo $\( bb(R)^3 \, chevron.l dot.op \, dot.op chevron.r \)$ con el producto escalar usual. Considera los vectores: $u = \( 2 \, 0 \, 1 \) \, quad v = \( 1 \, 2 \, - 1 \) \, quad w = \( 0 \, 1 \, 2 \) \, quad x = \( 3 \, 4 \, 5 \)$

+ Demuestra que ${ u \, v \, w }$ es un conjunto linealmente
  independiente y, por tanto, genera un subespacio $S subset bb(R)^3$.
+ Aplica el método de Gram-Schmidt para construir una base ortonormal
  $cal(B)'$ del subespacio $S$.
+ Calcula la proyección ortogonal del vector $x$ sobre el subespacio $S$
  usando la base ortonormal obtenida.
+ Explica brevemente qué representa la proyección obtenida y por qué se
  considera la "mejor aproximación" de $x$ en $S$.

