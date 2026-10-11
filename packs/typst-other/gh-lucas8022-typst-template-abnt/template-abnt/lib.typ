#import "_config.typ": *
#import "../config-textual/import.typ": *

#let template_ABNT(
  titulo: [],
  autor: [],
  faculdade: [],
  campus: [],
  graduacao: [],
  cidade: [],
  ano: [],
  orientador: [],
  coorientador: [],
  data_de_aprovacao_banca: [],
  jury:(),

  body
  
) = {
  // document settings
  set document(title: titulo, author: autor, date: auto)

  // ############## SETTINGS PRE-TEXTUAL ################


  // Heading settings
  set heading(
    numbering: "1.1.1.1",
    hanging-indent: 1.25cm,
  )
  show heading: it => {
    it
    v(1em)
  }

  show: espacamento_entrelinhas.with(tamanho: 0.17em)

  // List settings
  set list(indent: 2em)
  show list: it => {
    v(10pt)
    it
    v(10pt)
  }

  // page and text settings
  set text(lang: "pt",region: "BR", font: "Times New Roman", size: 12pt)

  set page("a4", margin: (
    left: 3cm,
    top: 3cm,
    right: 2cm,
    bottom: 2cm,),
  )
  align(center)[

  // Capa / Frontpage ABNT
  #text([#upper(faculdade) \ #emph("CAMPUS") #upper(campus)])
  #linebreak()
  #v(8em)

  #upper(autor)
  #linebreak()
  #v(15em)

  #text(weight: "bold", [#upper(titulo)])
  #v(1fr)

  #text(cidade)
  #linebreak()
  #text(ano)
  ]
  pagebreak()
  
  // Verso Capa ------------------------------------------
  align(center)[
    #upper(autor)
    #v(10em)

    #text(weight:"bold", upper(titulo))
    #v(15em)
  ]
  pad(left: 50%)[
    #align(left)[
    #set par(justify: true)
 
    Trabalho de Conclusão de Curso submetido à Coordenação do Curso de #graduacao do #faculdade  - _Campus_ #campus, como parte dos requisitos para a obtenção do Título de #graduacao. \
    Orientador: #orientador 
    #if coorientador != "" and type(coorientador) == str {
      [\ Coorientador: #coorientador]
    }else {
      []
    }
  ]]
  v(1fr)

  align(center)[
  #text(cidade)
  #linebreak()
  #text(ano)]
  // -----------------------------------------------------
  pagebreak()

  
  // Folha de Aprovacao ----------------------------------
  set align(center)
  upper(autor)
  v(3em)

  upper(text(weight: "bold",titulo))
  v(3em)

  pad(left: 50%)[
    #align(left)[
    #set par(justify: true)

    Trabalho de Conclusão de Curso submetido à Coordenação do Curso de #graduacao do #faculdade  - _Campus_ #campus, como parte dos requisitos para a obtenção do Título de #graduacao.
    
    ]]
  v(12pt)
  align(right)[#pad(left: 50%)[
      #if data_de_aprovacao_banca != "" and type(data_de_aprovacao_banca) == str {
        [Aprovado em #data_de_aprovacao_banca]
      }else {
        []
      }
    ]
  ]
  v(1.5em)

  text(weight: "bold","BANCA EXAMINADORA")
  table(
    columns: auto,
    inset: 2pt,
    align: center,
    stroke: none,
    ..jury.map(member => ([#v(5em)#line(length:85%)],member.title + " " + member.name + " - " +
  member.affiliation, member.role)).flatten()
  )
  // ----------------------------------------------------
  pagebreak()

  set text(lang: "pt", region: "BR", font: "Times New Roman")
  set align(start + top)
  // Dedicatoria ----------------------------------------
  include "Dedicatoria.typ"
  // ----------------------------------------------------
  // #####################################################
  pagebreak()

  show: easy-typography.with(
  fonts: (
    heading: "Times New Roman",
  )
  )

  // Agradecimentos -------------------------------------
  include("Agradecimentos.typ")
  // ----------------------------------------------------

  pagebreak()

  // Abstract -------------------------------------------
  include "Abstract.typ"
  // ----------------------------------------------------

  pagebreak()


  // Summary -------------------------------------------
  align(center)[*SUMÁRIO*]
    v(12pt)
    outline(
    indent: 0em,
    title: none,
  )

  // ----------------------------------------------------


  show table.cell.where(x: 1): set text(weight: "medium")
  show table.cell.where(y: 0): set text(weight: "bold")
  let frame(stroke) = (x, y) => (
    left: if x > 0 { 0pt } else { stroke },
    right: stroke,
    top: if y < 2 { stroke } else { 0pt },
    bottom: stroke,
  )

  set table(
    fill: (_, y) => if calc.odd(y) { table_color },
    stroke: frame(rgb("21222C")),
    inset: 5pt
  )

  body
}





