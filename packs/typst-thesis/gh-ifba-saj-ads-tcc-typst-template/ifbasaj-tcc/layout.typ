// layout.typ — Ponto único de estilo ABNT do pacote (NBR 14724/6024/10520).

#import "config.typ": get-config

// Constantes internas de conformidade com a norma (não customizáveis).
#let _abnt = (
  size: 12pt,
  leading: 1.5em,
  indent: 1.25cm,
  margin-top: 3cm,
  margin-bottom: 2cm,
  margin-inside: 3cm,
  margin-outside: 2cm,
)

// Cores internas (não customizáveis pelo tema).
#let _text-color = rgb(0, 0, 0)

// Tema público: apenas o que a ABNT é neutra.
#let default-theme = (
  serif: "New Computer Modern",
  link-color: rgb("#0000EE"),
)

#let _cm-dash = " – "

// Estado de pós-textuais (apêndice/anexo); consumido por pre-textual e annexes.
#let _backmatter = state("ifba-backmatter", none)

// Capítulo corrente para o cabeçalho (formato "Capítulo N. Título" ou
// "Apêndice/Anexo A – Título").
#let _chapter-mark(loc) = {
  let chaps = query(heading.where(level: 1)).filter(h => (
    h.location().page() <= loc.page() and (h.numbering != none or h.outlined == true)
  ))
  if chaps.len() == 0 { return none }
  let h = chaps.last()
  let modo = _backmatter.at(h.location())
  if modo != none {
    let letra = numbering("A", counter(heading).at(h.location()).first())
    [#if modo == "appendix" { "Apêndice" } else { "Anexo" } #letra#_cm-dash#h.body]
  } else if h.numbering != none {
    let num = numbering("1", ..counter(heading).at(h.location()))
    [Capítulo #num. #h.body]
  } else { h.body }
}

// Página A4 com margens ABNT e cabeçalho corrente (capítulo à esquerda,
// número da página à direita; na abertura de capítulo, só o número).
#let _abnt-page(print: false, body) = {
  set page(
    paper: "a4",
    // Impressão frente-e-verso: margens espelhadas (lombada interna de 3cm).
    margin: if print {
      (inside: _abnt.margin-inside, outside: _abnt.margin-outside, top: _abnt.margin-top, bottom: _abnt.margin-bottom)
    } else {
      (left: _abnt.margin-inside, right: _abnt.margin-outside, top: _abnt.margin-top, bottom: _abnt.margin-bottom)
    },
    binding: if print { left } else { auto },
    header-ascent: 1cm,
    header: context {
      let loc = here()
      let pg = loc.page()
      let mark = _chapter-mark(loc)
      if mark == none { return }
      set text(size: 10pt)
      // Página com heading nível 1 = abertura de capítulo: só número.
      let chap-here = query(heading.where(level: 1)).filter(h => h.location().page() == pg)
      if chap-here.len() > 0 {
        align(right, counter(page).display())
        return
      }
      // Página com heading nível 2/3 = continuação com seções: cabeçalho completo.
      let sub-here = query(heading.where(level: 2)).filter(h => h.location().page() == pg)
      if sub-here.len() > 0 {
        grid(
          columns: (1fr, auto),
          align: (left + bottom, right + bottom),
          mark, counter(page).display(),
        )
        v(-0.4em)
        line(length: 100%, stroke: 0.4pt)
        return
      }
      let sub3-here = query(heading.where(level: 3)).filter(h => h.location().page() == pg)
      if sub3-here.len() > 0 {
        grid(
          columns: (1fr, auto),
          align: (left + bottom, right + bottom),
          mark, counter(page).display(),
        )
        v(-0.4em)
        line(length: 100%, stroke: 0.4pt)
        return
      }
      // Página sem headings: pode ser continuação só com parágrafos OU verso em branco.
      // Verifica se há conteúdo de corpo (parágrafos, figuras, tabelas).
      let has-body = query(par).any(h => h.location().page() == pg) or (query(figure).any(h => h.location().page() == pg) or query(table).any(h => h.location().page() == pg))
      if not has-body { return }
      // Tem corpo mas sem headings = continuação de texto: cabeçalho completo.
      grid(
        columns: (1fr, auto),
        align: (left + bottom, right + bottom),
        mark, counter(page).display(),
      )
      v(-0.4em)
      line(length: 100%, stroke: 0.4pt)
    },
  )
  body
}

// Texto do corpo, parágrafos e legendas conforme a norma.
#let _abnt-body(theme: default-theme, body) = {
  set text(font: theme.serif, size: _abnt.size, lang: "pt", region: "br", hyphenate: true)
  set par(leading: _abnt.leading, spacing: _abnt.leading, first-line-indent: (amount: _abnt.indent, all: true), justify: true)
  set heading(numbering: (..nums) => if nums.pos().len() <= 3 { numbering("1.1.1", ..nums.pos()) })
  set math.equation(numbering: "(1)")
  // @rótulo de capítulo escreve "Capítulo N"; de seção, "Seção N.N".
  show heading.where(level: 1): set heading(supplement: [Capítulo])
  set figure(gap: 0.6em)
  set figure.caption(separator: _cm-dash, position: top)
  show figure.caption: it => {
    let _kinds = ("image", "frame", "code", "algorithm")
    let ok = if type(it.kind) == str { it.kind in _kinds } else { it.kind == table }
    if not ok { return it }
    set text(size: 12pt)
    set par(leading: 0.6em, first-line-indent: 0pt, spacing: 0.6em)
    layout(size => context {
      let number = it.counter.display(it.numbering)
      let is-alg = it.kind == "algorithm"
      let label = [#it.supplement #number#_cm-dash] 
      let full = label + it.body
      if measure(full).width <= size.width { align(center, full) } else {
        set par(hanging-indent: measure(label).width, justify: true)
        full
      }
    })
  }
  show raw: set text(font: "DejaVu Sans Mono")
  show raw.where(block: false): box.with(
    fill: luma(245),
    inset: (x: 4pt, y: 0pt),
    outset: (y: 3pt),
    radius: 3pt,
  )
  body
}

// Fim de folha de um elemento pré-textual: no modo impressão, o próximo
// elemento inicia no anverso (página ímpar); no digital, quebra fraca.
#let _fim-de-folha() = context {
  if get-config().at("versao-impressao", default: false) { pagebreak(to: "odd") } else { pagebreak(weak: true) }
}

// Títulos de seção: nível 1 em negrito com quebra de folha; níveis 2 e 3 em
// corpo 12 sem negrito (NBR 6024).
#let _abnt-headings(body) = {
  show heading.where(level: 1): it => context {
      // Pré-textuais (numbering: none) NÃO quebram — _fim-de-folha já
      // posicionou a folha. Seções primárias numeradas e pós-textuais
      // (outlined) quebram para anverso. A quebra é fraca para colapsar
      // com _fim-de-folha anterior (sem brancos duplos).
      let primaria = it.numbering != none or it.outlined == true
      if primaria {
        if get-config().at("versao-impressao", default: false) {
          pagebreak(weak: true, to: "odd")
        } else {
          pagebreak(weak: true)
        }
      }
      set text(size: 12pt, weight: "bold")
      set par(first-line-indent: 0pt, justify: false, leading: 0.93em)
      let modo = _backmatter.at(it.location())
      block(above: 0pt, below: 22pt, width: 100%, {
        if modo != none {
          let letra = numbering("A", counter(heading).at(it.location()).first())
          align(center, [#if modo == "appendix" { "Apêndice" } else { "Anexo" } #letra#_cm-dash#it.body])
        } else if it.numbering == none { align(center, it.body) } else { it }
      })
    }
  show heading.where(level: 2): it => context {
    set text(size: 12pt, weight: "regular", style: "italic")
    set par(first-line-indent: 0pt, justify: false, leading: 0.93em)
    let modo = _backmatter.at(it.location())
    if modo != none {
      let n = numbering("1", counter(heading).at(it.location()).at(1))
      block(above: 32pt, below: 22pt, [#n #it.body])
    } else { block(above: 32pt, below: 22pt, it) }
  }
  show heading.where(level: 3): it => context {
    set text(size: 12pt, weight: "regular", style: "normal")
    set par(first-line-indent: 0pt, justify: false, leading: 0.93em)
    let modo = _backmatter.at(it.location())
    if modo != none {
      let nums = counter(heading).at(it.location())
      let n = numbering("1.1", nums.at(1), nums.at(2))
      block(above: 32pt, below: 22pt, [#n #it.body])
    } else { block(above: 32pt, below: 22pt, it) }
  }
  body
}
