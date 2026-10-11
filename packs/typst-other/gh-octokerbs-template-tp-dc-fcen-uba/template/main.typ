#import "caratula.typ": caratula
#import "@preview/hydra:0.6.2": hydra
#set text(lang: "es", region: "ar")
#set page(margin: (x: 1.6cm),)

#let titulo = "Descripción del TP"

#show: caratula.with(
  materia: "Materia de la carrera",
  titulo: titulo,
  subtitulo: "Subtítulo del TP",
  grupo: "Grupo 42",
  fecha: "14 de Diciembre de 2025",
  integrantes: (
    (nombre: "Apellido Nombre", lu: "001/01", email: "alumno1@gmail.com"),
    (nombre: "Apellido Nombre", lu: "002/01", email: "alumno2@gmail.com"),
    (nombre: "Apellido Nombre", lu: "003/01", email: "alumno3@gmail.com"),
    (nombre: "Apellido Nombre", lu: "004/01", email: "alumno4@gmail.com"),
  ),
)

// Recuadro rojo en referencias
#show selector(outline): it => {
  show regex("\d+$"): num => {
    box(num, stroke: 1pt + red, outset: (bottom: 1.5pt, x: 1pt, y: 1pt))
  }
  it
}
#show selector(cite): it => {
  show regex("\\[\d+\\]"): num => {
    box(num, stroke: 1pt + red, outset: (bottom: 2pt, x:-2.7pt, y: 0.6pt))
  }
  it
}

#set heading(numbering: "1.")
#show bibliography: set heading(numbering: "1.")

#set page(numbering: "1")

#set page(
  header: context {
    if counter(page).get().first() > 1 [
      #let elems = query(selector(heading.where(level: 2)).before(here()))
      #if elems.len() > 0 {
          emph[#elems.last().body]
      }
      #h(1fr)
      #(titulo)
      #line(length: 100%, stroke: 0.5pt + black)
    ]
  }
)

#set text(size: 10pt)

#outline(title: "Índice")
#pagebreak()

#set par(justify: true)

// ======================== CONTENIDO ========================
= Definir referencias
En el archivo references.yml pueden definir sus referencias con una estructura similar a esta:

```yml
pe_format:
  type: Web
  title: Portable Executable Format
  url: https://learn.microsoft.com/en-us/windows/win32/debug/pe-format
  organization: Microsoft

cubawiki:
  type: Web
  title: Cubaca
  url: https://www.cubawiki.com.ar/images/e/e1/Cubaca.png
  organization: Cuba-Wiki
```

y referenciarlas literalmente con el nombre definido:
"Bla bla bla bla, bla bla! bla bla @pe_format"
"The cubaca loves you! @cubawiki"

Para saber mas pueden consultar la sintaxis de typst @typst_syntax

= Introduction
#lorem(60)

== In this paper
#lorem(20) 

=== Contributions
#lorem(40)

= Related Work
#lorem(500)

// ======================== REFERENCIAS ========================
#pagebreak()

#show link: it => {
  set text(fill: blue, style: "italic")
  underline(it)
}

#bibliography("references.yml", title: "Referencias", style: "ieee")