// code-algo.typ — Exibição de código-fonte (codly) e algoritmos estruturados.

#import "config.typ": get-config
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *

#let _render-source(src) = {
  let _self() = context {
    let cfg = get-config()
    let ano = if cfg.year == none { "ano" } else { cfg.year }
    [_Elaborado pelo próprio autor (#ano)._]
  }
  let _linha(body) = {
    set text(size: 10pt)
    set par(first-line-indent: 0pt, justify: false)
    v(3pt, weak: true)
    align(center, [Fonte#" – "#body])
  }
  if src == none {
    none
  } else if src == auto {
    _linha(_self())
  } else {
    _linha(src)
  }
}

// Inicializa o codly como TRANSFORMADOR (recebe body): regras `show:`
// só propagam quando aplicados diretamente via `show:` no template.
// A regra genérica do codly (show raw.where(block: true)) NÃO alcança
// raw dentro de figure — por isso reinjetamos codly() no escopo das
// figures de código. O container do codly é de largura total (grid
// width:100% no pacote); legenda e fonte da figura ficam centradas.
// Estilo: código à esquerda, mono (padrão de raw), numeração de linha
// ativa (padrão do codly) e entrelinha reduzida para legibilidade.
#let init-codly(body, enabled: true) = {
  if not enabled { return body }
  show: codly-init.with()
  codly(languages: codly-languages)
  codly(display-icon: false)
  codly(display-name: false)
  codly(lang-format:none)

  //codly-init já configura show rule para figure.where(kind: raw)
  //apenas ajustamos alinhamento e espaçamento
  show figure.where(kind: raw): set align(center)
  show raw.line: set align(left)
  show raw.where(block: true): set par(leading: 0.55em, first-line-indent: 0pt, justify: false)
  body
}



// 💻 Código-fonte — lê arquivo externo via read() e estiliza com codly.
// Bloco shrink-to-fit (width: auto): init-codly() centra a figura e mantém
// as linhas à esquerda dentro do bloco.
// Usa kind: raw (símbolo) para compatibilidade com codly.
#let codigo(
  lang: none,
  caption: none,
  source: auto,
  filename: none,
  kind: raw,
  keywords: none,
  supplement: [Código],
  body,
) = {
  let _highlight-keywords(body, keywords) = {
    // envolve o raw em um show local
    show regex("\b(" + keywords.join("|") + ")\b"): it => text(fill: black, weight: "bold", it.text)
    raw(body, lang: lang, block: true)
  }
  let content = if keywords != none {
    _highlight-keywords(body, keywords)
  } else if lang == none {
    raw(body, block: true)
  } else {
    raw(body, lang: lang, block: true)
  }
  figure(
    {
      if filename != none {
        codly(header: [#filename])
      }
      block(width: auto, content)
      _render-source(source)
    },
    caption: caption,
    numbering: "1",
    kind: kind,
    supplement: supplement,
  )
}



#let algoritmo(caption: none, filename: none, source: auto, body) = codigo(
  lang: "pseudocodigo",
  caption: caption,
  source: source,
  filename: filename,
  supplement: [Algoritmo], // ou param
  kind: "algorithm",
  keywords: ("se", "então", "senão", "para", "cada", "faça", "retorne", "enquanto", "fim", "procedure", "em"),  
  body,
)
