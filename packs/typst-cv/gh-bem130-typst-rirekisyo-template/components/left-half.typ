// left-half.typ
// 左面全体を返す純粋関数。
//
// セクション構成（上から）:
//   1. タイトル行: 「履歴書」+ 日付
//   2. 氏名欄: ふりがな / 氏名（大） + 写真オーバーレイ
//   3. 生年月日・性別欄
//   4. 現住所・連絡先欄（上下2段、右カラムに電話番号）
//   5. 学歴・職歴テーブル（左面分、history-table を使用）

#import "history-table.typ": history-table

#let _content-width = 168.487mm
#let _name-box-width = 113.03mm
#let _photo-width = 29.4mm
#let _photo-height = 42mm
#let _label-width = 28.152mm
#let _birth-main-width = _name-box-width
#let _sex-width = _content-width - _birth-main-width
#let _phone-width = 34.5mm
#let _title-band-h = 12.065mm
#let _title-offset-x = 3.6mm
#let _date-offset-x = 81.28mm
#let _photo-right-gap = 6.9mm
#let _photo-left-x = _content-width - _photo-right-gap - _photo-width
#let _photo-top-shift = 12.065mm
#let _title-box-w = 36mm
#let _address-upper-h = 24.342mm
#let _address-lower-h = 24.553mm
#let _name-part-w = 38mm
#let _name-gap-w = 8.878mm
#let _name-content-w = _name-box-width - 19.05mm
#let _title-size = 20pt
#let _small-label-size = 10pt
#let _label-size = 11pt
#let _body-size = 11pt
#let _address-body-size = 11pt
#let _footnote-size = 8pt
#let _note-size = 9pt


#let _date_stamp(date) = [
  #text(size: _label-size)[#date.display("[year]")]
  #h(5mm)
  #text(size: _label-size)[年]
  #h(5mm)
  #text(size: _label-size)[#date.display("[month padding:none]")]
  #h(5mm)
  #text(size: _label-size)[月]
  #h(5mm)
  #text(size: _label-size)[#date.display("[day padding:none]")]
  #text(size: _label-size)[日現在]
]

#let _date-row(date) = block(width: 100%, height: _title-band-h)[
  #place(left + horizon, dx: _title-offset-x)[
    #text(size: _title-size, tracking: 0.8em)[履歴書]
  ]
  #place(left + horizon)[
    #box(width: _name-box-width)[
      #align(right + horizon)[#_date_stamp(date)]
    ]
  ]
]

#let _photo(photo) = block(
  width: _photo-width,
  height: _photo-height,
  spacing: 0pt,
  clip: true,
  inset: (x: 7.2pt, y: 3.6pt),
  stroke: (paint: black, thickness: 0.30pt, dash: "dashed"),
)[
  #if photo == none [
    #v(8pt)
    #align(center)[#text(size: _footnote-size)[写真をはる位置]]
    #v(12pt)
    #align(left)[
      #text(size: _footnote-size)[写真をはる必要が]
      #linebreak()
      #text(size: _footnote-size)[ある場合]
      #linebreak()
      #text(size: _footnote-size)[1\. 縦]
      #linebreak()
      #text(size: _footnote-size)[　 横]
      #linebreak()
      #text(size: _footnote-size)[2.本人単身胸から上]
      #linebreak()
      #text(size: _footnote-size)[3.裏面のりづけ]
    ]
  ] else [
    #image(photo, width: 100%, height: 100%, fit: "cover")
  ]
]

#let _name-value(part, key) = {
  if type(part) == dictionary {
    part.at(key, default: "")
  } else {
    ""
  }
}

#let _name-family(name) = {
  if type(name) == dictionary {
    name.at("family-name", default: ())
  } else {
    ()
  }
}

#let _name-first(name) = {
  if type(name) == dictionary {
    name.at("first-name", default: ())
  } else {
    ()
  }
}

#let _name-ruby_row(name) = grid(
  columns: (1fr, 1fr),
  gutter: 0pt,
  align(center + horizon)[#text(size: _small-label-size)[#_name-value(_name-family(name), "ruby")]],
  align(center + horizon)[#text(size: _small-label-size)[#_name-value(_name-first(name), "ruby")]],
)

#let _name-base_row(name) = grid(
  columns: (1fr, 1fr),
  gutter: 0pt,
  align(center + horizon)[#text(font: "HGSeikaishotaiPRO", size: 28pt)[#_name-value(_name-family(name), "base")]],
  align(center + horizon)[#text(font: "HGSeikaishotaiPRO", size: 28pt)[#_name-value(_name-first(name), "base")]],
)

// _name_block
#let _name_block(name, stroke-outer, stroke-inner) = block(
  width: _name-box-width,
  height: 35.772mm,
  spacing: 0pt,
  inset: 0pt,
  stroke: stroke-outer,
  clip: true,
)[
  #table(
    columns: (1fr,),
    rows: (5.927mm, 1fr),
    inset: 0pt,
    stroke: none,

    // Row 0: ふりがな (no vertical line)
    table.cell(
      stroke: (bottom: stroke-inner),
      inset: (x: 4.5pt, y: 0pt),
    )[
      #place(left + horizon)[#text(size: _small-label-size)[ふりがな]]
      #align(center + horizon)[#_name-ruby_row(name)]
    ],

    // Row 1: 氏名本体 (no vertical line)
    table.cell(inset: 0pt)[
      #place(top + left, dx: 3.4pt, dy: 3pt)[#text(size: _label-size)[氏　　名]]
      #align(center + horizon)[#_name-base_row(name)]
    ],
  )
]

// _address_section: table()方式（学歴欄と同じアプローチ）
// left側（label+content 2列）とphone側（1列）をgridで並べる
#let _address_section(
  label-head,
  label-body,
  furigana,
  body,
  phone,
  note: none,
  head-h: 5.927mm,
  label-row-h: 5.503mm,
  body-row-h: 12.912mm,
  phone-label-h: none,
  phone-body-h: none,
  stroke-inner: 0.5pt,
) = {
  let actual-phone-label-h = if phone-label-h == none { head-h } else { phone-label-h }
  let actual-phone-body-h = if phone-body-h == none { label-row-h + body-row-h } else { phone-body-h }
  let _main-w = _content-width - _phone-width

  grid(
    columns: (_main-w, _phone-width),
    gutter: 0pt,

    // ── 左側: 3行テーブル ──────────────────────────────
    table(
      columns: (1fr,),
      rows: (head-h, label-row-h, body-row-h),
      inset: 0pt,
      stroke: none,

      // Row 0: ふりがな label & furigana content within one cell (no vertical line)
      table.cell(
        stroke: (bottom: stroke-inner, right: stroke-inner),
        inset: (x: 4.5pt, y: 0pt),
      )[
        #place(left + horizon)[#text(size: _small-label-size)[#label-head]]
        #place(left + horizon, dx: _label-width)[#text(size: _small-label-size)[#furigana]]
      ],

      // Row 1: 住所ラベル (下罫線なし)
      table.cell(
        stroke: (right: stroke-inner),
        inset: (x: 3.4pt, top: 3.4pt, bottom: 0pt),
      )[
        #align(left + top)[
          #text(size: _label-size)[#label-body]
          #if note != none { h(1fr); text(size: _note-size)[#note] }
        ]
      ],

      // Row 2: 住所本体
      table.cell(
        stroke: (right: stroke-inner),
        inset: (x: 3.8pt, y: 0pt),
      )[
        #align(left + horizon)[#set text(size: _address-body-size); #body]
      ]
    ),

    // ── 右側: 電話 2行テーブル ────────────────────────
    table(
      columns: (1fr,),
      rows: (actual-phone-label-h, actual-phone-body-h),
      inset: 0pt,
      stroke: none,
      
      // 電話ラベル (下罫線なし)
      table.cell(
        inset: (x: 3.4pt, top: 3.4pt, bottom: 0pt),
      )[
        #align(left + top)[#text(size: _label-size)[電話]]
      ],

      // 電話本体
      table.cell(
        inset: (x: 3.4pt, y: 0pt),
      )[
        #align(left + horizon)[#text(size: _label-size)[#phone]]
      ]
    ),
  )
}


#let left-half(
  date,
  name: (),
  birth-year: "",
  birth-month: "",
  birth-day: "",
  age: "",
  sex: "",
  furigana-address: "",
  address: [],
  phone-current: "",
  furigana-contact: "",
  contact: [],
  phone-contact: "",
  photo: none,
  history-left: (),
  year-col-w: 19.05mm,
  month-col-w: 9.102mm,
  header-row-h: 8mm,
  body-row-h: 8.55mm,
  stroke-outer: 0.95pt,
  stroke-inner: 0.5pt,
) = {
  grid(
    rows: (_title-band-h, 35.772mm, 58.632mm, 4.233mm, auto),
    gutter: 0mm,

    _date-row(date),

    [
      #place(top + right, dx: -_photo-right-gap, dy: -_photo-top-shift)[#_photo(photo)]
      #_name_block(
        name,
        stroke-outer,
        stroke-inner,
      )
    ],

    block(width: 100%, height: 58.632mm, spacing: 0pt, inset: 0pt, stroke: stroke-outer)[
      #table(
        columns: (1fr,),
        rows: (9.737mm, _address-upper-h, _address-lower-h),
        inset: 0pt,
        stroke: none,

        // 生年月日・性別行
        table.cell(stroke: (bottom: stroke-outer))[
          #table(
            columns: (_birth-main-width, _sex-width),
            rows: (9.737mm,),
            inset: 0pt,
            stroke: none,

            // 生年月日部分
            table.cell(stroke: (right: stroke-inner))[
              #align(center + horizon)[
                #text(size: _label-size)[#birth-year]
                #h(5mm)
                #text(size: _label-size)[年]
                #h(5mm)
                #text(size: _label-size)[#birth-month]
                #h(5mm)
                #text(size: _label-size)[月]
                #h(5mm)
                #text(size: _label-size)[#birth-day]
                #h(2mm)
                #text(size: _label-size)[日生]
                #h(8mm)
                #text(size: _label-size)[（満]
                #h(3mm)
                #text(size: _label-size)[#age]
                #h(3mm)
                #text(size: _label-size)[歳）]
              ]
            ],

            // 性別部分
            table.cell(inset: (top: 1.5pt, x: 3.4pt, bottom: 0pt))[
              #block(width: 100%, height: 100%, inset: 0pt)[
                #align(top + left)[#text(size: _label-size)[※性別]]
                #place(center + horizon)[#text(size: _label-size)[#sex]]
              ]
            ],
          )
        ],

        // 現住所
        table.cell(stroke: (bottom: stroke-inner))[
          #_address_section(
            [ふりがな],
            [現住所　〒],
            furigana-address,
            address,
            phone-current,
            head-h: 5.927mm,
            label-row-h: 5.503mm,
            body-row-h: 12.912mm,
            phone-label-h: 5.927mm,
            phone-body-h: 18.415mm,
            stroke-inner: stroke-inner,
          )
        ],

        // 連絡先
        table.cell()[
          #_address_section(
            [ふりがな],
            [連絡先　〒],
            furigana-contact,
            contact,
            phone-contact,
            note: [（現住所以外に連絡を希望する場合のみ記入）],
            head-h: 5.927mm,
            label-row-h: 5.715mm,
            body-row-h: 12.912mm,
            phone-label-h: 5.927mm,
            phone-body-h: 18.627mm,
            stroke-inner: stroke-inner,
          )
        ],
      )
    ],

    [], // Spacer

    [
      #history-table(
        entries: history-left,
        header-label: [学　歴　・　職　歴（各別にまとめて書く）],
        row-count: 16,
        year-col-w: year-col-w,
        month-col-w: month-col-w,
        header-row-h: 8.467mm,
        body-row-h: body-row-h,
        table-height: 165.139mm,
        stroke-outer: stroke-outer,
        stroke-inner: stroke-inner,
      )
      #v(2pt)
      #text(size: _footnote-size)[※「性別」欄: 記載は任意です。未記載とすることも可能です。]
    ],
  )
}
