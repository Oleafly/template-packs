// 参考: https://jrecin.jst.go.jp/html/app/seek/html/help_detail/katsuyou/loginato/ApplicationForm_ja.pdf

#set text(lang: "ja")

// （日付）現在
#let nowdate = {
  let today = datetime.today()
  today.display("[year]年[month]月[day]日 現在")
}

#let col_height = 1.3cm
#let 汎用ボックスフォント = "Hiragino Mincho ProN"


// 氏名ボックス
#let name(
  性: "名無しの", 
  名: "権兵衛",
  セイ: "ナナシノ",
  メイ: "ゴンベエ"
  ) = {
 grid(
  rows: (1fr, 4fr),
  gutter: 0pt,
  rect(
    stack(
      dir: ltr, 
      [フリガナ], 
      align(center)[#セイ],
      h(1cm),
      align(center)[#メイ],
    ), width: 100%, height: 100%
    ),
    rect(
      stack(
        dir: ltr, 
        [氏名],
        align(center+horizon)[
          #text([#性#h(1cm)#名], size: 20pt)
        ]
    ),
    width: 100%, height: 100%),
 )
}

// 生年月日
#let birthday_gender(年: 2000, 月: 1, 日: 1, 満年齢: 1, 性別: [男女]) = {
  grid(
    columns: (3fr, 1fr),
    gutter: 0pt,
  rect(
    align(center+horizon)[
    #年 年　#月 月　#日 日生 (満 #満年齢 歳)], 
    width: 100%, height: 100%),
  rect(
    align(horizon, 
    stack(
    dir: ltr, 
    [性別],
    align(center)[#text(性別, size:16pt)]
    )
  ),
  width: 100%, height: 100%)
  )
}

// 写真欄
#let photo(photo: "") = {
    rect(
      [
        #if (photo == ""){
          rect( stroke: none, height: 100%,
          [
            #align(center, 
            [#text([写真を貼る位置], size: 9pt)]
            )
            #align(bottom, [
            #text([縦 4cm x 横 3cm 程度，上半身，無帽，背景無色，直近3ヶ月以内に撮影の写真を使用してください．], size: 9pt)])
              ]
          )
          } else {
            image(photo, width: 3cm, height: 4cm, fit: "cover")
          }
        ],
      stroke: (dash: "dashed"),
      height: 4cm, 
      width: 3cm,
      inset: 0cm
      )
}

// 住所
#let 住所(
  現住所: "東京都", 
  ゲンジュウショ: "トウキョウト",
  郵便番号: "100-1000"
  ) = {
 grid(
  rows: (0.6cm, 2cm),
  gutter: 0pt,
  rect(
    stack(
      dir: ltr, 
      [フリガナ], 
      align(center)[#ゲンジュウショ],
    ), width: 100%, height: 100%
    ),
    rect(
      stack(
        dir: ltr, 
        [現住所　〒 #郵便番号],
        align(center+horizon)[
          #text([#現住所], size: 16pt)
        ]
    ),
    width: 100%, height: 100%),
 )
}

// 
#let 連絡先(
  電話番号1: "000-0000-0000", 
  電話番号2: "",
  メールアドレス: "hoge@hoge.hoge",
  FAX: "なし"
  ) = {
 grid(
  rows: (0.6cm, 1.3cm),
  gutter: 0pt,
  rect(
    stack(
      dir: ltr, 
      [電話番号],
      h(0.5cm),
      [#text(size: 8pt)[（電話1）]], 
      h(0.5cm),
      [#電話番号1],
      h(1.5cm),
      [#text(size: 8pt)[（電話2）]], 
      h(0.5cm),
      [#電話番号2]
    ), width: 100%, height: 100%
    ),
    grid(
      columns: (4fr, 2fr),
      rect(
        align(horizon)[
        #stack(
          dir: ltr, 
          [e-mail アドレス],
          align(center)[#メールアドレス]
      )],
      width: 100%, height: 100%),
      rect(
        align(horizon)[
        #stack(
          dir: ltr, 
          [FAX],
          align(center)[#FAX]
      )],
      width: 100%, height: 100%),
    )
    )
}

#let 学歴ヘッダ() = {
  rect(
    width:100%, height: 1.6cm,
    inset: 0cm, outset: 0cm,
    grid(
      columns: (1fr, 1fr, 2fr),
      grid(
        rect(
          width:100%, height: 50%,
        )[#align(center+horizon)[自]],
        grid(
          columns: (50%, 50%),
          rect(
            width:100%, height: 50%,
          )[#align(center+horizon)[年]],
          rect(
            width:100%, height: 50%,
          )[#align(center+horizon)[月]],
        )
      ),
      grid(
        rect(
          width:100%, height: 50%,
        )[#align(center+horizon)[至]],
        grid(
          columns: (50%, 50%),
          rect(
            width:100%, height: 50%,
          )[#align(center+horizon)[年]],
          rect(
            width:100%, height: 50%,
          )[#align(center+horizon)[月]],
        )
      ),
      rect(
        width:100%, height: 100%,
      )[#align(center+horizon)[学歴]],
    )
  )
}

#let 学歴(
  開始年: [],
  開始月: [],
  終了年: [],
  終了月: [],
  学歴: []
) = {
  rect(
    width:100%, height: col_height,
    inset: 0cm, outset: 0cm,
    grid(
      columns: (1fr, 1fr, 2fr),
        grid(
          columns: (50%, 50%),
          rect(width: 100%, height: 100%)[#align(center+horizon)[#開始年]],
          rect(width: 100%, height: 100%)[#align(center+horizon)[#開始月]],
        ),
        grid(
          columns: (50%, 50%),
          rect(width: 100%, height: 100%)[#align(center+horizon)[#終了年]],
          rect(width: 100%, height: 100%)[#align(center+horizon)[#終了月]],
        ),
        rect(width: 100%, height: 100%)[#align(center+horizon)[#学歴]],
      )
      )
}


#let 職歴ヘッダ() = {
  rect(
    width:100%, height: 1.6cm,
    inset: 0cm, outset: 0cm,
    grid(
      columns: (1fr, 1fr, 2fr),
      grid(
        rect(
          width:100%, height: 50%,
        )[#align(center+horizon)[自]],
        grid(
          columns: (50%, 50%),
          rect(
            width:100%, height: 50%,
          )[#align(center+horizon)[年]],
          rect(
            width:100%, height: 50%,
          )[#align(center+horizon)[月]],
        )
      ),
      grid(
        rect(
          width:100%, height: 50%,
        )[#align(center+horizon)[至]],
        grid(
          columns: (50%, 50%),
          rect(
            width:100%, height: 50%,
          )[#align(center+horizon)[年]],
          rect(
            width:100%, height: 50%,
          )[#align(center+horizon)[月]],
        )
      ),
      rect(
        width:100%, height: 100%,
      )[#align(center+horizon)[職歴]],
    )
  )
}


#let 職歴(
  開始年: [],
  開始月: [],
  終了年: [],
  終了月: [],
  職歴: []
) = {
  rect(
    width:100%, height: col_height,
    inset: 0cm, outset: 0cm,
    grid(
      columns: (1fr, 1fr, 2fr),
        grid(
          columns: (50%, 50%),
          rect(width: 100%, height: 100%)[#align(center+horizon)[#開始年]],
          rect(width: 100%, height: 100%)[#align(center+horizon)[#開始月]],
        ),
        grid(
          columns: (50%, 50%),
          rect(width: 100%, height: 100%)[#align(center+horizon)[#終了年]],
          rect(width: 100%, height: 100%)[#align(center+horizon)[#終了月]],
        ),
        rect(width: 100%, height: 100%)[#align(center+horizon)[#職歴]],
      )
      )
}

#let 汎用ボックス(タイトル: [], 本文: []) = {
  rect( width: 100%, inset: 0cm,
    grid(
      rect( width: 100%, height: 1cm,
        align(horizon + center, text(font: 汎用ボックスフォント, weight: "bold")[#タイトル])
      ),
      rect( width: 100%, inset: 0.5cm,
        [#本文]
      ),
    )
  )
}