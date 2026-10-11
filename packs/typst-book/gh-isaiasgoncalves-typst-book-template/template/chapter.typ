#import "@preview/droplet:0.3.1": dropcap
#import "../metadata/config.typ": em-frontmatter, titulo-capitulo


// ─── Parágrafo de abertura ───────────────────────────────────
// Aplica letra capitular e smallcaps na primeira palavra.
// Use no primeiro parágrafo de cada capítulo.
//
// Exemplo:  #par-inicio[Era][uma vez em terras distantes...]
//
#let par-inicio(primeira-palavra, resto) = dropcap(
  height: 3,
  justify: true,
  gap: 2pt,
  hanging-indent: 1em,
  font: "Kanzlei-Initialen",
)[#smallcaps[#primeira-palavra] #resto]


// ─── Estado interno das notas do capítulo ────────────────────
#let notas-cap-estado = state("notas-cap", ())


// ─── Converte número em símbolo clássico para notas de capítulo ────
#let nota-simbolo(n) = {
  let simbolos = ("*", "†", "‡", "§", "**", "††", "‡‡", "§§")
  if n <= simbolos.len() {
    simbolos.at(n - 1)
  } else {
    str(n)
  }
}


// ─── Renderização de Notas de Capítulo ───────────────────────
// Renderiza de forma limpa as notas coletadas para o capítulo.
// É chamada automaticamente no final de cada #capitulo().
//
#let exibir-notas-capitulo() = context {
  let notas = notas-cap-estado.get()
  if notas.len() > 0 [
    #v(1.5em)
    #line(length: 40%, stroke: 0.5pt)
    #v(0.6em)
    #set text(size: 9.5pt)
    #set par(justify: true, leading: 0.6em)
    #for (i, nota) in notas.enumerate() [
      #nota-simbolo(i + 1) #nota \
    ]
  ]
}


// ─── Capítulo ────────────────────────────────────────────────
// Inicia um novo capítulo, encerrando o pré-texto e ativando
// cabeçalhos/rodapés. Atualiza o título no cabeçalho.
// Renderiza as notas de fim de capítulo automaticamente no final.
//
// Exemplo:
//   #capitulo("O Início da Jornada")[
//     #par-inicio[Era][uma vez...]
//     == Seção
//     ...
//   ]
//
#let capitulo(titulo, corpo) = {
  notas-cap-estado.update(()) // limpa notas do capítulo anterior
  counter("nota-cap").update(0) // reseta o contador de notas de capítulo

  em-frontmatter.update(false) // encerra o pré-texto → ativa cabeçalho/rodapé
  pagebreak(to: "even")
  titulo-capitulo.update(str(titulo))
  heading(level: 1, titulo)
  corpo

  exibir-notas-capitulo() // renderiza notas do capítulo de forma automática
}


// ─── Verso (epígrafe / citação em verso) ─────────────────────
// Bloco recuado à esquerda para epígrafes e citações em verso.
//
// Exemplo:  #verse[_Texto do poema_]
//
#let verse(corpo) = {
  pad(x: 2.0cm, align(left)[#corpo])
}


// ─── Notas de Fim de Capítulo ────────────────────────────────
// Insere uma nota de fim de capítulo com numeração local e
// exibição automática ao final do capítulo.
//
// Exemplo:  ...algum texto#nota-cap[Esta é a descrição da nota.]...
//
#let nota-cap(corpo) = {
  let c = counter("nota-cap")
  c.step()

  // Adiciona o conteúdo ao estado das notas
  notas-cap-estado.update(old => old + (corpo,))

  // Exibe o sobrescrito dinamicamente
  context {
    let n = c.get().first()
    nota-simbolo(n)
  }
}


// ─── Notas de Fim do Livro ───────────────────────────────────
// Insere uma nota de fim de livro com numeração contínua ao
// longo de todo o volume, exibida apenas na seção final do livro.
//
// Exemplo:  ...algum texto#nota-livro[Nota que vai pro fim do livro.]...
//
#let nota-livro(corpo) = context {
  let cap = titulo-capitulo.get()

  // Salva os metadados da nota com o capítulo correspondente
  [#metadata((capitulo: cap, corpo: corpo)) <nota-livro>]

  // Calcula o índice global com base nas notas inseridas antes desta
  let notas-anteriores = query(selector(<nota-livro>).before(here()))
  let idx = notas-anteriores.len() + 1
  super(str(idx))
}

// ─── Apêndice ────────────────────────────────────────────────
// Inicia um novo apêndice, numerado alfabeticamente (A, B, C...).
//
// Exemplo:
//   #apendice("Metodologia de Testes")[
//     ...
//   ]
//
#let apendice(titulo, corpo) = {
  em-frontmatter.update(false)
  pagebreak(to: "even")

  titulo-capitulo.update("Apêndice: " + str(titulo))

  let c = counter("apendice")
  c.step()

  context {
    let letra = numbering("A", c.get().first())
    heading(level: 1, "Apêndice " + letra + ": " + titulo)
  }

  corpo
}


