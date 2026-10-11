#import "template-abnt/lib.typ": template_ABNT
#import "template-abnt/_config.typ": *
#import "config-textual/import.typ": *


// PREENCHER O ESCOPO PRE-TEXTUAL (template_ABNT)
#show: template_ABNT.with(
  titulo: "Titulo do Trabalho",   
  autor: "Lucas Felix Soares",
  orientador: "Prof. Me. Fulano de Tal",
  coorientador: "Prof. Dr. Cicrano de Tal",  // del. caso não tenha
  faculdade: "Instituto Federal de Educação, Ciência e Tecnologia da Paraíba",
  campus: "Cajazeiras",
  graduacao: "Bacharelado em Engenharia de Controle e Automação",
  cidade: "Cajazeiras-PB",
  ano: "2025",


  data_de_aprovacao_banca: "01 de janeiro de 2025",
  jury: (
    (
      name: "Fulano de Tal",
      title: [Prof. Me.],
      affiliation: [IFPB - _Campus_ Cajazeiras],
      role: [Orientador],
      email: "fulano.nome@email.com"
    ),
    
    (
      name: "Cicrano de Tal",
      title: [Prof. Dr.],
      affiliation: [UFPB - _Campus_ João Pessoa],
      role: [Coorientador],
      email: "cicrano.nome@email.com"
    ),

    (
      name: "Jubileu de Tal",
      title: [Prof. Dr.],
      affiliation: [UFCG - _Campus_ Pombal],
      role: [Examinador],
      email: "jubileu.nome@email.com"
    ),
  )
)

#show "al.": it => [#text("al.", style: "italic")]

#pagebreak()
#include("Introduction.typ")
