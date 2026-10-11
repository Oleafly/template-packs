// pre-textual.typ — classic-ppgsi order, ABNT header, capa/folha correct
#import "layout.typ": default-theme, _abnt-page, _abnt-body, _abnt-headings, _backmatter, _cm-dash, _fim-de-folha, _text-color
#import "config.typ": get-config, set-config
#import "gloss.typ": glossario, lista-abreviaturas
#import "bibliography.typ": cite, references, register-bib
#import "code-algo.typ": init-codly
#import "@preview/codly-languages:0.1.1": codly-languages
#import "@preview/datify:1.3.0": display-date
#let _pre-titulo(nome) = heading(level: 1, numbering: none, outlined: false, bookmarked: true, upper(nome))
#let _logo() = {
  rect(width: 2.7cm, height: 2.7cm, stroke: (paint: luma(45%), thickness: 1pt, dash: "dashed"), radius: 4pt, align(
    center + horizon,
    stack(dir: ttb, spacing: 4pt, text(fill: luma(45%), weight: "bold", size: 10pt)[LOGOTIPO], text(
      fill: luma(45%),
      weight: "bold",
      size: 14pt,
    )[IFBA]),
  ))
}
#let _logo() = image("../assets/logo.png", height: 2.7cm) 
#let _capa(logo, instituicao, autor, titulo, local, data) = {
  set align(center)
  set par(leading: 1.1em, first-line-indent: 0pt, justify: false)
  set text(size: 12pt)
  if logo != none { if type(logo) == str { image(logo, width: 2.7cm) } else { logo } }
  v(0.3cm)
  upper(instituicao)
  v(4cm)
  autor
  v(5cm)
  text(weight: "bold", upper(titulo))
  v(1fr)
  upper(local)
  parbreak()
  upper(str(data))
  v(1cm)
}
#let _single(body) = {
  set par(leading: 0.65em, spacing: 0.65em)
  body
}
#let _folha-de-rosto(autor, titulo, preambulo, orientador, coorientador, local, data) = {
  set align(center)
  set par(leading: 1.1em, first-line-indent: 0pt, justify: false)
  set text(size: 12pt)
  autor
  v(1fr)
  v(1fr)
  text(weight: "bold", upper(titulo))
  v(1fr)
  align(left, pad(left: 50%, _single({
    set par(justify: true, leading: 0.65em, spacing: 1.3em)
    preambulo
    v(2em)
    [#orientador]
    if coorientador != none {
      v(0.5em)
      [#coorientador]
    }
  })))
  v(1fr)
  upper(local)
  parbreak()
  upper(str(data))
  v(1cm)
}
#let _ficha(ficha) = {
  if ficha == none { return }
  page(margin: 0cm, header: none, footer: none, {
    if type(ficha) == str { image(ficha, width: 100%, height: 100%, fit: "contain") } else { ficha }
  })
}
#let template(
  titulo: none,
  autor: none,
  orientador: none,
  co-orientador: none,
  instituicao: [Instituto Federal de Educação, Ciência e Tecnologia da Bahia],
  curso: [Análise e Desenvolvimento de Sistemas],
  local: "Santo Antônio de Jesus",
  data-banca: none,
  logo: none,
  ficha-catalografica: none,
  errata: none,
  texto-aprovacao: none,
  banca: (),
  dedicatoria: none,
  agradecimentos: none,
  epigrafe: none,
  resumo-conteudo: none,
  resumo-palavras: (),
  abstract-conteudo: none,
  abstract-palavras: (),
  versao-impressao: false,
  codly-habilitado: true,
  bibliografia: none,
  body,
) = {
  assert(ficha-catalografica != none, message: "Parâmetro obrigatório ABNT ausente: ficha-catalografica")
  assert(data-banca != none, message: "Parâmetro obrigatório ABNT ausente: data-banca")
  assert(banca.len() > 0, message: "Parâmetro obrigatório ABNT ausente: banca")
  assert(resumo-conteudo != none, message: "Parâmetro obrigatório ABNT ausente: resumo-conteudo")
  assert(resumo-palavras.len() > 0, message: "Parâmetro obrigatório ABNT ausente: resumo-palavras")
  assert(abstract-conteudo != none, message: "Parâmetro obrigatório ABNT ausente: abstract-conteudo")
  assert(abstract-palavras.len() > 0, message: "Parâmetro obrigatório ABNT ausente: abstract-palavras")
  assert(bibliografia != none, message: "Parâmetro obrigatório ABNT ausente: bibliografia")
  let _ano = data-banca.year()
  set-config(
    year: _ano,
    author: autor,
    titulo: titulo,
    orientador: orientador,
    curso: curso,
    cidade: local,
    versao-impressao: versao-impressao,
  )
  let _logo-val = if logo == none { _logo() } else if type(logo) == str { image(logo, width: 2.7cm) } else { logo }
  let _author-upper = if autor == none { none } else { upper(str(autor)) }
  // Preâmbulo parametrizado: compõe a partir de instituicao/curso/local (ABNT folha de rosto).
  let _preamb = [Trabalho de Conclusão de Curso apresentado a #instituicao, campus #local, como requisito parcial para obtenção do grau de Tecnólogo em #curso.]
  // Texto de aprovação parametrizado (estratégia let _preamb): montado a partir de autor/titulo/banca/local/ano/instituicao/curso.
  let _texto-aprovacao-pad = {
    let _autor-upper = upper(str(autor))
    let _titulo-upper = upper(str(titulo))
    let _ass = banca.enumerate().map(((i, m)) => {
      let is-orientador = i == 0
      stack(dir: ttb, spacing: 2pt, line(length: 10cm, stroke: 0.5pt), text(weight: "bold", m), if is-orientador { text(size: 10pt, [Orientador]) } else { none })
    }).join(v(1.2cm))
    stack(dir: ttb, spacing: 0pt,
      align(center, text(weight: "bold", _autor-upper)),
      v(2cm),
      align(center, text(weight: "bold", _titulo-upper)),
      v(1.5cm),
      par(justify: true, leading: 0.65em, [A banca examinadora, abaixo listada, aprova o Trabalho de Conclusão de Curso #_titulo-upper elaborado por #_author-upper como requisito parcial para obtenção do grau de Tecnólogo em #curso, pelo #instituicao.]),
      v(1cm),
      align(center, [#local, #display-date(data-banca, pattern: "full")]),
      v(1cm),
      align(center, [Comissão Examinadora]),
      v(1cm),
      align(center, _ass),
    )
  }
  // global styles (ponto único de estilo: layout.typ)
  show: _abnt-page.with(print: versao-impressao)
  show: _abnt-body
  show: _abnt-headings
  show: init-codly.with(enabled: codly-habilitado)
  show heading: set block(above: 1.5em, below: 1.5em)
  register-bib(bibliografia)
  // alias @key → #cite("key") para motor custom (mantém @ nativo)
  show ref: it => {
    let k = str(it.target)
    context {
      let entries = {
        let src = state("ifba-bibsrc", "").get()
        let _strip(s) = s.split("\n").filter(l => not l.trim().starts-with("%")).join("\n")
        let has = _strip(src).contains(k)
        has
      }
      if entries { cite(k) } else { it }
    }
  }
  // PRE-TEXTUAIS em ordem classic-ppgsi
  _capa(_logo-val, instituicao, _author-upper, titulo, local, _ano)
  _fim-de-folha()
  // A contagem recomeça após a capa: a folha de rosto é a folha 1.
  counter(page).update(1)
  _folha-de-rosto(_author-upper, titulo, _preamb, orientador, co-orientador, local, _ano)
  // Ficha catalográfica no verso da folha de rosto (NBR 14724) — obrigatória.
  pagebreak()
  _ficha(ficha-catalografica)
  if errata != none {
    heading(level: 1, numbering: none, outlined: false, bookmarked: true, upper("Errata"))
    errata
    _fim-de-folha()
  }
  heading(level: 1, numbering: none, outlined: false, bookmarked: true, hide[ Folha de aprovação])
  if texto-aprovacao == none {
    _single(_texto-aprovacao-pad)
  } else if type(texto-aprovacao) == str {
    page(margin: 0cm, header: none, footer: none, image(texto-aprovacao, width: 100%, height: 100%, fit: "contain"))
  } else {
    _single({
      set par(justify: true)
      texto-aprovacao
      v(3cm)
      set align(center)
      for member in banca {
        v(1.2cm)
        line(length: 10cm, stroke: 0.5pt)
        member
        parbreak()
      }
    })
  }
  _fim-de-folha()
  if dedicatoria != none {
    v(1fr)
    align(center, emph(dedicatoria))
    v(1fr)
    _fim-de-folha()
  }
  if agradecimentos != none {
    _pre-titulo[AGRADECIMENTOS]
    agradecimentos
    _fim-de-folha()
  }
  if epigrafe != none {
    v(1fr)
    align(right, emph(epigrafe))
    _fim-de-folha()
  }
  _pre-titulo[RESUMO]
  _single({
    set par(first-line-indent: 0pt, spacing: 18pt)
    resumo-conteudo
    parbreak()
    [Palavras-chave: #(resumo-palavras.join("; ")).]
  })
  _fim-de-folha()
  _pre-titulo[ABSTRACT]
  _single({
    set par(first-line-indent: 0pt, spacing: 18pt)
    set text(lang: "en")
    abstract-conteudo
    parbreak()
    [Keywords: #(abstract-palavras.join("; ")).]
  })
  _fim-de-folha()
  // Lista pré-textual: renderiza título + outline apenas se houver itens.
  // query() em context enxerga o documento inteiro (forward reference nativa),
  // dispensando qualquer mecanismo de estado manual.
  let _lista(nome, target) = context {
    if query(target).len() > 0 {
      _pre-titulo(nome)
      show outline.entry: it => {
        let dest = it.element.location()
        let tail = if it.fill != none { box(width: 1fr, it.fill) } else { h(1fr) }
        link(dest, it.indented(
          text(fill: _text-color, {
            it.prefix()
            _cm-dash
          }),
          text(fill: _text-color, it.body()) + [ ] + tail + [ ] + it.page(),
        ))
      }
      outline(title: none, target: target)
      _fim-de-folha()
    }
  }
  // Listas pré-textuais automáticas na ordem ABNT:
  // figuras → quadros → tabelas → códigos → algoritmos → equações → abreviaturas → Sumário
  _lista([Lista de figuras], figure.where(kind: image))
  _lista([Lista de quadros], figure.where(kind: "frame"))
  _lista([Lista de tabelas], figure.where(kind: table))
  _lista([Lista de códigos], figure.where(kind: raw))
  _lista([Lista de algoritmos], figure.where(kind: "algorithm"))
  _lista([Lista de equações], math.equation.where(block: true))
  // lista-abreviaturas guarda internamente com _abbrev-state.final(); não renderiza quando vazia
  lista-abreviaturas()
  _pre-titulo[SUMÁRIO]
  {
    show outline.entry.where(level: 1): it => context block(above: 1em, below: 0pt, {
      let dest = it.element.location()
      let modo = _backmatter.at(dest)
      if modo != none {
        let letra = numbering("A", counter(heading).at(dest).first())
        link(dest, text(fill: _text-color, weight: "bold", it.indented(
          [#if modo == "appendix" { "Apêndice" } else { "Anexo" } #letra#_cm-dash],
          it.inner(),
        )))
      } else {
        let e = it.indented(it.prefix(), it.inner())
        let body = if it.element.body == [Referências] { upper(e) } else { e }
        link(dest, text(fill: _text-color, weight: "bold", body))
      }
    })
    show outline.entry.where(level: 2): it => context if _backmatter.at(it.element.location()) != none { none } else {
      link(it.element.location(), text(fill: _text-color, style: "italic", it.indented(it.prefix(), it.inner())))
    }
    show outline.entry.where(level: 3): it => context if _backmatter.at(it.element.location()) != none { none } else {
      link(it.element.location(), text(fill: _text-color, it.indented(it.prefix(), it.inner())))
    }
    outline(title: none, depth: 3, indent: 1.2em)
    _fim-de-folha()
  }
  body
}
