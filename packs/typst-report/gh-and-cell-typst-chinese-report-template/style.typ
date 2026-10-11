#import "@preview/pointless-size:0.1.1": zh  // 设置中文字号
#import "@preview/cjk-unbreak:0.1.1": remove-cjk-break-space
#import "@preview/numbly:0.1.0": numbly  // 简化标题编号
#import "@preview/i-figured:0.2.4"  // 公式图表编号
// #import "@preview/mitex:0.2.5": *  // 使用LaTeX格式的公式
// #import "@preview/tablex:0.0.9": tablex, rowspanx, colspanx, hlinex  // 绘制复杂的表格
// #import "@preview/rexllent:0.3.3": xlsx-parser  // 导入Excel表格


// 字体
#let SongTi = ("Times New Roman", "Source Han Serif SC")  // 英文使用 Times New Roman，其他使用 Source Han Serif SC
#let Mono = ("Ubuntu Mono")  // 等宽字体
#let KaiTi = ("Times New Roman", "KaiTi")
#let HeiTi = ("Times New Roman", "Source Han Sans SC")
#let FZXBSong = ("FZXiaoBiaoSong-B05S")


#let without_indent(it) = [  // 一些段落不希望首行缩进
  #set par(first-line-indent: 0pt)
  #it
]

// 封面
#let cover(
  title: "报告题目",
  time: "2025年7月15日"
) = {
  block(width: 100%, height: 100%)[
    #set text(font: FZXBSong)
    #grid(
      rows: (8fr, 4em, 4em),
      columns: (1fr),
      stroke: none,
      align: center+horizon,
      text(size: zh(1), title),
      text(time, size: zh(4))
    )
  ]
}

// 摘要
#let abstract(
  conent,
  keywords: ("关键字1", "关键字2"),
) = {
  align(center, text("摘要", font: FZXBSong, size: zh(3)))
  set text(font: KaiTi, size: zh(-4))

  conent

  v(1em)
  set text(font: HeiTi, size: zh(-4))
  set par(hanging-indent: 4em)
  without_indent[关键字：#keywords.join("，")]
  
  pagebreak()
}

// 目录
#let contents(
  depth: 4
) = (body) => {
  outline(
    depth: depth, 
    title: block(width: 100%)[
      #set align(center)
      #text("目录", font: FZXBSong, size: zh(3))
      #v(1em)
    ],
    indent: 1em
  )

  set page(numbering: "1")  // 新的一页
  counter(page).update(1)  // 将页面计数器设置为1

  body
}


// 正文
#let report(
  size: zh(-4),
  font: SongTi,
  font-mono: Mono,
  first-line-indent: true,
  leading: 1em,
  spacing: 1em,
  headings: (
    "1": (numbering: "{1:一}、", 
          style: (size: zh(3), font: SongTi, weight: "black")),
    "2": (numbering: "{1:1}.{2:1}", 
          style: (size: zh(4), font: SongTi, weight: "black")),
    "3": (numbering: "{1:1}.{2:1}.{3:1}", 
          style: (size: zh(4), font: SongTi, weight: "extrabold")),
    "4": (numbering: "{1:1}.{2:1}.{3:1}.{4:1}", 
          style: (size: zh(-4), font: SongTi, weight: "extrabold")),
    "5": (numbering: "({5:1})", 
          style: (size: zh(-4), font: SongTi, weight: "bold")),
    "6": (numbering: "{6:①}", 
          style: (size: zh(-4), font: SongTi, weight: "bold"))
  ),
) = (body) => {
  set text(lang: "zh", size: size, font: font)
  set par(
    first-line-indent: if first-line-indent {
      (amount: 2em, all: true)  // 首行缩进两字符
    } else {0em},
    justify: true,  // 两端对齐
    leading: leading,  // 行距
    spacing: spacing,  // 段间距
  )
  show: remove-cjk-break-space  // 去掉源码中换行引起的中文字符间空格

  show raw: set text(font: font-mono)  // 代码字体

  // 多级标题
  set heading(numbering: numbly(
    ..range(1,7).map(i => headings.at(str(i)).numbering)
  ))
  let heading_kwargs = (above: 1em, below: 1em, sticky: true)
  for i in range(1, 7) {
    show heading.where(level: i): it => block(
      text(..headings.at(i).style, it),
      ..heading_kwargs
    )
  }

  // 公式编号
  show math.equation: it => i-figured.show-equation(it, numbering: "(1-1)")
  show heading: i-figured.reset-counters

  // 图表
  // 表格的标题放在表格上方，图片的标题放在图片下方
  show figure.where(kind: table): set figure.caption(position: top)
  show figure: set block(breakable: true)  // 表格可以跨页
  show figure.where(kind: image): set block(sticky: true)
  show figure.caption: set text(font: KaiTi, size: zh(5))  // 题注的字体
  for k in (table, image, raw) {
    show figure.where(kind: k): it => i-figured.show-figure(it, numbering: "1-1")  // 图表和代码块编号
  }

  body
}


// 参考文献


