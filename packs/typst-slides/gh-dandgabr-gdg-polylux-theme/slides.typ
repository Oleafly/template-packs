// slides.typ
// Exemplo mínimo usando o tema GDG com Polylux.
//
// Este arquivo funciona como referência prática de composição de deck:
// - Mostra a ordem recomendada (import -> show -> slides).
// - Demonstra cada tipo de slide exportado pelo tema.
// - Serve como base para duplicar e iniciar novas apresentações.

#import "@preview/polylux:0.4.0": *
#import "gdg-polylux.typ": *

// Aplica o tema a todo o documento.
// Dica: mantenha um único `#show: theme.with(...)` no arquivo.
// Isso evita configurações conflitantes entre slides.
#show: theme.with(
  aspect-ratio: "16-9",
  footer: [GDG Londrina · 2026],
)

// Title slide (usa heading nível 1).
#title-slide[
#set text(fill: gdg-red)
#text(size: 2.3em, weight: "bold")[Exemplo de Slides com Typst/Polylux]

#v(2em)
#set text(fill: gdg-grey)
Google Developer Groups Londrina
]

#slide[
#set page(
  header: block[
    #v(0.4em)
    #align(center)[#gdg-color-strip()]
  ],
  header-ascent: 1.2em,
)

== Índice

#context[
  #set text(fill: gdg-grey)
  #outline(target: heading.where(level: 1))
]
]

// Nova seção (heading nível 1) + primeiro slide (heading nível 2).
// `= Seção` cria capa automática porque o tema intercepta heading nível 1.
= Primeira Seção

#slide[
== Abertura e objetivo

Neste exemplo, a ideia é mostrar um fluxo de apresentação simples,
com ritmo natural e distribuição visual equilibrada.

#v(0.8em)

#align(center + horizon)[
  #block(width: 88%)[
    #grid(
      columns: (1fr, 1fr),
      gutter: 1em,
      [
        #set text(weight: "bold", fill: gdg-blue)
        O que vamos ver
        #set text(weight: "regular", fill: gdg-grey)
        - estrutura de um deck
        - variação de layout
        - slides de destaque
      ],
      [
        #set text(weight: "bold", fill: gdg-green)
        Resultado esperado
        #set text(weight: "regular", fill: gdg-grey)
        - mensagem clara
        - leitura rápida
        - transições suaves
      ],
    )
  ]
]
]

// Outro slide na mesma seção.
// Enquanto a seção não muda, o header continua mostrando o mesmo contexto.
#slide[
== Estrutura básica de um bom slide

- Um título direto por slide
- No máximo uma ideia principal por bloco
- Hierarquia com cor e espaçamento
- Respiro visual entre elementos
]

// Focus slide com fundo azul GDG.
// Use com parcimônia para enfatizar uma única mensagem-chave.
#focus-slide[
#text(weight: "bold")[Dica prática]
#v(0.5em)
Use slide de foco para reforçar mensagem-chave, não para repetir conteúdo da lista anterior.
]

= Segunda Seção

#slide[
== Exemplo de disposição equilibrada

#align(center + horizon)[
  #block(width: 88%)[
    #grid(
      columns: (3fr, 2fr),
      gutter: 1.2em,
      [
        #set text(weight: "bold", fill: gdg-blue)
        Mensagem principal
        #set text(weight: "regular", fill: gdg-grey)
        - Comece com contexto curto
        - Traga 2 ou 3 pontos de apoio
        - Feche com uma ação concreta
      ],
      [
        #rect(
          fill: luma(245),
          radius: 8pt,
          inset: 0.8em,
          [
            #set text(weight: "bold", fill: gdg-red)
            Checklist
            #set text(weight: "regular", fill: gdg-grey)
            - título curto
            - boa margem
            - contraste claro
          ],
        )
      ],
    )
  ]
]
]

#slide[
== Recursos úteis no fluxo

- Heading nível 1 cria capa de seção automaticamente
- #text(weight: "bold")[focus-slide] destaca mensagens importantes
- #text(weight: "bold")[centered-slide] funciona bem para transição e fechamento
]

#slide[
== QR Code com estilo GDG

#set text(fill: gdg-grey)
Use o helper abaixo para manter o QR Code alinhado com a identidade visual do tema.

#v(0.8em)
#align(center)[
  #gdg-qr-code("https://gdg.londrina.dev/", width: 6cm)
]
]

#slide[
== Código com estilo Codly GDG

#set text(fill: gdg-grey)
Blocos de código já seguem o estilo visual do tema quando você usa \#show: theme.with(...).

#v(0.2em)

````C
#include <stdio.h> // Inclui a biblioteca de entrada e saída padrão

int main() {
    // printf é usada para exibir o texto na tela
    printf("Hello, GDG!\n");                
    return 0; // Indica que o programa terminou com sucesso
}
````
]

#slide[
== Exemplo de tabela

#set text(fill: gdg-grey)
Uma tabela simples para comparar opções de formato de conteúdo.

#v(0.6em)

#table(
  columns: (2fr, 1fr, 1fr),
  inset: 8pt,
  stroke: luma(220),
  [#text(weight: "bold", fill: gdg-blue)[Formato]],
  [#text(weight: "bold", fill: gdg-blue)[Tempo]],
  [#text(weight: "bold", fill: gdg-blue)[Impacto]],

  [Demo ao vivo], [10 min], [Alto],
  [Estudo de caso], [8 min], [Médio],
  [Q&A], [5 min], [Alto],
)
]

#slide[
== Exemplo de equação matemática

#set text(fill: gdg-grey)
Equação para representar crescimento composto ao longo do tempo.

#v(0.8em)

#align(center)[
  $A = P (1 + r)^n$
]

#v(0.6em)

- $A$: valor final
- $P$: valor inicial
- $r$: taxa de crescimento
- $n$: número de períodos
]

// Slide centrado para encerramento.
// Bom para abertura, transição entre blocos e call-to-action final.
#centered-slide[
#text(size: 1.8em, weight: "bold", fill: gdg-blue)[Perguntas?]
#v(0.7em)
#text(fill: gdg-grey)[Obrigado por acompanhar.]
]