// capitulos/04-desenvolvimento.typ — Capítulo 4: Desenvolvimento do software.
// Recursos do template demonstrados aqui: #quadro de requisitos, diagrama cetz importado de
// assets/, imagem SVG gerada pelo PlantUML, diagrama de classes gerado do código-fonte
// (sourcecraft), #codigo com arquivo externo e nome de arquivo, #algoritmo e código inline.
// Pode ser aberto sozinho no preview: o #show: capitulo.with(...) aplica o estilo e a numeração.
// Rótulos de outros capítulos aparecem como ‹rótulo› em vermelho; no main.typ, saem certos.
#import "../ifbasaj-tcc/imports.typ": *
#show: capitulo.with(numero: 4)
#import "../assets/diagramas/arquitetura.typ": arquitetura
#import "@preview/sourcecraft:0.1.0": source-diagram

= Desenvolvimento (do software) <cap-desenvolvimento>

#orientacao[
  Descreva o que foi feito, com decisões técnicas justificadas. Listagens longas de
  código vão para o Apêndice. Toda figura DEVE ter fonte e ser citada no texto.
  O que o texto afirma que foi implementado DEVE existir no repositório.
]

== Requisitos <sec-requisitos>

#orientacao[Liste os requisitos funcionais e não funcionais que saíram do levantamento da @sec-levantamento.]

O @qua-requisitos apresenta os requisitos funcionais (RF) e não funcionais (RNF) do sistema.

#quadro(
  columns: (auto, 1fr, auto),
  align: (center, left, center),
  (
    [*ID*], [*Descrição*], [*Prioridade*],
    [RF01], [O sistema deve permitir que o usuário se cadastre.], [Alta],
    [RF02], [O sistema deve ...], [Média],
    [RNF01], [O tempo de resposta das consultas deve ser inferior a 2 s.], [Alta],
  ),
  caption: [Requisitos do sistema],
) <qua-requisitos>

== Arquitetura <sec-arquitetura>

#orientacao[Apresente a arquitetura com diagrama e explique cada parte.]

A @fig-arquitetura mostra a arquitetura do sistema. O diagrama foi desenhado em cetz, no arquivo `assets/diagramas/arquitetura.typ`, e importado neste capítulo.

#figura(arquitetura, caption: [Arquitetura do sistema]) <fig-arquitetura>

#lorem(40)

== Modelagem <sec-modelagem>

#orientacao[Traga a modelagem (casos de uso, classes, dados) coerente com os requisitos.]

Diagramas feitos em ferramentas externas entram como imagem. A @fig-uml foi gerada pelo PlantUML a partir de `assets/diagramas/diagramauml.puml` (exporte em SVG para manter a nitidez).

#figura(
  image("../assets/diagramas/diagramauml.svg", width: 70%),
  caption: [Diagrama UML gerado pelo PlantUML],
) <fig-uml>

O diagrama de classes da @fig-classes é gerado diretamente do código-fonte com o pacote `sourcecraft`: se o código mudar, o diagrama acompanha.

#figura(
  source-diagram(
    (
      read("../assets/codigos/Estoque.java"),
      read("../assets/codigos/Produto.java"),
    ).join("\n\n"),
    grammar: "java",
    max-height: 8cm,
  ),
  caption: [Diagrama de classes de Produto e Estoque],
) <fig-classes>

== Implementação <sec-implementacao>

#orientacao[
  Mostre só os trechos que sustentam uma decisão técnica e comente-os. Nomes de arquivos,
  classes e comandos no meio do texto vão como código inline, entre crases: `server.js`.
]

O @cod-servidor mostra o ponto de entrada da API, definido no arquivo `server.js`.

#codigo(
  lang: "javascript",
  caption: [Servidor Express da API],
  filename: "server.js",
  read("../assets/codigos/server.js"),
) <cod-servidor>

A busca de produtos segue o @alg-busca. Algoritmos em pseudocódigo ficam em arquivos `.alg`, e as palavras-chave (_se_, _então_, _para cada_, _retorne_) saem em negrito.

#algoritmo(
  read("../assets/algoritmos/busca.alg"),
  caption: [Busca linear],
) <alg-busca>

== Testes <sec-testes>

#orientacao[Descreva os testes realizados e o que cobrem: unidade, integração, aceitação.]

#lorem(60)
