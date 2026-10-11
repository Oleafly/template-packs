#import "first_page.typ": first_page
#import "summary.typ": summary_page
#import "acknowledgements.typ": acknowledgements_page
#import "contents/content.typ": document
#import "config.typ": apply_config

// Apply the document configuration
// using a show block, otherwise
// it will only apply to the function block
#show: apply_config

#first_page(
  title: "Typst template for FEUP project",
  subtitle: "Subtitle goes here",
  authors: (
    (name: "Author 1", email: "author1@up.pt"),
    (name: "Author 2", email: "author2@up.pt"),
    (name: "Author 3", email: "author3@up.pt"),
  )
)

// Set page numbering for preliminary pages
// These will use roman numbers. After this,
// arabic numbering will be used for the rest
// if the document.
#set page(
    numbering: "i",
    number-align: center,
  )
#counter(page).update(1)

#summary_page(
  keywords: ("Palavra1", "Palavra2", "Palavra3", "Palavra4")
)[
  O resumo tem um caráter essencialmente informativo, devendo ser escrito
  de forma concisa (até 200 palavras) de maneira a captar o interesse de
  quem o vai ler.

  O Resumo substitui a leitura do documento e não contém figuras, tabelas,
  citações, etc. Deve incluir os seguintes tópicos: âmbito, objetivos, os
  métodos, as principais descobertas, incluindo resultados, conclusões e
  recomendações, se existirem.
]

#acknowledgements_page[
  Elemento opcional. Habitualmente é mencionada a contribuição de outras
  pessoas ou entidades, tanto para a realização do estudo como para a
  produção do relatório. Podem fazer-se numa página autónoma ou incluir-se
  na introdução. 
]

// Table of contents
#heading(level: 1, numbering: none, outlined: false)[
  #text(size: 1.5em, weight: "bold")[Índice]
]
#v(5em)

#outline(
  title: none,
  indent: auto,
)

// From here on out, use arabic page numbering
// (reset the page counter)
#set page(
    numbering: "1",
    number-align: center,
  )
#counter(page).update(1)

// Main document
#document()