#import "@preview/drafting:0.2.2": *

= Introducción <ch:intro>

Esta plantilla y descripción están basadas en la plantilla de Ángel Herranz para LaTeX @tfg-latex-etsiinf.

El capítulo de introducción debe servir para que los profesores que evalúan el trabajo puedan comprender el contexto en el que se realiza el mismo, y los objetivos que se plantean.

Esta plantilla muestra la estructura básica de la memoria final de un trabajo fin de grado (TFG), así como algunas instrucciones de formato. En el caso de una tesis de master el tutor del mismo deberá ofrecerte indicaciones más precisas.

El esquema básico de una memoria final de TFG es el siguiente:
- Resumen en español e inglés (máximo 2 páginas cada uno)
- Tabla de contenidos
- Introducción (con los objetivos del TFG)
- Estado del arte y/o preliminares
- Desarrollo (normalmente varios capítulos, ej. Análisis, Diseño e Implementación)
- Análisis de impacto (puede formar parte de las conclusiones)
- Resultados, conclusiones y trabajo futuro
- Bibliografía (publicaciones utilizadas en el estudio y desarrollo del trabajo)
- Anexos (opcional)

En cualquier caso, es el tutor del trabajo quien indicará a su estudiante la estructura de memoria final que mejor se ajuste al trabajo desarrollado.

Con respecto al formato, se seguirán las siguientes pautas, que se muestran en esta plantilla:
- _Formato:_ un único fichero PDF (recomendable que su tamaño no supere los $20$ Megas, no pudiendo ser superior a $50$ Megas), y opcionalmente un fichero comprimido para presentar código, ficheros de multimedia, etc. (de tamaño inferior a $10$ Megas)
- _Tamaño de papel:_ DIN A4 a doble cara
- _Portada:_ tal y como se recoge en las plantillas.
- _Tipo de letra para texto._ Preferiblemente "Bookman Old Style" $11$ puntos o equivalente, en negro.
- _Tipo de letra para código fuente:_ "Consolas" o "Roboto mono".
- _Márgenes:_ superior e inferior $3.5$ cm, izquierdo y derecho $3.0$ cm.
- _Superficie del texto:_ $22.5$ cm de alto (aproximadamente $40$ líneas) y $15$ cm de ancho.
- _Cabecera y pies:_ fuera de la superficie del texto.
- _Secciones y subsecciones:_ reseñadas con numeración decimal a continuación del número del capítulo. Ej.: subsecciones 2.3.1.
- _Números de página:_ siempre centrado en margen inferior, página 1 comienza en capítulo 1, todas las secciones anteriores al capítulo 1 en número romano en minúscula (i, ii, iii…).
- _Bibliografía:_ según recomendaciones de la IEEE #link("https://www.etsiinf.upm.es/docs/estudios/grado/1475_ieeecitationref.pdf")[(ver enlace)]. En principio la plantilla sigue dichas recomendaciones si metes tu bibliografía en formato bib.

#v(1em) // Espacio vertical equivalente a \medskip

Para elaborar la memoria final del trabajo con esta plantilla, seguir los siguientes pasos:
+ Descargar e instalar el compilador de Typst @typst-software:
  - Compilador oficial: #link("https://typst.app/open-source/#download")
+ Descargar e instalar un editor compatible con Typst
  - Visual Studio Code: #link("https://code.visualstudio.com/")
    - Extensión para Typst (Tinymist): \ #link("https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist")
+ Cambiar el nombre del *documento principal* `tfg_etsiinf_plantilla.typ` para que incluya el nombre del alumno (ej. `tfg_etsiinf_LuisAmigo.typ`).
+ Modifica los datos de tu trabajo en `data.typ`.
+ Observa el fichero documento principal y cómo se van incluyendo los contenidos de la memoria a partir de los ficheros en el directorio `secciones`.
+ Por supuesto puedes modificar la estructura de secciones propuestas para adecuarla al tipo de trabajo que realices (no olvides modificar y reordenar los `#include` en el documento principal).
+ Si no sabes Typst te recomendamos explorar el contenido de los ficheros para aprender un uso básico y algunas buenas prácticas, además de revisar la documentación y referencia oficial.
+ Si usas bibliografía, tendrás que meter entradas con formato Hayagriva @hayagriva-docs `secciones/biblio.yml`, o puedes cambiarlo a formato BibTeX @bibtex, cambiando la extensión a `.bib` y actualizando el documento principal


== Algunas notas sobre el uso de Typst <sec:typst>

Si es la primera vez que te enfrentas a Typst quizás ya te hayas percatado que se parece "mucho" a un lenguaje de programación: escribes texto plano para describir el documento y luego compilas para generar el PDF.

Lo que puedes escribir en los ficheros Typst (ficheros `*.typ`) deberá seguir una sintaxis muy concreta y algunas buenas prácticas. Las siguientes secciones entran en algunos detalles interesantes.

=== Compilación

Cuando ejecutas el _compilador_ (ej. `typst compile`) se genera un PDF. Si usas Visual Studio Code con Tinymist, no hace falta compilar para ver la previsualización, se mostrará en tiempo real si se abre el menú "Preview Opened File". En otros entornos, puedes usar `typst watch` para recompilar el PDF de manera dinámica.


Para compilar la versión final del documento, basta con llamar al siguiente mandato (es necesario incluir la ubicación de las fuentes si no están instaladas):

```bash
typst compile --font-path ./urw-base35-fonts/ tfg_etsiinf_LuisAmigo.typ
```

En Visual Studio Code, también añade la extensión opciones para realizar esto sin la línea de comandos.

=== Estructura en capítulos, secciones y párrafos

Para estructurar tu documento basta con que incluyas marcas de dónde empiezan los capítulos y secciones. Así #footnote[Como ya habrás podido observar en este mismo ejemplo.]:

```typ
= Título del capítulo
== Título de la sección
=== Título de la subsección
```

Es importante observar que *los párrafos están indicados con dos cambios de línea*: hasta que Typst no encuentra dos cambios de línea no cambia de párrafo, es decir para Typst es lo mismo un único cambio de línea que un espacio.

Si colocas tu memoria bajo control de versiones, algo altamente recomendado, te aconsejamos *que las líneas en el fichero `.typ` no sean muy largas* para así poder ver los cambios en cada *commit* del sistema de control de versiones.

=== Listas y enumeraciones

Como has podido ver es fácil hacer enumeraciones o listas de "cosas" usando `-` y `+` (ver más arriba en este mismo capítulo).

Puedes usar listas no numeradas:

- Cosa uno
- Cosa dos
- Cosa tres
- Cosa cuatro


O listas numeradas:

+ Cosa uno
+ Cosa dos
+ Cosa tres
+ Cosa cuatro

=== Tablas
La función para hacer tablas es `table`. Veamos un ejemplo:

#align(center)[
  #table(
    columns: (auto, auto, auto, 15em),
    stroke: (x, y) => if y == 0 or y == 1 { (bottom: 1pt) } else { none },
    // Simulación simple de bordes
    table.header([*Alimento*], [*Categoría*], [*Kcal/100gr*], [*Descripción*]),
    [Manzana],
    [Fruta],
    [52],
    [Es el fruto comestible de la especie Malus domestica, el manzano común. Es una fruta pomácea de forma redonda y sabor muy dulce, dependiendo de la variedad.],

    [Repollo],
    [Verdura],
    [19],
    [Es una planta comestible de la familia de las Brasicáceas, y una herbácea bienal, cultivada como anual, cuyas hojas lisas forman un característico cogollo compacto.],
  )
]

Esta función tiene muchas opciones de estilizado, una tabla por defecto es la siguiente:

#align(center)[
  #table(
    columns: (auto, auto, auto, 15em),
    // Simulación simple de bordes
    table.header([*Alimento*], [*Categoría*], [*Kcal/100gr*], [*Descripción*]),
    [Manzana],
    [Fruta],
    [52],
    [Es el fruto comestible de la especie Malus domestica, el manzano común. Es una fruta pomácea de forma redonda y sabor muy dulce, dependiendo de la variedad.],

    [Repollo],
    [Verdura],
    [19],
    [Es una planta comestible de la familia de las Brasicáceas, y una herbácea bienal, cultivada como anual, cuyas hojas lisas forman un característico cogollo compacto.],
  )
]

Esta tabla por defecto se puede cambiar con reglas `set`. Además, se pueden añadir pies de tabla y numeración usando `figure`

=== Referencias

Para poder generar *etiquetas* y *referencias* puedes *y debes* usar las etiquetas `<etiqueta>` y el símbolo `@` como puedes ver en el capítulo @ch:intro o en la sección @sec:typst. ¡No olvides que Typst suele manejar las referencias automáticamente en una sola pasada, aunque a veces requiere dos!

=== Tipografía y entrecomillado

Puedes cambiar ciertas características del tipo de letra: #text(font: "New Computer Modern")[texto en "roman font"], *texto en negrita*, _texto en itálica_, `texto en teletype`, #smallcaps[Texto En Small Caps]. Por supuesto puedes combinar: *_texto itálica en negrita_*.

El entrecomillado en Typst es inteligente: "texto entrecomillado".

=== Alineado
El alineado de todo en Typst es por defecto a la izquierda (en modos LTR).

#align(center)[
  Puedes centrar casi cualquier cosa con la función `align(center)[...]`
]


#align(right)[
  Puedes alinear a la derecha casi cualquier cosa con la función `align(right)[...]`
]

=== Figuras

Puedes poner cualquier cosa dentro de una figura. Por ejemplo la figura @fig:escudo. Typst coloca las figuras automáticamente, pero puedes forzar ubicación con argumentos en `figure()`.

#figure(
  image("../portada/escudo_etsiinf.png", width: 33%),
  caption: [El escudo de la ETSIINF],
) <fig:escudo>

Una vez que has incluido una figura la puedes referenciar tantas veces como quieras: ver figura @fig:escudo.

Si simplemente quieres incluir un gráfico que fluya con el texto puedes hacerlo cuando quieras como por ejemplo ahora mismo:
#align(center)[
  #image("../portada/escudo_upm.png", width: 15%)
]

== Matemáticas

Typst está muy preparado para escribir fórmulas matemáticas con variables como  en expresiones como esta en línea:  o en un párrafo centrado aparte:

$ integral.cont_V f(s) dif s $

=== Espaciados verticales

Trata siempre de evitar funciones manuales de espaciado si puedes. Casi siempre hay alternativas para hacer lo que quieres de forma semántica.

=== Citas bibliográficas

Las citas bibliográficas se incluyen de esta forma: puede encontrar las recomendaciones para realizar el trabajo en @recomendaciones. Para añadir nuevas citas deberás poner las entradas en el fichero `biblio.yml` (formato Hayagriva @hayagriva-docs, o cambiarlo a uno BibTex `*.bib` @bibtex y luego referenciarlas.

Esta es la cita bibliográfica de un libro @stallings2006.

=== Ejemplo de "por hacer" (todonotes)


#margin-note[TODO: como este en el margen]

#inline-note[TODO inline: O como este "inline"]

=== Ejemplo de inclusión de código fuente

A continuación se muestra un listado de código. En él se puede ver la función `main()` de un programa en C que hace un *hello world*.

```C
#include <stdio.h>
// A simple Hello World
int main(){
  printf("Hello World!\n");
  return 0;
}

```

También podemos hacerlo sin colores:

```
#include <stdio.h>
// A simple Hello World
int main(){
  printf("Hello World!\n");
  return 0;
}

```

Para más configuración, revisar la documentación del paquete "Codly" @codly y la función `raw` de Typst @typst-raw

También puedes usar bloques raw simples, pero te recomendamos usar la sintaxis de bloques de código.

=== Lorem Ipsum
Lo que sigue es un lorem ipsum como ejemplo de lo que sería una sección relativamente larga.

// TODO: Requiere importar el paquete lipsum: #import "@preview/lipsum:1.0.0": lipsum
#lorem(500)

