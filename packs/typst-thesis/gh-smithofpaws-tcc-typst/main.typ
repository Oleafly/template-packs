#import "unipampa.typ": unipampa, citacao_longa, titulo_sem_numeracao

// Preencha todos os dados pré-textuais aqui
#show: doc => unipampa(
  titulo: "TÍTULO DO TRABALHO",
  subtitulo: "SUBTÍTULO (se houver)",
  autor: "NOME DO AUTOR",
  curso: "CURSO DE (NOME DO CURSO)",
  orientador: "Prof. Dr. Nome do Orientador",
  coorientador: "Prof. Dr. Nome do Coorientador", // Opcional
  local: "Cidade",
  ano: "Ano",
  natureza: "Trabalho de Conclusão de Curso apresentado ao Curso de (Nome do Curso) da Universidade Federal do Pampa, como requisito parcial para obtenção do Título de Bacharel em (Área do curso).",
  area_concentracao: "Nome da Área",
  data_defesa: "dia, mês e ano",
  
  // Membros da banca além do orientador (o orientador já entra automaticamente na primeira linha da banca)
  banca: (
    (nome: "Prof. (titulação). (Nome do Orientador) - Orientador", instituicao: "(sigla da instituição)"),
    (nome: "Prof. (titulação). (Nome do membro da banca)", instituicao: "(sigla da instituição)"),
    (nome: "Prof. (titulação). (Nome do membro da banca)", instituicao: "(sigla da instituição)"),
  ),

  // Elementos pré-textuais opcionais (coloque `none` para omitir a página)
  dedicatoria: [
    Dedico este trabalho ...... (a dedicatória é opcional).
  ],
  
  agradecimento: [
    Ao Prof. Dr. ..... \
    Aos professores... \
    A todos os colegas de curso ... \
    (O agradecimento é opcional)
  ],

  epigrafe: "As grandes ideias surgem da observação dos pequenos detalhes.",
  epigrafe_autor: "Augusto Cury (A epígrafe é opcional)",

  // Resumos
  resumo: [
    Apresentar, de forma resumida os pontos relevantes do texto, ou seja, os elementos de maior interesse e importância, as principais ideias do autor. Este resumo deve conter apenas um parágrafo de 150 a 500 palavras.
  ],
  palavras_chave: ("palavra 1", "palavra 2", "palavra 3"),

  abstract: [
    Consiste na versão do resumo para outra língua (em inglês: Abstract, em espanhol: Resumen, em francês: Résumé, por exemplo).
  ],
  keywords: ("word 1", "word 2", "word 3"),

  lista_abreviaturas: (
    ("cap.", "capítulo"),
    ("ed.", "edição"),
    ("p.", "página"),
    ("vol.", "volume"),
  ),

  lista_siglas: (
    ("ABNT", "Associação Brasileira de Normas Técnicas"),
    ("IBGE", "Instituto Brasileiro de Geografia e Estatística"),
    ("UNIPAMPA", "Universidade Federal do Pampa"),
  ),

  doc
)

// Listas de Figuras, Tabelas, Abreviaturas e Siglas devem ser inseridas manualmente antes da introdução se existirem.
// Exemplo:
// #titulo_sem_numeracao("LISTA DE FIGURAS")
// Figura 1 - Fotografia da sala de aula ...................... 11
// #pagebreak()


= INTRODUÇÃO

Na introdução do trabalho deve constar a definição do tema em linhas gerais, a delimitação do assunto estudado, o estabelecimento dos objetivos gerais e específicos, a apresentação da justificativa para a escolha do tema, a apresentação da metodologia e a indicação da organização do trabalho, ou seja, das partes que o compõem.

Para normatização dos trabalhos acadêmicos da UNIPAMPA, fica definido que, quanto ao tipo de fonte, deverá ser utilizada a fonte Arial ou Times New Roman, onde todo o trabalho deverá ser apresentado sempre com a mesma fonte escolhida, no tamanho 12 e 10 para citações longas (mais de três linhas), notas, fontes das ilustrações e das tabelas, paginação, ficha catalográfica, legendas e outras notas.

As margens devem ser 3cm (superior e esquerda) e 2cm (inferior e direita) no anverso das folhas. O texto do trabalho deve ser digitado com espaço entre as linhas de 1,5 (um e meio). 

= CONCEITOS GERAIS E REVISÃO DE LITERATURA

O desenvolvimento do trabalho é a revisão de literatura ou referencial teórico, sendo a parte mais importante do trabalho, por isso exige-se organização, objetividade e clareza. 

== Revisão de literatura

Na revisão de literatura deve-se ler o que já foi publicado sobre o assunto, refere-se ao levantamento do tema pesquisado. 

Uma citação indireta pode ser inserida mencionando a obra de forma fluida no texto, como por exemplo os conceitos abordados por #cite(<bailona2006>, form: "prose"). E, quando o autor não faz parte da sentença, a citação aparece entre parênteses no final da ideia @alves2000.

Quando for utilizar uma cópia literal do texto, a mesma deve seguir as regras para citações. Nas citações deve sempre aparecer o autor (Sobrenome), o ano, e, se houver, o número da página. Para citações com mais de três linhas, estas devem ser recuadas:

#citacao_longa[
  O ego é a mente consciente. Ele é constituído por percepções, memórias, pensamentos e sentimentos conscientes. O ego é responsável pelos nossos sentimentos de identidade e de continuidade, e, do ponto de vista da pessoa, considera-se que esteja no centro da consciência (Hall; Lindsey; Campbell, 2000, p. 88).
]

As citações são menções de informações retiradas de outras fontes, e servem para dar embasamento teórico.

=== Subseção nível 3 (Exemplo)

Pode ser dividida de acordo com a abordagem.

Abaixo temos um exemplo de como inserir uma figura no Typst. A inserção de figuras com legenda fará com que a *Lista de Figuras* seja gerada automaticamente nos elementos pré-textuais.

#figure(
  rect(width: 50%, height: 3cm, fill: rgb("eee"))[Figura de Exemplo],
  caption: [Modelo de ilustrações],
)

Abaixo temos um exemplo de como inserir uma tabela. Como ela está dentro de um bloco `#figure` e foi informada como `kind: table`, a *Lista de Tabelas* também será gerada de forma automática!

#figure(
  table(
    columns: (auto, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header(
      [*Situação do domicílio*], [*Mulheres*], [*Homens*]
    ),
    [Urbana], [41 115 439], [38 857 492],
    [Rural], [18 479 893], [19 507 477],
  ),
  caption: [Pessoas residentes em domicílios particulares],
  kind: table
)

= METODOLOGIA

Neste capítulo será apresentado o tipo de pesquisa realizado e os métodos e procedimentos adotados para o desenvolvimento do trabalho. Na metodologia é realizada uma descrição minuciosa e rigorosa do objeto de estudo e das técnicas utilizadas nas atividades de pesquisa.

= APRESENTAÇÃO DA PESQUISA E ANÁLISE DOS RESULTADOS

Esta é a parte central do trabalho, onde será apresentada a pesquisa realizada e a análise e interpretação dos dados e informações obtidos. O uso de gráficos, tabelas e quadros enriquece o trabalho, fornecendo apoio visual ao que está sendo apresentado.

= CONSIDERAÇÕES FINAIS

A conclusão ou considerações finais é a parte final do texto, o fechamento do trabalho, onde se apresentam de forma clara, sintética e ordenada as deduções tiradas da discussão, e se os objetivos foram ou não alcançados.


// Remove a numeração para as seções pós-textuais
#set heading(numbering: none)

// As referências são geradas automaticamente baseadas no arquivo referencias.bib
// A opção de estilo aplica a formatação da ABNT via o arquivo CSL da Unipampa (NBR 6023:2025).
#set par(leading: 0.4em, first-line-indent: 0pt, spacing: 1.5em)
#bibliography("referencias.bib", style: "abnt-unipampa-nbr6023-2025.csl", title: "REFERÊNCIAS")

= APÊNDICES

Elemento opcional. Colocado após o glossário e constituído de informações elaboradas pelo autor do trabalho, não incluídas no texto. 

= ANEXOS

Elemento opcional. Colocado após os apêndices e constituído de informações não elaboradas pelo autor do trabalho, que serve de fundamentação, comprovação e ilustração.
