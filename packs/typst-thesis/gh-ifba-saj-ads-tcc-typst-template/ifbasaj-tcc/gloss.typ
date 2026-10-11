// gloss.typ — inline #abbrev / #gloss com state nativo (inspirado min-article)
#import "layout.typ": _fim-de-folha
#let _gloss-state = state("ifba-gloss", (:))
#let _abbrev-state = state("ifba-abbrev", (:))

#let abbrev(key, long: none) = context {
  let abbrev-key = if type(key) == str { key } else { str(key) }
  let cur = _abbrev-state.get()
  if abbrev-key in cur {
    upper(abbrev-key)
  } else {
    if long == none {
      // Capítulo aberto sozinho: a 1ª ocorrência pode estar em outro capítulo.
      if heading.numbering == none { return upper(abbrev-key) }
      panic("abbrev: long required on first use for '" + abbrev-key + "'")
    }
    _abbrev-state.update(s => { s.insert(abbrev-key, (long: long)); s })
    [#long (#upper(abbrev-key))]
  }
}

#let gloss(term, body) = context {
  let t = if type(term) == str { term } else { str(term) }
  let cur = _gloss-state.get()
  if t not in cur {
    _gloss-state.update(s => { s.insert(t, body); s })
  }
  [#t]
}

#let _cabecalho(titulo) = {
  pagebreak(weak: true)
  align(center, text(size: 14pt, weight: "bold")[#upper(titulo)])
  v(1em)
}

#let lista-abreviaturas(title: "Lista de abreviaturas e siglas") = context {
  let data = _abbrev-state.final()
  if data.len() > 0 {
    _cabecalho(title)
    set par(first-line-indent: 0pt)
    for k in data.keys().sorted() {
      let v = data.at(k)
      block(grid(columns: (3.5em, 1fr), column-gutter: 1cm, [#upper(k)], v.long))
    }
    _fim-de-folha()
  }
}

#let glossario(title: "Glossário") = context {
  let data = _gloss-state.final()
  if data.len() > 0 {
    heading(level:1, numbering:none, outlined:true, bookmarked:true, upper(title))
    set par(first-line-indent: 0pt)
    for k in data.keys().sorted() {
      let v = data.at(k)
      block(terms.item(k, v))
    }
  }
}
