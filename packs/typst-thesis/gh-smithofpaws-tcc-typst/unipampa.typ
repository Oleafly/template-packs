#let unipampa(
  titulo: "",
  subtitulo: "",
  autor: "",
  curso: "",
  orientador: "",
  coorientador: "",
  local: "",
  ano: "",
  natureza: "",
  area_concentracao: "",
  data_defesa: "",
  banca: (),
  dedicatoria: none,
  agradecimento: none,
  epigrafe: none,
  epigrafe_autor: none,
  resumo: none,
  palavras_chave: (),
  abstract: none,
  keywords: (),
  lista_abreviaturas: (),
  lista_siglas: (),
  lista_simbolos: (),
  body,
) = {
  set document(title: titulo, author: autor)

  set page(
    paper: "a4",
    margin: (top: 3cm, left: 3cm, bottom: 2cm, right: 2cm),
  )

  set text(
    font: ("Arial", "Times New Roman"),
    size: 12pt,
    lang: "pt",
    region: "BR",
  )

  set par(
    justify: true,
    first-line-indent: 1.25cm,
    leading: 1em,
  )
  
// --- REGRA DO ET AL. EM ITÁLICO (Geral, Citações e Bibliografia) ---
  show regex("et\\s+al\\."): emph

  show cite: it => {
    show regex("et\\s+al\\."): emph
    it
  }
  
  show bibliography: it => {
    show regex("et\\s+al\\."): emph
    it
  }
  
  set enum(
    numbering: "a)",
    indent: 1.25cm,
  )
  
  set list(
    marker: [--],
    indent: 1.25cm,
  )

  // --- CONFIGURAÇÃO DE EQUAÇÕES ---
  set math.equation(numbering: "(1)")
  show math.equation.where(block: true): set block(above: 1em, below: 1em)
  
  show math.equation.where(block: true): it => {
    it
  // Truque invisível para forçar o recuo do parágrafo seguinte
    par(text(size:0pt, ""))
  }

  // --- REGRA PARA TÍTULO DA FIGURA NA PARTE SUPERIOR ---
let espaco-simples = 0.65em
let espaco-linha-e-meia = 1em

// --- REGRA PARA TÍTULO DA FIGURA/TABELA NA PARTE SUPERIOR ---
set figure.caption(separator: [ -- ])
show figure.caption: set align(left)

show figure.where(kind: table): set figure.caption(position: top)
show figure.where(kind: table): set figure(gap: espaco-simples) // título ↔️ tabela
show figure.where(kind: table): set block(
  above: espaco-linha-e-meia, // texto ↔️ título
  below: espaco-simples,      // tabela ↔️ fonte
)

show figure.where(kind: image): it => {
  block(
    breakable: false,
    width: 100%,
    above: espaco-linha-e-meia, // texto ↔️ título
    below: espaco-simples,      // figura ↔️ fonte
  )[
    #set par(first-line-indent: 0pt)

    #if it.has("caption") [
      #it.caption
      #v(espaco-simples) // título ↔️ figura
    ]

    #align(center)[#it.body]
  ]

  par(text(size: 0pt, ""))
}

  // --- CAPA ---
  align(center)[
    #text(weight: "bold")[
      UNIVERSIDADE FEDERAL DO PAMPA\
      #upper(curso)
    ]
    #v(1fr)
    #text(weight: "bold")[#upper(autor)]
    #v(1fr)
    #text(weight: "bold")[
      #upper(titulo)#if subtitulo != "" [: #upper(subtitulo)]
    ]
    #v(1fr)
    #text(weight: "bold")[#local\ #ano]
  ]
  pagebreak()

  // --- FOLHA DE ROSTO ---
  counter(page).update(1)
  align(center)[
    #text(weight: "bold")[#upper(autor)]
    #v(1fr)
    #text(weight: "bold")[
      #upper(titulo)#if subtitulo != "" [: #upper(subtitulo)]
    ]
    #v(2cm)
    #align(right)[
      #block(width: 50%, align(left)[
        #set par(leading: 0.65em, first-line-indent: 0pt)
        #set text(weight: "regular", size: 12pt)
        #natureza
        #v(1em)
        Orientador(a): #orientador
        #if coorientador != "" [\ Coorientador(a): #coorientador]
      ])
    ]
    #v(1fr)
    #text(weight: "bold")[#local\ #ano]
  ]
  pagebreak()

  // --- FICHA CATALOGRÁFICA ---
  /*
  align(bottom)[
    #block(
      width: 100%,
      height: 7.75cm,
      stroke: 1pt,
      inset: 10pt,
      [
        #align(center)[
          #text(size: 10pt)[
            Ficha catalográfica elaborada automaticamente com os dados fornecidos\
            pelo(a) autor(a) através do Módulo de Biblioteca do\
            Sistema GURI (Gestão Unificada de Recursos Institucionais).\
            \
            *(Substitua este bloco pela imagem/texto da ficha catalográfica oficial)*
          ]
        ]
      ]
    )
  ]
  pagebreak()
  */

  // --- FOLHA DE APROVAÇÃO ---
  align(center)[
    #text(weight: "bold")[#upper(autor)]
    #v(1fr)
    #text(weight: "bold")[
      #upper(titulo)#if subtitulo != "" [: #upper(subtitulo)]
    ]
    #v(1cm)
    #align(right)[
      #block(width: 50%, align(left)[
        #set par(leading: 0.65em, first-line-indent: 0pt)
        #set text(weight: "regular", size: 12pt)
        #natureza
        #if area_concentracao != "" [
          \ \ Área de concentração: #area_concentracao
        ]
      ])
    ]
    #v(1cm)
	#if data_defesa != "" [
		#align(left)[Trabalho de Conclusão de Curso defendido e aprovado em: #data_defesa.]
	]
    #v(1cm)
    Banca examinadora:
    #v(1cm)

	// Banca dynamically
	#for (i, membro) in banca.enumerate() [
	  #line(length: 80%, stroke: 0.5pt)
      #membro.nome\
      #if i == 0 [
		Orientador\
	  ]
	  #membro.instituicao \
	  #v(1cm)
	]
  ]
  pagebreak()

  // --- DEDICATÓRIA ---
  if dedicatoria != none {
    align(bottom + right)[
      #block(width: 50%, align(left)[
        #set par(leading: 0.26em, first-line-indent: 0pt)
        #dedicatoria
      ])
    ]
    pagebreak()
  }

  // --- AGRADECIMENTOS ---
  if agradecimento != none {
    align(center)[#text(weight: "bold")[AGRADECIMENTO]]
    v(1cm)
    set par(first-line-indent: 0pt)
    agradecimento
    pagebreak()
  }

  // --- EPÍGRAFE ---
  if epigrafe != none {
    align(bottom + right)[
      #block(width: 50%, align(left)[
        #set par(leading: 0.26em, first-line-indent: 0pt)
        "#epigrafe"\
        #align(right)[#epigrafe_autor]
      ])
    ]
    pagebreak()
  }

  // --- RESUMO ---
  if resumo != none {
    align(center)[#text(weight: "bold")[RESUMO]]
    v(1cm)
    set par(first-line-indent: 0pt, leading: 0.65em)
    resumo
    v(0.65em)
    [*Palavras-Chave:* #palavras_chave.join("; ").]
    pagebreak()
  }

  // --- ABSTRACT ---
  if abstract != none {
    align(center)[#text(weight: "bold")[ABSTRACT]]
    v(1cm)
    set par(first-line-indent: 0pt, leading: 0.65em)
    abstract
    v(0.65em)
    [*Keywords:* #keywords.join("; ").]
    pagebreak()
  }

  // --- LISTA DE FIGURAS ---
  // Apenas gera se houver figuras no documento com legenda (caption)
  context {
    let figures = query(figure.where(kind: image))
    if figures.len() > 0 {
      align(center)[#text(weight: "bold")[LISTA DE FIGURAS]]
      v(1cm)
      
      for fig in figures {
        let title = fig.caption.body
        let num = counter(figure).at(fig.location()).first()
        let loc = fig.location()
        let page_num = counter(page).at(loc).first()
        
        box(width: 100%)[
          #set par(leading: 0.52em, first-line-indent: 0pt)
          #link(loc)[Figura #num -- #title #box(width: 1fr, repeat[ . ]) #page_num]
        ]
      }
      pagebreak()
    }
  }

  // --- LISTA DE TABELAS ---
  // Apenas gera se houver tabelas no documento com legenda (caption)
  context {
    let tables = query(figure.where(kind: table))
    if tables.len() > 0 {
      align(center)[#text(weight: "bold")[LISTA DE TABELAS]]
      v(1cm)
      
      for tab in tables {
        let title = tab.caption.body
        let num = tab.counter.display(tab.numbering)
        let loc = tab.location()
		let num = counter(figure.where(kind: table)).at(loc).first()
        let page_num = counter(page).at(loc).first()
        
        box(width: 100%)[
          #set par(leading: 0.52em, first-line-indent: 0pt)
          #link(loc)[Tabela #num -- #title #box(width: 1fr, repeat[ . ]) #page_num]
        ]
      }
      pagebreak()
    }
  }

  // --- LISTA DE ABREVIATURAS ---
  if lista_abreviaturas.len() > 0 {
    align(center)[#text(weight: "bold")[LISTA DE ABREVIATURAS]]
    v(1cm)
    set par(first-line-indent: 0pt, leading: 1em)
    grid(
      columns: (2.5cm, 1fr),
      row-gutter: 1em,
      ..lista_abreviaturas.flatten()
    )
    pagebreak()
  }

  // --- LISTA DE SIGLAS ---
  if lista_siglas.len() > 0 {
    align(center)[#text(weight: "bold")[LISTA DE SIGLAS]]
    v(1cm)
    set par(first-line-indent: 0pt, leading: 1em)
    grid(
      columns: (2.5cm, 1fr),
      row-gutter: 1em,
      ..lista_siglas.flatten()
    )
    pagebreak()
  }
  
  // --- LISTA DE SÍMBOLOS ---
  if lista_simbolos.len() > 0 {
    align(center)[#text(weight: "bold")[LISTA DE SÍMBOLOS]]
    v(1cm)
    set par(first-line-indent: 0pt, leading: 1em)
    grid(
      columns: (2.5cm, 1fr),
      row-gutter: 1em,
      ..lista_simbolos.flatten()
    )
    pagebreak()
  }

  // --- SUMÁRIO ---
  align(center)[#text(weight: "bold")[SUMÁRIO]]
  v(1cm)
  show outline.entry.where(
    level: 1
  ): it => {
    v(0.65em, weak: true)
    strong(it)
  }
  outline(title: none, indent: auto)
  pagebreak()

  // --- INÍCIO DA PARTE TEXTUAL ---
  // A partir daqui a paginação aparece.
  set page(
    header: context {
      let page_num = counter(page).display()
      align(right)[#text(size: 10pt)[#page_num]]
    }
  )

  // Configuração visual dos Títulos (Seções Numéricas)
  set heading(numbering: "1.1")
  
  show heading: it => {
    if it.level == 1 {
      pagebreak(weak: true)
    }
    block(
      width: 100%,
      above: 1.3em,
      below: 1em,
      {
        set text(weight: "bold", size: 12pt)
        if it.level == 1 {
          upper(it)
        } else {
          it
        }
      }
    )
  }

  show heading: it => {
    it
    par(text(size:0pt, ""))
  }

  body
}

// Citação Longa
#let citacao_longa(texto) = {
  pad(
    left: 4cm,
    block(
      width: 100%,
      {
        set text(size: 10pt)
        set par(leading: 0.26em, justify: true, first-line-indent: 0pt)
        texto
      }
    )
  )
}

// Título Sem Numeração (para Referências, Apêndices, Anexos)
#let titulo_sem_numeracao(titulo) = {
  show heading: set align(center)
  heading(numbering: none, outlined: true)[#titulo]
}