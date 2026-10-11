#import "fonts.typ": *
#import "abstract.typ": *
#import "toc.typ": *
#import "bibliography.typ": *
#import "utils.typ": *
#import "@preview/cuti:0.4.0": show-cn-fakebold, show-fakebold

// 主模板函数 — 浙江大学本科毕业论文（设计）
#let zju-thesis(
  thesis-info: (
    title-cn: "",
    title-en: "",
    author: "",
    student-id: "",
    grade: "",
    major: "",
    school: "",
    mentor: "",
    mentor-title: "",
    date: auto,
    confidential: false,
    blind-review: false,
  ),

  figure-options: (
    numbering-style: "chapter", // "global", "chapter", "chapter-dash"
  ),

  bibliography: none,

  abstract-cn: [],
  keywords-cn: (),
  abstract-en: [],
  keywords-en: (),

  conclusion: [],
  appendix: none,
  achievement: none,
  acknowledgement: [],

  // 作者简历
  author-bio-info: none,

  body
) = {
  // 全局字体设置 — 仿宋为主字体
  set text(
    font: fonts.main + fonts.cjk,
    size: 12pt,
    lang: "zh",
    region: "cn"
  )

  // 1.5倍行距（浙大规范）
  set par(
    leading: 1.5em,
    spacing: 1.5em,
    justify: true,
    first-line-indent: 2em
  )

  // 列表项首行缩进
  set list(indent: 2em)
  set enum(indent: 2em)

  // 图表标题与正文间距，题注分隔符用空格
  set figure(gap: 1.5em)
  set figure.caption(separator: h(0.5em))

  // 强制列表和图表后的段落恢复首行缩进
  show list: it => {
    it
    par(leading: 0em, spacing: 0em, first-line-indent: 0em)[#box()]
  }
  show enum: it => {
    it
    par(leading: 0em, spacing: 0em, first-line-indent: 0em)[#box()]
  }

  // 图表样式：表标题在上方，图标题在下方
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: table): set figure(gap: 1em)
  show figure: it => {
    set par(spacing: 0em)
    block(above: 18pt, below: 0pt, it)
    par(leading: 0em, spacing: 0em, first-line-indent: 0em)[#box()]
  }

  // 图/表标题：五号宋体加黑 (10.5pt), 1.5倍行距，居中
  show figure.caption: it => {
    set text(size: 10.5pt, font: ("Times New Roman",) + fonts.song, weight: "bold")
    set par(first-line-indent: 0em, leading: 1.5em)
    align(center, it)
  }

  // 表格内部：5号宋体 (10.5pt), 单倍行距
  show table: set par(spacing: 1em, leading: 1em)
  show table: set text(size: 10.5pt, font: fonts.song)
  // 三线表：横线通过 table.hline 显式添加，列间 0.5pt 竖线（非首列加左边线）
  show table: set table(stroke: (col, row) => (
    top: none, bottom: none, left: if col > 0 { 0.5pt }, right: none
  ))

  // 中英文加粗伪粗体
  show: show-cn-fakebold
  show: doc => show-fakebold(
    reg-exp: "[^p{script=Han}！-･〇-〰—]+",
    weight: "regular",
    doc
  )

  // 数学公式样式
  show math.equation: set text(font: "Cambria Math")
  show math.equation: set block(above: 1.5em, below: 1.5em)

  // 设置标题编号
  set heading(numbering: "1.1.1.1")

  // 标题样式
  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    v(21pt, weak: true)
    set par(first-line-indent: 0em)
    align(left)[
      #text(size: 16pt, weight: "bold", font: ("Times New Roman",) + fonts.fang)[
        #if it.numbering != none {
          [#counter(heading).display()  ]
        }
        #it.body
      ]
    ]
    v(11pt)
  }

  show heading.where(level: 2): it => {
    v(3pt)
    set par(first-line-indent: 0em)
    align(left)[
      #text(size: 15pt, weight: "bold", font: ("Times New Roman",) + fonts.fang)[
        #counter(heading).display() #it.body
      ]
    ]
    v(3pt)
  }

  show heading.where(level: 3): it => {
    v(3pt)
    set par(first-line-indent: 0em)
    align(left)[
      #text(size: 14pt, weight: "bold", font: ("Times New Roman",) + fonts.fang)[
        #counter(heading).display() #it.body
      ]
    ]
    v(3pt)
  }

  show heading.where(level: 4): it => {
    v(6pt, weak: true)
    set par(first-line-indent: 0em)
    align(left)[
      #text(size: 12pt, font: ("Times New Roman",) + fonts.fang)[
        #counter(heading).display() #it.body
      ]
    ]
  }

  // 图表编号：图 X.X / 表 X.X
  set figure(numbering: n => {
    let ch = counter(heading.where(level: 1)).get().first()
    [#ch.#n]
  })

  // ===== 致谢（单面打印） =====
  if acknowledgement != [] {
    set page(
      paper: "a4",
      margin: (top: 25mm, bottom: 25mm, left: 30mm, right: 25mm),
      header: none,
      footer: context [#align(center)[#text(size: 9pt)[#counter(page).display("1")]]],
    )
    set par(leading: 1.5em)
    align(center)[
      #text(size: 16pt, weight: "bold", font: ("Times New Roman",) + fonts.fang)[致谢]
    ]
    v(1em)
    set par(first-line-indent: 2em)
    text(size: 12pt, font: ("Times New Roman",) + fonts.fang)[#acknowledgement]
  }

  // ===== 中文摘要（单面打印） =====
  pagebreak()
  chinese-abstract(abstract-cn, keywords-cn)

  // ===== 英文摘要（单面打印） =====
  pagebreak()
  english-abstract(abstract-en, keywords-en)

  // ===== 目录（从右页/奇数页起） =====
  make-toc()

  // ===== 正文 =====
  // 用 state 存储论文题目，供页眉 context 读取
  let title-cn = thesis-info.at("title-cn", default: "")
  state("zju-thesis-title").update(title-cn)

  set page(
    paper: "a4",
    margin: (top: 25mm, bottom: 25mm, left: 30mm, right: 25mm),
    header: context [
      #set text(size: 9pt, font: fonts.song)
      #set par(spacing: 0.5em)
      #let current-page = here().page()
      #if calc.odd(current-page) [
        // 奇数页：论文题目，靠右
        #align(right)[#state("zju-thesis-title").final()]
      ] else [
        // 偶数页：固定字样，靠左
        #align(left)[浙江大学本科毕业论文（设计）]
      ]
      #line(length: 100%, stroke: rgb("#f6f6f6"))
    ],
    footer: context [#align(center)[#text(size: 9pt)[#counter(page).display("1")]]],
    header-ascent: 7mm,
    footer-descent: 18pt,
  )
  pagebreak()
  counter(page).update(1)

  // 正文内容
  body

  // ===== 结论 =====
  if conclusion != [] {
    pagebreak()
    heading(level: 1)[结论]
    conclusion
  }

  // ===== 参考文献 =====
  if bibliography != none {
    bibliography-page(bibliography)
  }

  // ===== 附录 =====
  if appendix != none {
    pagebreak()
    heading(level: 1, numbering: none)[附录]
    appendix
  }

  // ===== 作者简历 =====
  if author-bio-info != none {
    author-bio(
      name: author-bio-info.at("name", default: ""),
      gender: author-bio-info.at("gender", default: ""),
      ethnicity: author-bio-info.at("ethnicity", default: ""),
      birth: author-bio-info.at("birth", default: ""),
      hometown: author-bio-info.at("hometown", default: ""),
      education: author-bio-info.at("education", default: ()),
      awards: author-bio-info.at("awards", default: ()),
      projects: author-bio-info.at("projects", default: ()),
      publications: author-bio-info.at("publications", default: ()),
    )
  }

  // ===== 在学期间发表的学术论文与研究成果 =====
  if achievement != none {
    pagebreak()
    heading(level: 1, numbering: none)[在学期间发表的学术论文与研究成果]
    achievement
  }
}
