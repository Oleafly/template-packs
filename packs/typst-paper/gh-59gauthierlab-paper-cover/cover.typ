// 正規表現でマッチした部分も含めて分割する関数
#let split-keep(text, reg) = {
  let result = ()
  let last-end = 0

  // 正規表現にマッチする箇所をループで回す
  for m in text.matches(reg) {
    // マッチした箇所の直前にあるテキストを抽出
    if m.start > last-end {
      result.push(text.slice(last-end, m.start))
    }
    // マッチしたテキスト自体を抽出
    result.push(m.text)
    last-end = m.end
  }

  // 最後に残ったテキストがあれば追加
  if last-end < text.len() {
    result.push(text.slice(last-end))
  }

  return result
}

// 数字を漢数字に変換する関数
// 形式: 12345 -> 一万二千三百四十五
#let number-to-kanji(num) = {
  if num == 0 { return "零" }

  let kanji-digits = ("", "一", "二", "三", "四", "五", "六", "七", "八", "九")
  let small-units = ("", "十", "百", "千")
  let large-units = ("", "万", "億", "兆", "京")

  let result = ""
  let temp-num = calc.abs(num)
  let unit-index = 0

  while temp-num > 0 {
    // 4桁ずつ取り出す (万、億、兆単位)
    let part = calc.rem(temp-num, 10000)

    if part > 0 {
      let part-kanji = ""
      let sub-temp = part

      for i in range(4) {
        let digit = calc.rem(sub-temp, 10)
        if digit > 0 {
          let s = ""
          // 10, 100, 1000 の位で数字が 1 の場合は「一」を省略するルール
          if digit == 1 and i > 0 {
            s = small-units.at(i)
          } else {
            s = kanji-digits.at(digit) + small-units.at(i)
          }
          part-kanji = s + part-kanji
        }
        sub-temp = calc.floor(sub-temp / 10)
      }
      result = part-kanji + large-units.at(unit-index) + result
    }

    temp-num = calc.floor(temp-num / 10000)
    unit-index += 1
  }

  // 負の数の場合
  if num < 0 {
    result = "マイナス" + result
  }

  return result
}

// 和暦変換関数
#let japanese-era(date, kanji: true) = {
  let y = date.year()
  let m = date.month()
  let d = date.day()

  // start, end
  let showa = (1926, 1989) // 昭和元年～昭和64年
  let heisei = (1989, 2019) // 平成元年～平成31年
  let reiwa = (2019, 9999) // 令和元年～

  // 昭和・平成・令和の分岐
  let era-name = (
    if y < showa.at(1) {
      "昭和"
    } else if y < heisei.at(1) {
      "平成"
    } else {
      "令和"
    }
  )

  // 元号開始年ごとの西暦オフセット
  let offset = (
    if y < showa.at(1) {
      showa.at(0) - 1
    } else if y < heisei.at(1) {
      heisei.at(0) - 1
    } else {
      reiwa.at(0) - 1
    }
  )

  // 元号年計算
  let era-year-num = y - offset

  // 組み立て
  if kanji {
    let era-year = (
      if era-year-num == 1 {
        "元"
      } else {
        number-to-kanji(era-year-num)
      }
    )
    return era-name + era-year + "年　" + number-to-kanji(m) + "月　" + number-to-kanji(d) + "日"
  } else {
    let era-year = (
      if era-year-num == 1 {
        "元"
      } else {
        str(era-year-num)
      }
    )
    return era-name + era-year + "年　" + str(m) + "月　" + str(d) + "日"
  }
}

// 縦書き表示環境
#let vw(
  body,
  size: 13.5pt,
  font: "Harano Aji Gothic",
  weight: "regular",
  kerning: 0.3em,
  leading: 0.5em,
  spacing: 1em,
) = {
  let rotateChar = regex("[\u{FF5E}\u{301C}\p{Open_Punctuation}\p{Close_Punctuation}a-zA-Z0-9-~:]+")
  set text(size: size, font: font, weight: weight)
  stack(dir: rtl, spacing: leading, ..for line in body.split(regex("[\n]")) {
    // "line"
    (
      stack(dir: ttb, spacing: spacing, ..for segment in split-keep(line, rotateChar) {
        // "segment"
        (
          // ラテン文字・記号など
          if rotateChar in segment {
            rotate(90deg, segment, reflow: true)
          } else {
            stack(dir: ttb, spacing: kerning, ..for char in segment {
              // "char"
              (
                // スペースは空白として扱う
                if char == " " {
                  v(-0.7em)
                  char
                  v(-0.7em)
                } // 全角長音符・波ダッシュ
                else if char == "ー" or char == "～" {
                  rotate(93.5deg, char)
                  // rotate(90deg, char, reflow: true)
                } else {
                  char
                },
              )
            })
          },
        )
      }),
    )
  })
}


#let make_cover = (
  title: [],
  affiliation: [],
  author: "",
  title-spine: "",
  date: datetime.today(),
  font: ("New Computer Modern", "Noto Serif CJK JP"),
) => [
  // metadata
  #set page(
    paper: "a4",
    margin: (top: 5mm, bottom: 5mm, left: 5mm, right: 5mm),
  )

  #grid(
    columns: (5%, 95%),
    gutter: 12pt,
    // 左コンテナ
    [
      #rect(
        width: 20mm,
        height: 100%,
        inset: 0% + 15pt,
        stroke: (paint: gray, thickness: 1pt, dash: "dashed"),
      )[
        // 背表紙の高さを指定（例：24cm）
        #block(height: 100%, width: 100%)[
          #set align(center)

          // タイトル（上寄せ）
          #vw(
            title-spine,
            spacing: 0.7em,
            font: font,
            size: 12pt,
          )

          #v(1fr)

          // 著者名と日付（下寄せ）
          #vw(
            author,
            spacing: 0.1em,
            font: font,
            size: 12pt,
          )
          #v(1.5em)
          #vw(
            japanese-era(date, kanji: true).replace("\n", ""),
            spacing: 0.1em,
            font: font,
            size: 12pt,
          )
        ]
      ]
    ],
    // 右コンテナ
    [
      // title
      #align(center)[
        #rect(
          width: 170mm,
          inset: 0% + 15pt,
          stroke: (paint: gray, thickness: 1pt, dash: "dashed"),
        )[
          #text(
            title,
            weight: "regular",
            font: font,
            size: 20pt,
          )
        ]
      ]
      // author
      #v(30pt)
      #align(center)[
        #rect(
          inset: 0% + 15pt,
          stroke: (paint: gray, thickness: 1pt, dash: "dashed"),
        )[
          #text(
            author,
            weight: "regular",
            font: font,
            size: 18pt,
          )
        ]
      ]
      // date
      #v(30pt)
      #align(center)[
        #rect(inset: 0% + 15pt, stroke: (paint: gray, thickness: 1pt, dash: "dashed"))[
          #text(
            japanese-era(date, kanji: false),
            weight: "regular",
            font: font,
            size: 16pt,
          )
        ]
      ]
      // affiliation
      #v(30pt)
      #align(center)[
        #rect(inset: 0% + 15pt, stroke: (paint: gray, thickness: 1pt, dash: "dashed"))[
          #text(affiliation, weight: "regular", font: font, size: 14pt)
        ]
      ]
    ],
  )
]
