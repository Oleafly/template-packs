#import "config.typ": *

#let get-value(data, key, default: none) = {
  if key in data { data.at(key) } else { default }
}

#let frame-cell-text(cell, body, size: auto) = context {
  set par(
    first-line-indent: 0pt,
    justify: false,
    leading: 0.8em,
    spacing: 0pt,
  )

  text(
    font: ("ГОСТ тип А", "Times New Roman"),
    style: "italic",
    size: if size == auto {
      get-value(cell, "text-size", default: 3.5mm)
    } else {
      size
    },
    body
  )
}

#let resolve-frame-cell-body(cell-data, fields) = {
  let text-value = get-value(cell-data, "text", default: [])
  if type(text-value) == str {
    if text-value.starts-with("_") and text-value in fields {
      fields.at(text-value)
    }
  } else if type(text-value) == function {
    text-value(fields)
  } else {
    text-value
  }
}

#let fit-frame-cell-text(cell-data, body) = context {
  let no-wrap = get-value(cell-data, "nowrap", default: cell-data.height == 5mm)
  let inset = get-value(cell-data, "inset", default: 1mm)
  let cell-align = get-value(cell-data, "align", default: center)
  let available-width = cell-data.width - inset * 2
  let natural-content = frame-cell-text(cell-data, body)
  let natural-width = measure(natural-content).width
  let width-factor = if no-wrap and natural-width > available-width and natural-width > 0pt {
    calc.min(100%, available-width / natural-width * 100%)
  } else {
    100%
  }

  if no-wrap {
    box(scale(x: width-factor, origin: cell-align + horizon, reflow: true)[#natural-content])
  } else {
    natural-content
  }
}

#let draw-frame-cell(cell-data, table, fields, origin) = {
  let body = resolve-frame-cell-body(cell-data, fields)
  let inset = get-value(cell-data, "inset", default: 1mm)
  let cell-align = get-value(cell-data, "align", default: left)

  place(
    top + left,
    dx: origin.x + cell-data.x,
    dy: origin.y + cell-data.y,
    rect(
      width: cell-data.width,
      height: cell-data.height,
      stroke: get-value(cell-data, "stroke", default: thin-stroke),
      fill: none,
      inset: inset,
      align(horizon + cell-align, fit-frame-cell-text(cell-data, body))
    )
  )
}

#let draw-frame-line(line-data, table, origin) = {
  place(
    top + left,
    dx: origin.x,
    dy: origin.y,
    line(
      start: (line-data.x1, line-data.y1),
      end: (line-data.x2, line-data.y2),
      stroke: get-value(line-data, "stroke", default: 1pt)
    )
  )
}

#let draw-table(table, fields) = {
  let origin = (
    x: if page.flipped {
      page.height - table.width - 5mm
    } else {
      page.width - table.width - 5mm
    },
    y: if page.flipped {
      page.width - table.height - 5mm
    } else {
      page.height - table.height - 5mm
    }
  )

  for cell-data in table.cells {
    draw-frame-cell(cell-data, table, fields, origin)
  }

  for line-data in table.lines {
    draw-frame-line(line-data, table, origin)
  }
}

#let resolve-frame-table(table, page-num, start-page) = {
  if type(table) == dictionary and "first" in table and "continuation" in table {
    if page-num == start-page {
      table.at("first")
    } else {
      table.at("continuation")
    }
  } else {
    table
  }
}

#let table-bottom-margin(table) = {
  if type(table) == dictionary and "first" in table and "continuation" in table {
    calc.max(table.at("first").height, table.at("continuation").height) + 5mm + 10mm
  } else {
    table.height + 5mm + 10mm
  }
}

#let make-background(fields, table, start-page) = context {
  let page-num = counter(page).get().first()
  if page-num < start-page { return }
  let active-table = resolve-frame-table(table, page-num, start-page)

  place(
    top + left,
    dx: 20mm,
    dy: 5mm,
    rect(
      width: if page.flipped { page.height - 25mm } else { page.width - 25mm },
      height: if page.flipped { page.width - 10mm } else { page.height - 10mm },
      stroke: thick-stroke,
      fill: none
    )
  )

  let numbering = (
    _page: [#counter(page).display()],
    _pages: [#counter(page).final().first()]
  )

  draw-table(active-table, numbering + fields)
}

#let frame(fields, table: dictionary, doc) = context {
  if table == none {
    set page(
      margin: (bottom: 20mm),
      background: none
    )
    doc
    return
  }
  let start-page = counter(page).get().first()
  let bottom-margin = table-bottom-margin(table)

  set page(
    margin: (bottom: bottom-margin),
    background: make-background(fields, table, start-page)
  )
  doc
}
