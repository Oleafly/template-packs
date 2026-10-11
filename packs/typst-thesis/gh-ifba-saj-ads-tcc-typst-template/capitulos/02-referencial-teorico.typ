// capitulos/02-referencial-teorico.typ — Capítulo 2: Referencial teórico.
// Recursos do template demonstrados aqui: todas as formas de citação da NBR 10520:2023
// (#cite, #prose, @chave, localizador, múltiplas fontes, #citacao-curta, #citacao-longa)
// e #quadro (comparativo de trabalhos relacionados, com colunas definidas).
// Pode ser aberto sozinho no preview: o #show: capitulo.with(...) aplica o estilo e a numeração.
// Rótulos de outros capítulos aparecem como ‹rótulo› em vermelho; no main.typ, saem certos.
#import "../ifbasaj-tcc/imports.typ": *
#show: capitulo.with(numero: 2)

= Referencial teórico <cap-referencial>

#orientacao[
  Cada seção DEVE se ligar a um objetivo específico ou a uma decisão do trabalho, com
  fontes acadêmicas e atuais que dialoguem entre si. NÃO DEVE descrever o sistema do
  aluno nem trazer resultados, nem ser "colcha de retalhos", um parágrafo por autor. Os títulos das seções podem ser adaptados ao tema.
]

== Conceitos da área do problema <sec-conceitos>

#orientacao[Conceitos da área do problema indispensáveis para entender o restante do texto.]

// Citação indireta parentética: autor e ano entre parênteses, ao fim da frase.
A engenharia de software reúne práticas para produzir software de qualidade com custo previsível #cite("sommerville2011").

// Citação indireta narrativa: o autor entra no fluxo do texto.
Segundo #prose("wazlawick2014"), a pesquisa em computação deve deixar claro qual problema resolve e como a solução será avaliada.

// Com localizador (página): vale para as duas formas.
Funções pequenas facilitam a leitura do código #cite("martin2008", supplement: [p. 34]). Na forma narrativa, #prose("martin2008", supplement: [p. 34]) defende o mesmo ponto.

// Atalho: @chave do .bib funciona como #cite("chave").
Essa visão é compartilhada por outros autores @newman2021.

// Múltiplas fontes: separadas por ponto e vírgula, na ordem alfabética.
Há convergência na literatura sobre a importância da modularidade #cite("martin2008", "newman2021", "sommerville2011").

== Tecnologias utilizadas <sec-tecnologias>

#orientacao[
  Explique por que cada tecnologia importa para o problema; NÃO DEVE virar tutorial nem manual de
  instalação. NÃO DEVE usar blog ou documentação de fornecedor como única base de conceito
  central. A justificativa da escolha fica na @sec-ferramentas (Metodologia).
]

// Citação direta curta (até 3 linhas): entre aspas, com página.
Para #prose("newman2021", supplement: [p. 2]), microsserviços são #citacao-curta[trecho transcrito literalmente da obra, com até três linhas]. Se a obra for estrangeira e você traduzir o trecho, acrescente "tradução nossa" no localizador.

// Citação direta longa (4 linhas ou mais): recuo de 4 cm, fonte 10, sem aspas.
#citacao-longa(autor: "Martin", ano: "2009", pagina: "11")[
  Texto transcrito literalmente da obra, com quatro linhas ou mais. Use este formato apenas quando
  a formulação exata do autor for indispensável; na maior parte do referencial, prefira citações
  indiretas, que mostram que você compreendeu e sintetizou a fonte. #lorem(20)
]

#lorem(40)

== Engenharia de software <sec-engenharia>

#orientacao[Conceitos de engenharia de software que o trabalho aplica: processo, requisitos, arquitetura, testes.]

#lorem(60)

== Trabalhos relacionados <sec-trabalhos-relacionados>

#orientacao[
  DEVE comparar os trabalhos com critérios explícitos, de preferência num quadro, e fechar
  mostrando a lacuna que este TCC ocupa. NÃO DEVE só listar trabalhos.
  Quadro (bordas fechadas) é para conteúdo textual; Tabela (bordas abertas) é para dados numéricos.
]

O @qua-trabalhos-relacionados compara os trabalhos analisados segundo os critérios ...

#quadro(
  columns: (1.3fr, 1fr, 1fr, 1fr),
  align: (left, center, center, center),
  (
    [*Critério*], [*Trabalho A*], [*Trabalho B*], [*Este trabalho*],
    [Plataforma], [Web], [Mobile], [Web e mobile],
    [Código aberto], [Não], [Sim], [Sim],
    [Avaliação com usuários], [Não], [Parcial], [Sim],
  ),
  caption: [Comparativo entre os trabalhos relacionados],
) <qua-trabalhos-relacionados>

Como se observa, nenhum dos trabalhos analisados ... — essa é a lacuna que este trabalho ocupa.
