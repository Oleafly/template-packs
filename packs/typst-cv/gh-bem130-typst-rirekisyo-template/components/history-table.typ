// history-table.typ
// 年 | 月 | 内容 の table() を返す純粋関数。
// 学歴・職歴（左右）・免許資格で共用する。
//
// 引数:
//   entries      - (year: str, month: str, body: str) の配列
//   header-label - ヘッダーセンターに表示するテキスト（例: "学　歴・職　歴（各別にまとめて書く）"）
//   row-count    - 表示する行数（entries が足りない場合は空行で埋める）
//   year-col-w   - 年カラム幅
//   month-col-w  - 月カラム幅
//   header-row-h - ヘッダー行高
//   body-row-h   - データ行高
//   stroke-outer - 外枠線
//   stroke-inner - 内側線

#let _empty-entry = (year: "", month: "", body: "")
#let _table-label-size = 11pt
#let _table-body-size = 11pt
#let _table-header-inset = (x: 5.5pt, y: 2.4pt)
#let _table-body-inset = (x: 5.5pt, y: 2.6pt)

#let _entry-at(entries, index) = {
  if index < entries.len() {
    entries.at(index)
  } else {
    _empty-entry
  }
}

#let _entry-cell(entry, key) = entry.at(key, default: "")

#let history-table(
  entries: (),
  header-label: "",
  row-count: 0,
  year-col-w: 13.5mm,
  month-col-w: 8.7mm,
  header-row-h: 8mm,
  body-row-h: 8.55mm,
  table-height: none,
  stroke-outer: 0.95pt,
  stroke-inner: 0.5pt,
) = {
  let actual-body-row-h = if table-height == none {
    body-row-h
  } else {
    (table-height - header-row-h) / row-count
  }

  let row-heights = range(0, row-count + 1).map(index => {
    if index == 0 { header-row-h } else { actual-body-row-h }
  })

  block(width: 100%, spacing: 0pt)[
    #table(
      columns: (year-col-w, month-col-w, 1fr),
      rows: row-heights,
      inset: (x, y) => if y == 0 { _table-header-inset } else { _table-body-inset },
      align: (x, y) => {
        if y == 0 or x < 2 {
          center + horizon
        } else {
          left + horizon
        }
      },
      stroke: (x, y) => {
        (
          left: if x == 0 { stroke-outer } else { stroke-inner },
          right: if x == 2 { stroke-outer } else { stroke-inner },
          top: if y == 0 { stroke-outer } else { stroke-inner },
          bottom: if y == row-count { stroke-outer } else { stroke-inner },
        )
      },

      table.cell[#text(size: _table-label-size)[年]],
      table.cell[#text(size: _table-label-size)[月]],
      table.cell[#text(size: _table-label-size)[#header-label]],

      ..range(0, row-count).map(index => {
        let entry = _entry-at(entries, index)
        (
          table.cell[#text(size: _table-body-size)[#_entry-cell(entry, "year")]],
          table.cell[#text(size: _table-body-size)[#_entry-cell(entry, "month")]],
          table.cell(align: left + horizon)[#text(size: _table-body-size)[#_entry-cell(entry, "body")]],
        )
      }).flatten(),
    )
  ]
}
