#import "@preview/codelst:2.0.2": sourcecode

// -----------------------------------

// 文ブロック

#let note = (body, title: none) => [
  #pad(left: 8pt, right: 8pt)[
    #block(
      width: 100%,
      inset: (top: 4pt, bottom: 4pt),
      stroke: (top: 1pt, bottom: 1pt),
      {
        if title != none {
          text(
            title + linebreak(),
            style: "oblique",
            size: 12pt,
          )
        }
        body
      },
    )
  ]
]

#let callout = (body, title: none) => [
  #block(
    width: 100%,
    inset: 8pt,
    fill: luma(240),
    radius: 4pt,
    {
      if title != none {
        text(
          title + linebreak(),
          style: "oblique",
          size: 12pt,
        )
      }
      body
    },
  )
]

#let cite = (body, title: none) => [
  #pad(left: 8pt)[
    #block(
      width: 100%,
      inset: (left: 8pt),
      stroke: (left: 2pt),
      {
        if title != none {
          text(
            title + linebreak(),
            style: "oblique",
            size: 12pt,
          )
        }
        body
      },
    )
  ]
]

// -----------------------------------

// ノンブル
#let nonble = (page: int) => {
  if calc.odd(page) {
    // 偶数ページは右側奥
    place(left, dx: -15mm, dy: 4mm)[#text(6pt)[#page]]
  } else {
    // 奇数ページは左側奥
    place(right, dx: 15mm, dy: 4mm)[#text(6pt)[#page]]
  }
}

// ページ番号
#let pageno = (page: int) => {
  if page == 1 {
    // 表紙には表示しない
    []
  } else if calc.odd(page) {
    // 偶数ページは左下
    align(right)[#text(10pt)[#here().page()]]
  } else {
    // 奇数ページは右下
    align(left)[#text(10pt)[#here().page()]]
  }
}

// -----------------------------------

#let doujinshi(
  title: "",
  subtitle: "",
  author: "",
  id: "",
  date: datetime.today(),
  prologue: [],
  epilogue: [],
  okuduke: [],
  font: "Rounded Mplus 1c",
  paper: "a5",
  doc,
) = [
  #set page(paper: paper) // 紙サイズの設定
  #set text(font: font) // フォントの設定
  #set line(length: 100%) // 横線は幅100%
  #set par(first-line-indent: 1em) // 段落頭の字下げ
  // 各章最初の段落が字下げされないのは既知の問題です
  // https://github.com/typst/typst/issues/311
  // いずれ修正されることを信じてこのままにしています

  // ページ番号
  #set page(
    header: context nonble(page: here().page()),
    footer: context pageno(page: here().page()),
  )

  //-----------------------------------
  // 表紙

  #align(center + horizon)[
    #text(size: 20pt)[#title]
    #v(4pt)
    #text(size: 14pt)[#subtitle]
    #v(80pt)
    #text(size: 14pt)[[著] #author]
    #v(1pt)
    #text(size: 14pt)[#id]
    #v(80pt)
    #date.year() 年 #date.month() 月 #date.day() 日
  ]
  #pagebreak()

  //-----------------------------------
  // 免責

  #align(bottom)[
    #text(size: 8pt)[
      - 本書は #date.year() 年 #date.month() 時点での情報に基づいて執筆されたものです。
      - 本書に記載された内容は情報の提供のみを目的としております。特定の使用目的に対して保証をするものではありません。
      - 本書に記載されている会社名・製品名等は、一般に各社の商標または登録商標です。本文中では商標記号(®、™)の表記は省略しています。
    ]
  ]
  #pagebreak()

  //-----------------------------------
  // まえがき

  #text(size: 16pt, weight: "bold")[まえがき]
  #line()
  #prologue
  #pagebreak()

  //-----------------------------------
  // 凡例

  #text(size: 16pt)[凡例]
  #line()

  #sourcecode[```
    // プログラムコードはこのように表⽰します。
    print("Hello, world!")
    ```]

  #sourcecode[```
    ターミナルはこのように表⽰します。
    $ echo Hello
    Hello
    ```]

  #note(title: [ノート])[
    ノートは本⽂に対する補⾜情報です。
  ]

  #callout(title: [コールアウト])[
    コールアウトは重要な情報を強調するためのものです。
  ]

  #cite(title: [引用文])[
    引用文は他の⽂献からの引⽤です。
  ]

  #pagebreak()

  //-----------------------------------
  // 目次

  #show outline.entry.where(level: 1): it => {
    strong(it)
  }
  #text(size: 16pt)[目次]
  #line()
  #outline(title: none, indent: auto, depth: 2)

  //-----------------------------------
  // 本文用設定

  // 章番号の設定
  #set heading(level: auto, numbering: "1.1.")

  // 章タイトル
  #show heading.where(level: 1): it => [
    #pagebreak()
    #v(20pt)
    #block(
      width: 100%,
      inset: 24pt,
      fill: luma(240),
      radius: 4pt,
    )[
      #text(size: 20pt)[第 #context counter(heading).get().at(0) 章]
      #v(4pt)
      #text(size: 20pt)[#it.body]
    ]
    #v(20pt)
  ]

  // 節タイトル
  #show heading.where(level: 2): it => [
    #block(
      width: 100%,
      inset: (top: 6pt, bottom: 8pt),
      stroke: (top: 1pt, bottom: 1pt),
    )[#text(size: 16pt, weight: "bold")[
        #context counter(heading).display() #it.body
      ]
    ]
  ]

  // 項タイトル
  #show heading.where(level: 3): it => [
    #block(
      inset: (bottom: 2pt),
      stroke: (bottom: 0.5pt),
    )[#text(size: 12pt, weight: "bold")[
        #context counter(heading).display() #it.body
      ]
    ]
  ]

  #set figure(supplement: [図])

  //-----------------------------------
  // 本文

  #doc
  #pagebreak()

  //-----------------------------------
  // あとがき

  #text(size: 16pt, weight: "bold")[あとがき]
  #line()
  #epilogue

  #pagebreak()

  // 奥付
  #align(bottom)[
    #text(size: 14pt)[#title]
    #v(1pt)
    #text(size: 10pt)[#subtitle]
    #line()
    #okuduke
    #line()
  ]
]
