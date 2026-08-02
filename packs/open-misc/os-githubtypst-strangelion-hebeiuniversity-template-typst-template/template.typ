#set text(lang: "zh", region: "cn")

// 在字符间插入固定小间距，避免短字段被过度拉伸；对2-4字字段效果更好
#let justify-text(body) = {
  if type(body) != str { return body }
  let chars = body.clusters()
  let n = chars.len()
  if n < 2 { return body }
  for (i, char) in chars.enumerate() {
    char
    if i < n - 1 { h(0.25em) }
  }
}

/// 三线表（学术论文标准格式）：顶线粗、栏目线细、底线粗，无竖线
#let three-line-table(columns: auto, ..body) = table(
  stroke: none,
  columns: columns,
  table.hline(stroke: 1.5pt),
  ..body,
  table.hline(stroke: 1.5pt),
)

/// 公式计数器（每章重置）
#let equation-counter = counter("equation")

/// 带编号的块级公式：编号自动右对齐，格式为 (章号-序号)
#let eq-block(body) = context {
  equation-counter.step()
  let eq-num = equation-counter.get().at(0)
  let h1 = counter(heading).at(here()).at(0)
  let tag = numbering("1-1", h1, eq-num + 1)
  grid(
    columns: (1fr, auto),
    column-gutter: 1em,
    align: (center, bottom + right),
    math.equation(block: true, body), text(size: 10.5pt)[（#tag）],
  )
}

/// 切换到附录模式：章节编号改为字母
#let appendix() = {
  set heading(numbering: "附录A")
  counter(heading).update(0)
}

#let template(
  doc,
  head: (name: none, value: none, visible: none, depth: none),
  title: (name: none, value: none, visible: none, depth: none),
  title-en: (name: none, value: none, visible: none, depth: none),
  school-semester: (name: none, value: none, visible: none, depth: none),
  school: (name: none, value: none, visible: none, depth: none),
  course-id: (name: none, value: none, visible: none, depth: none),
  course-name: (name: none, value: none, visible: none, depth: none),
  college: (name: none, value: none, visible: none, depth: none),
  author: (name: none, value: none, visible: none, depth: none),
  student-id: (name: none, value: none, visible: none, depth: none),
  class: (name: none, value: none, visible: none, depth: none),
  major: (name: none, value: none, visible: none, depth: none),
  supervisor: (name: none, value: none, visible: none, depth: none),
  date: (name: none, value: datetime.today().display("[year]年[month]月[day]日"), visible: none, depth: none),
  info-order: none,
  binding_line: none,
  score_table: none,
  evaluation-data: none,
  evaluation-style: none,
  header-text: none,
) = {
  // 1. 页面设置（页眉直接内联条件判断：封面页不显示）
  set page(
    paper: "a4",
    margin: (top: 3cm, bottom: 3cm, left: 2.5cm, right: 2.5cm),
    header: context [
      #if header-text != none and counter(page).get().first() > 1 {
        align(center + horizon, text(size: 10.5pt, header-text))
      }
    ],
  )

  // 2. 基础字体和段落设置
  set text(font: ("Times New Roman", "simsun"), size: 12pt)
  set par(leading: 1em, first-line-indent: (amount: 2em, all: true), justify: true)

  // 3. 封面生成
  if binding_line {
    // 1. 在封面左侧添加装订线 (相对于页面边缘定位)
    // 因为是在封面逻辑内，place 会作用于当前页
    place(left + top, dx: -1.5cm, dy: 5%)[
      // dx: -1.5cm 是相对于左内边距的偏移。
      // 如果您的左边距是 2.5cm，-1.5cm 正好让线处于距离纸张左边缘 1cm 的位置。
      #block(width: 30pt, height: 90%)[
        #set align(center)
        #set text(size: 11pt, fill: gray) // 使用 fill 修复报错

        // 上方虚线：1fr 自动伸缩
        #line(angle: 90deg, length: 40%, stroke: (paint: gray, dash: "dashed"))

        #v(2em)
        #stack(spacing: 2em, [装], [订], [线])
        #v(2em)

        // 下方虚线：1fr 自动伸缩
        #line(angle: 90deg, length: 40%, stroke: (paint: gray, dash: "dashed"))
      ]
    ]
  }

  if score_table {
    place(top + right, dx: 1cm, dy: -2.4cm)[
      #align(right)[
        #set text(size: evaluation-style.text-size)
        #table(
          align: left,
          columns: evaluation-style.columns,
          stroke: evaluation-style.stroke,
          // 使用 .. 展开操作符将数组内容填入表格
          ..evaluation-data
        )
      ]
    ]
  }

  align(center)[
    #v(1.2cm)
    #image("resource/logo.png", width: 80%)
    #v(0.6cm)
    #if head.visible {
      text(size: 26pt, weight: "bold")[#head.value]
      v(1cm)
    }
    #if title.visible {
      text(size: 22pt, weight: "bold")[#title.value]
      v(0.6cm)
    }
    #if title-en.visible {
      text(size: 18pt)[#title-en.value]
      v(0.6cm)
    }
    #v(1fr)

    #context {
      // 1. 标签名（不含冒号）和值的映射
      let all-names = (
        "4": school-semester.name,
        "5": school.name,
        "6": course-id.name,
        "7": course-name.name,
        "8": college.name,
        "9": author.name,
        "10": student-id.name,
        "11": class.name,
        "12": major.name,
        "13": supervisor.name,
      )
      let all-data = (
        "4": school-semester,
        "5": school,
        "6": course-id,
        "7": course-name,
        "8": college,
        "9": author,
        "10": student-id,
        "11": class,
        "12": major,
        "13": supervisor,
      )

      // 2. 测量可见字段的最大宽度
      let visible = info-order.map(d => str(d)).filter(k => k in all-data and all-data.at(k).visible)
      let left-nats = visible.map(k => measure(block(width: auto, text(size: 14pt, all-names.at(k)))).width)
      let right-nats = visible.map(k => measure(block(width: auto, text(size: 14pt, all-data.at(k).value))).width)
      let left-max = if left-nats.len() > 0 { calc.max(..left-nats) } else { 70pt }
      let right-max = if right-nats.len() > 0 { calc.max(..right-nats) + 10pt } else { 150pt }

      // 3. 两端对齐：将字符串均匀展开至 target 宽度（不设上限）
      let justify-to(body, target) = {
        if type(body) != str { return body }
        let chars = body.clusters()
        let n = chars.len()
        if n < 2 { return body }
        let nat = measure(block(width: auto, text(size: 14pt, body))).width
        let extra = calc.max(target - nat, 0pt)
        let gap = extra / (n - 1)
        for (i, char) in chars.enumerate() {
          char
          if i < n - 1 { h(gap) }
        }
      }

      // 4. 行渲染：左[标签两端对齐]  中[冒号]  右[值居中+定宽下划线]
      let info-row(name, value) = {
        grid(
          columns: (left-max, auto, right-max),
          column-gutter: 0pt,
          align: (right + horizon, center + horizon, center + horizon),
          text(size: 14pt, weight: "bold")[#justify-to(name, left-max)],
          text(size: 14pt, weight: "bold")[：],
          block(width: right-max, stroke: (bottom: 1pt), inset: (bottom: 4pt), align(center + horizon)[
            #set text(size: 14pt)
            #value
          ]),
        )
      }

      // 5. 循环渲染
      for d in info-order {
        let key = str(d)
        if key in all-data {
          let data = all-data.at(key)
          if data.visible {
            info-row(all-names.at(key), data.value)
            v(1.2em)
          } else {
            if data.value != none {
              grid(
                columns: (left-max, auto, right-max),
                column-gutter: 0pt,
                align: (right + horizon, center + horizon, center + horizon),
                text(size: 14pt, weight: "bold")[#justify-to(all-names.at(key), left-max)],
                text(size: 14pt, weight: "bold")[：],
                block(width: right-max, stroke: (bottom: 1pt), inset: (bottom: 4pt))[#v(1.2em)],
              )
            }
          }
        }
      }
    }

    #v(1fr)
    #if date.visible {
      text(size: 14pt)[#date.value]
    }

  ]

  pagebreak()

  // 4. 章节标题格式设置 (等同于 ctexset)
  set heading(numbering: "1.1")

  show heading: it => {
    set text(weight: "bold")
    if it.level == 1 {
      // 一级标题：第X章，居中，三号字(16pt)
      let num = if it.numbering != none {
        numbering("1", ..counter(heading).at(it.location()))
      }
      colbreak(weak: true)
      v(15pt)
      align(center)[
        #text(size: 16pt)[
          #(if num != none { "第" + num + "章　" })
          #it.body
        ]
      ]
      v(10pt)
    } else if it.level == 2 {
      // 二级标题：四号字(14pt)
      text(size: 14pt)[#it]
    } else if it.level == 3 {
      // 三级标题：小四号(12pt)
      text(size: 12pt)[#it]
    } else {
      it
    }
  }

  // 设置图表自动按章节编号：(一级章节号)-(图表序号)
  set figure(numbering: n => {
    let h1 = counter(heading).at(here()).at(0)
    numbering("1-1", h1, n)
  })

  // 每一级标题（第X章）出现时，重置图表计数器
  show heading.where(level: 1): it => {
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    equation-counter.update(0)
    it
  }

  // 设置图表名称的样式
  show figure.where(kind: image): set figure(supplement: [图])
  show figure.where(kind: table): set figure(supplement: [表])

  // 设置图表标题的间隔符，例如“图 1-1：标题”
  show figure.caption: it => [
    #set text(size: 10.5pt, font: ("Times New Roman", "SimSun"))
    #it.supplement #context it.counter.display(it.numbering) ：#it.body
  ]

  // --- 跨页续表处理方案 ---
  // 1. 定义一个状态变量来记录表格开始的页码
  let table-start-page = state("table-start-page", 0)

  // 2. 拦截 table，记录它开始渲染时的页码
  show table: it => {
    context {
      table-start-page.update(here().page())
    }
    it
  }

  // 3. 拦截 table.header，判断当前页码是否大于开始页码
  show table.header: it => {
    context {
      let start = table-start-page.at(here())
      if here().page() > start {
        align(right)[
          #set text(size: 10.5pt, weight: "regular")
          续表
        ]
      }
    }
    it
  }

  // 目录样式修正
  show outline.entry.where(level: 1): it => {
    v(12pt, weak: true)
    strong(it)
  }

  // 代码块样式 — 自动适配浅/深色主题
  show raw.where(block: true): it => {
    set text(font: ("JetBrains Mono", "Cascadia Code", "Fira Code", "Consolas"), size: 9.5pt)
    block(
      width: 100%,
      inset: (top: 6pt, bottom: 6pt, left: 10pt, right: 10pt),
      radius: 4pt,
      fill: luma(245),
      stroke: 0.5pt + luma(210),
      it,
    )
  }
  show raw.where(block: false): it => {
    set text(font: ("JetBrains Mono", "Cascadia Code", "Fira Code", "Consolas"), size: 9.5pt)
    box(
      inset: (left: 4pt, right: 4pt),
      fill: luma(245),
      radius: 3pt,
      it,
    )
  }
  doc
}
