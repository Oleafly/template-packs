// 山东大学课程作业 Typst 模板
// SDU Course Assignment Template v2

#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *

// 字体设置（英文字体在前，中文 fallback 在后）
// Typst 按顺序查找：英文命中第一个，中文自动 fallback 到 CJK 字体
// 本地编译可替换为: "Times New Roman" / "SimHei" / "SimSun" 等
#let heiti = ("Noto Sans CJK SC", "DejaVu Sans")          // 标题：英文无衬线 + 中文黑体
#let songti = ("Libertinus Serif", "Noto Serif CJK SC")   // 正文：英文衬线 + 中文宋体
#let monoti = ("DejaVu Sans Mono",)                       // 代码：等宽字体

// ============================================================
// 封面页函数
// ============================================================
#let sdu-cover(
  title: "",
  course: "",
  college: "",
  major: "",
  student-id: "",
  author: "",
  instructor: "",
  date: datetime.today().display("[year]年[month]月[day]日"),
  logo: none,
) = {
  set page(header: none, footer: none,
    background: {
      // 顶部装饰条
      place(top + left, rect(
        width: 100%,
        height: 0.8cm,
        fill: rgb("#003366"),
      ))
      // 底部装饰条
      place(bottom + left, rect(
        width: 100%,
        height: 0.4cm,
        fill: rgb("#003366"),
      ))
    },
  )

  v(0.8fr)

  // 校徽（可选）
  if logo != none {
    align(center)[
      #image(logo, width: 5cm)
    ]
    v(0.8em)
  }

  // 校名
  align(center)[
    #text(font: heiti, size: 28pt, weight: "bold", fill: rgb("#003366"))[
      山 东 大 学
    ]
  ]

  v(0.4em)

  // 分隔线
  align(center)[
    #line(length: 70%, stroke: 1.5pt + rgb("#003366"))
  ]

  v(0.6em)

  // 文档类型
  align(center)[
    #text(font: heiti, size: 22pt, weight: "bold")[
      课 程 作 业
    ]
  ]

  v(2em)

  // 标题
  align(center)[
    #block(width: 80%)[
      #text(font: heiti, size: 18pt, weight: "bold")[
        #title
      ]
    ]
  ]

  v(3em)

  // 信息表格
  {
    set text(font: songti, size: 14pt)
    let info-line(label, value) = {
      grid(
        columns: (6em, 1em, 1fr),
        align: (right, center, center),
        text(weight: "bold")[#label],
        [:],
        {
          box(width: 100%, stroke: (bottom: 0.5pt + black))[
            #align(center)[#value]
          ]
        },
      )
    }
    align(center)[
      #block(width: 65%)[
        #set par(leading: 1.8em)
        #info-line("课程名称", course)
        #info-line("学　　院", college)
        #info-line("专　　业", major)
        #info-line("学　　号", student-id)
        #info-line("姓　　名", author)
        #if instructor != "" {
          info-line("指导教师", instructor)
        }
      ]
    ]
  }

  v(3em)

  // 日期
  align(center)[
    #text(font: songti, size: 14pt)[#date]
  ]

  v(1fr)

  pagebreak()
}

// ============================================================
// 摘要页函数
// ============================================================
#let abstract-page(abstract-body, keywords: ()) = {
  set page(header: none, footer: none)

  v(2em)

  align(center)[
    #text(font: heiti, size: 16pt, weight: "bold")[摘　要]
  ]

  v(1em)

  abstract-body

  if keywords.len() > 0 {
    v(1.5em)
    par(first-line-indent: 0em)[
      #text(font: heiti, weight: "bold")[关键词：]
      #keywords.join("；")
    ]
  }

  pagebreak()
}

// ============================================================
// 附录支持
// ============================================================
#let appendix(body) = {
  counter(heading).update(0)
  set heading(numbering: "A.1")
  body
}

// ============================================================
// 定理 / 定义 / 引理 等环境
// ============================================================
#let theorem-counter = counter("theorem")
#let definition-counter = counter("definition")
#let lemma-counter = counter("lemma")
#let proposition-counter = counter("proposition")
#let corollary-counter = counter("corollary")
#let example-counter = counter("example")
#let remark-counter = counter("remark")

#let _reset-chapter-counters() = {
  counter(figure.where(kind: image)).update(0)
  counter(figure.where(kind: table)).update(0)
  counter(math.equation).update(0)
  theorem-counter.update(0)
  definition-counter.update(0)
  lemma-counter.update(0)
  proposition-counter.update(0)
  corollary-counter.update(0)
  example-counter.update(0)
  remark-counter.update(0)
}

#let _chapter-numbered-counter(target-counter) = context {
  let chapter = counter(heading).get().at(0, default: 0)
  let number = target-counter.get().at(0, default: 0)
  if chapter == 0 {
    numbering("1", number)
  } else {
    numbering("1.1", chapter, number)
  }
}

#let _theorem-block(counter, kind-name, fill-color, body, name: none) = {
  counter.step()
  block(
    width: 100%,
    inset: (x: 12pt, y: 10pt),
    radius: 3pt,
    stroke: 0.8pt + fill-color,
    fill: fill-color.lighten(92%),
  )[
    #text(weight: "bold", fill: fill-color)[
      #kind-name #_chapter-numbered-counter(counter) #if name != none [(#name)]
    ]
    #h(0.5em) #body
  ]
}

#let theorem(body, name: none) = _theorem-block(
  theorem-counter, "定理", rgb("#1a5276"), body, name: name,
)

#let definition(body, name: none) = _theorem-block(
  definition-counter, "定义", rgb("#196f3d"), body, name: name,
)

#let lemma(body, name: none) = _theorem-block(
  lemma-counter, "引理", rgb("#7d3c98"), body, name: name,
)

#let proposition(body, name: none) = _theorem-block(
  proposition-counter, "命题", rgb("#b9770e"), body, name: name,
)

#let corollary(body, name: none) = _theorem-block(
  corollary-counter, "推论", rgb("#2e86c1"), body, name: name,
)

#let example(body, name: none) = _theorem-block(
  example-counter, "例", rgb("#616a6b"), body, name: name,
)

#let remark(body, name: none) = _theorem-block(
  remark-counter, "注", rgb("#5d6d7e"), body, name: name,
)

#let proof(body) = {
  block(
    width: 100%,
    inset: (x: 12pt, y: 10pt),
  )[
    #text(weight: "bold", style: "italic")[证明.]
    #h(0.3em) #body #h(1fr) $square$
  ]
}

// ============================================================
// 数学公式展示框
// ============================================================
#let math-box(
  body,
  title: none,
  accent-color: rgb("#003366"),
  fill: rgb("#f8fbff"),
) = {
  set par(first-line-indent: 0em)
  block(
    width: 100%,
    above: 0.8em,
    below: 0.8em,
    inset: (x: 12pt, y: 10pt),
    radius: 3pt,
    stroke: 0.8pt + accent-color.lighten(35%),
    fill: fill,
  )[
    #if title != none {
      text(font: heiti, weight: "bold", fill: accent-color)[#title]
      v(0.4em)
    }
    #align(center)[#body]
  ]
}

#let boxed-equation(body, title: none) = math-box(body, title: title)

// ============================================================
// Linux 终端模拟框
// ============================================================
#let terminal(user: "user", host: "localhost", dir: "~", ..commands) = {
  set par(first-line-indent: 0em)
  let prompt = text(fill: rgb("#44cc44"), weight: "bold")[#user\@#host]
  let colon = text(fill: white)[:]
  let dir-text = text(fill: rgb("#5588ff"), weight: "bold")[#dir]
  let dollar = text(fill: white)[\$ ]

  let lines = ()
  for cmd in commands.pos() {
    if type(cmd) == str {
      // 纯命令，无输出
      lines.push({
        prompt; colon; dir-text; dollar
        text(fill: rgb("#eeeeee"), weight: "bold")[#cmd]
      })
    } else if type(cmd) == array and cmd.len() >= 1 {
      // (命令, 输出1, 输出2, ...)
      lines.push({
        prompt; colon; dir-text; dollar
        text(fill: rgb("#eeeeee"), weight: "bold")[#cmd.at(0)]
      })
      for i in range(1, cmd.len()) {
        lines.push(text(fill: rgb("#cccccc"))[#cmd.at(i)])
      }
    }
  }

  block(
    width: 100%,
    radius: 5pt,
    clip: true,
    stroke: 0.8pt + rgb("#444444"),
    above: 1em,
    below: 1em,
  )[
    // 终端内容
    #block(
      width: 100%,
      inset: (x: 12pt, y: 10pt),
      fill: rgb("#1e1e1e"),
    )[
      #set text(font: monoti, size: 10pt)
      #set par(leading: 0.65em)
      #for line in lines {
        line
        linebreak()
      }
    ]
  ]
}

// ============================================================
// 注意 / 提示 / 警告 框
// ============================================================
#let note-box(body, title: "注意") = {
  block(
    width: 100%,
    inset: (x: 12pt, y: 10pt),
    radius: 3pt,
    stroke: (left: 3pt + rgb("#e67e22")),
    fill: rgb("#fef9e7"),
  )[
    #text(weight: "bold", fill: rgb("#e67e22"))[#title] \
    #body
  ]
}

#let tip-box(body, title: "提示") = {
  block(
    width: 100%,
    inset: (x: 12pt, y: 10pt),
    radius: 3pt,
    stroke: (left: 3pt + rgb("#27ae60")),
    fill: rgb("#eafaf1"),
  )[
    #text(weight: "bold", fill: rgb("#27ae60"))[#title] \
    #body
  ]
}

#let warning-box(body, title: "警告") = {
  block(
    width: 100%,
    inset: (x: 12pt, y: 10pt),
    radius: 3pt,
    stroke: (left: 3pt + rgb("#e74c3c")),
    fill: rgb("#fdedec"),
  )[
    #text(weight: "bold", fill: rgb("#e74c3c"))[#title] \
    #body
  ]
}

// ============================================================
// 主文档配置函数
// ============================================================
#let sdu-assignment(
  title: "",
  course: "",
  college: "",
  major: "",
  student-id: "",
  author: "",
  instructor: "",
  date: datetime.today().display("[year]年[month]月[day]日"),
  show-toc: true,
  logo: none,
  body,
) = {
  // 文档基础设置
  set document(title: title, author: author)
  set page(
    paper: "a4",
    margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  )
  set text(font: songti, size: 12pt, lang: "zh")
  set par(leading: 1em, first-line-indent: 2em, justify: true)

  // 参考文献格式：GB/T 7714
  set bibliography(style: "gb-7714-2005-numeric")

  // ---- 标题样式 ----
  set heading(numbering: "1.1.1")
  show heading: it => {
    set par(first-line-indent: 0em)
    if it.level == 1 {
      _reset-chapter-counters()
      v(0.8em)
      text(font: heiti, size: 16pt, weight: "bold")[
        #context counter(heading).display() #h(0.3em) #it.body
      ]
      v(0.3em)
      line(length: 100%, stroke: 1pt + rgb("#003366"))
      v(0.4em)
    } else if it.level == 2 {
      v(0.6em)
      text(font: heiti, size: 14pt, weight: "bold")[
        #context counter(heading).display() #h(0.3em) #it.body
      ]
      v(0.4em)
    } else {
      v(0.4em)
      text(font: heiti, size: 12pt, weight: "bold")[
        #context counter(heading).display() #h(0.3em) #it.body
      ]
      v(0.3em)
    }
  }

  // ---- 图表按章编号 ----
  set figure(numbering: (..nums) => context {
    let chapter = counter(heading).get().at(0, default: 0)
    if chapter == 0 {
      numbering("1", ..nums)
    } else {
      numbering("1-1", chapter, ..nums)
    }
  })
  show figure.where(kind: table): set figure.caption(position: top)

  set math.equation(numbering: (..nums) => context {
    let chapter = counter(heading).get().at(0, default: 0)
    if chapter == 0 {
      numbering("(1)", ..nums)
    } else {
      numbering("(1-1)", chapter, ..nums)
    }
  })

  // ---- 代码块样式（codly）----
  show: codly-init.with()
  codly(
    languages: codly-languages,
    zebra-fill: none,
    stroke: 0.5pt + rgb("#dee2e6"),
    fill: rgb("#f8f9fa"),
  )

  // ---- 行内代码样式 ----
  show raw.where(block: false): it => {
    box(
      inset: (x: 3pt, y: 0pt),
      outset: (y: 3pt),
      radius: 2pt,
      fill: rgb("#f0f0f0"),
    )[
      #set text(font: monoti, size: 10.5pt)
      #it
    ]
  }

  // ---- 图表标题样式 ----
  show figure.caption: it => {
    set text(size: 10.5pt)
    it
  }

  // ---- 列表样式 ----
  set list(indent: 1.2em, body-indent: 0.5em, marker: ([•], [◦], [--]))
  set enum(indent: 1.2em, body-indent: 0.5em, numbering: "1.a.i.")

  // ---- 表格样式 ----
  set table(
    inset: 8pt,
    stroke: 0.5pt + rgb("#999999"),
  )
  show table.cell.where(y: 0): set text(weight: "bold")

  // ============================================================
  // 页面排布
  // ============================================================

  // 封面
  sdu-cover(
    title: title,
    course: course,
    college: college,
    major: major,
    student-id: student-id,
    author: author,
    instructor: instructor,
    date: date,
    logo: logo,
  )

  // 目录
  if show-toc {
    set page(
      header: none,
      footer: align(center)[
        #set text(size: 10pt)
        #context counter(page).display("I")
      ],
    )
    counter(page).update(1)
    outline(title: [目　录], indent: 1.5em, depth: 3)
    pagebreak()
  }

  // 正文
  let page-border = {
    place(center + horizon, rect(
      width: 100% - 1cm,
      height: 100% - 1cm,
      stroke: 1.2pt + rgb("#003366").lighten(40%),
      radius: 0pt,
    ))
  }
  set page(
    background: page-border,
    header: {
      set text(font: songti, size: 9pt, fill: rgb("#666666"))
      grid(
        columns: (1fr, 1fr),
        align: (left, right),
        [山东大学 · #course],
        [#title],
      )
      v(-5pt)
      line(length: 100%, stroke: 0.4pt + rgb("#cccccc"))
    },
    footer: align(center)[
      #set text(size: 10pt)
      #context counter(page).display("1")
    ],
  )
  counter(page).update(1)

  body
}
