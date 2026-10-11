#import "../utils/lib.typ": parse-value

────────────────────────────────────────────────────────

#let _parse-value-ex(v) = {
  if type(v) == str {
    if v == "true"  { return true  }
    if v == "false" { return false }
    return parse-value(v)
  }
  v
}

#let _parse-dict(dict) = {
  let result = (:)
  for (k, v) in dict {
    result.insert(k, if type(v) == dictionary {
      _parse-dict(v)
    } else {
      _parse-value-ex(v)
    })
  }
  result
}

#let _parse-track(track) = {
  if type(track) == int {
    (auto,) * track
  } else if type(track) == array {
    track.map(entry => {
      if type(entry) == dictionary {
        let val = entry.at("width", default: entry.at("height", default: "auto"))
        _parse-value-ex(if type(val) == str { val } else { repr(val) })
      } else {
        _parse-value-ex(if type(entry) == str { entry } else { repr(entry) })
      }
    })
  } else {
    track
  }
}

#let _field-content(val) = {
  if type(val) != str { return [#val] }
  let parts = val.split("\n\n").map(p => p.trim()).filter(p => p.len() > 0)

  for part in parts {
    let lines = part.split("\n").map(l => l.trim()).filter(l => l.len() > 0)
    par(lines.join(" "))
  }
}

#let _apply-item-style(item-style, body) = {
  if type(item-style) != dictionary {
    return body
  }
  if "text" in item-style {
    let td = _parse-dict(item-style.text)
    body = { set text(..td); body }
  }
  if "paragraph" in item-style {
    let pd = _parse-dict(item-style.paragraph)
    body = { set par(..pd); body }
  }
  body
}

#let _apply-use-style(use-style, body) = {
  if type(use-style) != dictionary {
    return body
  }
  let par-name  = use-style.at("paragraph", default: none)
  let text-name = use-style.at("text",      default: none)
  if text-name != none {
    let text-path = if text-name == "" {
      "../../style/text.yml"
    } else {
      "../../style/text/" + text-name + ".yml"
    }
    let td = _parse-dict(yaml(text-path))
    body = { set text(..td); body }
  }
  if par-name != none {
    let par-path = if par-name == "" {
      "../../style/paragraph.yml"
    } else {
      "../../style/paragraph/" + par-name + ".yml"
    }
    let pd = _parse-dict(yaml(par-path))
    body = { set par(..pd); body }
  }
  body
}

#let _wrap-margin(item, body) = {
  let m = if "margin" in item { item.margin } else { (:) }
  let top    = if "top"    in m { parse-value(str(m.top))    } else { none }
  let bottom = if "bottom" in m { parse-value(str(m.bottom)) } else { none }
  if top    != none { body = { v(top);    body } }
  if bottom != none { body = { body; v(bottom) } }
  body
}

#let _build-table-item(ti, fields) = {
  if "field" in ti {
    let val = fields.at(ti.field, default: "")
    _field-content(val)
  } else if "text" in ti {
    [#(ti.text)]
  } else {
    []
  }
}

#let _parse-style-map(dict) = {
  let result = (:)
  for (k, v) in dict {
    let parsed = if type(v) == dictionary {
      _parse-style-map(v)
    } else if type(v) == array {
      v.map(el => _parse-value-ex(if type(el) == str { el } else { repr(el) }))
    } else if type(v) == str {
      _parse-value-ex(v)
    } else {
      v
    }
    result.insert(k, parsed)
  }
  result
}

#let _build-table-box(item, fields) = {
  let td     = item.table
  let tw     = if "table-width" in td { parse-value(td.table-width) } else { 100% }
  let rows   = if "rows"    in td { td.rows    } else { auto }
  let cols-v = if "columns" in td { td.columns } else { auto }

  let tbl-props = (:)
  if "table-style" in td {
    tbl-props = _parse-style-map(td.table-style)
  }
  if "columns" not in tbl-props { tbl-props.insert("columns", cols-v) }
  if "rows"    not in tbl-props { tbl-props.insert("rows",    rows)   }

  let cell-text-props = (:)
  if "table-cell-style" in td {
    cell-text-props = _parse-style-map(td.table-cell-style)
  }

  let items  = if "table-items" in td { td.table-items } else { () }
  let n-rows = if "rows" in tbl-props { tbl-props.rows } else { 1 }
  let n-cols = {
    let c = tbl-props.columns
    if type(c) == array { c.len() }
    else if type(c) == int { c }
    else { 1 }
  }

  let cells = range(n-rows * n-cols).map(_ => [])
  for ti in items {
    let r   = (ti.at("row", default: 1)) - 1
    let c   = (ti.at("col", default: 1)) - 1
    let idx = r * n-cols + c
    if idx >= 0 and idx < cells.len() {
      cells.at(idx) = _build-table-item(ti, fields)
    }
  }

  let final-cells = if cell-text-props.len() > 0 {
    cells.map(cell => { set text(..cell-text-props); cell })
  } else {
    cells
  }

  block(width: tw, table(..tbl-props, ..final-cells))
}

 ────────────────────────────────────────────────────────────

#let _build-grid(config, fields) = {
  let items = config.at("grid-items", default: ())

  let grid-props = (:)
  if "grid-style" in config {
    grid-props = _parse-style-map(config.grid-style)
  }

  let col-count = {
    let c = grid-props.at("columns", default: 1)
    if type(c) == array { c.len() } else if type(c) == int { c } else { 1 }
  }
  let row-count = {
    let r = grid-props.at("rows", default: 1)
    if type(r) == array { r.len() } else if type(r) == int { r } else { 1 }
  }

  let cells = (:)

  for item in items {
    let r   = item.at("row", default: 1)
    let c   = item.at("col", default: 1)
    let key = str(r) + "," + str(c)

    let content = if "field" in item {
      let val = fields.at(item.field, default: "")
      _field-content(val)
    } else if "text" in item {
      [#(item.text)]
    } else if "table" in item {
      _build-table-box(item, fields)
    } else {
      []
    }

    if "style" in item {
      content = _apply-item-style(item.style, content)
    }
    if "use-style" in item {
      content = _apply-use-style(item.at("use-style"), content)
    }

    content = _wrap-margin(item, content)

    if key in cells {
      cells.insert(key, cells.at(key) + parbreak() + content)
    } else {
      cells.insert(key, content)
    }
  }

  let grid-cells = range(row-count).map(ri => {
    range(col-count).map(ci => {
      let key = str(ri + 1) + "," + str(ci + 1)
      block(cells.at(key, default: []))
    })
  }).join()

  grid(..grid-props, ..grid-cells)
}

──────────────────────────────────────────────────────────────

#let new(name: "", fields) = {
  let path = if name == "" {
    "../../style/catalog-card.yml"
  } else {
    "../../style/catalog-card/" + name + ".yml"
  }

  let config = yaml(path)
  let uses   = config.at("uses-style", default: (:))

  let par-name  = uses.at("paragraph", default: none)
  let text-name = uses.at("text",      default: none)

  let rect-defaults = (width: 100%, height: auto)
  let rect-overrides = if "style" in config { _parse-dict(config.style) } else { (:) }
  let rect-props = rect-defaults + rect-overrides

  let card-type = config.at("type", default: "grid")

  let inner = if card-type == "grid" {
    _build-grid(config, fields)
  } else {
    [Неизвестный тип карточки: #card-type]
  }

  if text-name != none {
    let text-path = if text-name == "" {
      "../../style/text.yml"
    } else {
      "../../style/text/" + text-name + ".yml"
    }
    let td = _parse-dict(yaml(text-path))
    inner = { set text(..td); inner }
  }

  if par-name != none {
    let par-path = if par-name == "" {
      "../../style/paragraph.yml"
    } else {
      "../../style/paragraph/" + par-name + ".yml"
    }
    let pd = _parse-dict(yaml(par-path))
    inner = { set par(..pd); inner }
  }

	let result = box(..rect-props, inner)

  if "place" in config {
    let pl = config.place

    let alignment = if "position" in pl {
      let pos = pl.position
      let parts = if type(pos) == array { pos } else { (pos,) }
      let parsed = parts.map(p => parse-value(if type(p) == str { p } else { repr(p) }))
      parsed.fold(none, (acc, a) => if acc == none { a } else { acc + a })
    } else {
      auto
    }

    let place-props = (:)
    for (k, v) in pl {
      if k == "position" { continue }
      place-props.insert(k, _parse-value-ex(if type(v) == str { v } else { repr(v) }))
    }

    place(alignment, ..place-props, align(start, result))
  } else {
    result
  }
}
