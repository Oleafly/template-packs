#import "@preview/ctheorems:1.1.3": *

// 文本和代码的字体
#let songti = "SimSun"
#let heiti = "SimHei"
#let kaiti = "SimKai"
#let text-font = "Times New Roman"
#let code-font = "DejaVu Sans Mono"

// 主题色
#let primary-color = rgb("#1a365d")
#let accent-color = rgb("#3182ce")

#let title(
  title: "文章标题",
  date: "2025-01-01",
  name: "作者姓名",
  avatar: "figures/cover.jpg",
  body,
) = {
  
  set page(
    paper: "a4",
    margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
    footer: align(center)[#context (counter(page).display("1"))],
  )
  
  set text(font: (text-font, songti), size: 12pt, lang: "zh", region: "cn")
  set par(first-line-indent: 2em, linebreaks: "optimized", justify: true)
  
  set line(length: 100%, stroke: 0.5pt)

  show raw: set text(font: code-font, 8pt)


  set math.equation(numbering: "(1.1)")
  show math.equation: eq => {
    set block(spacing: 0.65em)
    eq
  }
  show math.equation: it => {
    show regex("[\p{hani}\s]+"): set text(font: songti)
    it
  }


  show figure: it => [
    #v(4pt)
    #it
    #v(4pt)
  ]
  show figure.where(kind: raw): it => {
    set block(width: 100%, breakable: true)
    it
  }


  // 顶部装饰条
  place(top + left, dx: -2.5cm, dy: -2.5cm)[
    #rect(width: 100% + 5cm, height: 6pt, fill: accent-color)
  ]
  
  v(1cm)
  
  // 标题区域
  align(center)[
    #box(
      width: 100%,
      inset: (y: 16pt),
    )[
      #text(
        size: 28pt, 
        font: (text-font, heiti), 
        fill: primary-color,
        weight: "bold",
        tracking: 2pt,
      )[#title]
    ]
  ]
  
  v(8pt)
  
  // 装饰分隔线
  align(center)[
    #box(width: 50%)[
      #grid(
        columns: (1fr, auto, 1fr),
        align: horizon,
        line(length: 100%, stroke: 1pt + luma(200)),
        box(inset: (x: 12pt))[
          #text(fill: accent-color, size: 12pt)[◆]
        ],
        line(length: 100%, stroke: 1pt + luma(200)),
      )
    ]
  ]
  
  v(16pt)
  
  // 作者信息
  align(center)[
    #box(
      fill: rgb("#f7fafc"),
      radius: 8pt,
      inset: 16pt,
      stroke: 1pt + luma(230),
    )[
      #grid(
        columns: (auto, auto, auto),
        gutter: 24pt,
        align: horizon,
        
        // 头像
        box(
          clip: true,
          radius: 6pt,
          stroke: 2pt + accent-color,
        )[
          #image(avatar, width: 50pt, height: 50pt, fit: "cover")
        ],
        
        // 作者
        box(inset: (x: 8pt))[
          #text(size: 10pt, fill: luma(120))[作者]
          #v(2pt)
          #text(size: 14pt, font: (text-font, songti), fill: primary-color, weight: "medium")[#name]
        ],
        
        // 日期
        box(inset: (x: 8pt))[
          #text(size: 10pt, fill: luma(120))[日期]
          #v(2pt)
          #text(size: 14pt, fill: primary-color)[#date]
        ],
      )
    ]
  ]
  

  v(24pt)
  
  // 底部装饰线
  line(length: 100%, stroke: 0.5pt + luma(200))
  
  v(16pt)
  
  // 初始化页码 (如果需要从正文开始计数，可以在这里重置)
  counter(page).update(1)

  // 渲染正文
  body
}

// 参考文献辅助函数 (保持独立)
#let bib(bibliography-file) = {
  show bibliography: set text(12pt)
  set bibliography(title: "参考文献", style: "gb-7714-2015-numeric")
  bibliography-file
  v(12pt)
}

