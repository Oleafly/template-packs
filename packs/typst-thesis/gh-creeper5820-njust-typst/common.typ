#import "@preview/cuti:0.4.0": cn-fakebold, fakebold

// 范文字体
#let fonts = (
  song: "SimSun",
  hei: "SimHei",
  times: "Times New Roman",
  kai: "KaiTi",
)
// 中文字号 → pt 映射
#let size = (
  初号: 42pt,
  小初: 36pt,
  一号: 26pt,
  小一: 24pt,
  二号: 22pt,
  小二: 18pt,
  三号: 16pt,
  小三: 15pt,
  四号: 14pt,
  小四: 12pt,
  五号: 10.5pt,
  小五: 9pt,
)

// 全局论文题目 state（main.typ 中设置一次，各页面函数通过 context 读取）
#let thesis-title-state = state("thesis-title", "")
#let current-chapter-state = state("current-chapter", [])

#let chapter-figure-numbering(kind) = n => {
  let loc = here()
  let chapter = counter(heading.where(level: 1)).at(loc).first()
  numbering("1.1", chapter, n)
}

#let chapter-equation-numbering(n) = {
  let loc = here()
  let chapter = counter(heading.where(level: 1)).at(loc).first()
  numbering("（1.1）", chapter, n)
}

#let njust-image(path, caption, width: 50%) = figure(
  image(path, width: width),
  caption: caption,
)

#let njust-table(col-widths, col-align, caption, header, rows, ..body) = figure(
  align(center)[
    #set text(font: (fonts.times, fonts.song), size: size.五号)
    #table(
      columns: col-widths,
      align: col-align,
      stroke: none,
      table.hline(y: 0, stroke: 0.8pt),
      table.header(..header),
      table.hline(y: 1, stroke: 0.5pt),
      ..body.pos(),
      table.hline(y: rows + 1, stroke: 0.8pt),
    )
  ],
  kind: table,
  caption: caption,
)

// 页面边距（封面通用）
#let page-margin = (
  top: 30mm,
  bottom: 24mm,
  left: 25mm,
  right: 25mm,
)

// 正文区逻辑宽度（160mm = 210mm - 25mm×2）
#let content-width = 160mm

// 页眉通用样式（小五号宋体，顶部横线）
// odd-left/odd-right 为奇数页眉左右内容
// even-left/even-right 为偶数页眉左右内容
// 模板规律：
//   奇数页：左="毕业设计（论文）报告"  右=论文题目
//   偶数页：左=当前章节名             右="毕业设计（论文）报告"
#let thesis-header(
  odd-left: "毕业设计（论文）报告",
  odd-right: "",
  even-left: "",
  even-right: "毕业设计（论文）报告",
) = {
  context {
    let pg = counter(page).get().first()
    let is-odd = calc.odd(pg)
    let l = if is-odd { odd-left } else { even-left }
    let r = if is-odd { odd-right } else { even-right }

    set text(font: (fonts.times, fonts.song), size: size.小五)
    grid(
      columns: (auto, 1fr),
      align: (left, right),
      l, r,
    )
    v(-8pt)
    line(length: 100%, stroke: 0.5pt)
  }
}

// 页脚通用样式（小五号宋体，页码置于页面外侧）
// 模板：奇数页靠右（left≈782），偶数页靠左（left=107），top=1148（距底约27mm）
#let thesis-footer(numbering: none) = {
  set text(font: fonts.song, size: size.小五)
  context {
    let pg = counter(page).get().first()
    let is-odd = calc.odd(pg)
    align(if is-odd { right } else { left })[
      #if numbering == none {
        counter(page).display()
      } else {
        counter(page).display(numbering)
      }
    ]
  }
}

// 正文整体样式封装（wrapper function 模式）
// show: set 规则在函数内不向外传播，但通过 wrapper 包裹内容可以正常生效
// 用法：#main-body[正文内容...]（论文题目通过 thesis-title-state 自动读取）
//
// 格式规范（来源：撰写格式.txt + 模板 P17-P18 XML）：
//   正文：小四宋体+TNR，行距30px，首行缩进2em，两端对齐
//   一级标题：小三号宋体加粗，段前段后30pt（→L2:61px, →body:61px）
//   二级标题：四号宋体加粗，段前20pt段后24pt（→body:51px）
//   三级标题：小四宋体加粗，段前段后17pt（→body:38px）
#let main-body(content) = {
  set page(
    paper: "a4",
    margin: page-margin,
    numbering: "1",
    header: context {
      let title = thesis-title-state.get()
      let chapter = current-chapter-state.get()
      thesis-header(
        odd-left: "毕业设计（论文）报告",
        odd-right: title,
        even-left: chapter,
        even-right: "毕业设计（论文）报告",
      )
    },
    footer: thesis-footer(),
    header-ascent: 14pt,
    footer-descent: -3mm,
  )

  show: set text(font: (fonts.times, fonts.song), size: size.小四)
  show: set par(
    justify: true,
    first-line-indent: (amount: 2em, all: true),
    leading: 12pt,
    spacing: 12pt,
  )

  show figure.caption: set text(font: (fonts.times, fonts.song), size: size.五号)

  show figure.where(kind: image): set figure(
    supplement: [图],
    numbering: chapter-figure-numbering("image"),
  )
  show figure.where(kind: image): set figure.caption(separator: [ ])

  show figure.where(kind: table): set figure(
    supplement: [表],
    numbering: chapter-figure-numbering("table"),
  )
  show figure.where(kind: table): set figure.caption(position: top, separator: [ ])

  show math.equation.where(block: true): set math.equation(
    supplement: [式],
    numbering: chapter-equation-numbering,
  )
  show math.equation.where(block: true): it => context block(
    width: 100%,
    above: 12pt,
    below: 12pt,
  )[
    #place(right + horizon)[
      #counter(math.equation.where(block: true)).display(it.numbering)
    ]
    #align(center)[#it.body]
  ]

  show heading.where(level: 1): it => {
    let chapter = [#counter(heading.where(level: 1)).display("1") #it.body]
    current-chapter-state.update(chapter)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(math.equation.where(block: true)).update(0)
    colbreak(weak: true)
    set text(font: (fonts.times, fonts.song), size: size.小三)
    set block(above: 30pt, below: 30pt)
    cn-fakebold(it)
  }

  show heading.where(level: 2): it => {
    set text(font: (fonts.times, fonts.song), size: size.四号)
    set block(above: 20pt, below: 24pt)
    cn-fakebold(it)
  }

  show heading.where(level: 3): it => {
    set text(font: (fonts.times, fonts.song), size: size.小四)
    set block(above: 12pt, below: 12pt)
    cn-fakebold(it)
  }

  block(inset: (top: 2mm, bottom: 5mm))[
    #content
  ]
}
