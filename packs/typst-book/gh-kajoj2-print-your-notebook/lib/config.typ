// Loads config/notebook.toml and turns numbers into lengths/colours.
// Requires compiling with --root . (paths are relative to the project root).

#let _input(key, default) = sys.inputs.at(key, default: default)

// Insert settings (--input config=/inserts/<insert>.toml, passed by nb.py) override
// config/notebook.toml key by key; missing sections (printer, duplex) stay from the config.
#let _merge(base, over) = {
  let out = base
  for (k, v) in over {
    let b = out.at(k, default: none)
    out.insert(k, if type(v) == dictionary and type(b) == dictionary { _merge(b, v) } else { v })
  }
  out
}
#let toml-cfg = {
  let base = toml("/config/notebook.toml")
  let extra = _input("config", none)
  if extra == none { base } else { _merge(base, toml(extra)) }
}
#let _mm(x) = x * 1mm

#let format-name = _input("format", toml-cfg.insert.format)
#assert(format-name in toml-cfg.formats, message: "Unknown format: " + format-name)
#let _fmt = toml-cfg.formats.at(format-name)

#let cfg = (
  format: format-name,
  width: _mm(_fmt.width),
  height: _mm(_fmt.height),
  // true: 2 spreads one above the other on portrait A4 (see lib/sheet.typ)
  stacked: _fmt.at("stacked", default: false),
  pages: int(_input("pages", str(toml-cfg.insert.pages))),
  lang: toml-cfg.insert.lang,
  margin: (
    top: _mm(toml-cfg.margins.top),
    bottom: _mm(toml-cfg.margins.bottom),
    inside: _mm(toml-cfg.margins.inner),
    outside: _mm(toml-cfg.margins.outer),
  ),
  grid: (
    type: _input("grid", toml-cfg.grid.type),
    spacing: _mm(toml-cfg.grid.spacing),
    dot-diameter: _mm(toml-cfg.grid.dot_diameter),
    line-width: _mm(toml-cfg.grid.line_width),
    color: rgb(toml-cfg.grid.color),
    // accent: margin line, bold lines of graph paper, calligraphy baseline, storyboard frames
    accent: rgb(toml-cfg.grid.at("accent", default: toml-cfg.grid.color)),
  ),
  ink: (
    text: rgb(toml-cfg.ink.text),
    line: rgb(toml-cfg.ink.line),
    line-width: _mm(toml-cfg.ink.line_width),
  ),
  font: (family: toml-cfg.font.family, size: toml-cfg.font.size * 1pt),
  numbers: (
    enabled: toml-cfg.page_numbers.enabled,
    size: toml-cfg.page_numbers.size * 1pt,
    color: rgb(toml-cfg.page_numbers.color),
    x: _mm(toml-cfg.page_numbers.from_edge_x),
    y: _mm(toml-cfg.page_numbers.from_edge_y),
    // "outer" = outer corner, "center" = middle of the bottom edge
    position: toml-cfg.page_numbers.at("position", default: "outer"),
  ),
  year: int(_input("year", str(toml-cfg.calendar.year))),
  // "monday" | "sunday": first day of the week in calendars
  week-start: toml-cfg.calendar.at("week_start", default: "monday"),
  printer: (
    sheet-width: _mm(toml-cfg.printer.sheet_width),
    sheet-height: _mm(toml-cfg.printer.sheet_height),
    unprintable: _mm(toml-cfg.printer.unprintable),
  ),
  duplex: (
    dx: _mm(toml-cfg.duplex.dx),
    dy: _mm(toml-cfg.duplex.dy),
    even-reverse: toml-cfg.duplex.even_reverse,
    rotate-back: toml-cfg.duplex.rotate_back,
  ),
  marks: (
    enabled: toml-cfg.marks.enabled,
    color: rgb(toml-cfg.marks.color),
    width: _mm(toml-cfg.marks.width),
    length: _mm(toml-cfg.marks.length),
    gap: _mm(toml-cfg.marks.gap),
    band-start: _mm(toml-cfg.marks.band_start),
    band-length: _mm(toml-cfg.marks.band_length),
  ),
)

// Height of the page number box (must fit in the bottom margin).
#let number-box-height = 3.5mm

// --- geometry checks: a compile error instead of a bad print ---
#{
  let m = cfg.margin
  let u = cfg.printer.unprintable
  for (name, v) in m {
    assert(v >= u, message: "Margin " + name + " (" + repr(v) + ") is smaller than the printer's unprintable area (" + repr(u) + ")")
  }
  if cfg.numbers.enabled {
    assert(
      cfg.numbers.y + number-box-height / 2 <= m.bottom,
      message: "The page number overlaps the grid: increase margins.bottom or decrease page_numbers.from_edge_y",
    )
    assert(cfg.numbers.y - number-box-height / 2 >= u, message: "The page number is in the unprintable area")
  }
  if cfg.stacked {
    // portrait sheet: width = short side of A4, height = long side
    assert(2 * cfg.width <= cfg.printer.sheet-height, message: "The spread is wider than the portrait sheet")
    assert(2 * cfg.height <= cfg.printer.sheet-width, message: "Two spreads don't fit one above the other")
  } else {
    assert(2 * cfg.width <= cfg.printer.sheet-width, message: "The spread is wider than the sheet")
    assert(cfg.height <= cfg.printer.sheet-height, message: "The insert is taller than the sheet")
  }
}
