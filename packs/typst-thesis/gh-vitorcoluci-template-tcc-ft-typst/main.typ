#import "templateTCC-FT.typ": *

#let vars = (
  autor: [Nome do aluno],
  titulo: [Título do TCC],
  orientador: [Prof. Dr. Nome do orientador],
  local: [Limeira],
  ano: [2025],
  tcc: 2,
  banca: (
    nome1: [Nome do(a) avaliador(a) 1], inst1: [Instituição do(a) avaliador(a) 1],
    nome2: [Nome do(a) avaliador(a) 2], inst2: [Instituição do(a) avaliador(a) 2]
  ),
  listas: (figuras: false, quadros: false, tabelas: false),
  instituicao: [Universidade Estadual de Campinas],
  faculdade: [Faculdade de Tecnologia],
  dedicatoria: [Inclua aqui a dedicatória. #lorem(10)],
  agradecimentos: [
    Inclua aqui os agradecimentos.
  ],
  resumo: [O resumo consiste de uma apresentação concisa dos pontos relevantes do conteúdo e das conclusões do trabalho. Compondo-se de uma sequência corrente de frases e não de uma enumeração de tópicos, não ultrapassando 500 palavras. Não usar parágrafos no meio do resumo, bem como figuras, fórmulas, equações, diagramas e símbolos. Não deve incluir citações.],
  abstract: [O resumo consiste de uma apresentação concisa dos pontos relevantes do conteúdo e das conclusões do trabalho. Compondo-se de uma sequência corrente de frases e não de uma enumeração de tópicos, não ultrapassando 500 palavras. Não usar parágrafos no meio do resumo, bem como figuras, fórmulas, equações, diagramas e símbolos. Não deve incluir citações.]
)

#show: doc => project( ..vars, doc)


Antes de utilizar este modelo, certifique-se de estudar cuidadosamente o #link("https://github.com/jocoteles/GuiaTypst/blob/main/guia/guiaTypst.pdf")[Guia de usos e exemplos do Typst] produzido pelo Prof. João Teles de Carvalho Neto (Ufscar).  


Instruções para instalação do Typst no Linux estão disponíveis #link("https://github.com/typst/typst")[aqui].


= Introdução


A introdução é a parte inicial do texto, na qual devem constar a formulação e delimitação do assunto tratado e problema de pesquisa. Tem por finalidade fornecer ao leitor os antecedentes que justificam o trabalho, assim como enfocar o assunto a ser abordado. A introdução pode incluir informações sobre a natureza e a importância do problema, sua relação com outros estudos sobre o mesmo assunto e suas limitações. Essa seção deve representar a essência do pensamento do autor em relação ao assunto que pretende estudar. Deve ser abrangente sem ser prolongada. Pode ser finalizada com o objetivo geral do trabalho.

= Objetivos

Os objetivos visam a verificação das hipóteses (expectativas) do projeto. É interessante dividir os objetivos em objetivo geral e objetivos específicos.

== Geral

== Específico


= Desenvolvimento teórico

É uma discussão cujo pesquisador oferece ao leitor uma síntese dos conceitos da literatura; expressa sua própria opinião - contrastando-a ou não - com a literatura; estabelece justificativas para o trabalho resumindo apropriadamente começo, meio e fim de sua proposta de estudo.

As referências utilizadas para a elaboração do trabalho (que poderão ser citadas em qualquer seção e não apenas nesta) e as fontes documentais previamente identificadas que serão necessárias à pesquisa devem seguir as normas técnicas (no Brasil as normas mais aceitas são as estabelecidas pela ABNT – Associação Brasileira de Normas Técnicas).

O arquivo `bibliografia.bib` (produzida pelo pelo Prof. André Leon) contém diversos exemplos de referências @Gradvohl2015a que podem ser usadas como modelo.

A @fig_galileu1 é um exemplo de inserção e uso de figuras no Typst seguindo as normas ABNT.

#figure(  
image("figuras/Galileu1.png"),  
  caption: [Exemplo clássico do método científico de Galileu.],
) <fig_galileu1>
#align(center)[Fonte: #cite_indireta(<Gradvohl2015a>)]

= Materiais e métodos (ou Metodologia)

Com relação a Material, esta seção descreve o equipamento/sujeito empregado na pesquisa. Com relação aos Métodos, deve haver a descrição completa, que permita a compreensão e interpretação dos resultados, bem como a reprodução do estudo e sua utilização por outros pesquisadores. Os Métodos devem ser apresentados na sequência cronológica em que o projeto será realizado. Marcas comerciais só deverão ser incluídas quando importantes para a com preensão e avaliação do trabalho.

Cabe esclarecer que se o estudo utilizar coleta de dados com seres humanos ou animais, o trabalho necessitará de aprovação do Comitê de Ética responsável.


= Resultados e discussão

Os resultados e a discussão podem ser apresentados em um único tópico ou em tópicos separados.

- *Resultados*. Apresentação dos resultados obtidos de forma objetiva, exata, clara e lógica deve ser feita nesta seção. Podem-se incluir tabelas, quadros ou figuras em geral (desenhos, gráficos, mapas, esquemas, modelos, fotografias).

- *Discussão*. O autor deve tentar:
  - estabelecer relações entre causa e efeito;
  - deduzir as generalizações e princípios básicos que tenham comprovação nas observações experimentais;
  - fazer comparação dos resultados obtidos com aqueles apresentados na revisão da literatura;
  - esclarecer as exceções, modificações e contradições das hipóteses, teorias e princípios diretamente relacionados com o trabalho realizado;
  - indicar as aplicações teóricas ou práticas dos resultados obtidos, bem como as suas limitações.
  - O autor deve manifestar seu ponto de vista sobre os resultados obtidos e seu alcance. Não se permite a inclusão de dados novos na Discussão.


= Conclusões ou Considerações Finais

Conclusão ou Considerações Finais devem responder a os objetivos do trabalho. Deve ser clara e concisa e referir-se às hipóteses levantadas e discutidas no trabalho. Neste tópico também podem ser sugeridos estudos futuros sobre o mesmo tema do trabalho realizado.


= Referências

#bibliography("bibliografia.bib", title: none, style:"associacao-brasileira-de-normas-tecnicas")


= Anexos e Apêndices

Apêndices são elementos complementares ao projeto e que foram elaborados pelo pesquisador. Aqui entrariam, por exemplo, questionários, formulários de pesquisa de campo ou fotografias.

Anexos, assim como os apêndices, só devem aparecer nos projetos de pesquisa se forem extremamente necessários. São textos de autoria de outra pessoa e não do pesquisador. Por exemplo: mapas, documentos originais, fotografias batidas por outra pessoa que não o pesquisador.