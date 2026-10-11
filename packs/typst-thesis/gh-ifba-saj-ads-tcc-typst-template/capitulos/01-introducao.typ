// capitulos/01-introducao.typ — Capítulo 1: Introdução.
// Recursos do template demonstrados aqui: #abbrev (siglas), #gloss (glossário),
// #cite e #prose (citações indiretas), nota de rodapé, #figura com fonte de terceiros,
// referência cruzada com @rótulo e lista não numerada.
// Pode ser aberto sozinho no preview: o #show: capitulo.with(...) aplica o estilo e a numeração.
// Rótulos de outros capítulos aparecem como ‹rótulo› em vermelho; no main.typ, saem certos.
#import "../ifbasaj-tcc/imports.typ": *
#show: capitulo.with(numero: 1)

= Introdução <cap-introducao>

== Contextualização <sec-contextualizacao>

#orientacao[
  DEVE situar o tema e o cenário real em que o problema aparece, sempre com fontes.
  NÃO DEVE apresentar a solução, a ferramenta ou a tecnologia do trabalho — a proposta só aparece
  na @sec-hipotese. NÃO DEVE adiantar resultados nem trazer citação longa.
]

// Sigla: a 1ª ocorrência exige `long:` e escreve "Nome por extenso (SIGLA)";
// as seguintes escrevem só a sigla. A Lista de abreviaturas e siglas é gerada sozinha.
O #abbrev("ifba", long: "Instituto Federal de Educação, Ciência e Tecnologia da Bahia") oferece, no campus Santo Antônio de Jesus, o curso de #abbrev("ads", long: "Análise e Desenvolvimento de Sistemas"). Nas demais menções, basta escrever #abbrev("ifba") ou #abbrev("ads").

// Glossário: o termo aparece normal no texto e a definição vai para o Glossário, no fim.
Descreva o cenário em que o problema ocorre. Termos técnicos que o leitor pode não conhecer, como #gloss("deploy")[Implantação de uma versão do software em um ambiente de execução.], podem ser definidos no glossário. Toda afirmação sobre o cenário precisa de fonte #cite("sommerville2011")#footnote[Notas de rodapé servem para explicações curtas que interromperiam o texto. Use com moderação.].

#figura(
  image("../assets/imagens/logo.svg", width: 40%),
  caption: [Exemplo de figura com fonte de terceiros],
  source: [Adaptado de #prose("typstdocs")],
) <fig-exemplo-contexto>

Toda figura precisa ser citada no texto antes ou logo depois de aparecer, como na @fig-exemplo-contexto. #lorem(40)

== Problema de pesquisa <sec-problema>

#orientacao[
  DEVE formular o problema de forma explícita, de preferência como pergunta, e dizer o que fica
  fora do escopo. NÃO DEVE ser uma solução disfarçada, como "o problema é que não existe
  o sistema X".
]

Diante do cenário descrito, este trabalho investiga a seguinte questão: _como ...?_ #lorem(30)

Fica fora do escopo deste trabalho ...

== Hipótese <sec-hipotese>

#orientacao[
  DEVE ficar exatamente aqui: depois do problema e antes dos objetivos. É o único lugar
  do capítulo em que a proposta de solução aparece. DEVE ser testável: o Capítulo 5 precisa
  conseguir dizer se ela se sustentou.
]

Parte-se do pressuposto de que ... #lorem(30)

== Objetivo geral <sec-objetivo-geral>

#orientacao[
  Uma frase, com um único verbo no infinitivo, que responde ao problema da @sec-problema.
  NÃO DEVE ser um passo de método, como "fazer revisão bibliográfica".
]

Desenvolver ... para ...

== Objetivos específicos <sec-objetivos-especificos>

#orientacao[
  Lista NÃO numerada, com marcador `-`, de 3 a 5 itens, cada um com um verbo no
  infinitivo e verificável nas Considerações finais. Evite verbos vagos: conhecer,
  entender, compreender, estudar.
]

- Levantar ...;
- Modelar ...;
- Implementar ...;
- Avaliar ....

== Justificativa <sec-justificativa>

#orientacao[
  DEVE explicar por que o problema importa, com evidências: dados, fontes, contexto.
  NÃO DEVE se basear só em opinião nem repetir a contextualização.
]

#lorem(60)

== Organização do trabalho <sec-organizacao>

#orientacao[
  Escreva por último, quando todos os capítulos existirem. Um parágrafo curto por capítulo. Use referências cruzadas: se um título mudar, o número se atualiza sozinho.
]

O @cap-referencial apresenta ... O @cap-metodologia descreve ... O @cap-desenvolvimento detalha ... O @cap-resultados discute ... Por fim, o @cap-consideracoes retoma os objetivos e aponta trabalhos futuros.
