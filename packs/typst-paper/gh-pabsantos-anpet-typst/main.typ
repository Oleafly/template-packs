#import "anpet-typst.typ": anpet-typst

#show: anpet-typst.with(
  authors: (
    (
      name: "Pedro Augusto Borges",
      department: "Pesquisa, Desenvolvimento & Inovação",
      affiliation: "Observatório Nacional de Segurança Viária",
      email: "pedro.borges@onsv.org.br",
      address: "Rua, 123, Centro, Curitiba, PR, Brasil"
    ),
    (
      name: "John Doe",
      department: "XYZ Department",
      affiliation: "ABC University",
      email: "foo@bar",
      address: "Rua, 456, Centro, Curitiba, PR, Brasil"
    )
  ),
  title: "TEMPLATE EM TYPST PARA O CONGRESSO DA ANPET",
  agradecimentos: "Agradeço ao ONSV pelo financiamento dessa pesquisa.",
  bibliography: bibliography(
    "refs.bib",
    title: text(10pt, [REFERENCIAS BIBLIOGRÁFICAS]),
    style: "apa"
  ),
)

= TEXTO

#lorem(50)

#lorem(50) @santosEstabelecimentoMetasReducao2022

== Heading 2

#lorem(50) @santosRoadtrafficdeathsRoadTraffic2023

=== Heading 3

#lorem(50)

= TABELAS

A @tbl-test inclui a tabela no formato requerido pelo congresso.

#figure(
  table(
    columns: 3,
    table.header([a], [b], [c]),
    [1], [2], [3],
    [4], [5], [6],
    [7], [8], [9],
    table.hline()
  ),
  caption: [Tabela formatada]
) <tbl-test> 

= FIGURAS

A @fig-test inclui uma figura apresentada no formato do congresso.

#figure(
  image("fig/taz_dist.png"),
  caption: [Inserção de figuras]
) <fig-test> 

= EQUAÇÕES

A @eq-test apresenta uma equação no formato requerido.

$ R = c_1 G + c_2 G V + c_a A V^2 + 10 G i $ <eq-test> 

#block(
  [
    #show par: set block(spacing: 0.65em)
    em que: $R$: resistência total [N];

    #h(1.5cm) $c_1$: constante;

    #h(1.5cm) $G$: peso bruto total combinado [kN];

    #h(1.5cm) $c_2$: constante;

    #h(1.5cm) $V$: velocidade [km/h];

    #h(1.5cm) $c_a$: constante de penetração aerodinâmica;

    #h(1.5cm) $A$: seção transversal do veículo [$m^2$]; e

    #h(1.5cm) $i$: declividade da rampa [m/100 m].
  ]
)

#lorem(25)

