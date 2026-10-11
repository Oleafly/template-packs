#import "variables.typ": *
#import "@preview/numbly:0.1.0": numbly


// Generic UC header
#let _header() = {
  context {
    let shown = state("header-shown", false)
    if not shown.get() {
      shown.update(true)
      [#table(
          columns: (1in, auto),
          align: (auto, horizon),
          stroke: none,
          image("../assets/logo.pdf", width: 100%),
          
          [#if formato == 0 [#set par(leading: 0.65em)
            #smallcaps([
              #universidad\
              #escuela\
              #departamento\ ])
            *#sigla* -- *#nombre-curso*
          ] else if formato == 1 [#set par(leading: 0.65em)
            #smallcaps([
              #universidad\
              #if escuela != "" [ #escuela \ ]
              #departamento\ 
            #sigla -- #nombre-curso ])
          ]],
        )
      ]
    }
  }
}


// General configuration
#let config(doc, text-size: 11pt, darkmode: false) = {


  let text-color = if darkmode {rgb("#ffffff")} else {rgb("#000000")}
  let background-color = if darkmode {rgb("#000000")} else {rgb("#ffffff")}
  set page(fill: background-color)
  set text(fill: text-color)


  set document(
    title: titulo,
    author: author,
    date: none
  )

  set page(
    paper: "us-letter", // "a4" o "us-letter"
    margin: (top: 2cm,
            bottom: 3cm,
            left: 2.5cm, 
            right: 2.5cm),
    columns: 1,
    numbering: "1",
    number-align: center + bottom,
    footer: auto,
    header: if head == 1 [#_header()] else [],
    header-ascent: -150%,
  )

  set par(
    justify: true,   // Justificado
    leading: 0.65em, // Espacio interlineado
    spacing: 1.5em,  // Espacio entre parrafos
  )

  set text(
    font: "New Computer Modern",
    size: text-size,
    lang: "es",
  )


  set heading(numbering: "1.")
  set terms(separator: ": ")
  
  // For nested enumerations
  set enum(
      full:true, 
      numbering: numbly("{1:1}.", "{2:a})", "{3:i})","({4})" )
  )

  // For showing equation references as (1)
  set math.equation(numbering: "(1)")
  show ref: it => {
    let eq = math.equation
    let el = it.element
    // Skip all other references.
    if el == none or el.func() != eq { return it }
    // Override equation references.
    link(el.location(), numbering(
      el.numbering,
      ..counter(eq).at(el.location())
    ))
  }

  show raw: set text(font: "New Computer Modern Mono", size: text-size)
  show heading: set block(above: 1.4em, below: 1em)
  show heading.where(level:1): set text(size: 14pt)
  show heading.where(level:2): set text(size: 12pt)


  doc

}