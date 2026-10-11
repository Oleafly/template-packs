/*
templateTCC.typ

Template que implementa a formatação das monografias de TCC do 
Curso de TADS/BSI da Faculdade de Tecnologia/UNICAMP.

Produzido por Vitor R. Coluci FT/Unicamp
Julho/2025

Esse material se baseia no template Latex desenvolvido pelo Prof. André Leon https://github.com/gradvohl/tese-ft 
e no template Typst desenvolvido pelo Prof. João Teles (Ufscar) para TCCs da Ufscar.

Uma guia prático do Typst pode ser visto em https://github.com/jocoteles/GuiaTypst

*/

#import "@preview/zero:0.1.0": num, set-num
#import "@preview/physica:0.9.4": *


// Declaração das variáveis padrão para o documento do template:
//--------------------------------------------------------------

#let espacoAbaixoParagrafo = 6pt
#let espacoAbaixoTitulo = 6pt
#let espacoAcimaTitulo = 18pt
#let fonte = "libertinus serif" //"Liberation Serif"
#let indentacao = 0.0em

    
#let descricaoTCC = [Monografia apresentada à Faculdade de Tecnologia da Universidade Estadual de Campinas como parte dos requisitos para a obtenção do título de Bacharel em Sistemas de Informação.]


//Definição do Template:
//-------------------------------------------------------------
#let project(  
  autor: [],
  titulo: [],
  orientador: [],
  local: [],
  ano: [],  
  instituicao: [],
  faculdade: [],
  tcc: [],
  resumo: [],
  abstract:[],
  listas: (figuras: false, quadros: false, tabelas: false),
  dedicatoria: [],
  agradecimentos: [],
  dataDefesa: [],
  resultado: [],
  banca: (nome1:[], inst1: [], nome2:[], inst2: []),
  doc
) = {
  
  set page(
    paper: "a4",
    margin: (x: 3cm, y: 2cm, top: 3cm, bottom: 3cm)    
  )
  
  set par(
    leading: 0.8em, //Espaçamento entre linhas
    spacing: 1.5em, //Espaçamento abaixo dos parágrafos
    first-line-indent: (amount: indentacao, all: true),    
    justify: true,
  )
 
  set text(
    lang: "pt",
    font: fonte,
    size: 12pt
  )  
  
  set math.vec(
    delim: "[",
    gap: 1em
  )
  
  set math.mat(
    delim: "[",
    gap: 1em
  )

  set math.equation(numbering: "(1)")  //Estilo de numeração das equações

  set-num(decimal-separator: ",")  //Separador decimal usado pela função #num()

  show link: it => underline(text(blue, it)) //Melhor destaque para os links

  set figure.caption(position: bottom)      
  
  //Estilo de numeração das seções:
  set heading(numbering: "1.")
  
  //Espaçamento acima e abaixo dos títulos das seções:
  show heading: set block(
    above: 1em + espacoAcimaTitulo,
    below: 1em + espacoAbaixoTitulo
  )

  // Adequa citação em bloco para ABNT:
  set quote(block: true, quotes: false)
  show quote: it => {
    set pad(left: 4cm)
    set align(right)
    text(size: 10pt, it)  
  }
  
  
  //Capa:
  page(
    {
      set align(center)
      set text(hyphenate: false, weight: "bold")
      set par(justify: false)
      grid(    
        columns: (1fr, 4fr),
        rows: (1fr),
        grid.cell(
        colspan: 1,
              image("figuras/logo-unicamp.png", width: 60%),
        ),
        align(top + center,
          text(size: 14pt)[
            #upper(instituicao) \
            #faculdade
          ]
        ),
       grid.cell(
        colspan: 2,
              align(horizon + center,
                 text(size: 14pt)[
                #autor    
                 ]
               )
        ),
        grid.cell(
        colspan: 2,
              align(horizon + center,
                text(size: 20pt)[
                #titulo
              ]
            )       
         ),

         grid.cell(
         colspan: 2,
              align(bottom + center,
                text(size: 14pt, weight: "regular")[
                #local\
                #ano
                ]
              )     
         )
       )
    }
  )
  
  //Folha de rosto:
  page(
    {
      set text(hyphenate: false, weight: "bold")
      set par(justify: false)
      grid(
        rows: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
        align(top + center,
          text(size: 14pt,
            autor
          )
        ),
        align(horizon + center,
          text(size: 20pt,
            titulo
          )
        ),
        align(horizon + right,
          pad(left: 50%,        
            par(leading: 0.5em, justify: true,
              {
                set text(weight: "regular")            
                [#descricaoTCC]     
                                
              }
            )
          )
        ),
        align(horizon + left,
          text(size: 12pt,
            [Orientador: #orientador]
          )
        ),
        
        align(horizon + left,
              pad(right: 50%,
                par(leading: 0.5em, justify: true,
                {
                  set text(weight: "regular")      
                  [Este trabalho corresponde à versão final da Monografia defendida por #autor e orientada pelo #orientador.
]
                  
                }
                )
              )
        ),
        align(bottom + center,
          text(size: 14pt, weight: "regular")[
            #local \
            #ano
          ]
        )
      )
    }
  )


  //Folha de Aprovação
  page(
      align(top, [
          #align(center, 
          text(size: 14pt, 
            [*FOLHA DE APROVAÇÃO*]
              )
          ) \
          Abaixo se apresentam os membros da comissão julgadora da sessão pública de defesa de monografia para o Título de Bacharel em Sistemas de Informação, a que se submeteu o aluno #autor, em #dataDefesa na Faculdade de Tecnologia – FT/UNICAMP, em Limeira/SP. \ \ \ \ \ \ \ 
          #text(weight: "bold")[#orientador] \ 
          Presidente da Comissão Julgadora\ \
          #text(weight: "bold")[#banca.nome1] \ 
          #banca.inst1 \ \
          #text(weight: "bold")[#banca.nome2] \ 
          #banca.inst2 \ \ \ \ \ \ \ \ \ \
          Ata da defesa, assinada pelos membros da Comissão Examinadora, encontra-se no SIGA/Sistema de Fluxo de Dissertação/Tese e na Secretaria de Graduação da Faculdade de Tecnologia.  
        ]
      )
    )
  
  //Página de agradecimentos:
  page(
      align(top, [
          #align(left, text(size: 18pt, [*Agradecimentos*])) \
          #agradecimentos
        ]
      )
    )
  
  //Página de resumo:
  page(
    align(top, [
        #align(left, text(size: 18pt,
        [*Resumo*])) \
        #resumo
      ]
    )
  )

  //Página de abstract:
  page(
    align(top, [
        #align(left, text(size: 18pt,
        [*Abstract*])) \
        #resumo
      ]
    )
  )

  //Lista de figuras:
  if (listas.figuras) {
    pagebreak()
    outline(
      title: [LISTA DE FIGURAS],
      target: figure.where(kind: image),
    )
  }

  //Lista de quadros:
  if (listas.quadros) {
    pagebreak()
    outline(
      title: [LISTA DE QUADROS],
      target: figure.where(kind: "quadro"),
    )
  }

  //Lista de tabelas:
  if (listas.tabelas) {
    pagebreak()
    outline(
      title: [LISTA DE TABELAS],
      target: figure.where(kind: table),
    )
  }
  
  //Página de sumário:
  page(align(horizon,
    outline()
  ))

  //Início da numeração de páginas:
  set page(
    numbering: "1"
  )

  doc
  
}

/* Função para uso do orientador para efetuar comentários.*/
#let ori(origin, comment, origin_color: red) = {
  text(origin_color, [[#origin]])
  text(orange, [*#comment*])  
  text(blue, [[_Orientador_]])
}

/* Função para uso do autor para efetuar comentários.*/
#let aut(origin, comment, origin_color: red) = {
  text(origin_color, [[#origin]])
  text(orange, [*#comment*])  
  text(green, [[_Autor_]])
}


//Funções e variáveis auxiliares
//-------------------------------------------------

#let cite_indireta(reference) = {
  cite(reference, form: "prose")
}

#let mi = text("µ")    //Para uso de µ (micron) em modo texto

#let sen = math.op("sen")  //Para reconhecimento da função seno em português no modo matemático.

#let noi = h(-indentacao) //Retira a indentação no início do parágrafo