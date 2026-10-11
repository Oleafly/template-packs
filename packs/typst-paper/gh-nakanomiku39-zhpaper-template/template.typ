// 中文学术报告模板
// 字体设置：标题/小标题 14pt 黑体，正文/摘要/作者/关键词 12pt 楷体

// 字体定义（兼容 Windows 和 macOS）
#let font-heiti = ("Times New Roman", "SimHei", "Heiti TC", "Heiti SC")
#let font-kaiti = ("Times New Roman", "KaiTi", "Kaiti TC", "Kaiti SC")

// 三线表
#let three-line-table(columns: auto, ..args) = {
  set table(
    stroke: none,
    align: center + horizon,
    inset: 8pt,
  )
  table(
    columns: columns,
    table.hline(stroke: 1.5pt),
    table.header(..args.pos().slice(0, columns.len())),
    table.hline(stroke: 0.75pt),
    ..args.pos().slice(columns.len()),
    table.hline(stroke: 1.5pt),
  )
}

#let report(
  title: "",
  authors: (),  // 格式: ((name: "", affiliation: "", email: ""), ...)
  abstract: [],
  keywords: (),
  body,
) = {
  // 页面设置
  set page(
    paper: "a4",
    margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  )

  // 正文默认字体：12pt 楷体
  set text(font: font-kaiti, size: 12pt, lang: "zh")

  // 段落设置：首行缩进2字符
  set par(first-line-indent: 2em, justify: true, leading: 1em)

  // 标题编号格式：1, 1.1, 1.1.1
  set heading(numbering: "1.1.1")

  // 标题样式：14pt 黑体
  show heading: it => {
    set text(font: font-heiti, size: 14pt, weight: "bold")
    set par(first-line-indent: 0em)
    v(0.5em)
    it
    v(0.5em)
    par(first-line-indent: 2em)[#h(0em)]
  }

  // 图片编号设置
  set figure(numbering: "1")
  show figure.caption: it => {
    set text(font: font-kaiti, size: 12pt)
    if it.kind == image {
      [图#it.counter.display() #it.body]
    } else if it.kind == table {
      [表#it.counter.display() #it.body]
    } else {
      it
    }
  }

  // ========== 标题 ==========
  align(center)[
    #set par(first-line-indent: 0em)
    #text(font: font-heiti, size: 14pt, weight: "bold")[#title]
  ]

  v(1em)

  // ========== 作者列表 ==========
  align(center)[
    #set par(first-line-indent: 0em)
    #text(font: font-kaiti, size: 12pt)[
      #for author in authors {
        [#author.name，#author.affiliation，#author.email]
        linebreak()
      }
    ]
  ]

  v(1.5em)

  // ========== 摘要 ==========
  [
    #text(font: font-heiti, size: 14pt, weight: "bold")[摘要：]#abstract
  ]

  v(0.5em)

  // ========== 关键词 ==========
  [
    #set par(first-line-indent: 0em)
    #text(font: font-heiti, size: 14pt, weight: "bold")[关键词：]#text(font: font-kaiti, size: 12pt)[#keywords.join("；")]
  ]

  v(1.5em)

  // ========== 正文 ==========
  body
}

// 附录环境
#let appendix(body) = {
  set heading(numbering: "A.1")
  counter(heading).update(0)

  pagebreak(weak: true)

  align(center)[
    #text(font: font-heiti, size: 14pt, weight: "bold")[附录]
  ]

  v(1em)
  body
}
