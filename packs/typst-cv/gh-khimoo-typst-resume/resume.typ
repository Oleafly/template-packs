#let system-font-size = 8pt
#let name-font-size = 16pt
#let input-font-size = 10pt

#let font-serif = ("Noto Serif", "Noto Serif CJK JP")
#let font-sans = ("Noto Sans", "Noto Sans CJK JP")

#set text(font: font-serif, size: system-font-size)
#set page(paper: "jis-b5", margin: 1.5cm)

#let data = yaml("resume_data.yaml")

// === ユーティリティ関数 ===

// 生年月日から年齢を計算（満年齢）
#let calculate-age(birth-year, birth-month, birth-day) = {
  let today = datetime.today()
  let birth-date = datetime(year: birth-year, month: birth-month, day: birth-day)

  let age = today.year() - birth-date.year()

  // 誕生日がまだ来ていない場合は1歳引く
  if today.month() < birth-date.month() or (
    today.month() == birth-date.month() and today.day() < birth-date.day()
  ) {
    age = age - 1
  }

  age
}

// 中央揃えのボックス（学歴・職歴・資格用）
#let center-box(content, height: 12.6pt) = align(center + horizon, box(height: height)[#content])

// 左揃えのボックス
#let left-box(content, height: 12.6pt) = align(left + horizon, box(height: height)[#content])

// 右揃えのボックス
#let right-box(content, height: 12.6pt) = align(right + horizon, box(height: height)[#content])

// 年・月・内容の3列テーブル行を生成
#let timeline-row(year, month, desc, height: 12.6pt) = (
  center-box(year, height: height),
  center-box(month, height: height),
  left-box(desc, height: height)
)

// 空のタイムライン行
#let empty-row(height: 12.6pt) = timeline-row([], [], [], height: height)

// === コンポーネント ===

// 名前セクション
#let name-section(data) = {
  let name-row(label, yomi-field, name-field, font-size: name-font-size) = [
    #grid(
      columns: (1.5cm, 4cm, 1fr),
      label,
      [#align(center, data.at(yomi-field))],
      [#align(start, data.at(name-field))]
    )
  ]

  stack(
    place(top + right, dy: -10pt,
      datetime.today().display("[year]年[month]月[day]日現在")
    ),
    rect(
      stroke: (bottom: none, top: 1.5pt, left: 1.5pt, right: 1.5pt),
      height: auto,
      width: 100%,
      name-row([ふりがな], "sei_yomi", "mei_yomi")
    ),
    line(length: 100%, stroke: (dash: "dashed")),
    rect(
      stroke: (bottom: 0.5pt, top: none, left: 1.5pt, right: 1.5pt),
      height: auto,
      width: 100%,
      align(top,
        grid(
          columns: (1.5cm, 4cm, 1fr),
          [氏 #h(0.6cm) 名],
          pad(y: 0.4cm, align(center + horizon, text(name-font-size, data.sei))),
          pad(y: 0.4cm, align(start + horizon, text(name-font-size, data.mei)))
        )
      )
    )
  )
}

// 生年月日・性別セクション
#let birth-gender-section(data) = table(
  columns: (1fr, auto),
  stroke: (left: 1.5pt, right: 1.5pt, bottom: 0.5pt, top: none, y: 0.6pt),
  table.cell(stroke: (right: 0.5pt))[
    #align(start + top,
      grid(
        columns: (1.5cm, 1fr),
        [生年月日],
        pad(y: 0.2cm,
          pad(left: 1cm,
            text(input-font-size, [#data.birth.wareki 生 #h(0.6cm) (満 #h(0.5em) #calculate-age(data.birth.year, data.birth.month, data.birth.day) 才)])
          )
        )
      )
    )
  ],
  [
    #place(horizon + left, dx: -2pt, circle(radius: 6pt))
    #if data.gender != "男" [
      #place(horizon + right, dx: 2pt, circle(radius: 6pt))
    ]
    #align(center + horizon)[男・女]
  ]
)

// 写真セクション
#let photo-section(data) = {
  set text(size: 7pt)
  pad(bottom: 0.3cm, left: 0.4cm,
    box(
      stroke: (dash: "dashed"),
      height: 4cm,
      width: 3cm,
      image(data.photo, width: 3cm, height: 4cm)
    )
  )
}

// 住所セクション
#let address-section(data) = stack(
  grid(
    columns: (5fr, 2fr),
    stack(
      rect(
        stroke: (bottom: none, top: none, left: 1.5pt, right: 0.5pt),
        grid(
          columns: (1.5cm, 1fr),
          [ふりがな],
          [#align(center, data.address1_yomi)]
        )
      ),
      line(stroke: (dash: "dashed"), length: 100%)
    ),
    rect(
      width: 100%,
      stroke: (bottom: 0.5pt, top: 1.5pt, left: none, right: 1.5pt),
      [電話 #h(10pt) #data.tel1]
    )
  ),
  grid(
    columns: (5fr, 2fr),
    rect(
      width: 100%,
      height: 1.8cm,
      stroke: (bottom: 1.5pt, top: none, left: 1.5pt, right: 0.5pt),
      [
        [現住所 (〒 #text(tracking: 1pt, system-font-size, data.zip1))],
        #pad(y: 0.2cm, align(center, text(input-font-size, data.address1)))
      ]
    ),
    rect(
      width: 100%,
      height: 1.8cm,
      stroke: (bottom: 1.5pt, top: none, left: none, right: 1.5pt),
      [
        E-mail,
        #pad(y: 0.3cm, align(center, data.email1))
      ]
    )
  )
)

// タイムラインテーブル（学歴・職歴・資格共通）
#let timeline-table(entries, header-text, max-rows: 12) = {
  import table: cell

  // 空の行配列を生成
  let rows = (..range(max-rows).map(_ => empty-row())).flatten()

  // データ行を埋める
  let row-idx = 0
  for entry in entries {
    let (year, month, desc) = entry
    rows.at(row-idx * 3) = center-box(year)
    rows.at(row-idx * 3 + 1) = center-box(month)
    rows.at(row-idx * 3 + 2) = left-box(desc)
    row-idx += 1
  }

  // ヘッダー行を追加
  rows.at(row-idx * 3) = center-box([])
  rows.at(row-idx * 3 + 1) = center-box([])
  rows.at(row-idx * 3 + 2) = center-box(text(size: 10pt, header-text))
  row-idx += 1

  // "以上"行
  rows.at(row-idx * 3) = center-box([])
  rows.at(row-idx * 3 + 1) = center-box([])
  rows.at(row-idx * 3 + 2) = right-box(text(size: 9pt, [以上]) + h(60pt))

  box(
    stroke: (bottom: 1.5pt, top: 1.5pt, left: 1.5pt, right: 1.5pt),
    height: auto,
    width: 100%,
    table(
      columns: (1.5cm, 0.8cm, 1fr),
      stroke: 0.4pt,
      table.header(
        cell(inset: 6pt, align(center)[*年*]),
        cell(inset: 6pt, align(center)[*月*]),
        cell(inset: 6pt, align(center)[*#header-text*])
      ),
      ..rows
    )
  )
}

// 資格テーブル
#let licence-table(licences, max-rows: 3) = {
  import table: cell

  let rows = (..range(max-rows).map(_ => empty-row())).flatten()

  let row-idx = 0
  for entry in licences {
    let (year, month, desc) = entry
    rows.at(row-idx * 3) = center-box(year)
    rows.at(row-idx * 3 + 1) = center-box(month)
    rows.at(row-idx * 3 + 2) = left-box(desc)
    row-idx += 1
  }

  rows.at(row-idx * 3) = center-box([])
  rows.at(row-idx * 3 + 1) = center-box([])
  rows.at(row-idx * 3 + 2) = right-box(text(size: 9pt, [以上]) + h(60pt))

  box(
    stroke: (bottom: 1.5pt, top: 1.5pt, left: 1.5pt, right: 1.5pt),
    height: auto,
    width: 100%,
    table(
      columns: (1.5cm, 0.8cm, 1fr),
      stroke: 0.4pt,
      table.header(
        cell(inset: 6pt, align(center)[*年*]),
        cell(inset: 6pt, align(center)[*月*]),
        cell(inset: 6pt, align(center)[*免許・資格*])
      ),
      ..rows
    )
  )
}

// 追加情報テーブル
#let info-table(data) = box(
  stroke: 1.5pt,
  table(
    columns: (1fr, 1fr, 1fr, 1fr),
    stroke: 0.5pt,
    [
      #grid(
        rows: (auto, auto, auto, auto, auto),
        align(left)[最寄り駅],
        [],
        [
          #h(1fr)
          #align(right, text(size: 10pt, data.nearest_line))
          #v(7pt)
        ],
        [],
        align(right, text(size: 10pt, data.nearest_station))
      )
    ],
    [
      #grid(
        rows: (auto, 10pt, auto),
        [扶養家族数(配偶者を除く)],
        [],
        [
          #h(1fr)
          #align(right, text(size: 16pt, str(data.dependents)) + "人")
        ]
      )
    ],
    [
      #grid(
        rows: (auto, auto),
        [配偶者],
        [
          #h(1fr)
          #align(horizon + right, text(size: 17pt, data.marital_status))
        ]
      )
    ],
    [
      #grid(
        rows: (auto, auto),
        [配偶者の扶養義務],
        [
          #h(1fr)
          #align(horizon + right, text(size: 17pt)[なし])
        ]
      )
    ]
  )
)

// === メイン ===

= #text(tracking: 1em, size: 14pt, [履歴書])

#move(dy: -1cm,
  stack(
    // 上部: 名前・生年月日・写真
    align(bottom,
      grid(
        columns: (5fr, 2fr),
        stack(
          name-section(data),
          birth-gender-section(data)
        ),
        photo-section(data)
      )
    ),
    // 住所セクション
    address-section(data),
    linebreak(),
    // 学歴・職歴・資格
    stack(
      timeline-table(data.education, [学歴・職歴(まとめて書く)], max-rows: 12),
      licence-table(data.licences, max-rows: 3),
      info-table(data)
    )
  )
)
