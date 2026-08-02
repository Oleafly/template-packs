#let resume(
  日付: auto,
  氏名: ([], []),
  氏名ふりがな: ([], []),
  生年月日: datetime(year: 1970, month: 1, day: 1),
  性別: [],
  写真: none,
  現住所: (
    郵便番号: [],
    住所: [],
    住所ふりがな: [],
    電話: [],
    E-mail: [],
  ),
  連絡先: (
    郵便番号: [],
    住所: [],
    住所ふりがな: [],
    電話: [],
    E-mail: [],
  ),
  学歴: (),
  職歴: (),
  免許・資格: (),
  志望動機: [],
  本人希望記入欄: [],
  学歴・職歴の最小行数: 22,
  学歴と職歴の間の空行数: 1,
  免許・資格の最小行数: 6,
  志望動機の高さ: 22em,
  本人希望記入欄の高さ: 10em,
  body,
) = {
  set document(title: "履歴書")
  set page(paper: "a4", numbering: none, margin: (x: 17mm, y: 20mm))
  set text(font: "Harano Aji Mincho", size: 10pt, lang: "ja")

  if 日付 == auto {
    日付 = datetime.today()
  }

  place(
    top + right,
    dx: -7mm,
    dy: -3mm,
    box(
      width: 30mm,
      height: 40mm,
      stroke: (thickness: 0.5pt, dash: (0.5pt, 0.5pt)),
      if 写真 == none {
        pad(0.7em, align(horizon, text(size: 7.5pt, {
          align(center, [写真をはる必要が\ ある場合])
          v(1em)
          align(left, [
            1. 縦 36〜40mm\ 横 24〜30mm
            2. 本人単身胸から上
            3. 裏面のりづけ
          ])
        })))
      } else {
        align(center + horizon, image(写真, width: 100%))
      }
    )
  )

  h(1em)

  grid(
    columns: (5fr, 5fr),
    align: bottom,
    text("履 歴 書", size: 2em), 日付.display("[year]年[month]月[day]日 現在"),
  )

  stack(
    table(
      columns: (7em, 60%),
      rows: (auto, 6em),
      align: horizon,
      stroke: (x, y) => (
        top: (1pt, 0.2pt).at(y),
        left: (1pt, 0pt).at(x),
        right: (0pt, 1pt).at(x),
      ),
      [ふりがな], { 氏名ふりがな.at(0); h(1em); 氏名ふりがな.at(1) },
      [氏名], text(1.8em, { 氏名.at(0); h(1em); 氏名.at(1); })
    ),
    table(
      columns: (7em + 60%, 4em, 1fr),
      rows: 3em,
      align: (center + horizon, left, left + horizon),
      stroke: (x, _) => (
        top: 1pt,
        left: (1pt, 1pt, 0pt).at(x),
        right: (1pt, 0pt, 1pt).at(x),
      ),
      {
        let age = 日付.year() - 生年月日.year()
        if (日付.month(), 日付.day()) < (生年月日.month(), 生年月日.day()) {
          age -= 1
        }
        text(size: 1.1em, [
          #生年月日.year()年 #h(0.5em)
          #生年月日.month()月 #h(0.5em)
          #生年月日.day()日生
          #h(0.5em)
          （満 #age 歳）
        ])
      },
      [性別], 性別
    ),
    table(
      columns: (7em, 60%, 5em, 1fr),
      rows: (auto, auto, 3em),
      stroke: (x, y) => (
        top: (1pt, 0.2pt, 0pt).at(y),
        left: (1pt, 0pt, 1pt, 0pt).at(x),
        right: (0pt, 1pt, 0pt, 1pt).at(x),
      ),
      [ふりがな], 現住所.住所ふりがな, [電話], move(dx: -2em, 現住所.電話),
      [現住所 #h(1em) 〒], move(dx: -1em, 現住所.郵便番号), [E-mail], [],
      table.cell(colspan: 2, align: horizon + center, text(size: 1.2em, 現住所.住所)),
      table.cell(colspan: 2, align: horizon + center, stroke: (right: 1pt), layout(size => {
        let (content, text-size) = (現住所.E-mail, 1em);
        while true {
          let m = measure(text(size: text-size, content))
          if m.width <= size.width { break; }
          text-size -= 0.5pt
        }
        text(size: text-size, content)
      })),
    ),
    table(
      columns: (7em, 60%, 5em, 1fr),
      rows: (auto, auto, 3em),
      stroke: (x, y) => (
        top: (1pt, 0.2pt, 0pt).at(y),
        left: (1pt, 0pt, 1pt, 0pt).at(x),
        right: (0pt, 1pt, 0pt, 1pt).at(x),
        bottom: 1pt
      ),
      [ふりがな], 連絡先.住所ふりがな, [電話], move(dx: -2em, 連絡先.電話),
      [現住所 #h(1em) 〒], move(dx: -1em, {
        連絡先.郵便番号; h(1fr); text(size: 0.8em, [（現住所以外に連絡先を希望する場合のみ記入）])
      }), [E-mail], [],
      table.cell(colspan: 2, align: horizon + center, text(size: 1.2em, 連絡先.住所)),
      table.cell(colspan: 2, align: horizon + center, stroke: (right: 1pt), layout(size => {
        let (content, text-size) = (連絡先.E-mail, 1em);
        while true {
          let m = measure(text(size: text-size, content))
          if m.width <= size.width { break; }
          text-size -= 0.5pt
        }
        text(size: text-size, content)
      })),
    ),
  )

  let 元号(year, month) = {
    let (era-name, era-year) = if year > 2019 or (year == 2019 and month >= 5) {
      ("令和", year - 2018)
    } else if year >= 1989 {
      ("平成", year - 1988)
    } else if year > 1926 or (year == 1926 and month >= 12) {
      ("昭和", year - 1925)
    } else if year > 1912 or (year == 1912 and month >= 8) {
      ("大正", year - 1911)
    } else {
      ("明治", year - 1867)
    }
    era-name + if era-year == 1 { "元" } else { str(era-year) }
  }

  let 年表(タイトル, 最小行数, lines) = {
    lines.push(([], [], align(right, [以上])))
    while lines.len() < 最小行数 {
      lines.push(([], [], []))
    }
    table(
      columns: (6em, 3em, 1fr),
      rows: (auto, 2.5em),
      stroke: (x, y) => (
        top: 1pt,
        left: if x == 1 { 0.2pt } else { 1pt },
        right: if x == 0 { 0.2pt } else { 1pt },
        bottom: 1pt,
      ),
      align: (center + horizon, center + horizon, left + horizon),
      table.header([年], [月], align(center, タイトル)),
      ..lines.flatten(),
    )
  }

  年表([学歴・職歴（各別にまとめて書く）], 学歴・職歴の最小行数, {
    let lines = ()
    lines.push(([], [], align(center, [学　歴])))
    for (year, month, content) in 学歴 {
      lines.push((元号(year, month), str(month), content))
    }
    for _ in range(学歴と職歴の間の空行数) {
      lines.push(([], [], []))
    }
    lines.push(([], [], align(center, [職　歴])))
    if 職歴.len() == 0 {
      lines.push(([], [], [なし]))
    } else {
      for (year, month, content) in 職歴 {
        lines.push((元号(year, month), str(month), content))
      }
    }
    lines
  })

  年表([免許・資格], 免許・資格の最小行数, {
    let lines = ()
    for (year, month, content) in 免許・資格 {
      lines.push((元号(year, month), str(month), content))
    }
    lines
  })

  let 記入欄(タイトル, 高さ, 本文) = {
    table(
      columns: 1fr,
      rows: (auto, 高さ),
      stroke: (x, y) => (
        top: (1pt, 0.2pt).at(y),
        left: 1pt,
        right: 1pt,
        bottom: (0.2pt, 1pt).at(y),
      ),
      タイトル,
      本文,
    )
  }

  記入欄(
    [志望の動機、特技、好きな学科、アピールポイントなど],
    志望動機の高さ,
    志望動機
  )

  記入欄(
    [本人希望記入欄 #text(size: 0.8em, [（特に給料・職種・勤務時間・勤務地・その他についての希望などがあれば記入）])],
    本人希望記入欄の高さ,
    本人希望記入欄
  )

  body
}
