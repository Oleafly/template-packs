// Equal to Office365 Word's Single Line Spacing 
// Equal to Office365 Word's 1.5  Lines Spacing 

#let estilo = (
  fonte:(
        // serif:"Times New Roman",
        // serif:"STIX Two Text",
        serif:"Times New Roman",
        // sans:"TeX Gyre Heros",
        // sans:"Helvetica",
        sans:"Arial",
        mono:"SF Mono",
        // mono:"IBM 3270",
        tamanho:(
          normal: (size:1em),
          large: 18pt,
          larger: 20pt,
          huge: 25pt,
          small: 10pt,
          regular:12pt,
            
        ),),

    // ABNT NBR 14724:2011 §5.1 - FORMATO
    // Recomenda-se, quando digitado, a fonte tamanho 12 para todo o trabalho (...)
    // Tamanhos de letra baseadas na regular. regular = 1em
    espacamento: (
        // ABNT NBR 14724:2011 §5.2 - ESPAÇAMENTO
        // Todo texto deve ser digitado ou datilografado com espaçamento 1,5 entre linhas
        // entrelinhas: 1.5,
        simples: 0.17em,
        entrelinhas1-5: 0.75em,
        //entrelinhas: 1.5,
        entreparagrafos: 1.5,
        titulos: 3,
        ),
    numeracao: (titulos: "1.1.1.1.1", enumeracoes: "1.1.1.1.1.",),
    tema: red.darken(50%), // cor do tema (afeta links e outros pequenos detalhes)

)


#let Prune = rgb(99, 0, 60)
#let table_color = rgb("EAF2F5")
#let B1 = rgb(49, 62, 72)
#let C1 = rgb(124, 135, 143)
#let D1 = rgb(213, 218, 223)
#let A2 = rgb(198, 11, 70)
#let B2 = rgb(237, 20, 91)
#let C2 = rgb(238, 52, 35)
#let D2 = rgb(243, 115, 32)
#let A3 = rgb(124, 42, 144)
#let B3 = rgb(125, 106, 175)
#let C3 = rgb(198, 103, 29)
#let D3 = rgb(254, 188, 24)
#let A4 = rgb(0, 78, 125)
#let B4 = rgb(14, 135, 201)
#let C4 = rgb(0, 148, 181)
#let D4 = rgb(70, 195, 210)
#let A5 = rgb(0, 128, 122)
#let B5 = rgb(64, 183, 105)
#let C5 = rgb(140, 198, 62)
#let D5 = rgb(213, 223, 61)
#let Link_old = rgb(0204, 51, 51)
#let Link = B1



  

#let espacamento_entrelinhas(tamanho: 0.75em, justify: true,body) = {
  set text(top-edge: 1em, bottom-edge: 0em)
  set par(
    spacing: tamanho,
    leading: tamanho,
    justify: justify,
    // first-line-indent: (amount: 1.25cm, all: true),
    // linebreaks: "optimized",
  )
  body
}
  
// #let espacamento-simples = {
//   set text(top-edge: 1em, bottom-edge: 0em)
//   set par(leading: estilo.espacamento.simples) 
// }
  
  

