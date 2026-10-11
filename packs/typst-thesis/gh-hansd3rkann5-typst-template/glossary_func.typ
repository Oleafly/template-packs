#import "utils.typ": si, used-keys,
#import "config.typ": glossary-text-size, symbol-text-size, glossary-inset, col-abbr, col-symbols, stroke-thick, stroke-thin, stroke-main
#import "data.typ": glossary, symbols

// --- ABBREVIATIONS TABLE ---
#context {
  set text(size: glossary-text-size)
  let used-info = used-keys.final()
  let filtered-abbr = used-info
    .map(it => glossary.find(a => str(a.key) == it.key))
    .filter(a => a != none)

  if filtered-abbr.len() > 0 {
    heading(numbering: none)[List of abbreviations]
    table(
      columns: col-abbr, stroke: none, inset: glossary-inset,
      align: (left + horizon, left + horizon),
      table.hline(stroke: stroke-thick),
      [*Abbreviation*], [*Definition*],
      table.hline(stroke: stroke-main),
      ..filtered-abbr.map(a => (
        a.short,
        a.long,
        table.hline(stroke: stroke-thin)
      )).flatten(),
      table.hline(stroke: stroke-thick),
    )
    pagebreak()
  }
}

// --- FORMULA SYMBOLS ---
#context {
  set text(size: symbol-text-size)
  let used-info = used-keys.final()
  let filtered-symbols = used-info
    .map(it => symbols.find(s => str(s.key) == it.key))
    .filter(s => s != none)

  if filtered-symbols.len() > 0 {
    v(1cm)
    heading(numbering: none)[Formula Symbols]
    table(
      columns: col-symbols,
      stroke: none,
      inset: glossary-inset,
      align: (center + horizon, left + horizon, center + horizon, center + horizon),
      table.hline(stroke: stroke-thick),
      [*Symbol*], [*Description*], [*Unit*], [*Chapter*],
      table.hline(stroke: stroke-main),
      ..filtered-symbols.map(s => {
        let info = used-info.find(it => it.key == str(s.key))
        let ch = if info != none { info.ch } else { "-" }
        let rendered-unit = if s.unit == "" or s.unit == "none" { [-] } else { s.unit }
        (
          strong(s.short),
          s.long,
          text(style: "italic", rendered-unit),
          ch,
          table.hline(stroke: stroke-thin)
        )
      }).flatten(),
      table.hline(stroke: stroke-thick),
    )
  }
}
