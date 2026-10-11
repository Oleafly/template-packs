#import "../font-config.typ": ntu-fonts, ntu-heading-fonts
#import "../utils/zh-num.typ": to-zh-num

#let mainmatter(main-lang: (zh: true, en: false), doc) = {
  /*
   * 正文設定 - 遵循台大論文格式規範
   *
   * @param main-lang: 主要撰寫語言
   * @param doc: 正文內容
   */

  // 重置頁碼為阿拉伯數字
  counter(page).update(1)
  
  // 設定頁面編號格式
  set page(
    numbering: "1",
    number-align: center,
    header: none
  )

  // 正文字體設定 - 遵循台大格式規範
  set text(
    font: ntu-fonts,
    size: 12pt,        // 台大規範正文字體大小
    lang: if main-lang.zh { "zh" } else { "en" },
    region: if main-lang.zh { "tw" } else { none },
  )

  // 正文段落設定 - 遵循台大格式規範 (2.0倍行距)
  set par(
    leading: 12pt,      // 2.0倍行距
    spacing: 18pt,      // 段落間距
    justify: true,      // 兩端對齊
    first-line-indent: if main-lang.zh { 2em } else { 0em }, // 中文首行縮排
  )

  // 正文標題設定 - 遵循台大格式規範
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(1.5em)
    align(center)[
      #text(
        size: 18pt,     // 章標題字體大小
        weight: "bold",
        font: ntu-heading-fonts
      )[
        #if main-lang.zh [
          第#to-zh-num(counter(heading).get().first())章　#it.body
        ] else [
          Chapter #counter(heading).get().first()　#it.body
        ]
      ]
    ]
    v(1em)
  }
  
  show heading.where(level: 2): it => {
    v(1.5em)
    text(
      size: 14pt,     // 節標題字體大小
      weight: "bold",
      font: ntu-heading-fonts
    )[#it]
    v(0.75em)
  }
  
  show heading.where(level: 3): it => {
    v(1em)
    text(
      size: 12pt,     // 小節標題字體大小
      weight: "bold",
      font: ntu-heading-fonts
    )[#it]
    v(0.5em)
  }

  // to-zh-num 函數已從 utils/zh-num.typ 導入

  // 圖表設定 - 遵循台大格式規範
  show figure: it => {
    v(1em)
    it
    v(1em)
  }
  
  set figure(numbering: "1.1")

  // 顯示正文內容
  doc
} 