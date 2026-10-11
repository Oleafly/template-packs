// ==============================================================================
// Plantilla para Trabajos de Graduación IE-MT 2019v3 -- réplica en Typst
// Traducido desde la plantilla LaTeX original (z-main.tex y archivos anexos)
// Autor original de la plantilla: MSc. Miguel Zea
// ==============================================================================
// Este archivo único reúne el contenido que originalmente estaba repartido en
// los archivos .tex (0-datos_estudiante, 1-opciones_adicionales, a-prefacio,
// b-resumen, c-abstract, d-introduccion, ..., o-glosario). Cada sección se
// marca con un comentario equivalente al nombre del archivo .tex original.
//
// Además de ser el punto de partida para tu propio trabajo de graduación, este
// archivo funciona como una guía introductoria a Typst: cada capítulo conserva
// el título y el propósito que exige el formato IE-MT 2019v3, pero su contenido
// aprovecha ese espacio para explicar y demostrar en vivo un concepto distinto
// del lenguaje (encabezados, listas, citas, figuras, tablas, matemáticas,
// funciones reutilizables y el glosario). Ningún estilo ni sección fue
// removido: solo sustituye el texto de ejemplo por el tuyo y actualiza los
// datos de la sección siguiente.
// ------------------------------------------------------------------------------
// 0-datos_estudiante.tex -- Datos del estudiante y del trabajo de graduación
// ------------------------------------------------------------------------------
#let nombreestudiante = "Nombre Completo del Estudiante"
#let uvgcarne = "00000"
#let uvgfacultad = "Ingeniería"
#let uvgcarrera = "Nombre de la carrera"

#let titulotesis = "Título del Trabajo de Graduación"
#let anoentrega = "2026"
#let nombreasesor = "Nombre del Asesor"

#let nombreprimerex = "Nombre del Primer Examinador"
#let nombresegundoex = "Nombre del Segundo Examinador"
#let anoaprobacion = "2026"

#let imagenportada = "media/template/portadacit.jpg"

// ------------------------------------------------------------------------------
// 1-opciones_adicionales.tex -- Capítulos incluidos (todas las secciones se
// incluyen por defecto, igual que en la plantilla original)
// ------------------------------------------------------------------------------

//
// ============ METHODS

// Cita varias referencias consecutivas como un rango "primera--última"
// (ej. @Knuth1984TeXbook-@Lamport1994LaTeX). Las citas intermedias se
// insertan invisibles para que Typst las registre en la bibliografía sin
// mostrarlas en el texto.
#let cite-range(first, ..middle, last) = {
  cite(label(first))
  for c in middle.pos() {
    box(width: 0pt, text(fill: white, cite(label(c))))
  }
  text("\u{2013}")
  cite(label(last))
}

// ------------------------------------------------------------------------------
// Definiciones generales de la plantilla
// ------------------------------------------------------------------------------
#let uvg-green = rgb("#114734")

#set document(title: titulotesis, author: nombreestudiante)
#set page(paper: "us-letter", margin: (top: 1in, left: 1.5in, right: 1in, bottom: 1in))
#set text(lang: "es", size: 11pt)
#set par(justify: true, leading: 0.65em, spacing: 1.2em)

// Numeración de encabezados: capítulo.sección.subsección
#set heading(numbering: "1.1")

// Cuadros (tablas): en español "es" (no "es-MX") la plantilla original usa
// "Cuadro" en vez de "Tabla" para los captions.
#show figure.where(kind: table): set figure(supplement: "Cuadro")
#show figure.where(kind: table): set figure.caption(position: top)

// Estilo de encabezados de capítulo (equivalente a \usepackage[Sonny]{fncychap})
#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  v(1em)
  if it.numbering != none {
    block(text(size: 13pt, tracking: 2pt, fill: uvg-green)[
      CAPÍTULO #counter(heading).display("1")
    ])
    v(0.3em)
  }
  text(size: 20pt, weight: "bold")[#it.body]
  v(0.3em)
  line(length: 100%, stroke: 0.6pt + uvg-green)
  v(1em)
}
#show heading.where(level: 2): it => {
  v(0.8em)
  text(size: 14pt, weight: "bold")[#it.body]
  v(0.4em)
}
#show heading.where(level: 3): it => {
  v(0.6em)
  text(size: 12pt, weight: "bold", style: "italic")[#it.body]
  v(0.3em)
}
// Nota: solo se personalizaron los niveles 1 a 3, tal como pedía la plantilla
// original. Un encabezado de nivel 4 (====) no tiene "show rule" propia, así
// que Typst recurre a su apariencia por defecto -- lo verás en el capítulo de
// Metodología, usado ahí a propósito para mostrar el contraste.

// Formato de párrafo por defecto (\defaultparformat en la plantilla original:
// espaciado entre párrafos en vez de sangría)
#set par(first-line-indent: 0pt)

// Salto de página en blanco (equivalente a \blankpage), no se usa en la
// versión digital pero se deja disponible.
#let blankpage() = {
  pagebreak()
  [ ]
  pagebreak()
}

// Glosario manual (Typst no trae un paquete de glosarios como
// \usepackage{glossaries}; se simula con un diccionario + funciones gls/Gls).
#let glossary = (
  typst: (name: "Typst", desc: "Sistema de composición de textos basado en marcado, con un lenguaje de programación propio embebido"),
  marcado: (name: "marcado", desc: "Sintaxis ligera (como el `*`, `_` o `=` de este documento) que describe la estructura de un texto sin salir del modo de escritura"),
  funcion: (name: "función", desc: "Valor de Typst que recibe argumentos y produce contenido o datos; se define con #`let nombre(..) = {..}`"),
  raw: (name: "bloque raw", desc: "Región de texto literal (típicamente código), delimitada con comillas invertidas, que Typst puede resaltar por lenguaje"),
)
#let gls(key) = glossary.at(key).name
#let Gls(key) = {
  let n = glossary.at(key).name
  upper(n.slice(0, 1)) + n.slice(1)
}

// ==============================================================================
// PORTADA
// ==============================================================================
#page(
  fill: uvg-green,
  margin: (left: 3cm, right: 3cm, top: 1in, bottom: 0in),
  numbering: none,
)[
  #set text(fill: white)
  #line(length: 100%, stroke: 0.6pt + white)
  #v(0.1in)
  #text(size: 26pt, weight: "bold")[#titulotesis]
  #v(0.3em)
  #line(length: 100%, stroke: 0.6pt + white)
  #v(0.3em)
  #text(size: 18pt)[#nombreestudiante]

  #v(1fr)
  #box(width: 100%, height: 13.25cm)[
    #box(width: 100%, height: 100%, clip: true)[
      #image(imagenportada, height: 13.25cm, width: 100%, fit: "cover")
    ]
    // Logo institucional con fondo (fondologo_grande.png), esquina inferior derecha
    #place(bottom + right, dx: -1cm, dy: -0.2cm)[
      #image("media/template/fondologo_grande.png", height: 1.15in)
    ]
    // TODO: logoUVGblanco.eps -- Typst no soporta el formato EPS de forma
    // nativa. Convierta el archivo a PNG o SVG (por ejemplo con
    // `inkscape plantilla/logoUVGblanco.eps --export-type=svg` o
    // `pdftocairo`/`magick`) y luego descomente e inserte:
    #place(bottom + right, dx: -1.6cm, dy: -0.8cm)[
      #image("media/template/logoUVGblanco.svg", height: 0.55in)
    ]
  ]
]

// ==============================================================================
// CARÁTULA
// ==============================================================================
#page(numbering: none)[
  #align(center)[
    #text(size: 18pt)[UNIVERSIDAD DEL VALLE DE GUATEMALA] \
    #text(size: 18pt)[Facultad de #uvgfacultad]
  ]
  #v(0.75cm)

  #align(center)[
    // TODO: escudoUVGnegro.eps -- Typst no soporta EPS de forma nativa.
    // Convierta el archivo a PNG o SVG y descomente la siguiente línea:
    #image("media/template/escudoUVGnegro.svg", height: 5.5cm)
    #v(5.5cm)
  ]
  #v(0.5in)

  #align(center)[
    #text(size: 15pt, weight: "bold")[#titulotesis]
    #v(1fr)
    #text(size: 13pt)[
      Modalidad de trabajo profesional presentado por #nombreestudiante para optar al
      grado académico de Licenciado en #uvgcarrera
    ]
    #v(1fr)
    #text(size: 12pt)[Guatemala,]
    #v(1em)
    #text(size: 12pt)[#anoentrega]
  ]
]

// ==============================================================================
// HOJA DE FIRMAS
// ==============================================================================
#page(numbering: none)[
  #v(0.5in)
  #text(size: 13pt)[Vo.Bo.:]
  #v(1cm)
  #align(center)[
    #line(length: 4in, stroke: 0.5pt)
    #nombreasesor
  ]
  #v(1in)

  #text(size: 13pt)[Tribunal Examinador:]
  #v(1cm)
  #align(center)[
    #line(length: 4in, stroke: 0.5pt)
    #nombreasesor
    #v(1in)
    #line(length: 4in, stroke: 0.5pt)
    #nombreprimerex
    #v(1in)
    #line(length: 4in, stroke: 0.5pt)
    #nombresegundoex
  ]
  #v(1in)

  Fecha de aprobación: Guatemala, #box(width: 0.5in, line(length: 100%, stroke: 0.5pt))
  de #box(width: 1in, line(length: 100%, stroke: 0.5pt)) de #anoaprobacion.
]

// ==============================================================================
// CONTENIDO DEL TRABAJO -- numeración romana para las primeras páginas
// ==============================================================================
#set page(numbering: "i")
#counter(page).update(1)

// ------------------------------------------------------------------------------
// a-prefacio.tex -- AGRADECIMIENTOS
// ------------------------------------------------------------------------------
#heading(level: 1, numbering: none, outlined: true)[Reconocimientos]

Esta plantilla adapta a Typst el formato de tesis IE-MT 2019v3 de la Facultad de
Ingeniería de la UVG, originalmente escrito en LaTeX por MSc. Miguel Zea. Cada
capítulo conserva su título y su función dentro del formato, pero su cuerpo se
aprovecha para presentar, con ejemplos que puedes ver renderizados aquí mismo,
un concepto distinto de Typst. Para usarla en tu propio trabajo: actualiza las
variables de la sección "Datos del estudiante" al inicio del archivo, y
reemplaza el contenido de cada capítulo conservando su encabezado.

// ------------------------------------------------------------------------------
// b-resumen.tex -- RESUMEN
// ------------------------------------------------------------------------------
#heading(level: 1, numbering: none, outlined: true)[Resumen]

Este documento es, a la vez, una plantilla lista para usar y una guía
introductoria a *Typst*, el lenguaje de composición de textos en el que está
escrito. Cumple con la estructura que exige el formato de graduación
IE-MT 2019v3 de la UVG (portada, carátula, hoja de firmas, resumen, índices,
capítulos numerados, bibliografía, anexos y glosario) sin alterar ninguna de
esas secciones. Lo que cambia es _cómo_ se explican: cada capítulo introduce,
con ejemplos renderizados en vivo, un bloque del lenguaje -- encabezados,
énfasis, listas, citas, figuras, tablas, matemáticas y funciones propias
reutilizables#footnote[Bloques de `#let nombre(..) = {..}` que encapsulan
composición repetitiva; se muestran en el capítulo de Anexos.]. La idea es que
puedas aprender la sintaxis básica de #gls("typst") mientras ves, capítulo a
capítulo, un documento formal completo ya construido con ella.

// ------------------------------------------------------------------------------
// c-abstract.tex -- ABSTRACT
// ------------------------------------------------------------------------------
#heading(level: 1, numbering: none, outlined: true)[Abstract]

This document is both a ready-to-use template and an introductory guide to
*Typst*, the markup-based typesetting language it is written in. It follows
the structure required by UVG's IE-MT 2019v3 thesis format (cover page, title
page, signature page, abstract, indices, numbered chapters, bibliography,
appendices and glossary) without altering any of those sections. What changes
is _how_ they are explained: each chapter introduces, through examples
rendered live on the page, one building block of the language -- headings,
emphasis, lists, citations, figures, tables, math, and reusable custom
functions. The goal is to let a new user learn Typst's basic syntax while
reading a complete, formal document already built with it.

// ------------------------------------------------------------------------------
// ÍNDICE GENERAL
// ------------------------------------------------------------------------------
#pagebreak()
#heading(level: 1, numbering: none, outlined: true)[Índice]
#outline(title: none, indent: auto)

// ------------------------------------------------------------------------------
// LISTADO DE FIGURAS
// ------------------------------------------------------------------------------
#pagebreak()
#heading(level: 1, numbering: none, outlined: true)[Lista de figuras]
#outline(title: none, target: figure.where(kind: image))

// ------------------------------------------------------------------------------
// LISTADO DE CUADROS
// ------------------------------------------------------------------------------
#pagebreak()
#heading(level: 1, numbering: none, outlined: true)[Lista de cuadros]
#outline(title: none, target: figure.where(kind: table))


// ==============================================================================
// A partir de aquí inicia la numeración arábiga y el conteo de capítulos
// ==============================================================================
#set page(numbering: "1")
#counter(page).update(1)
#counter(heading).update(0)

// ------------------------------------------------------------------------------
// d-introduccion.tex -- INTRODUCCIÓN
// ------------------------------------------------------------------------------
= Introducción

Todo lo que has leído hasta ahora -- portada, títulos, párrafos justificados --
salió de #gls("marcado") simple. Este capítulo repasa los tres bloques más
básicos: encabezados, énfasis y notas al pie.

== Encabezados y numeración

Los capítulos y secciones se escriben con signos `=` al inicio de línea: uno
para el título de capítulo (nivel 1), dos para una sección (nivel 2, como este
mismo párrafo) y tres para una subsección. El archivo raíz de esta plantilla
fija `#set heading(numbering: "1.1")` una sola vez, y a partir de ahí Typst
numera automáticamente cada encabezado y actualiza los índices por ti:

```typ
= Introducción       // -> "Capítulo 1"
== Encabezados        // -> "1.1 Encabezados"
=== Un ejemplo         // -> "1.1.1 Un ejemplo"
```

=== Un ejemplo

Esta subsección (nivel 3) no tiene ningún contenido especial: es solo para
mostrar cómo se ve el tercer nivel de anidamiento con el estilo definido al
inicio del documento (letra cursiva y en negrita, más pequeña que la sección).

== Énfasis y notas al pie

Para dar énfasis se usa `_cursiva_` o `*negrita*`, y se pueden combinar:
esto produce _texto en cursiva_, *texto en negrita* y hasta *_ambos a la
vez_*. Las notas aclaratorias -- como esta#footnote[Las notas al pie se
insertan con `#footnote[...]` justo donde quieres que aparezca el número; Typst
las numera y las coloca al final de la página automáticamente.] -- se agregan
con `#footnote[...]`. Los párrafos, como los que estás leyendo, simplemente se
separan con una línea en blanco; esta plantilla los distingue con espacio
vertical en vez de sangría, gracias a `#set par(first-line-indent: 0pt)`.

// ------------------------------------------------------------------------------
// f-justificacion.tex -- JUSTIFICACIÓN
// ------------------------------------------------------------------------------
= Justificación

¿Por qué usar Typst y no LaTeX o Word para un trabajo de graduación? Este
capítulo lo argumenta mientras muestra las dos formas de hacer listas.

Una lista con viñetas se escribe con `-` al inicio de línea:

- *Sintaxis más corta*: no requiere `\begin{}`/`\end{}` ni compiladores en
  varias pasadas.
- *Errores comprensibles*: el compilador de Typst señala la línea y la causa
  exacta del problema.
- *Composición en tiempo real*: herramientas como `typst watch` recompilan el
  PDF en milisegundos con cada guardado.
  - Las listas se pueden anidar aumentando la sangría, como en este punto.

Una lista numerada usa `+` (autonumerado) o `1.`, `2.`, ... explícitamente:

+ Se instala el compilador de Typst.
+ Se escribe el documento en archivos `.typ`.
+ Se compila con `typst compile archivo.typ`.

Y una cita destacada se logra con `#quote[...]`:

#quote(attribution: [Documentación de Typst])[
  Un lenguaje de composición de textos que es tan poderoso como LaTeX y tan
  fácil de aprender como Markdown.
]

// ------------------------------------------------------------------------------
// g-objetivos.tex -- OBJETIVOS
// ------------------------------------------------------------------------------
= Objetivos

Los objetivos de un trabajo de graduación suelen distinguir uno general de
varios específicos; aquí ese mismo patrón sirve para mostrar cómo se referencia
contenido dentro del documento con `<etiquetas>` y `@referencias`.

== Objetivo general <obj-general>
Explicar la sintaxis básica de Typst -- #gls("marcado"), listas, citas,
figuras, tablas, matemáticas y #gls("funcion")es propias -- sin romper la
estructura exigida por el formato IE-MT 2019v3 de la UVG.

== Objetivos específicos
1. Documentar, capítulo por capítulo, un concepto del lenguaje distinto,
  reutilizando las secciones que el formato ya exige (véase el objetivo
  general en @obj-general).
2. Mantener ejemplos ejecutables: todo bloque de código mostrado en gris debe
  corresponder a algo efectivamente renderizado en la misma página.
3. Dejar las variables de personalización (nombre, carné, título, asesor) en
  un solo lugar, al inicio del archivo, para que adaptar la plantilla no
  requiera tocar el resto del documento.

// ------------------------------------------------------------------------------
// i-marco_teorico.tex -- MARCO TEÓRICO
// ------------------------------------------------------------------------------
= Marco teórico

Todo trabajo académico necesita citar fuentes y referenciar figuras o tablas;
este capítulo cubre ambos mecanismos.

== Citas bibliográficas

Typst compara los sistemas de composición de texto con una larga tradición:
TeX sentó las bases del tipografiado programable, LaTeX simplificó su uso con
macros de alto nivel, y más recientemente Typst propuso un lenguaje de marcado
y una API de funciones más directos -- todo ese linaje se puede citar de un
solo rango con #cite-range("Knuth1984TeXbook", "Lamport1994LaTeX", "TypstProject2019").
Una cita puntual se escribe `@clave` (por ejemplo `@TypstProject2019`), y
`cite-range(first, ..middle, last)` -- definida al inicio de este archivo --
agrupa varias claves consecutivas en un solo rango "primera--última". Todas
las claves usadas deben existir en `ref.bib`.

== Figuras y tablas

Una figura se inserta con `#figure(image(...), caption: [...])`, y se le puede
poner una etiqueta con `<nombre>` para referenciarla luego con `@nombre`, como
en la @fig-escudo.

#figure(
  image("media/template/escudoUVGnegro.svg", width: 35%),
  caption: [Ejemplo de figura con su etiqueta y numeración automática.],
)<fig-escudo>

Una tabla se construye con `#table(columns: .., [..], [..])`; cada argumento
llena una celda en orden, fila por fila:

#figure(
  table(
    columns: (auto, 1fr, 1fr),
    align: (left, left, left),
    table.header([*Aspecto*], [*LaTeX*], [*Typst*]),
    [Compilación], [Varias pasadas], [Incremental, casi instantánea],
    [Errores], [Mensajes crípticos], [Ubicación y causa explícitas],
    [Programación], [TeX / paquetes externos], [Lenguaje propio integrado],
  ),
  caption: [Comparación superficial entre LaTeX y Typst.],
)<tabla-comparacion>

Como puedes ver en la @tabla-comparacion, la sintaxis de tabla evita el manejo
manual de `&` y `\\` característico de LaTeX.

// ------------------------------------------------------------------------------
// Metodología
// ------------------------------------------------------------------------------
= Metodología

Este capítulo muestra el modo matemático de Typst, y de paso deja ver qué
ocurre cuando un encabezado *no* tiene una regla de estilo propia.

Una expresión matemática dentro del texto se escribe entre signos de dólar,
por ejemplo $x^2 + y^2 = r^2$, mientras que rodearla de espacios (`$ .. $`) la
separa en su propio bloque centrado:

$ D_i = sum_(j=1)^(N) frac(Q_(i j) dot S_j, C_j) $

==== Comprensión cognitiva

Este subtítulo usa cuatro signos `=` (nivel 4). Como el bloque de estilos al
inicio del archivo solo definió apariencia para los niveles 1 a 3, Typst le
aplica su formato por defecto -- por eso se ve distinto (más simple) al resto
de encabezados de este documento. Sirve como recordatorio de que las reglas de
estilo (`#show heading.where(level: n): ..`) solo alcanzan a los niveles que
explícitamente configures.

// ------------------------------------------------------------------------------
// k-conclusiones.tex -- CONCLUSIONES
// ------------------------------------------------------------------------------
= Conclusiones

- Los encabezados (`=`, `==`, `===`) estructuran y numeran el documento solos.
- El énfasis (`_cursiva_`, `*negrita*`) y las notas al pie (`#footnote[..]`) se
  escriben sin salir del modo de escritura normal.
- Las listas con viñetas (`-`) y numeradas (`+`) organizan enumeraciones y
  aceptan anidamiento.
- Las citas (`@clave`) y las figuras/tablas etiquetadas (`<nombre>` /
  `@nombre`) se resuelven y numeran automáticamente.
- El modo matemático (`$..$`) reutiliza la misma sintaxis para fórmulas en
  línea y en bloque.
- Las funciones propias (`#let f(..) = {..}`, importadas con `#import`)
  permiten construir componentes reutilizables, como los del capítulo de
  Anexos.
- Todo lo anterior convive con reglas de estilo (`#set`, `#show`) definidas
  una sola vez al inicio del archivo, sin que el resto del documento tenga
  que preocuparse por ellas.

// ------------------------------------------------------------------------------
// l-recomendaciones.tex -- RECOMENDACIONES
// ------------------------------------------------------------------------------
= Recomendaciones

Para adaptar esta plantilla a tu propio trabajo de graduación:

1. Instala Typst y, opcionalmente, la extensión *Tinymist* para tu editor
  (resaltado de sintaxis y vista previa en vivo).
2. Compila con `typst compile template.typ` o, mientras escribes, con
  `typst watch template.typ` para ver los cambios al guardar.
3. Reemplaza las variables de la sección "Datos del estudiante" al inicio del
  archivo (`nombreestudiante`, `titulotesis`, `nombreasesor`, etc.).
4. Sustituye el contenido de cada capítulo por el tuyo, conservando su título
  -- son los que exige el formato IE-MT 2019v3.
5. Agrega tus propias referencias a `ref.bib` y cítalas con `@clave`; borra
  las entradas de ejemplo (`TypstProject2019`, `Knuth1984TeXbook`,
  `Lamport1994LaTeX`) cuando ya no las uses.
6. Actualiza el diccionario `glossary` al inicio del archivo con los términos
  técnicos de tu propio trabajo; el capítulo de Glosario se genera solo a
  partir de él.
7. Versiona el proyecto con Git desde el principio: al ser texto plano, los
  `diff` de Typst son legibles, a diferencia de un `.docx`.

// ------------------------------------------------------------------------------
// m-bibliografia.bib -- BIBLIOGRAFÍA (estilo IEEE, igual que el original)
// ------------------------------------------------------------------------------
#heading(level: 1, numbering: none, outlined: true)[Bibliografía]<bibliografia>
#bibliography("ref.bib", title: none, style: "ieee")

// ------------------------------------------------------------------------------
// n-anexos.tex -- ANEXOS
// ------------------------------------------------------------------------------
= Anexos

Además de contenido complementario, los anexos son un buen lugar para mostrar
cómo crear tus propias *funciones reutilizables*: bloques de
`#let nombre(..) = {..}` que encapsulan composición repetitiva, para no tener
que reescribir el mismo bloque de estilo cada vez que lo necesitas.

== Definir una función propia

Por ejemplo, esta función arma una nota destacada a partir de un color y un
cuerpo de contenido:

```typ
#let nota(color: uvg-green, cuerpo) = block(
  fill: color.lighten(85%),
  inset: 10pt,
  radius: 4pt,
  stroke: (left: 2pt + color),
)[#cuerpo]
```

#let nota(color: uvg-green, cuerpo) = block(
  fill: color.lighten(85%),
  inset: 10pt,
  radius: 4pt,
  stroke: (left: 2pt + color),
)[#cuerpo]

== Reutilizarla

Una vez definida, se invoca como cualquier otra función de Typst, cuantas
veces sea necesario y con distintos argumentos:

#nota[Esta nota fue generada llamando a `nota(..)`, la función definida arriba.]

#nota(color: red)[El color también es un argumento: aquí se pasó `color: red`.]

Si tu trabajo necesita componentes más elaborados y reutilizados en varios
capítulos -- casillas de verificación, escalas tipo Likert, cajas de
respuesta -- conviene definirlos siguiendo el mismo patrón pero en un archivo
aparte (por ejemplo `utilities.typ`) e importarlos al inicio del documento con
`#import "utilities.typ": nombre1, nombre2`.

// ------------------------------------------------------------------------------
// o-glosario.tex -- GLOSARIO
// ------------------------------------------------------------------------------
#pagebreak(weak: true)
#heading(level: 1, numbering: none, outlined: true)[Glosario]

Los términos técnicos usados a lo largo de este documento -- como
#gls("typst") o #Gls("funcion") -- se definieron una sola vez en el
diccionario `glossary`, al inicio del archivo, y se invocan con `#gls("clave")`
(minúscula) o `#Gls("clave")` (con mayúscula inicial, útil a principio de
oración). La lista siguiente se genera recorriendo ese mismo diccionario, así
que basta con agregar una entrada nueva para que aparezca aquí también.

// Typst no incluye un paquete de glosarios equivalente a \usepackage{glossaries};
// esta sección lista manualmente las entradas definidas en el diccionario
// `glossary` de arriba, ordenadas alfabéticamente por término.
#for key in glossary.keys().sorted(key: k => glossary.at(k).name) [
  #strong[#glossary.at(key).name] #h(0.5em) --- #glossary.at(key).desc
  #v(0.5em)
]

