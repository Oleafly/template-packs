#import "ifpist.typ": *

#show: ifpist.with(
  autor: "Cadu Maverick",
  autor-pronome: "M",
  autor-email: "cadumaverick@ifpi.edu.br",
  titulo: [Tá Dando Onda],
  subtitulo: [Surfe!],
  tipo-trabalho: "TCC",
  orientador: "Big Z",
  orientador-pronome: "M",
  orientador-bio: [Lenda do surfe.],
  orientador-email: "bigz@ifpi.edu.br",
  coorientador: "João Frango",
  coorientador-pronome: "M",
  coorientador-bio: [Filósofo do surfe.],
  coorientador-email: "joao@ifpi.edu.br",
  resumo: [#lorem(150)],
  palavras: ("surfe", "onda", "praia"),
  abstract: [#lorem(150)],
  keywords: ("surf", "wave", "beach"),
  data: datetime(year: 2026, month: 06, day: 30),
)

= Introdução

#lorem(50)

#lorem(45)

#lorem(20)

#lorem(20)

#quote(attribution: [Platão])[#lorem(30)]

#lorem(45)

Wikipedia, a enciclopédia livre que todos podem editar. @web:wikipedia

#rascunho[
  Adicionar história do surfe.
]

= Desenvolvimento

#lorem(100)

#lorem(50)

#lorem(20)

== Metodologia

#lorem(30)

#lorem(40)

#lorem(20)

#figure(
  [
    #table(
      columns: 2,
      table.header([Estado], [Capital]),
      [Maranhão], [São Luís],
      [Piauí], [Teresina],
      [Ceará], [Fortaleza],
      [Rio Grande do Norte], [Natal],
      [Paraíba], [João Pessoa],
      [Pernambuco], [Recife],
      [Alagoas], [Maceió],
      [Sergipe], [Aracaju],
      [Salvador], [Bahia],
      table.hline(),
    )
    #fonte[Brasil.]
  ],
  caption: [Capitais do Nordeste],
)

#lorem(30)

Alínea e subalínea #footnote[
  Não são automáticas. É necessário usar `enum` para alínea e `list` para subalíneas.
  Além disso, deve-se observar as regras de pontuação.
]:

+ item 1;
+ #lorem(20);
+ item 3.
  - subitem 1;
  - #lorem(20);
  - subitem 3.

=== Ferramentas

#lorem(30)

#lorem(50)

$ phi.alt := (1 + sqrt(5)) / 2 $

#lorem(25)

#lorem(10)

#lorem(60)

#lorem(30)

#figure(
  [
    #image("img/ifpi-logo-horizontal.png", width: 50%)
    #fonte[IFPI.]
  ],
  caption: [IFPI],
)

#lorem(20)

=== #lorem(20)

#lorem(100)

#figure(
  [
    ```zig
    const std = @import("std");

    pub fn main() void {
        std.debug.print("Hello world!\n", .{});
    }
    ```
    #fonte[ZIG.]
  ],
  caption: [Hello World, ZIG],
)

#lorem(40)

= Considerações Finais

#lorem(200)

#lorem(180)

#bibliography("refs.bib")

#pos-textual[
  = Agradecimentos

  Obrigado!
]
