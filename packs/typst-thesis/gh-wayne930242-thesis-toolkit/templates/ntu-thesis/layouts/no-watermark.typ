#import "../font-config.typ": ntu-fonts, ntu-heading-fonts
#import "../utils/zh-num.typ": to-zh-num

#let no-watermark-layout(
  main-lang: (zh: true, en: false),
  doc,
) = {
  /*
   * 無浮水印版本的全域設定 - 基於 whole.typ 但移除浮水印
   * 適用於 writing-direction 等非正式文件
   *
   * @param main-lang: 主要撰寫語言
   * @param doc: 文件內容
   */

  // 檢查語言設定
  assert(
    (main-lang.zh and not main-lang.en) or (main-lang.en and not main-lang.zh),
    message: "只能選擇一種主要語言！"
  )

  // 頁面設定 - 遵循台大格式規範但無浮水印
  set page(
    paper: "a4",
    margin: (top: 3cm, bottom: 2cm, left: 3cm, right: 3cm),
    // 無浮水印背景
  )

  // 字體設定 - 遵循台大格式規範
  set text(
    font: ntu-fonts,
    size: 12pt,
    lang: if main-lang.zh { "zh" } else { "en" },
    region: if main-lang.zh { "tw" } else { none },
  )

  // 段落設定 - 遵循台大格式規範 (2.0倍行距)
  set par(
    leading: 12pt,
    spacing: 18pt,
    justify: true,
    first-line-indent: if main-lang.zh { 2em } else { 0em },
  )

  // 標題設定 - 遵循台大格式規範
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(1.5em)
    align(center)[
      #text(
        size: 18pt,
        stroke: 0.02em + black,
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
      size: 14pt,
      stroke: 0.015em + black,
      font: ntu-heading-fonts
    )[#it]
    v(0.75em)
  }
  
  show heading.where(level: 3): it => {
    v(1em)
    text(
      size: 12pt,
      stroke: 0.01em + black, 
      font: ntu-heading-fonts
    )[#it]
    v(0.5em)
  }
  
  set heading(numbering: "1.1")

  // 圖表設定
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

  // 顯示文件內容
  doc
}