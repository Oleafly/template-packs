// WHU Thesis Typst Template
// 武汉大学学位论文 Typst 模板
// Version: 0.1.0

#import "@preview/cuti:0.2.1": fakebold

// ========== 论文类型 ==========
// thesis-type: "bachelor" | "master" | "doctor"
// degree-class: "academic" | "professional"

#let whu-thesis(
  // 论文类型
  thesis-type: "bachelor", // bachelor, master, doctor
  degree-class: "academic", // academic, professional
  // 论文信息
  title: "论文题目",
  title-en: "Thesis Title",
  department: "学院名称",
  department-en: "School of XXX",
  author: "作者姓名",
  author-en: "Author Name",
  student-id: "2021202012345",
  supervisor: "导师姓名",
  supervisor-en: "Supervisor Name",
  academic-title: "教授",
  academic-title-en: "Prof.",
  supervisor-outer: none,
  academic-title-outer: none,
  subject: none,
  major: "专业名称",
  major-en: "Major Name",
  research-area: "研究方向",
  research-area-en: "Research Area",
  year: 2024,
  month: 4,
  clc: none,
  udc: none,
  secret-level: none,
  keywords-zh: ("关键词1", "关键词2"),
  keywords-en: ("Keyword1", "Keyword2"),
  bib-resource: none,
  author-signature: none, // 作者签名图片路径（可选）
  // 正文内容
  body,
) = {
  // ========== 字号定义 ==========
  let zihao = (
    "初号": 42pt,
    "小初": 36pt,
    "一号": 26pt,
    "小一": 24pt,
    "二号": 22pt,
    "小二": 18pt,
    "三号": 16pt,
    "小三": 15pt,
    "四号": 14pt,
    "小四": 12pt,
    "五号": 10.5pt,
    "小五": 9pt,
  )

  // ========== 页面设置 ==========
  let page-margin = if thesis-type == "bachelor" {
    (left: 31.8mm, right: 31.8mm, top: 25.4mm, bottom: 25.4mm)
  } else {
    (left: 28mm, right: 25mm, top: 30mm, bottom: 29mm)
  }

  // ========== 中文月份/年份（大写） ==========
  let cn-digits = ("〇", "一", "二", "三", "四", "五", "六", "七", "八", "九")
  let year-cn = str(year).clusters().map(d => cn-digits.at(int(d))).join("")
  let month-cn = if month < 10 {
    cn-digits.at(month)
  } else if month == 10 {
    "十"
  } else {
    "十" + cn-digits.at(month - 10)
  }
  let month-str = str(month)

  // ========== 学位类型文字 ==========
  let thesis-type-zh = if thesis-type == "bachelor" {
    "本科毕业论文（设计）"
  } else if thesis-type == "master" {
    "硕士学位论文"
  } else {
    "博士学位论文"
  }

  let degree-class-zh = if degree-class == "academic" {
    "（学术学位）"
  } else {
    "（专业学位）"
  }

  let header-text = if thesis-type == "bachelor" {
    "武汉大学本科毕业论文（设计）"
  } else if thesis-type == "master" {
    "武汉大学硕士学位论文"
  } else {
    "武汉大学博士学位论文"
  }

  // ========== 文档基本设置 ==========
  set document(
    title: title,
    author: author,
  )

  set text(
    font: ("Times New Roman", "Source Han Serif"),
    size: zihao.at("小四"),
    lang: "zh",
    region: "cn",
  )

  // 只对宋体（SimSun）使用伪粗体；黑体/楷体/仿宋本身有真粗体或不需要加粗
  show strong: it => context {
    let fonts = text.font
    let stack = if type(fonts) == array { fonts } else { (fonts,) }
    if "Source Han Sans SC" in stack or "KaiTi" in stack or "FangSong" in stack {
      it
    } else {
      fakebold(it)
    }
  }

  // 行距：本科 23pt 行距（≈1.59），硕博 20pt 行距（≈1.39），对齐 LaTeX 模板的 linespread 设置
  let body-leading = if thesis-type == "bachelor" { 23pt - zihao.at("小四") } else { 20pt - zihao.at("小四") }

  set par(
    first-line-indent: (amount: 2em, all: true),
    leading: body-leading,
    spacing: body-leading * 1.5,
    justify: true,
  )

  // ========== 脚注 ==========
  // 对齐 LaTeX 模板：五号字（10.5pt），数字编号，分隔横线约 2 英寸
  set footnote(numbering: "1")
  show footnote.entry: it => {
    set text(size: 9pt)
    set par(leading: 0.5em, first-line-indent: 0em)
    it
  }
  set footnote.entry(
    separator: line(length: 2in, stroke: 0.5pt),
    indent: 1em,
    gap: 0.5em,
  )

  // ========== 封面页 ==========
  {
    set page(
      paper: "a4",
      margin: (x: 2.445cm, y: 2.54cm),
      header: none,
      footer: none,
      numbering: none,
    )

    if thesis-type == "bachelor" {
      // ===== 本科封面（对齐 2024 官方 LaTeX 模板）=====
      // 在指定宽度内将 CJK 字符两端展开（等价于 \__whu_spread_with:nn）
      let spread(width, s) = {
        let chars = s.clusters()
        if chars.len() >= 2 {
          box(width: width, stack(
            dir: ltr,
            spacing: 1fr,
            ..chars,
          ))
        } else {
          box(width: width)[#align(center)[#s]]
        }
      }

      align(center)[
        #v(2cm)
        #image("logo/whu-name.png", width: 5.5cm)
        #v(1.5cm)
        #text(
          size: zihao.at("二号"),
          weight: "extrabold",
          font: ("Times New Roman", "Source Han Serif"),
        )[#thesis-type-zh]
        #v(4em)
        #block(height: 6cm, width: 100%)[
          #set par(leading: 32pt - zihao.at("一号"))
          #align(horizon + center)[
            #text(
              size: zihao.at("一号"),
              font: ("Times New Roman", "KaiTi"),
            )[#title]
          ]
        ]
        #v(4em)
      ]

      // 信息栏：字段名在 4em 内两端展开，"：" 后空 2em，值居中填满约 7em
      {
        set text(size: zihao.at("四号"))
        set par(leading: 0.5em)
        let field-width = 4em
        let value-width = 8em
        let row(key, value) = (
          align(right)[#spread(field-width, key)],
          [：],
          h(2em),
          spread(value-width, value),
        )
        align(center)[
          #grid(
            columns: (auto, auto, auto, auto),
            row-gutter: 1em,
            column-gutter: 0pt,
            ..row("姓名", author),
            ..row("学号", student-id),
            ..row("专业", major),
            ..row("学院", department),
            ..row("指导教师", supervisor),
          )
        ]
      }

      v(1fr)
      align(center)[
        #text(
          size: zihao.at("小二"),
          font: ("Times New Roman", "Source Han Serif"),
        )[#year-cn#h(0.25em)年#month-cn#h(0.25em)月]
      ]
      v(1cm)
    } else {
      // ===== 硕士/博士封面 =====
      // 分类号等信息
      {
        set text(size: zihao.at("五号"))
        grid(
          columns: (1fr, 1fr),
          row-gutter: 8pt,
          [分类号：#if clc != none { clc }], align(right)[密级：#if secret-level != none { secret-level }],
          [U D C：#if udc != none { udc }], align(right)[编号：],
        )
      }

      v(1.0cm)
      align(center)[
        #image("logo/whu-name.png", width: 5cm)
        #v(0.5cm)
        #text(size: zihao.at("二号"), weight: "bold", tracking: 0.3em)[#thesis-type-zh]
        #v(0.2cm)
        #text(size: zihao.at("小二"), weight: "bold")[#degree-class-zh]
        #v(1.2cm)
        #text(size: zihao.at("一号"), font: ("Times New Roman", "KaiTi"))[#title]
        #v(1.5cm)
      ]

      // 信息栏
      {
        set text(size: zihao.at("四号"))
        let info-key(body) = {
          text(weight: "bold")[#body]
          h(0.5em)
        }
        let info-value(body) = {
          box(width: 180pt, stroke: (bottom: 0.5pt), outset: (bottom: 3pt))[
            #align(center)[#body]
          ]
        }
        align(center)[
          #grid(
            columns: (auto, auto),
            row-gutter: 16pt,
            align: (right, left),
            info-key[研 究 生 姓 名：], info-value[#author],
            info-key[学　　　　号：], info-value[#student-id],
            ..if subject != none { (info-key[学 科、 专 业：], info-value[#subject]) },
            info-key[研　究　方　向：], info-value[#research-area],
            info-key[指 导 教 师：], info-value[#supervisor #h(1em) #academic-title],
            ..if supervisor-outer != none {
              (info-key[校外指导教师：], info-value[#supervisor-outer #h(1em) #academic-title-outer])
            },
          )
        ]
      }

      v(1fr)
      align(center)[
        #text(size: zihao.at("三号"), font: ("Times New Roman", "Source Han Sans SC"))[#year-cn 年#month-cn 月]
      ]
      v(1cm)
    }
  }

  // ========== 英文封面 ==========
  {
    set page(
      paper: "a4",
      margin: (x: 2.445cm, y: 2.54cm),
      header: none,
      footer: none,
      numbering: none,
    )

    let en-thesis-type = if thesis-type == "bachelor" {
      "Bachelor's Thesis"
    } else if thesis-type == "master" {
      "Master's Thesis"
    } else {
      "Doctoral Dissertation"
    }

    align(center)[
      #v(2cm)
      #text(size: zihao.at("二号"), weight: "bold")[#title-en]
      #v(2cm)
      #text(size: zihao.at("四号"))[
        #en-thesis-type
      ]
      #v(2cm)
    ]

    {
      set text(size: zihao.at("四号"))
      let info-key(body) = text(weight: "bold")[#body]
      let info-value(body) = body

      align(center)[
        #grid(
          columns: (auto, auto),
          row-gutter: 14pt,
          align: (right, left),
          info-key[Candidate: #h(1em)], info-value[#author-en],
          info-key[Major: #h(1em)], info-value[#major-en],
          info-key[Supervisor: #h(1em)], info-value[#supervisor-en],
          info-key[Department: #h(1em)], info-value[#department-en],
        )
      ]
    }

    v(1fr)
    align(center)[
      #image("logo/whu-logo.png", width: 2.5cm)
      #v(0.3cm)
      #text(size: zihao.at("三号"), weight: "bold")[Wuhan University]
      #v(0.5cm)
      #text(size: zihao.at("四号"))[
        #{
          let month-names = ("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December")
          month-names.at(month - 1)
        }, #str(year)
      ]
    ]
    v(1cm)
  }

  // ========== 独创性声明 ==========
  {
    set page(
      paper: "a4",
      margin: page-margin,
      header: none,
      footer: none,
      numbering: none,
    )
    set par(first-line-indent: (amount: 2em, all: true))

    if thesis-type == "bachelor" {
      let signature-box = if author-signature != none {
        box(height: 3em, baseline: 30%)[#image(author-signature, height: 3em)]
      } else {
        box(width: 6em, repeat[])
      }
      let sig-line = box(width: 5em, repeat[ ])
      let sig-block = {
        grid(
          columns: (1fr, 1fr),
          column-gutter: 2em,
          row-gutter: 1.2em,
          [作者签名：#sig-line], [指导教师签名：#sig-line],
          [日#h(0.5em)期：#h(1em)#box(width: 3em, repeat[ ])年#box(width: 2em, repeat[ ])月#box(width: 2em, repeat[ ])日], [],
        )
      }

      // ===== 原创性声明 =====
      align(center)[
        #text(
          size: zihao.at("小二"),
          weight: "bold",
          font: ("Times New Roman", "Source Han Sans SC"),
        )[原创性声明]
      ]
      v(0.5cm)
      text(size: zihao.at("小四"))[
        本人郑重声明：所呈交的论文（设计），是本人在指导教师的指导下，严格按照学校和学院有关规定完成的。除文中已经标明引用的内容外，本论文（设计）不包含任何其他个人或集体已发表及撰写的研究成果。对本论文（设计）做出贡献的个人和集体，均已在文中以明确方式标明。本人承诺在论文（设计）工作过程中没有伪造数据等行为。若在本论文（设计）中有侵犯任何方面知识产权的行为，由本人承担相应的法律责任。
      ]
      v(2cm)
      text(size: zihao.at("小四"))[#sig-block]

      // ===== 版权使用授权书 =====
      v(4.5cm)
      align(center)[
        #text(
          size: zihao.at("小二"),
          weight: "bold",
          font: ("Times New Roman", "Source Han Sans SC"),
        )[版权使用授权书]
      ]
      v(0.5cm)
      text(size: zihao.at("小四"))[
        本人完全了解武汉大学有权保留并向有关部门或机构送交本论文（设计）的复印件和电子版，允许本论文（设计）被查阅和借阅。本人授权武汉大学将本论文的全部或部分内容编入有关数据进行检索和传播，可以采用影印、缩印或扫描等复制手段保存和汇编本论文（设计）。
      ]
      v(2cm)
      text(size: zihao.at("小四"))[#sig-block]
    } else {
      align(center)[
        #text(size: zihao.at("小二"), weight: "bold", font: ("Times New Roman", "Source Han Sans SC"))[
          关于学位论文原创性和学术规范的声明
        ]
      ]
      v(0.5cm)
      text(size: 14pt)[
        本人郑重声明所呈交的学位论文，是在导师指导下独立进行研究工作所得的研究成果。除了文中已经标明引用的内容外，本论文不包含任何其他个人或集体已经发表或撰写过的研究成果。对本文的研究做出贡献的个人和集体，均已在文中以明确方式标明。

        本声明的法律后果由本人承担。
      ]
      v(2cm)
      align(right)[
        #text(size: 14pt)[
          论文作者（签名）：#box(width: 6em, repeat[])
          #h(1em)
          日期：#box(width: 8em, repeat[])
        ]
      ]
    }
  }

  // ========== 前置部分：摘要等 ==========
  // 使用 state 追踪页码类型
  let front-matter-start = state("front-matter-start", true)

  // 前置部分页面设置（罗马数字页码）
  set page(
    paper: "a4",
    margin: page-margin,
    header: context {
      if thesis-type == "bachelor" {
        // 本科前置部分无页眉
        none
      } else {
        set text(size: zihao.at("五号"))
        let page-num = here().page()
        if calc.odd(page-num) {
          align(center)[#title]
        } else {
          align(center)[#header-text]
        }
        v(-0.5em)
        line(length: 100%, stroke: 0.5pt)
      }
    },
    footer: context {
      set text(size: zihao.at("五号"))
      let counter-val = counter(page).get().first()
      align(center)[#numbering("I", counter-val)]
    },
    numbering: "I",
  )
  counter(page).update(1)

  // 提供给用户的函数通过 body 传入
  body
}


// ========== 中文摘要环境 ==========
#let abstract-zh(keywords: (), body) = {
  let zihao-small2 = 18pt
  let zihao-small4 = 12pt

  pagebreak(weak: true)

  {
    set text(size: zihao-small4)
    show heading: it => align(center)[
      #text(
        size: zihao-small2,
        weight: "bold",
        font: ("Times New Roman", "Source Han Sans SC"),
      )[摘#h(2em)要]
    ]
    heading(level: 1, numbering: none, outlined: true, bookmarked: true)[摘要]
    v(0.5cm)
    body
    v(0.5em)

    par(first-line-indent: 0pt)[
      #text(
        weight: "bold",
        font: ("Times New Roman", "Source Han Sans SC"),
      )[关键词：]#keywords.join("；")
    ]
  }
}


// ========== 英文摘要环境 ==========
#let abstract-en(keywords: (), body) = {
  let zihao-small2 = 18pt
  let zihao-small4 = 12pt

  pagebreak(weak: true)

  {
    set text(size: zihao-small4)
    show heading: it => align(center)[
      #text(size: zihao-small2, weight: "bold")[ABSTRACT]
    ]
    heading(level: 1, numbering: none, outlined: true, bookmarked: true)[ABSTRACT]
    v(0.5cm)
    body
    v(0.5em)

    par(first-line-indent: 0pt)[
      #text(weight: "bold")[Keywords: ]#keywords.join("; ")
    ]
  }
}


// ========== 目录 ==========
#let make-toc() = {
  let zihao-small2 = 18pt

  pagebreak(weak: true)

  align(center)[
    #text(
      size: zihao-small2,
      weight: "bold",
      font: ("Times New Roman", "Source Han Sans SC"),
    )[目#h(2em)录]
  ]
  v(0.5cm)

  {
    set text(size: 12pt)
    show outline.entry.where(level: 1): it => {
      v(0.3em)
      strong(it)
    }
    outline(
      title: none,
      indent: auto,
      depth: 3,
    )
  }
}


// ========== 切换到正文 ==========
#let mainmatter() = {
  pagebreak(weak: true)
  counter(page).update(1)
}


// ========== 正文页面设置（在 show rule 中使用） ==========
#let mainmatter-style(thesis-type: "master", title: "", body) = {
  let zihao = (
    "小二": 18pt,
    "四号": 14pt,
    "小四": 12pt,
    "五号": 10.5pt,
  )

  let header-text = if thesis-type == "bachelor" {
    "武汉大学本科毕业论文（设计）"
  } else if thesis-type == "master" {
    "武汉大学硕士学位论文"
  } else {
    "武汉大学博士学位论文"
  }

  set page(
    header: context {
      set text(size: zihao.at("五号"))
      if thesis-type == "bachelor" {
        align(center)[#header-text]
      } else {
        let page-num = here().page()
        if calc.odd(page-num) {
          align(center)[#title]
        } else {
          align(center)[#header-text]
        }
      }
      v(-0.5em)
      line(length: 100%, stroke: 0.5pt)
    },
    footer: context {
      set text(size: zihao.at("五号"))
      let counter-val = counter(page).get().first()
      align(center)[#str(counter-val)]
    },
    numbering: "1",
  )

  // 章节标题样式
  set heading(numbering: "1.1.1")

  // 公式编号：章节号.公式号
  set math.equation(numbering: num => {
    let h = counter(heading).get()
    numbering("(1.1)", h.first(), num)
  })

  // 隐藏 theorem figure 的 caption
  show figure.where(kind: "theorem"): set figure(outlined: false)
  show figure.where(kind: "theorem"): set figure.caption(position: top)
  show figure.where(kind: "theorem"): it => it.body

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    set text(
      size: zihao.at("小二"),
      weight: "bold",
      font: ("Times New Roman", "Source Han Sans SC"),
    )
    v(0.8em)
    if it.numbering == none {
      if thesis-type == "bachelor" {
        align(center)[#it.body]
      } else {
        it.body
      }
    } else if thesis-type == "bachelor" {
      align(center)[
        #counter(heading).display("1")
        #h(0.5em)
        #it.body
      ]
    } else {
      [
        #counter(heading).display("第1章")
        #h(0.5em)
        #it.body
      ]
    }
    v(0.5em)
  }

  show heading.where(level: 2): it => {
    set text(
      size: zihao.at("四号"),
      weight: "bold",
      font: ("Times New Roman", "Source Han Sans SC"),
    )
    v(0.5em)
    it
    v(0.3em)
  }

  show heading.where(level: 3): it => {
    set text(
      size: zihao.at("小四"),
      weight: "bold",
      font: ("Times New Roman", "Source Han Sans SC"),
    )
    v(0.3em)
    it
    v(0.2em)
  }

  // 图表编号：章.序
  set figure(numbering: n => context {
    let h = counter(heading).get()
    if h.len() > 0 and h.first() > 0 {
      str(h.first()) + "." + str(n)
    } else {
      str(n)
    }
  })
  // 图表 caption 样式（参考 whu-thesis 2024 规范）：
  //   表标题：黑体加粗，小四号，置于表上方
  //   图标题：宋体，小四号，置于图下方
  //   "表 X.X"/"图 X.X" 与标题之间空一格
  show figure.where(kind: table): set figure(supplement: "表")
  show figure.where(kind: table): set figure.caption(position: top, separator: [#h(0.5em)])
  show figure.where(kind: image): set figure(supplement: "图")
  show figure.where(kind: image): set figure.caption(position: bottom, separator: [#h(0.5em)])
  show figure.caption: it => {
    if it.kind == table {
      set text(size: zihao.at("小四"), weight: "bold", font: ("Source Han Sans SC", "Times New Roman"))
      it
    } else if it.kind == image {
      set text(size: zihao.at("小四"), font: ("Source Han Serif", "Times New Roman"))
      it
    } else {
      set text(size: zihao.at("五号"), weight: "bold")
      it
    }
  }

  // 表格默认样式：内容五号字，三线表（无网格、无填充）
  show figure.where(kind: table): set text(size: zihao.at("五号"))
  set table(stroke: none, inset: (x: 0.6em, y: 0.5em))

  body
}


// ========== 致谢环境 ==========
#let acknowledgements(body) = {
  let zihao-small2 = 18pt
  let zihao-small4 = 12pt

  pagebreak(weak: true)

  {
    set text(size: zihao-small4)
    show heading: it => align(center)[
      #text(
        size: zihao-small2,
        weight: "bold",
        font: ("Times New Roman", "Source Han Sans SC"),
      )[致#h(2em)谢]
    ]
    heading(level: 1, numbering: none, outlined: true, bookmarked: true)[致谢]
    v(0.5cm)
    body
  }
}


// ========== 参考文献 ==========
// 按 LaTeX 模板：本科默认 GB/T 7714-2005 数字制（numeric），硕士/博士默认著者-出版年制（author-year）。
#let make-bibliography(bib-file, thesis-type: "bachelor") = {
  let zihao-small2 = 18pt

  pagebreak(weak: true)

  // 让"参考文献"出现在目录中（不参与章节编号）
  heading(level: 1, numbering: none, outlined: true, bookmarked: true)[参考文献]

  set text(size: 12pt)

  bibliography(
    bib-file,
    title: none,
    style: if thesis-type == "bachelor" {
      "gb-7714-2005-numeric"
    } else {
      "gb-7714-2005"
    },
  )
}


// ========== 附录开始 ==========
// 调用后，后续一级标题编号变为「附录A」「附录B」…
#let appendix-start() = {
  pagebreak(weak: true)
  counter(heading).update(0)
  set heading(numbering: (..nums) => {
    let n = nums.pos()
    if n.len() == 1 {
      "附录" + numbering("A", n.first())
    } else {
      numbering("A.1", ..n)
    }
  })
}


// ========== 数学定理环境 ==========
#let make-theorem(name, title: none, body) = figure(
  kind: "theorem",
  supplement: name,
  numbering: n => context {
    let h = counter(heading).get()
    if h.len() > 0 { str(h.first()) + "." }
    str(n)
  },
  block(width: 100%, above: 0.3em, below: 0.3em)[
    #h(2em)
    #text(weight: "bold")[
      #name
      #context {
        let c = counter(figure.where(kind: "theorem")).get().first()
        let h = counter(heading).get()
        if h.len() > 0 { str(h.first()) + "." }
        str(c)
      }
      #if title != none [ (#title)]
    ]
    #h(0.5em)
    #body
  ],
)

#let theorem(title: none, body) = make-theorem("定理", title: title, body)
#let definition(title: none, body) = make-theorem("定义", title: title, body)
#let lemma(title: none, body) = make-theorem("引理", title: title, body)
#let corollary(title: none, body) = make-theorem("推论", title: title, body)
#let proposition(title: none, body) = make-theorem("命题", title: title, body)
#let example(title: none, body) = make-theorem("例", title: title, body)
#let property(title: none, body) = make-theorem("性质", title: title, body)
#let axiom(title: none, body) = make-theorem("公理", title: title, body)
#let remark(title: none, body) = make-theorem("注", title: title, body)

#let proof(title: "证明", body) = {
  v(0.3em)
  block(width: 100%)[
    #h(2em)
    #text(weight: "bold")[#title：]
    #body
    #h(1fr) $square$
  ]
  v(0.3em)
}
