// 三線表 (three-line table): a rule above the header, one below it, one under
// the last row, and nothing else -- latex's booktabs look.
//
//   #tlt(
//     caption: [各校浮水印],
//     columns: (auto, 1fr),
//     header: ([學校], [浮水印]),
//     rows: (([政大], [有]), ([臺大], [有])),
//     notes: [資料來源：各校教務處。],   // 印成「註：資料來源……」
//   ) <tbl:watermark>
//
// `notes-label` changes that prefix, and `notes-label: none` drops it.

#let rules = (
  thick: 0.08em, // the top and bottom rules
  thin: 0.05em, // below the header
)

// latex booktabs' three rules, exposed by name for anyone building a table by
// hand with `table()` instead of `tlt()`. `tlt()` itself draws these three
// automatically -- reach for them only to add a rule `tlt()` doesn't draw for
// you, e.g. a midrule between two blocks of body rows.
#let toprule = table.hline(stroke: rules.thick)
#let midrule = table.hline(stroke: rules.thin)
#let bottomrule = table.hline(stroke: rules.thick)

// latex booktabs' `\cmidrule{a-b}`: a midrule under just columns a through b
// (1-indexed, inclusive -- the same numbers you'd write in LaTeX). Used to
// underline a grouped header that spans only some of the table's columns.
#let cmidrule(a, b, stroke: rules.thin) = table.hline(start: a - 1, end: b, stroke: stroke)

#let tlt(
  caption: none,
  columns: auto,
  align: center + horizon,
  header: (),
  rows: (),
  inset: (x: 0.6em, y: 0.45em), // cell padding, i.e. how tall a row sits
  thick: rules.thick, // weight of the top and bottom rules, this table only
  thin: rules.thin, // weight of the rule under the header, this table only
  notes: none,
  notes-label: [註：],
  supplement: auto,
  ..args,
) = figure(
  {
    let top = table.hline(stroke: thick)
    let mid = table.hline(stroke: thin)
    let bottom = table.hline(stroke: thick)
    table(
      columns: columns,
      align: align,
      stroke: none,
      inset: inset,
      ..args,
      ..if header.len() > 0 {
        (table.header(repeat: true, top, ..header, mid),)
      } else {
        (top,)
      },
      ..rows.flatten(),
      bottom,
    )
    // table notes sit under the bottom rule, flush left, one size down
    if notes != none {
      let body = if notes-label == none { notes } else { notes-label + notes }
      // `align` is the parameter name above, so reach for the real function
      block(width: 100%, above: 0.5em, std.align(left, text(size: 0.9em, body)))
    }
  },
  caption: caption,
  kind: table,
  supplement: supplement,
)
