// ==================== 行ヘルパー ====================

#let ヘッダ行 = 内容 => (セル: ("", "", align(center)[#内容]))
#let データ行 = (年, 月, 内容) => (セル: (align(center)[#年], align(center)[#月], 内容))
#let 空行 = (セル: ("", "", ""))
#let 以上 = (セル: ("", "", align(right)[以上#h(1cm)]))

// ==================== セクション描画 ====================

#let 名前セクション = (情報, 小行高さ) => {
  let 氏名 = 情報.氏名.姓 + h(0.5cm) + 情報.氏名.名
  let よみ = 情報.氏名よみ.姓 + h(0.5cm) + 情報.氏名よみ.名
  let 生年月日 = str(情報.生年月日.年) + "年" + str(情報.生年月日.月) + "月" + str(情報.生年月日.日) + "日生"
  let 年齢表示 = "（満" + str(情報.年齢) + "歳）"
  let 性別 = 情報.性別
  set text(size: 1em)
  stack(
    dir: ttb,
    rect(width: 100%, height: 小行高さ, stroke: (top: 1pt, bottom: 1pt, left: 1pt, right: 1pt))[
      #place(left + horizon, dx: 3pt)[ふりがな]
      #place(center + horizon)[#よみ]
    ],
    rect(width: 100%, height: 2cm, stroke: (top: 0pt, bottom: 1pt, left: 1pt, right: 1pt))[
      #place(top + left, dx: 3pt, dy: 3pt)[氏名]
      #place(center + horizon)[#text(size: 2em)[#氏名]]
    ],
    grid(
      columns: (4fr, 1fr),
      stroke: (bottom: 1pt, left: 1pt, right: 1pt),
      rect(width: 100%, height: 小行高さ, stroke: none)[
        #align(horizon)[
          #stack(
            dir: ltr,
            align(left + horizon)[#move(dx: 3pt, text("生年月日"))],
            align(center + horizon)[#生年月日#年齢表示],
          )
        ]
      ],
      rect(width: 100%, height: 小行高さ, stroke: none)[
        #align(horizon)[
          #stack(
            dir: ltr,
            align(left)[#move(dx: 3pt, text("性別"))],
            align(center)[#性別],
          )
        ]
      ],
    ),
  )
}

#let 住所セクション = (情報, 小行高さ) => {
  let よみ = 情報.住所.よみ
  let よみ2 = 情報.住所.よみ2
  set text(size: 1em)
  stack(
    dir: ttb,
    rect(width: 100%, height: 小行高さ, stroke: (top: 1pt, bottom: 1pt, left: 1pt, right: 1pt))[
      #place(left + horizon, dx: 3pt)[ふりがな]
      #place(center + horizon)[#よみ]
    ],
    rect(width: 100%, height: 1.6cm, stroke: (top: 0pt, bottom: 1pt, left: 1pt, right: 1pt))[
      #place(top + left, dx: 3pt)[住所#h(0.1cm)〒#情報.住所.郵便番号]
      #place(center + horizon)[#text(size: 1.3em)[#情報.住所.本文]]
    ],
    grid(
      columns: (1fr, 1fr),
      stroke: (top: none, right: 1pt, bottom: none, left: 1pt),
      rows: 小行高さ,
      rect(width: 100%, height: 小行高さ, stroke: none)[
        #place(left + horizon, dx: 3pt)[E-mail]
        #place(center + horizon)[#情報.住所.メール]
      ],
      rect(width: 100%, height: 小行高さ, stroke: none)[
        #place(left + horizon, dx: 3pt)[電話番号]
        #place(center + horizon)[#情報.住所.電話]
      ],
    ),
    rect(width: 100%, height: 小行高さ, stroke: (top: 1pt, bottom: 1pt, left: 1pt, right: 1pt))[
      #place(left + horizon, dx: 3pt)[ふりがな]
      #place(center + horizon)[#よみ2]
    ],
    rect(width: 100%, height: 1.6cm, stroke: (top: 0pt, bottom: 1pt, left: 1pt, right: 1pt))[
      #place(top + left, dx: 3pt)[住所#h(0.1cm)〒#情報.住所.郵便番号2]
      #place(center + horizon)[#text(size: 1.3em)[#情報.住所.本文2]]
    ],
    grid(
      columns: (1fr, 1fr),
      stroke: (top: none, right: 1pt, bottom: 1pt, left: 1pt),
      rows: 小行高さ,
      rect(width: 100%, height: 小行高さ, stroke: none)[
        #place(left + horizon, dx: 3pt)[E-mail]
        #place(center + horizon)[#情報.住所.メール2]
      ],
      rect(width: 100%, height: 小行高さ, stroke: none)[
        #place(left + horizon, dx: 3pt)[電話番号]
        #place(center + horizon)[#情報.住所.電話2]
      ],
    ),
  )
}

#let 学歴職歴テーブル = (エントリ一覧, ラベル, 行高さ) => {
  let セル一覧 = エントリ一覧.map(e => e.セル).flatten()
  table(
    columns: (2fr, 1fr, 12fr),
    rows: 行高さ,
    stroke: 1pt,
    align: horizon,
    inset: (x: 4pt, y: 0pt),
    table.cell(align: center)[年],
    table.cell(align: center)[月],
    table.cell(align: center)[#ラベル],
    ..セル一覧,
  )
}

// ==================== ページ描画 ====================

#let 履歴書を描画 = (
  個人情報,
  証明写真: "",
  履歴エントリ,
  志望動機,
  本人希望,
  行高さ: 0.9cm,
  小行高さ: 0.7cm,
  ページ1最大行数: 15,
  ページ2最大行数: 14,
) => {
  let ページ1エントリ = 履歴エントリ.slice(0, ページ1最大行数)
  let ページ2エントリ = 履歴エントリ.slice(ページ1最大行数, ページ1最大行数 + ページ2最大行数)
  let タイトル = text(tracking: 1em, size: 15pt)[履歴書]

  // --- ページ1 ---
  stack(
    dir: ttb,
    grid(
      columns: (1fr, 3cm),
      column-gutter: 3mm,
      stack(
        dir: ttb,
        spacing: 2mm,
        grid(
          columns: (1fr, auto),
          align: bottom,
          text(size: 20pt, weight: "bold", タイトル), datetime.today().display("[year]年[month]月[day]日 現在"),
        ),
        名前セクション(個人情報, 小行高さ),
      ),
      place(dy: -3mm)[
        #if 証明写真 != "" {
          image(証明写真)
        } else {
          rect(
            height: 4cm,
            width: 3cm,
            stroke: 1pt,
            align(center + horizon)[写真],
          )
        }
      ],
    ),
    住所セクション(個人情報, 小行高さ),
    v(0.7cm),
    学歴職歴テーブル(ページ1エントリ, "学歴・職歴（各別にまとめて書く）", 行高さ),
  )

  pagebreak()

  // --- ページ2 ---
  grid(
    rows: (auto, 0.7cm, 2fr, 0.7cm, 1fr),
    学歴職歴テーブル(ページ2エントリ, "学歴・職歴（各別にまとめて書く）", 行高さ),
    [],
    rect(width: 100%, height: 100%)[
      #place(top + left, dx: 3pt, dy: 3pt)[志望の動機、特技、アピールポイントなど]
      #pad(top: 1.5em, left: 3pt)[#志望動機]
    ],
    [],
    rect(width: 100%, height: 100%)[
      #place(top + left, dx: 3pt, dy: 3pt)[本人希望記入欄]
      #pad(top: 1.5em, left: 3pt, right: 3pt)[#本人希望]
    ],
  )
}
