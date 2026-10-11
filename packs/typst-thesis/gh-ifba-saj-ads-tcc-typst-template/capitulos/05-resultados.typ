// capitulos/05-resultados.typ — Capítulo 5: Resultados e avaliação.
// Recursos do template demonstrados aqui: #tabela lendo CSV, #tabela com células mescladas
// (rowspan/colspan), gráficos cetz-plot (pizza e barras) importados de assets/, e fonte
// personalizada / fonte removida (source:).
// Pode ser aberto sozinho no preview: o #show: capitulo.with(...) aplica o estilo e a numeração.
// Rótulos de outros capítulos aparecem como ‹rótulo› em vermelho; no main.typ, saem certos.
#import "../ifbasaj-tcc/imports.typ": *
#show: capitulo.with(numero: 5)
#import "../assets/graficos/pizza.typ": pizza
#import "../assets/graficos/barras.typ": barras

= Resultados e avaliação <cap-resultados>

#orientacao[
  DEVE aplicar a avaliação planejada na @sec-avaliacao, com evidências: métricas, dados, testes,
  telas; discutir os resultados à luz do referencial e dos trabalhos relacionados;
  dizer se a hipótese da @sec-hipotese se sustentou e declarar as limitações.
  NÃO DEVE apresentar conceito teórico novo, mudar o método nem afirmar algo sem evidência.
]

== Desempenho

A @tab-desempenho resume o tempo de resposta e o uso de CPU medidos em cada módulo. Os dados vêm de `data/resultados.csv`: atualize o CSV e a tabela acompanha.

// Tabela (padrão IBGE): sem bordas laterais, topo e base fechados, cabeçalho em negrito.
#tabela(
  caption: [Tempo de resposta e uso de CPU por módulo],
  columns: (1.5fr, 2fr, 1.5fr),
  align: (left, center, center),
  width: 80%,
  header: ([Módulo], [Tempo de resposta (ms)], [Uso de CPU (%)]),
  ..csv("../data/resultados.csv"),
) <tab-desempenho>

Quando células precisam ser mescladas, escreva a tabela à mão com `table.cell`, como na @tab-comparacao.

#tabela(
  caption: [Tempo de resposta antes e depois da otimização],
  columns: (1.5fr, 1fr, 1fr),
  align: (left, center, center),
  header: ([Módulo], [Antes (ms)], [Depois (ms)]),
  [Autenticação], table.cell(rowspan: 2, align: center + horizon)[120], [45],
  [Busca], [80],
  [Relatórios], [3500], [350],
  [Notificações], table.cell(colspan: 2)[sem alteração: 60],
  source: [Dados da pesquisa (2026)],
) <tab-comparacao>

#lorem(40)

== Avaliação com usuários

Gráficos feitos com cetz-plot ficam em `assets/graficos/` e são importados como figuras, como a @fig-pizza e a @fig-barras.

#figura(pizza, caption: [Linguagens usadas pelos participantes]) <fig-pizza>

#lorem(30)

#figura(barras, caption: [Número de participantes por ano]) <fig-barras>

== Discussão

#orientacao[Compare os resultados com os trabalhos da @sec-trabalhos-relacionados e responda à hipótese da @sec-hipotese.]

#lorem(60)

== Limitações

#lorem(30)
