// ============================================================================
// bibliography.typ — motor próprio de citações + bibliografia ABNT (NBR 10520 / NBR 6023)
// Adaptado de classic-ppgsi para ifba-saj-tcc.
// ============================================================================

#import "layout.typ": _text-color

#let _CM = <ifba-cite-mark>

// ---------------------------------------------------------------------------
// PARSER BibTeX (subconjunto: @tipo{chave, campo = {valor} | "valor" | token})
// ---------------------------------------------------------------------------

#let _strip-comments(s) = s.split("\n").filter(l => not l.trim().starts-with("%")).join("\n")

#let _is-ws(c) = c == " " or c == "\t" or c == "\n" or c == "\r"

#let _skip-ws(cp, i) = {
  while i < cp.len() and _is-ws(cp.at(i)) { i += 1 }
  i
}

#let _read-braced(cp, i) = {
  let depth = 1
  let out = ""
  i += 1
  while i < cp.len() and depth > 0 {
    let c = cp.at(i)
    if c == "{" { depth += 1; out += c }
    else if c == "}" { depth -= 1; if depth > 0 { out += c } }
    else { out += c }
    i += 1
  }
  (out, i)
}

#let _read-quoted(cp, i) = {
  let out = ""
  let depth = 0
  i += 1
  while i < cp.len() {
    let c = cp.at(i)
    if c == "\"" and depth == 0 { i += 1; break }
    if c == "{" { depth += 1 }
    if c == "}" { depth -= 1 }
    out += c
    i += 1
  }
  (out, i)
}

#let _read-bare(cp, i) = {
  let out = ""
  while i < cp.len() and not (cp.at(i) in (",", "}")) { out += cp.at(i); i += 1 }
  (out.trim(), i)
}

#let _read-value(cp, i) = {
  i = _skip-ws(cp, i)
  let c = cp.at(i, default: "")
  if c == "{" { _read-braced(cp, i) }
  else if c == "\"" { _read-quoted(cp, i) }
  else { _read-bare(cp, i) }
}

#let _read-token(cp, i, stops) = {
  let out = ""
  while i < cp.len() and not (cp.at(i) in stops) { out += cp.at(i); i += 1 }
  (out, i)
}

#let _parse-bib(content) = {
  let cp = _strip-comments(content).clusters()
  let n = cp.len()
  let i = 0
  let entries = (:)
  while i < n {
    while i < n and cp.at(i) != "@" { i += 1 }
    if i >= n { break }
    i += 1
    let parts = _read-token(cp, i, ("{", "("))
    let etype = lower(parts.at(0).trim())
    i = parts.at(1)
    if i >= n { break }
    i += 1
    i = _skip-ws(cp, i)
    let kp = _read-token(cp, i, (",", "}"))
    let key = kp.at(0).trim()
    i = kp.at(1)
    if cp.at(i, default: "") == "," { i += 1 }
    let fields = (:)
    while i < n {
      i = _skip-ws(cp, i)
      if cp.at(i, default: "") == "}" { i += 1; break }
      let np = _read-token(cp, i, ("=", ",", "}"))
      let name = lower(np.at(0).trim())
      i = np.at(1)
      if cp.at(i, default: "") != "=" {
        if cp.at(i, default: "") == "," { i += 1 }
        continue
      }
      i += 1
      let vp = _read-value(cp, i)
      i = vp.at(1)
      if name != "" { fields.insert(name, vp.at(0).trim()) }
      i = _skip-ws(cp, i)
      if cp.at(i, default: "") == "," { i += 1 }
    }
    if key != "" { entries.insert(key, (type: etype, fields: fields)) }
  }
  entries
}

// ---------------------------------------------------------------------------
// AUTORES
// ---------------------------------------------------------------------------

#let _split-authors(field) = field.split(regex("\s+and\s+")).map(s => s.trim()).filter(s => s != "")

#let _name-parts(raw) = {
  let nm = raw.trim()
  // Autor institucional entre chaves duplas no .bib: author = {{Typst GmbH}}.
  if nm.starts-with("{") and nm.ends-with("}") {
    (nm.trim("{").trim("}").trim(), "")
  } else if "," in nm {
    let p = nm.split(",")
    (p.at(0).trim(), p.slice(1).join(",").trim())
  } else {
    let toks = nm.split(regex("\s+")).filter(t => t != "")
    if toks.len() == 0 { ("", "") }
    else if toks.len() == 1 { (toks.at(0), "") }
    else { (toks.last(), toks.slice(0, toks.len() - 1).join(" ")) }
  }
}

#let _initials(given) = given.split(regex("\s+")).filter(t => t != "").map(t => upper(t.clusters().at(0, default: "")) + ".").join(" ")

#let _format-name(raw) = {
  let np = _name-parts(raw)
  let fam = upper(np.at(0))
  let ini = _initials(np.at(1))
  if ini == none or ini == "" { fam } else { fam + ", " + ini }
}

#let _authors-bib(field) = _split-authors(field).map(_format-name).join("; ")

#let _families(field) = _split-authors(field).map(raw => _name-parts(raw).at(0))

#let _titlecase(s) = {
  let t = lower(s)
  if t.len() == 0 { t } else { upper(t.clusters().at(0)) + t.clusters().slice(1).join() }
}

#let _cite-authors(field, caixa: "upper", narrativo: false) = {
  let fams = _families(field)
  // Narrativa: mantém a grafia do .bib (McClelland, Typst GmbH); só normaliza nomes
  // escritos todo em maiúsculas ou todo em minúsculas.
  let aplica = if caixa == "upper" { f => upper(f) } else {
    f => if f == upper(f) or f == lower(f) { _titlecase(f) } else { f }
  }
  if fams.len() == 0 {
    []
  } else if fams.len() > 3 {
    [#aplica(fams.at(0)) #emph[et al.]]
  } else if narrativo {
    if fams.len() == 1 { aplica(fams.at(0)) }
    else {
      let ini = fams.slice(0, fams.len() - 1).map(aplica).join(", ")
      [#ini e #aplica(fams.last())]
    }
  } else {
    fams.map(aplica).join("; ")
  }
}

// ---------------------------------------------------------------------------
// DESAMBIGUAÇÃO
// ---------------------------------------------------------------------------

#let _year(entry) = entry.fields.at("year", default: "")

#let _ay-key(entry) = {
  let fams = _families(entry.fields.at("author", default: ""))
  lower(fams.at(0, default: "")) + "|" + _year(entry)
}

#let _cite-order(markers) = {
  let order = ()
  for m in markers { if m.value not in order { order.push(m.value) } }
  order
}

#let _suffixes(order, entries) = {
  let groups = (:)
  for k in order {
    let ks = str(k)
    if ks in entries {
      let ay = _ay-key(entries.at(ks))
      groups.insert(ay, groups.at(ay, default: ()) + (ks,))
    }
  }
  let smap = (:)
  for (ay, ks) in groups {
    if ks.len() > 1 {
      for (idx, k) in ks.enumerate() { smap.insert(k, numbering("a", idx + 1)) }
    }
  }
  smap
}

// ---------------------------------------------------------------------------
// ESTADO + MARCADORES
// ---------------------------------------------------------------------------

#let _bibsrc = state("ifba-bibsrc", "")
#let register-bib(content) = _bibsrc.update(content)
#let _entries() = _parse-bib(_bibsrc.get())
#let _mark(k) = [#metadata(str(k))<ifba-cite-mark>]
#let alias-ref = {
  show ref: it => {
    let k = str(it.target)
    context {
      let entries = _entries()
      if k in entries { cite(k) } else { it }
    }
  }
}

// ---------------------------------------------------------------------------
// CITAÇÕES PÚBLICAS
// ---------------------------------------------------------------------------

// Citação parentética: (SILVA, 2020) ou (SILVA, 2020a; SOUZA, 2021)
#let cite(..keys, supplement: none) = {
  let ks = keys.pos()
  ks.map(_mark).join()
  context {
    let entries = _entries()
    let smap = _suffixes(_cite-order(query(_CM)), entries)
    let parts = ks.map(k => {
      let ks_ = str(k)
      let e = entries.at(ks_, default: (type: "misc", fields: (author: ks_, year: "")))
      let base = text(fill: _text-color)[#_cite-authors(e.fields.at("author", default: ks_), caixa: "upper"), #(_year(e) + smap.at(ks_, default: ""))]
      if supplement != none and ks.len()==1 { [#base, #supplement] } else { base }
    })
    if supplement != none and ks.len()>1 { [(#parts.join[; ]; supplement)] } else { [(#parts.join[; ])] }
  }
}

// Citação narrativa: Silva (2020)
#let prose(key, supplement: none) = {
  _mark(key)
  context {
    let entries = _entries()
    let smap = _suffixes(_cite-order(query(_CM)), entries)
    let e = entries.at(key, default: (type: "misc", fields: (author: key, year: "")))
    let supp = if supplement != none { [, #supplement] } else { [] }
    text(fill: _text-color)[#_cite-authors(e.fields.at("author", default: key), caixa: "title", narrativo: true) (#(_year(e) + smap.at(key, default: ""))#supp)]
  }
}

// ---------------------------------------------------------------------------
// CITAÇÕES DIRETAS
// ---------------------------------------------------------------------------

#let citacao-curta(body) = {
  quote(block: false)[#body]
}

#let citacao-longa(body, autor: none, ano: none, pagina: none, citation: none) = block(
  width: 100%,
  inset: (left: 4cm),
  {
    set text(size: 10pt)
    set par(leading: 0.65em, spacing: 0.65em, first-line-indent: 0pt, justify: true)
    body
    if citation != none {
      [ #citation]
    } else if autor != none {
      let pg = if pagina != none { [, p. #pagina] } else { [] }
      [ (#upper(autor), #ano#pg)]
    }
  },
)

// ---------------------------------------------------------------------------
// FORMATAÇÃO DE ENTRADAS BIBLIOGRÁFICAS (ABNT NBR 6023:2018)
// ---------------------------------------------------------------------------

#let _g(f, name) = f.at(name, default: "")
#let _endash(s) = s.replace("-", "–")
#let _sentence(s) = _titlecase(s)
#let _dot(s) = if s == "" or s.ends-with(".") or s.ends-with("?") or s.ends-with("!") { s } else { s + "." }

#let _pub-addr(f) = {
  let addr = _g(f, "address")
  let pub = _g(f, "publisher")
  let l = if addr != "" { addr } else { "[S.l.]" }
  let e = if pub != "" { pub } else { "[s.n.]" }
  if addr == "" and pub == "" { "[S.l.: s.n.]" } else { l + ": " + e }
}

#let _edition(f) = {
  let ed = _g(f, "edition")
  if ed == "" { none }
  else if ed.match(regex("^[0-9]")) != none { ed + ". ed." } else { ed }
}

#let _vnp(f) = {
  let out = []
  if _g(f, "volume") != "" { out += [, v. #_g(f, "volume")] }
  if _g(f, "number") != "" { out += [, n. #_g(f, "number")] }
  if _g(f, "pages") != "" { out += [, p. #_endash(_g(f, "pages"))] }
  out
}

#let _render-entry(entry) = {
  let f = entry.fields
  let t = entry.type
  let aut = _authors-bib(_g(f, "author"))
  let yr = _year(entry)

  if t == "article" {
    let out = [#_dot(aut) #_sentence(_g(f, "title")). #emph(_g(f, "journal"))]
    if _g(f, "publisher") != "" { out += [, #_g(f, "publisher")] }
    if _g(f, "address") != "" { out += [, #_g(f, "address")] }
    out += _vnp(f)
    if yr != "" { out += [, #yr] }
    out += [.]
    out
  } else if t == "book" or t == "manual" or t == "techreport" {
    let out = [#_dot(aut) #emph(_g(f, "title"))]
    let ed = _edition(f)
    if ed != none { out += [. #ed] }
    // "9. ed." já termina em ponto: não duplicar antes do local.
    let sep = if ed != none and ed.ends-with(".") { [ ] } else { [. ] }
    if t == "book" {
      out += sep + [#_pub-addr(f)]
      if yr != "" { out += [, #yr] }
    } else {
      let addr = _g(f, "address")
      out += [. #(if addr != "" { addr } else { "[S.l.]" })]
      if yr != "" { out += [, #yr] }
    }
    if _g(f, "pages") != "" { out += [. #_g(f, "pages") p.] }
    out += [.]
    out
  } else if t == "inbook" or t == "incollection" {
    let out = [#_dot(aut) #_sentence(_g(f, "title")). In: ]
    if t == "inbook" { out += [#"______". ] }
    else if _g(f, "editor") != "" { out += [#_authors-bib(_g(f, "editor")) (Ed.). ] }
    out += [#emph(_g(f, "booktitle"))]
    let ed = _edition(f)
    if ed != none { out += [. #ed] }
    out += if ed != none and ed.ends-with(".") { [ #_pub-addr(f)] } else { [. #_pub-addr(f)] }
    if yr != "" { out += [, #yr] }
    if _g(f, "pages") != "" { out += [, p. #_endash(_g(f, "pages"))] }
    out += [.]
    out
  } else if t == "inproceedings" or t == "conference" {
    let out = [#_dot(aut) #_sentence(_g(f, "title")). In: ]
    if _g(f, "organization") != "" { out += [#upper(_g(f, "organization")). ] }
    else if _g(f, "editor") != "" { out += [#_authors-bib(_g(f, "editor")) (Ed.). ] }
    out += [#emph(_g(f, "booktitle")). #_pub-addr(f)]
    if yr != "" { out += [, #yr] }
    if _g(f, "pages") != "" { out += [. p. #_endash(_g(f, "pages"))] }
    out += [.]
    out
  } else if t == "phdthesis" or t == "mastersthesis" {
    let out = [#_dot(aut) #emph(_g(f, "title")).]
    if _g(f, "pages") != "" { out += [ #_g(f, "pages") f.] }
    let tt = if t == "phdthesis" { "Tese (Doutorado)" } else { "Dissertação (Mestrado)" }
    out += [ #tt -- #_g(f, "school")]
    if _g(f, "address") != "" { out += [, #_g(f, "address")] }
    if yr != "" { out += [, #yr] }
    out += [.]
    out
  } else {
    let out = [#_dot(aut) #emph(_g(f, "title"))]
    if _g(f, "howpublished") != "" { out += [. #_g(f, "howpublished")] }
    if yr != "" { out += [, #yr] }
    out += [.]
    if _g(f, "url") != "" { out += [ Disponível em: <#_g(f, "url")>.] }
    out
  }
}

// ---------------------------------------------------------------------------
// BACK-REFERENCES
// ---------------------------------------------------------------------------

#let _backref(markers, key) = {
  let seen = (:)
  for m in markers.filter(m => str(m.value) == str(key)) {
    let p = counter(page).at(m.location()).first()
    if str(p) not in seen { seen.insert(str(p), m.location()) }
  }
  let pages = seen.pairs().map(((k, v)) => (p: int(k), loc: v)).sorted(key: x => x.p)
  let n = pages.len()
  let plink(x) = link(x.loc, text(fill: _text-color, str(x.p)))
  if n == 0 { [Nenhuma citação no texto.] }
  else if n == 1 { [Citado na página #plink(pages.at(0)).] }
  else {
    let ini = pages.slice(0, n - 1).map(plink).join(", ")
    [Citado #n vezes nas páginas #ini e #plink(pages.last()).]
  }
}

// ---------------------------------------------------------------------------
// LISTA DE REFERÊNCIAS
// ---------------------------------------------------------------------------

#let _padnum(n) = {
  let s = str(n)
  ("0" * (6 - s.len())) + s
}

#let references(title: "REFERÊNCIAS") = {
  heading(level: 1, numbering: none, outlined: true)[#upper(title)]
  context {
    let entries = _entries()
    let markers = query(_CM)
    let order = _cite-order(markers)
    let idx = (:)
    for (n, k) in order.enumerate() { idx.insert(str(k), n) }
    let cited = order.filter(k => str(k) in entries)
    let sorted = cited.sorted(key: k => {
      let e = entries.at(str(k))
      let sa = upper(_authors-bib(_g(e.fields, "author")))
      sa + "\u{1}" + _year(e) + "\u{1}" + lower(_g(e.fields, "title")) + "\u{1}" + _padnum(idx.at(str(k)))
    })
    set par(leading: 0.65em, spacing: 1.3em, first-line-indent: 0pt, justify: true)
    for k in sorted {
      block(_render-entry(entries.at(str(k))) + " " + _backref(markers, str(k)))
    }
  }
}
