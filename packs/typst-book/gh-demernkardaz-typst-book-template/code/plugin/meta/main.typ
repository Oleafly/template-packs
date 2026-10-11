#import "../../utils/lib.typ": resolve-path

#let _meta = yaml("../../../meta/book.yml")

#let _interpolate(val) = {
  if type(val) == str {
    let result = ""
    let rest = val
    while rest.len() > 0 {
      let start = rest.position("#(")
      if start == none {
        result += rest
        break
      }
      result += rest.slice(0, start)
      rest = rest.slice(start + 2)
      let end = rest.position(")")
      if end == none {
        result += "#(" + rest
        break
      }
      let key-path = rest.slice(0, end)
      rest = rest.slice(end + 1)
      let resolved = resolve-path(_meta, key-path)
      if resolved != none {
        if type(resolved) == str {
          result += resolved
        } else if type(resolved) == int or type(resolved) == float {
          result += str(resolved)
        } else {
          result += "#(" + key-path + ")"
        }
      }
    }
    result
  } else {
    val
  }
}

#let _make-getter(prefix) = {
  (name, fallback: none) => {
    let path = if prefix != none { prefix + "." + name } else { name }
    let val = resolve-path(_meta, path)
    if val != none {
      if type(val) == array { val.map(_interpolate) }
      else { _interpolate(val) }
    } else {
      fallback
    }
  }
}

#let get          = _make-getter(none)
#let property     = _make-getter("property")
#let book         = _make-getter("book")
#let publisher    = _make-getter("publisher")
#let contributor  = _make-getter("contributor")
#let version      = _make-getter("version")
#let date         = _make-getter("date")
#let copyright    = _make-getter("copyright")
#let audience     = _make-getter("audience")
#let print        = _make-getter("print")
#let status       = _make-getter("status")
#let translation  = _make-getter("translation")
#let epigraph     = _make-getter("epigraph")

#let author = (name, fallback: none) => {
  let val = resolve-path(_meta, "author")
  if val == none { return fallback }
  let node = if type(val) == array {
    if val.len() == 0 { return fallback }
    val.first()
  } else {
    val
  }
  if type(node) != dictionary { return fallback }
  let field = node.at(name, default: none)
  if field != none {
    if type(field) == array { field.map(_interpolate) }
    else { _interpolate(field) }
  } else {
    fallback
  }
}

#let get-authors(..filters) = {
  let authors = resolve-path(_meta, "author")
  if authors == none { return () }
  let arr = if type(authors) == array { authors } else { (authors,) }

  let filter-dict = filters.named()

  arr.filter(a => {
    filter-dict.pairs().all(((key, val)) => {
      a.at(key, default: none) == val
    })
  }).map(a => {
    let result = (:)
    for (key, val) in a.pairs() {
      result.insert(key, _interpolate(val))
    }
    result
  })
}

#let get-contributors(..filters) = {
  let contributors = resolve-path(_meta, "contributor")
  if contributors == none or type(contributors) != array {
    return ()
  }

  let filter-dict = filters.named()

  contributors.filter(c => {
    filter-dict.pairs().all(((key, val)) => {
      c.at(key, default: none) == val
    })
  }).map(c => {
    let result = (:)
    for (key, val) in c.pairs() {
      result.insert(key, _interpolate(val))
    }
    result
  })
}

#let get-asset(name, key: "path") = {
  let assets = resolve-path(_meta, "asset")
  if assets == none or type(assets) != array {
    return none
  }

  let asset = assets.find(a => a.at("name", default: none) == name)
  if asset == none {
    return none
  }

  if key == none {
    let result = (:)
    for (k, val) in asset.pairs() {
      result.insert(k, _interpolate(val))
    }
    result
  } else {
    let val = asset.at(key, default: none)
    if val != none { _interpolate(val) }
  }
}

#let get-history() = {
  let history = resolve-path(_meta, "history")
  if history == none or type(history) != array {
    return ()
  }
  history.map(h => {
    let result = (:)
    for (key, val) in h.pairs() {
      result.insert(key, _interpolate(val))
    }
    result
  })
}


#let _make-has(prefix) = {
  (name) => {
    let path = if prefix != none {
      prefix + "." + name
    } else {
      name
    }

    resolve-path(_meta, path) != none
  }
}

#let has          = _make-has(none)
#let property-has = _make-has("property")
#let book-has     = _make-has("book")
#let publisher-has = _make-has("publisher")
#let contributor-has = _make-has("contributor")
#let version-has  = _make-has("version")
#let date-has     = _make-has("date")
#let copyright-has = _make-has("copyright")
#let audience-has = _make-has("audience")
#let print-has    = _make-has("print")
#let status-has   = _make-has("status")
#let translation-has = _make-has("translation")
#let epigraph-has = _make-has("epigraph")
