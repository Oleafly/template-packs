// capitulos/03-metodologia.typ — Capítulo 3: Metodologia.
// Recursos do template demonstrados aqui: #diagram (fluxo desenhado com cetz), #quadro
// de ferramentas e #equacao (métrica numerada, referenciada por @rótulo).
// Pode ser aberto sozinho no preview: o #show: capitulo.with(...) aplica o estilo e a numeração.
// Rótulos de outros capítulos aparecem como ‹rótulo› em vermelho; no main.typ, saem certos.
#import "../ifbasaj-tcc/imports.typ": *
#show: capitulo.with(numero: 3)

= Metodologia <cap-metodologia>

#orientacao[
  Cada passo metodológico DEVE se ligar a um objetivo específico da @sec-objetivos-especificos. NÃO DEVE trazer resultados, telas do sistema pronto nem repetir a teoria do
  @cap-referencial.
]

== Natureza da pesquisa <sec-natureza>

#orientacao[Classifique a pesquisa quanto à natureza, à abordagem e aos objetivos, e justifique cada classificação.]

Quanto à natureza, esta pesquisa classifica-se como aplicada, pois ... #cite("wazlawick2014"). #lorem(30)

== Método de desenvolvimento <sec-metodo>

#orientacao[
  Descreva o método usado de fato (ex.: Scrum adaptado, prototipação) e como foi aplicado; NÃO
  DEVE copiar a descrição genérica do livro. Um diagrama das etapas ajuda o leitor.
]

A @fig-etapas resume as etapas do trabalho e o objetivo específico que cada uma atende.

// #diagram envolve cetz.canvas; importe cetz.draw dentro do bloco.
#figura(
  diagram({
    import cetz.draw: *
    let etapa(x, nome, rotulo) = {
      rect((x, 0), (x + 2.6, 1.2), name: nome, radius: 0.1)
      content(nome, align(center, text(size: 9pt, rotulo)))
    }
    etapa(0, "req", [Levantamento\ de requisitos])
    etapa(3.4, "mod", [Modelagem])
    etapa(6.8, "imp", [Implementação\ iterativa])
    etapa(10.2, "ava", [Avaliação])
    line("req.east", "mod.west", mark: (end: ">"))
    line("mod.east", "imp.west", mark: (end: ">"))
    line("imp.east", "ava.west", mark: (end: ">"))
  }),
  caption: [Etapas metodológicas do trabalho],
) <fig-etapas>

#lorem(40)

== Levantamento de requisitos <sec-levantamento>

#orientacao[
  Diga como os requisitos foram levantados: com quem e com quais técnicas (entrevista,
  questionário, observação). A lista de requisitos fica na @sec-requisitos.
  Instrumentos próprios (roteiros, questionários) vão para o Apêndice.
]

Os requisitos foram levantados por meio de entrevistas semiestruturadas com ..., conforme o roteiro do Apêndice A. #lorem(30)

== Tecnologias e ferramentas <sec-ferramentas>

#orientacao[Justifique a escolha de cada tecnologia e ferramenta. A teoria sobre elas fica na @sec-tecnologias.]

#quadro(
  columns: (auto, 1fr),
  align: (left, left),
  (
    [*Ferramenta*], [*Justificativa da escolha*],
    [Typst], [Composição do texto do TCC com o template ABNT do curso #cite("typstdocs").],
    [Linguagem X], [...],
    [Banco de dados Y], [...],
  ),
  caption: [Tecnologias e ferramentas utilizadas],
) <qua-ferramentas>

== Procedimentos de avaliação <sec-avaliacao>

#orientacao[
  Defina como o software será avaliado: métricas, critérios, participantes e instrumentos. O @cap-resultados segue exatamente este plano. Métricas com fórmula entram como
  equação numerada e são referenciadas pelo rótulo.
]

A usabilidade será medida com o questionário #abbrev("sus", long: "System Usability Scale") #cite("brooke1996", "lewis2018"). A pontuação de cada participante é dada pela @eq-sus, em que $x_i$ é a resposta ao item $i$ (de 1 a 5).

// #equacao: numerada à direita; referencie pelo rótulo (@eq-...).
#equacao[$ "SUS" = 2,5 dot (sum_(i in {1,3,5,7,9}) (x_i - 1) + sum_(i in {2,4,6,8,10}) (5 - x_i)) $] <eq-sus>

O tempo médio de resposta, usado na avaliação de desempenho, é calculado pela @eq-media.

#equacao[$ overline(t) = 1/n sum_(k=1)^n t_k $] <eq-media>
