#import "../font-config.typ": ntu-fonts, ntu-heading-fonts
#import "../utils/zh-num.typ": to-zh-num

#let whole(
  main-lang: (zh: true, en: false),
  doc,
) = {
  /*
   * 全域設定 - 適用於整個文件
   * 遵循台大論文格式規範 (example.cls)
   * 包含封面、摘要、致謝、正文、參考文獻和附錄
   *
   * @param main-lang: 主要撰寫語言
   * @param doc: 文件內容
   */

  // 檢查語言設定
  assert(
    (main-lang.zh and not main-lang.en) or (main-lang.en and not main-lang.zh),
    message: "只能選擇一種主要語言！"
  )

  // 頁面設定 - 遵循台大格式規範
  set page(
    paper: "a4",
    margin: (top: 3cm, bottom: 2cm, left: 3cm, right: 3cm), // 台大規範邊距
    // 浮水印背景 - 對齊頁面寬度，適中大小
    background: align(center + horizon, 
      image("../assets/watermark.svg", width: 40%)
    )
  )

  // 字體設定 - 遵循台大格式規範
  set text(
    font: ntu-fonts,
    size: 12pt,        // 台大規範字體大小
    lang: if main-lang.zh { "zh" } else { "en" },
    region: if main-lang.zh { "tw" } else { none },
  )

  // 段落設定 - 遵循台大格式規範 (2.0倍行距)
  set par(
    leading: 12pt,      // 2.0倍行距 (12pt * 2 = 24pt 總行高)
    spacing: 18pt,      // 段落間距
    justify: true,      // 兩端對齊
    first-line-indent: if main-lang.zh { 2em } else { 0em }, // 中文首行縮排
  )

  // 標題設定 - 遵循台大格式規範
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(1.5em)
    align(center)[
      #text(
        size: 18pt,     // 章標題字體大小
        stroke: 0.02em + black, // 模擬粗體效果：添加細描邊
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
      stroke: 0.015em + black, // 模擬粗體效果：較細的描邊
      font: ntu-heading-fonts
    )[#it]
    v(0.75em)
  }
  
  show heading.where(level: 3): it => {
    v(1em)
    text(
      size: 12pt,     // 小節標題字體大小
      stroke: 0.01em + black, // 模擬粗體效果：最細的描邊
      font: ntu-heading-fonts
    )[#it]
    v(0.5em)
  }
  
  set heading(numbering: "1.1")

  // 圖表設定 - 遵循台大格式規範
  show figure: it => {
    v(1em)
    it
    v(1em)
  }
  
  set figure(numbering: "1.1")

  // 目錄設定
  set outline(
    title: none,
    indent: auto
  )

  // 隱藏標記為 "invisible" 的內容
  show label("invisible"): it => { }

  // to-zh-num 函數已從 utils/zh-num.typ 導入

  // 顯示文件內容
  doc
} 