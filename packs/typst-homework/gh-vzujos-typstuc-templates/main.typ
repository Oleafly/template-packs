// Initial template config
#import "config/template.typ" as template
#show: doc => template.config(doc, darkmode: false)

// Useful packages for maths, presentations and diagrams
#import "@preview/lilaq:0.6.0" as lq
#import "@preview/physica:0.9.8": grad, div, curl, laplacian, vb, vu, dv, pdv
//#import "@preview/subpar:0.2.2"
//#import "@preview/touying:0.7.3"
//#import "@preview/cetz:0.5.0"
//#import "@preview/circuiteria:0.2.0"
//#import "@preview/fletcher:0.5.8"
//#import "@preview/akatable:0.1.0": academic-table
//#import "@preview/tiaoma:0.3.0" as tiaoma

// Add here any custom configs



#include "content/portada_tarea.typ"

= Plantilla de informe en Typst

Typst es un sistema de composición de documentos orientado a la escritura técnica pensado como una alternativa moderna a LaTeX. Su entorno principal funciona mediante markup `[...]`, es decir, texto enriquecido con una sintaxis simple y legible para definir títulos, listas, fórmulas, etc. Incorpora un entorno de código `{...}` y funciones que permite automatizar contenido, crear variables y programar comportamientos dinámicos dentro del documento. Al diferencia que LaTeX, Typst ofrece una sintaxis más compacta, consistente y fácil de aprender, junto con una compilación en tiempo real mucho más rápida y herramientas modernas integradas.

Para más información sobre Typst, pueden revisar su tutorial en la documentación oficial: #text([https://typst.app/docs/tutorial/writing-in-typst/], fill: blue), o ver la guía de equivalencia de funcionalidades entre Latex y Typst: #text([https://typst.app/docs/guides/for-latex-users/], fill: blue).


= Algunas ecuaciones importantes

Esta ecuación @eq:Euler se conoce popularmente como una de las más bellas del mundo (estoy en desacuerdo) porque tiene varios de los números más importantes de las matemáticas; estamos hablando de la identidad de Euler:

// Esto es para mostrar la numeración de ecuaciones
#set math.equation(numbering: "(1)")

$ 1 + e^(i pi) &= 1 dot cos(pi) + i dot sin(pi) \
&= (-1) + i dot 0 \
&= 0
$ <eq:Euler>

En ingeniería, una de las ecuaciones más importantes es la ecuación de Navier-Stokes @eq:N-S:
$
rho ( pdv( vb(v), t) + vb(v) dot grad vb(v) ) = - grad p + div vb(T) + vb(f)
$ <eq:N-S>
Donde $vb(v)(vb(x),t)$ es la velocidad espacial del fluido, y el resto de términos se deducen con facilidad.

Otro conjunto de ecuaciones fundamentales son las ecuaciones de Maxwell en electromagnetismo @wikipedia:

$
div vb(E) &= rho / epsilon_0 \
div vb(B) &= 0 \
curl vb(E) &= - pdv( vb(B), t) \
curl vb(B) &= mu_0 vb(J) + mu_0 epsilon_0 pdv( vb(E), t)
$

// Esta notación en Typst se llama definición
/ Teorema 1: #lorem(50)

#pagebreak()
= Figuras, gráficos y tablas

Para insertar figuras, se puede usar la función `#figure()` que acepta cualquier bloque de contenido, y le agrega un caption y un label para referenciarlo después. Dentro de `#figure()`, se pueden usar funciones como `#image()` para insertar imágenes, o incluso gráficos directo con la librería `lilaq`.


// Mas información en https://lilaq.org/docs/reference/diagram
#let N = 100
#let x = lq.linspace(0, 6, num:N)
#let y = x.map(i=> calc.sin(i))

#figure(
  lq.diagram(
    lq.plot(x, y, label: "sin(x)"),
    lq.plot(x, i => calc.cos(3*i) / 2, label: "cos(3x)/2"),
    xlabel: "x",
    ylabel: "y",
    title: "Funciones trigonométricas",
    aspect-ratio: 1,
    width: 80%
  ),
  caption: [Ejemplo de funciones trigonométricas.]
) <fig:trig>

Del un modo similar se pueden insertar tablas, usando la función `#table()` dentro de `#figure()`. Para citar elementos (ecuaciones, figuras, tablas, bibliografía, etc), se usa el símbolo `@` seguido del `label` que se le dio al elemento.

// Mas información en https://typst.app/docs/guides/tables/
#figure(
  table(
    columns: (auto, auto),
    align: (center, left),
    table.header[*Cantidad*][*Ingrediente*],
    [80], [Panes de completo],
    [80], [Salchichas],
    [6 kg], [Paltas],
    [4.8 kg], [Tomates],
    [Mucho], [Mayonesa],
  ),
  caption: [Ingredientes para preparar *80 completos*.]
) <tab:completos>

#pagebreak()
#set heading(numbering: none)

= Uso de IA Generativa
#lorem(100)

#bibliography("bibliography.yml", style: "ieee", title: "Referencias", full: true)

= Anexo
#if true [
  #lorem(100)
] else [
  Esto no se va a mostrar
]

El formato para agregar código es el mismo que utiliza Markdown:

```python
import numpy as np

def fun(a: int, b: int) -> int:
    "Funcion arbitraria"
    c = a + b
    return c * np.exp(c)

print(fun(2, 5)) # >> 7 * e**7
```
