#import "ifes-ciencia.typ": ifes-ciencia, author, affiliation, referencias

#show: ifes-ciencia.with(
  mode: "submission",
  language: "pt",

  title-pt: [
    Título do artigo
  ],

  title-en: [
    Article title
  ],

  graphical-abstract: rect(
    width: 80%,
    height: 3cm,
    stroke: 0.6pt,
  )[
    #align(center + horizon)[
      Substitua este retângulo pelo Graphical Abstract.
    ]
  ],

  authors: (
    author(
      name: "Nome do Autor",
      affiliations: (1,),
      email: "autor@example.org",
      orcid: "0000-0000-0000-0000",
      corresponding: true,
    ),
  ),

  affiliations: (
    affiliation(
      id: 1,
      institution: "Coordenadoria ou Departamento, Instituição por extenso",
      city: "Cidade",
      state: "UF",
    ),
  ),

  abstract-pt: [
    Escreva aqui o resumo em português, em um único parágrafo.
  ],

  keywords-pt: (
    "palavra-chave um",
    "palavra-chave dois",
    "palavra-chave três",
  ),

  abstract-en: [
    Write the English abstract here.
  ],

  keywords-en: (
    "keyword one",
    "keyword two",
    "keyword three",
  ),

  volume: none,
  issue: none,
  year: none,
  pages: none,
  doi: none,

  // Filled by the editorial workflow in the final version, when applicable.
  submitted: none,
  accepted: none,
  published: none,
)

= Introdução

Escreva aqui a introdução do artigo. O texto principal é disposto
automaticamente em duas colunas, com espaçamento de 1,25 cm entre elas.

== Subseção de exemplo

O corpo do artigo usa fonte de 12 pt, texto justificado, recuo de 1,25 cm
na primeira linha e 6 pt depois de cada parágrafo. Uma citação autor-data
pode ser escrita diretamente com a sintaxe nativa do Typst, por exemplo
@exemplo2026.

=== Subseção de terceiro nível

Continue o artigo normalmente usando a sintaxe de seções do Typst.

#referencias("references-template.bib")
