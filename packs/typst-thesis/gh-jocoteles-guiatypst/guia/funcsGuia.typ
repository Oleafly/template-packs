/*
funcsGuia.typ
Funções auxiliares para o Guia de usos e exemplos do Typst
*/


//Função para destacar comandos Typst no texto:
#let typw(body) = {
  highlight(fill: luma(90%))[#raw(body, lang: "typ")]
}

//Função para exemplificar comandados em Typst.
//Texto_str: string de texto que pode incluir markup Typst
//label: string com o rótulo que será mostrado no exemplo.
#let typex(texto_str, label) = {
  let texto = eval(texto_str, mode: "markup")  
  block(breakable: false)[
    #par(first-line-indent: (amount: 0pt, all: false), [*#label*])
  #grid(
    columns: (1fr, 1fr),
    gutter: 1em,
    block(width: 100%, fill: luma(90%), inset: 10pt, raw(texto_str, lang: "typ")),
    block(width: 100%, rect(stroke: 1pt + black, inset: 8pt, texto)),
  )]
}