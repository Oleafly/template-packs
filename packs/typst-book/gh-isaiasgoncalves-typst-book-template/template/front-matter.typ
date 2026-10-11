// ============================================================
//  template/front-matter.typ — Páginas de pré-texto
// ============================================================
//
//  Funções de layout para as páginas que antecedem os capítulos.
//  Os metadados do livro são lidos automaticamente de config.typ.
//  Os dados da ficha catalográfica vêm de catalog.typ e são
//  passados como argumento para `ficha-catalografica(ficha)`.
// ============================================================

#import "../metadata/config.typ": ano-edição, autor-livro, edição, subtítulo, titulo-livro


// ─── Folha de rosto ──────────────────────────────────────────
// Página de título clássica: título, subtítulo, autor e ano.
// Lê automaticamente as variáveis definidas em config.typ.
// Não exibe cabeçalho nem rodapé (controlado pelo estado
// `em-frontmatter` em config.typ).
//
// Uso em main.typ:  #pagina-titulo()
//
#let pagina-titulo() = {
  // O estado em-frontmatter já começa como `true` — sem ação necessária.
  // pagebreak(to: "odd")

  // Distribuição vertical clássica
  v(2fr)

  align(center)[
    #text(size: 36pt, weight: "medium")[#smallcaps[#titulo-livro]]

    #if subtítulo != none and subtítulo != "" [
      #v(0.6em)
      #text(size: 15pt, style: "italic")[#subtítulo]
    ]
  ]

  v(3fr)

  align(center)[
    #text(size: 14pt)[#autor-livro]
  ]

  v(1fr)

  align(center)[
    #text(size: 10pt)[
      #edição #h(1.5em) · #h(1.5em) #ano-edição
    ]

    #image(
      "figures/black_trans.png",
      width: 25%,
    )
  ]


  v(0.2fr)
}


// ─── Ficha catalográfica ─────────────────────────────────────
// Página de verso da folha de rosto com dados de catalogação.
// Segue o formato CIP (Catalogação na Publicação) / ISBD.
//
// Parâmetros:
//   ficha — dicionário definido em catalog.typ
//
// Uso em main.typ:
//   #import "catalog.typ": ficha
//   #ficha-catalografica(ficha)

#let ficha-catalografica(ficha) = {
  pagebreak() // sempre verso da folha de rosto (página par)

  v(1fr)

  // Caixa principal da ficha
  block(
    width: 100%,
    stroke: 0.4pt + black,
    inset: (x: 10pt, y: 10pt),
  )[
    #set text(size: 9pt)
    #set par(justify: false, leading: 1.4em)

    // Entrada principal (ISBD)
    #text(weight: "bold")[#upper(ficha.sobrenome-autor), #ficha.prenome-autor]
    #linebreak()

    #h(1.5em)#ficha.titulo
    #if ficha.subtítulo != none and ficha.subtítulo != "" [ \/ #ficha.subtítulo]
    \ \/ #ficha.autor. --- #ficha.edicao. ---
    #ficha.cidade : #ficha.editora, #ficha.ano.

    #v(0.3em)

    #h(1.5em)#ficha.paginas p. ; #ficha.formato

    #v(0.5em)

    ISBN #ficha.isbn

    #v(0.5em)

    // Descritores
    #for (i, assunto) in ficha.assuntos.enumerate() [
      #(i + 1). #assunto.#h(0.3em)
    ]
    I. Título.

    #v(0.6em)

    // Classificações — alinhadas à direita
    #align(right)[
      CDU #ficha.cdu #h(3em) CDD #ficha.cdd
    ]
  ]

  v(1em)

  // Direitos e avisos de produção
  align(center)[
    #set text(size: 8.5pt)
    #set par(justify: false)

    © #ficha.ano · #ficha.autor
    #v(0.4em)
    #ficha.direitos
    #v(0.6em)
    #text(style: "italic")[#ficha.aviso]
    #v(0.6em)
  ]
}


// ─── Dedicatória ─────────────────────────────────────────────
// Página simples com texto centralizado verticalmente.
// O conteúdo é definido em content/dedicatoria.typ.
//
// Uso:  #dedicatoria[_Para alguém especial._]
//
#let dedicatoria(corpo) = {
  pagebreak(to: "odd")
  v(3fr)
  pad(x: 1cm, align(right)[#corpo])
  v(4fr)
}


// ─── Agradecimentos ──────────────────────────────────────────
// Página com título simples (sem ornamentos) e texto justificado.
// O conteúdo é definido em content/agradecimentos.typ.
//
// Uso:  #agradecimentos[Agradeço a...]
//
#let agradecimentos(corpo) = {
  pagebreak(to: "odd")
  align(center)[
    #v(1.5em)
    #text(size: 20pt, weight: "medium")[#smallcaps[Agradecimentos]]
    #v(1.5em)
  ]
  corpo
}



