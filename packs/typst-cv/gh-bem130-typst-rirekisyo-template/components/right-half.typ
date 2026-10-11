// right-half.typ
// 右面全体を返す純粋関数。
//
// セクション構成（上から）:
//   1. 学歴・職歴テーブル（右面分、history-table を使用、8行）
//   2. 免許・資格テーブル（history-table を使用、6行）
//   3. 志望動機欄（block + ヘッダー行 + テキストエリア）
//   4. 本人希望記入欄（block + ヘッダー行 + 4行）
//
// 行高さの計算 (右面コンテンツ高さ = 277mm - inset_y×2 = 257mm):
//   学歴・職歴  77.047mm
//   免許・資格  56.551mm  ← 257 - 77.047 - 4.233 - 66.887 - 4.022 - 48.26 = 56.551
//   gap         4.233mm
//   志望動機   66.887mm
//   gap         4.022mm
//   本人希望   48.260mm
//   合計       257.000mm

#import "history-table.typ": history-table

// history-table と統一したセルの余白・テキストサイズ
#let _table-header-inset  = (x: 5.5pt, y: 2.4pt)
#let _table-body-inset    = (x: 5.5pt, y: 2.6pt)
#let _section-title-size  = 11pt
#let _section-body-size   = 11pt

#let _section-block(title, body, height, head-h, line-count: none, stroke-outer: 0.95pt, stroke-inner: 0.5pt) = block(
  width: 100%,
  height: height,
  breakable: false,
  clip: true,
  spacing: 0pt,
  inset: 0pt,
  stroke: stroke-outer,
)[
  #table(
    columns: (1fr,),
    rows: (head-h, 1fr),
    inset: 0pt,
    stroke: none,
    table.cell(stroke: (bottom: stroke-inner), inset: _table-header-inset)[
      #align(left + horizon)[#text(size: _section-title-size)[#title]]
    ],
    table.cell(inset: 0pt)[
      // 4行の罫線の高さを基準にする (39.792mm は 本人希望のbody部分の高さ)
      #let hope-row-h = 39.792mm / 4
      #let body-text-size = 11pt
      #let my-leading = hope-row-h - body-text-size
      #let my-top-inset = (hope-row-h - body-text-size) / 2 + 1.5pt

      #block(width: 100%, height: 100%, inset: 0pt)[
        #if line-count != none [
          #table(
            columns: (1fr,),
            rows: range(0, line-count).map(_ => 1fr),
            inset: 0pt,
            stroke: (x, y) => (
              bottom: if y + 1 < line-count { 0.5pt } else { none },
            ),
            ..range(0, line-count).map(_ => table.cell[])
          )
        ]
        #place(top + left)[
          #block(width: 100%, inset: (x: 5.5pt, top: my-top-inset, bottom: 0pt))[
            #set text(size: body-text-size)
            #set par(leading: my-leading)
            #align(left + top)[#body]
          ]
        ]
      ]
    ],
  )
]

#let right-half(
  history-right: (),
  licenses: (),
  motivation: [],
  hope: [],
  year-col-w: 19.05mm,
  month-col-w: 9.102mm,
  header-row-h: 8mm,
  body-row-h: 8.55mm,
  stroke-outer: 0.95pt,
  stroke-inner: 0.5pt,
) = {
  grid(
    rows: (86.591mm, 67.007mm, 4.233mm, 66.887mm, 4.022mm, 48.26mm),
    gutter: 0mm,

    history-table(
      entries: history-right,
      header-label: [学　歴　・　職　歴（各別にまとめて書く）],
      row-count: 8,
      year-col-w: year-col-w,
      month-col-w: month-col-w,
      header-row-h: 8.255mm,
      body-row-h: body-row-h,
      table-height: 86.591mm,
      stroke-outer: stroke-outer,
      stroke-inner: stroke-inner,
    ),

    history-table(
      entries: licenses,
      header-label: [免　許　・　資　格],
      row-count: 6,
      year-col-w: year-col-w,
      month-col-w: month-col-w,
      header-row-h: 8.255mm,
      body-row-h: body-row-h,
      table-height: 67.007mm,
      stroke-outer: stroke-outer,
      stroke-inner: stroke-inner,
    ),

    [],

    _section-block(
      [志望の動機、特技、好きな学科、アピールポイントなど],
      motivation,
      66.887mm,
      7.832mm,
      stroke-outer: stroke-outer,
      stroke-inner: stroke-inner,
    ),

    [],

    _section-block(
      [本人希望記入欄（特に給料・職種・勤務時間・勤務地・その他についての希望などがあれば記入）],
      hope,
      48.26mm,
      8.467mm,
      line-count: 4,
      stroke-outer: stroke-outer,
      stroke-inner: stroke-inner,
    ),
  )
}
