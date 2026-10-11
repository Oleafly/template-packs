#import "@preview/based:0.2.0": base64

// ================================
// 字体配置
// ================================

#let font = (
  // 中文字体
  zh_shusong: "SimSun",
  zh_zhongsong: "SimHei",
  zh_kai: "KaiTi",
  zh_hei: "SimHei",
  zh_fangsong: "FangSong",
  // 英文字体
  en_sans_serif: "New Computer Modern",
  en_serif: "New Computer Modern",
  en_typewriter: "Courier New",
  en_code: "Consolas",
)

// ================================
// 字号配置
// ================================

#let font-size = (
  s2: 18pt, // 二号
  n3: 16pt, // 三号
  s3: 15pt, // 小三
  n4: 14pt, // 四号
  s4: 12pt, // 小四
  n5: 10.5pt, // 五号
  s5: 9pt, // 小五
)

// ================================
// 样式配置
// ================================

#let config = (
  // 字号设置
  text-size: font-size.n5,
  author-size: font-size.n5,
  titles: (
    // (align, size, vbefore, vafter)
    (center, font-size.s3),
    (left, font-size.n4, -.75em, -.25em),
    (left, font-size.s4, -1em),
  ),
  // 字体设置
  title-font: (font.en_serif, font.zh_hei),
  author-font: (font.en_sans_serif, font.zh_shusong),
  body-font: (font.en_serif, font.zh_shusong),
  heading-font: (font.en_serif, font.zh_zhongsong),
  caption-font: (font.en_serif, font.zh_kai),
  header-font: (font.en_serif, font.zh_kai),
  strong-font: (font.en_serif, font.zh_hei),
  emph-font: (font.en_serif, font.zh_kai),
  raw-font: (font.en_code, font.zh_hei),
  // 间距设置
  spacing: 1.5em,
  leading: 1.0em,
  indent: 2em,
  list-indent: 3em,
  small-space: 1em,
  block-space: 0.75em,
  // 颜色设置
  raw-color: rgb("#e9eff7"),
  problem-color: rgb(241, 241, 255),
  summary-color: rgb(240, 248, 255),
  // 列表样式
  list-marker: ([•], [◦], [▶]),
  enum-numbering: ("1.", "(1)", "①", "a."),
  // 表格样式
  table-stroke: 0.08em,
  table-header-stroke: 0.05em,
  // 表格标题位置
  table-catption-top: false,
)

#let heading-break = state("heading-break", (100%, 30%, 15%))
#let get-hbreak = level => {
  let cfg = heading-break.get()
  let arr = if type(cfg) == ratio { (cfg,) } else if type(cfg) == array { cfg } else { (0%,) }
  let val = arr.at(level - 1, default: 0%)
  if type(val) == ratio { val } else { 0% }
}

// ================================
// 工具函数
// ================================

// 解决首段缩进问题的空白段
#let fake-par = {
  par(box())
  v(-config.spacing)
}

// 偏微分符号
#let pardiff(x, y) = $frac(partial #x, partial #y)$

// ================================
// 学术组件
// ================================
#let __author() = context {
  let author = document.author
  for (i, author) in document.author.enumerate() {
    author
    if i != document.author.len() - 1 {
      [, ]
    }
  }
}


#let back-cover(
  outline-title: [封底],
  extra: [],
  body,
) = {
  if (body.children.len() == 0) {
    body = context [
      — #document.title  — \
      #__author() \
    ]
  }

  pagebreak()
  [
    #set page(numbering: none, header: none)

    #align(center + bottom, [
      #body
      #extra

      #context document.date.display()
      #if outline-title.has("text") {
        show heading: it => []
        [= #outline-title] // 标题置后以跳转至底部
      }
    ])
  ]
}

// 通用框组件
#let custom-block(
  title: none,
  color: rgb(245, 245, 245),
  it,
) = {
  set text(font: config.emph-font)
  let body = if title != none {
    strong(title) + h(config.block-space) + it
  } else {
    it
  }

  block(
    fill: color,
    inset: 8pt,
    radius: 5pt,
    width: 100%,
    body,
  )
  fake-par
}

#let fdate(date, splitter: "-", ch: false) = {
  if ch {
    date.display("[year]年[month]月[day]日")
  } else {
    let sp = if type(splitter) == array {
      splitter
    } else {
      (splitter,)
    }
    let fmt = "[year]" + sp.at(0)
    fmt += "[month]" + sp.at(1, default: splitter.last())
    fmt += "[day]" + sp.at(2, default: "")
    date.display(fmt)
  }
}

// 题目框
#let problem-counter = counter("problem")
#let problem = custom-block.with(
  title: [
    #problem-counter.step()
    题目 #context problem-counter.display().
  ],
  color: config.problem-color,
)

// 解答框
#let solution(
  title: [*解答.*],
  it,
) = {
  set enum(numbering: "(1)")
  let body = title + h(config.block-space) + it
  block(
    inset: 8pt,
    below: config.leading,
    width: 100%,
    body,
  )
  fake-par
}

// 总结框
#let summary = custom-block.with(
  title: [总结.],
  color: config.summary-color,
)

// 三线表格
#let three-line-table(it) = {
  if it.children.any(c => c.func() == table.hline) {
    return it
  }

  let meta = it.fields()
  meta.stroke = none
  meta.remove("children")

  let header = it.children.find(c => c.func() == table.header)
  let cells = it.children.filter(c => c.func() == table.cell)

  if header == none {
    let columns = meta.columns.len()
    header = table.header(..cells.slice(0, columns))
    cells = cells.slice(columns)
  }

  return table(
    ..meta,
    table.hline(stroke: config.table-stroke),
    header,
    table.hline(stroke: config.table-header-stroke),
    ..cells,
    table.hline(stroke: config.table-stroke),
  )
}

#let header-style(heading) = context {
  set text(font: config.header-font)
  let title = document.title
  grid(
    columns: (auto, 1fr),
    align(left, title), align(right, heading),
  )
  v(-1.2em)
  line(stroke: 1pt + gray, length: 100%)
}

#let prev-or-current-header = context {
  let head = none
  let before = query(heading.where(level: 1).before(here()))
  if before.len() > 0 {
    head = before.last().body
  }
  let current = query(heading.where(level: 1)).find(h => h.location().page() == here().page())
  if current != none {
    head = current.body
  }
  if head != none {
    header-style(head)
  }
}

// 标题
#let make-title(
  title: "",
  author: "",
  subtitle: none,
  time: none,
) = {
  // 主标题
  show std.title: set text(size: 30pt)
  show std.title: strong
  show heading: set heading(numbering: none)

  align(center + horizon, {
    std.title()
    v(2.5em, weak: true)
    text(1.6em, subtitle)
  })

  align(center + bottom, text(1em, [
    #__author() \
    #time.display()
  ]))

  [
    #counter(page).update(0)
    #set page(header: none, numbering: "I")
    #outline(title: [
      #text(1.2em, "目录")
      #v(1em)
    ])
  ]
}

#let __min(..val) = {
  val = val.pos()
  let min = val.first()
  for v in val {
    if (type(v) == length and v < min) {
      min = v
    }
  }
  min
}

#let fimage(
  src,
  alt: "",
  width: auto,
  height: auto,
  max-width: 256pt,
  max-height: auto,
  radius: 10pt,
  ..props,
) = context {
  let img-h = measure(box(image(src, width: max-width, height: auto))).height
  let img-w = measure(box(image(src, width: auto, height: max-height))).width
  let img-o = measure(box(image(src)))

  if (width != auto) {
    img-w = width
  } else {
    img-w = __min(img-w, max-width, img-o.width)
  }

  if (height != auto) {
    img-h = height
  } else {
    img-h = __min(img-h, max-height, img-o.height)
  }

  figure(
    align(center, block(
      width: img-w,
      height: img-h,
      clip: true,
      radius: radius,
      image(
        src,
        ..props,
      ),
    )),
    caption: alt,
  )
}

#let _i(body) = {
  set par(first-line-indent: 0pt)
  body
}

// ================================
// 主模板函数
// ================================

#let project(
  title: "",
  author: "",
  subtitle: none,
  date: none,
  body,
) = {
  // 文档设置
  set document(author: author, title: title, date: date)

  // 页面设置
  set page(
    number-align: center,
    header: prev-or-current-header,
  )

  // 基础样式设置F
  set heading(numbering: "1.1.")

  set text(
    font: config.body-font,
    lang: "zh",
    region: "cn",
    size: config.text-size,
  )
  set par(
    first-line-indent: config.indent,
    justify: true,
    leading: config.leading,
    spacing: config.spacing,
  )
  set enum(
    indent: config.list-indent,
    full: true,
    numbering: (..n) => {
      n = n.pos()
      let level = n.len()
      let number = config.enum-numbering.at(level - 1, default: "1.")
      numbering(number, ..n.slice(level - 1))
    },
  )
  set list(
    indent: config.list-indent,
    marker: config.list-marker,
  )
  set math.equation(numbering: "(1)")
  set underline(evade: false)

  // ================================
  // 标题样式
  // ================================
  let my-location = state("my-location", (:))

  let smartbreak(percentage) = (
    context {
      if my-location.get().y > page.height * (100% - percentage) {
        colbreak(weak: true)
      }
    }
  )

  show heading: it => {
    set text(
      font: config.heading-font,
      size: config.titles.at(it.level - 1, default: ()).at(1, default: none),
    )
    set align(config.titles.at(it.level - 1, default: ()).at(0, default: left))
    let v-before = config.titles.at(it.level - 1, default: ()).at(2, default: none)
    let v-after = config.titles.at(it.level - 1, default: ()).at(3, default: none)
    let body = if it.numbering != none {
      counter(heading).display({
        if (it.level == 1) {
          "一、"
        } else {
          "1.1. "
        }
      })
      it.body
    } else {
      it.body
    }
    if (type(v-before) == length) {
      v(v-before)
    }
    let hbreak = get-hbreak(it.level)
    if (hbreak > 0%) {
      context my-location.update(here().position())
      smartbreak(hbreak)
    }
    box(width: 100%, body)
    if (type(v-after) == length) {
      v(v-after)
    }
  }
  // ================================
  // 元素样式
  // ================================

  // 数学公式：无标签则不编号
  show math.equation: it => {
    set block(breakable: true)
    if it.block and not it.has("label") [
      #counter(math.equation).update(v => v - 1)
      #math.equation(it.body, block: true, numbering: none)#label("_")
    ] else {
      it
    }
  }

  // 图表样式
  show figure: it => {
    set block(breakable: true)
    set text(font: config.caption-font)
    it + fake-par
  }

  if (config.table-catption-top) {
    show figure.where(kind: table): set figure.caption(position: top)
  }

  show table: it => {
    set text(font: config.body-font)
    it + fake-par
  }
  show image: it => it + fake-par

  // 列表样式
  show list: it => {
    set list(indent: 0em)
    set enum(indent: 0em)
    it + fake-par
  }
  show enum: it => {
    set list(indent: 0em)
    set enum(indent: 0em)
    it + fake-par
  }
  show terms: it => {
    set text(font: config.caption-font)
    it + fake-par
  }

  // 文字样式
  show strong: set text(font: config.strong-font)
  show emph: set text(font: config.emph-font)
  show ref: set text(red)
  show link: it => {
    box(
      image(
        bytes(
          base64.decode(
            "PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiIHN0YW5kYWxvbmU9Im5vIj8+PCEtLSBVcGxvYWRlZCB0bzogU1ZHIFJlcG8sIHd3dy5zdmdyZXBvLmNvbSwgR2VuZXJhdG9yOiBTVkcgUmVwbyBNaXhlciBUb29scyAtLT48c3ZnIHdpZHRoPSI4MDBweCIgaGVpZ2h0PSI4MDBweCIgdmlld0JveD0iMCAwIDIwIDIwIiB2ZXJzaW9uPSIxLjEiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiPiAgICAgICAgPHRpdGxlPnNlbmRfcm91bmQgWyMxNTY5XTwvdGl0bGU+ICAgIDxkZXNjPkNyZWF0ZWQgd2l0aCBTa2V0Y2guPC9kZXNjPiAgICA8ZGVmcz48L2RlZnM+ICAgIDxnIGlkPSJQYWdlLTEiIHN0cm9rZT0ibm9uZSIgc3Ryb2tlLXdpZHRoPSIxIiBmaWxsPSJub25lIiBmaWxsLXJ1bGU9ImV2ZW5vZGQiPiAgICAgICAgPGcgaWQ9IkRyaWJiYmxlLUxpZ2h0LVByZXZpZXciIHRyYW5zZm9ybT0idHJhbnNsYXRlKC02MC4wMDAwMDAsIC05NTkuMDAwMDAwKSIgZmlsbD0iIzAwMDAwMCI+ICAgICAgICAgICAgPGcgaWQ9Imljb25zIiB0cmFuc2Zvcm09InRyYW5zbGF0ZSg1Ni4wMDAwMDAsIDE2MC4wMDAwMDApIj4gICAgICAgICAgICAgICAgPHBhdGggZD0iTTE1LjczMiw4MDkuMTM3IEwyMS41NDcsODAzLjMyMiBDMjEuODU5LDgwMy4wMSAyMi4zOTMsODAzLjIyMiAyMi40MDYsODAzLjY2MyBMMjIuNDQ0LDgwNS4wMjkgQzIyLjQ2LDgwNS41ODEgMjIuOTIsODA2IDIzLjQ3Miw4MDYgTDIzLjI1LDgwNiBDMjMuODAyLDgwNiAyNCw4MDUuNTI0IDI0LDgwNC45NzIgTDI0LDgwMSBDMjQsNzk5LjkgMjMuMSw3OTkgMjIsNzk5IEwxOC40ODMsNzk5IEMxNy45Myw3OTkgMTcsNzk5LjQyNSAxNyw3OTkuOTc3IEwxNyw3OTkuOTggQzE3LDgwMC41MzIgMTcuNjQ3LDgwMC45OTQgMTguMTk5LDgwMS4wMDkgTDE5LjczMyw4MDEuMDUgQzIwLjE3NCw4MDEuMDYxIDIwLjM4Nyw4MDEuNTk1IDIwLjA3Niw4MDEuOTA3IEwxNC4yODksODA3LjcyMyBDMTMuODk5LDgwOC4xMTMgMTMuOTEzLDgwOC43NDYgMTQuMzA0LDgwOS4xMzcgQzE0LjY5NCw4MDkuNTI3IDE1LjM0MSw4MDkuNTI4IDE1LjczMiw4MDkuMTM3IE0yNCw4MTIuMDExIEwyNCw4MTcuMDE1IEMyNCw4MTguMTE3IDIzLjU1LDgxOSAyMi40NDgsODE5IEw2LjQ0LDgxOSBDNS4zMzgsODE5IDQsODE4LjExNyA0LDgxNy4wMTUgTDQsODAxLjAwNyBDNCw3OTkuOTA0IDUuMzM4LDc5OSA2LjQ0LDc5OSBMMTEuNDQ0LDc5OSBDMTEuOTk2LDc5OSAxMi40NDQsNzk5LjQ0OCAxMi40NDQsODAwIEMxMi40NDQsODAwLjU1MyAxMS45OTYsODAxIDExLjQ0NCw4MDEgTDcuNDQ0LDgwMSBDNi44OTIsODAxIDYsODAxLjQ1OCA2LDgwMi4wMTEgTDYsODE1LjAxNSBDNiw4MTYuMTE3IDcuMzM4LDgxNyA4LjQ0LDgxNyBMMjEuNDQ0LDgxNyBDMjEuOTk2LDgxNyAyMiw4MTYuNTYzIDIyLDgxNi4wMTEgTDIyLDgxMi4wMTEgQzIyLDgxMS40NTggMjIuNDQ3LDgxMS4wMTEgMjMsODExLjAxMSBDMjMuNTUyLDgxMS4wMTEgMjQsODExLjQ1OCAyNCw4MTIuMDExIiBpZD0ic2VuZF9yb3VuZC1bIzE1NjldIj48L3BhdGg+ICAgICAgICAgICAgPC9nPiAgICAgICAgPC9nPiAgICA8L2c+PC9zdmc+",
          ),
        ),
        width: 0.5em,
        height: 0.5em,
        format: "svg",
      ),
      width: 0.7em,
      clip: false,
      radius: 0em,
    )
    underline(it)
  }

  // 代码样式
  show raw.where(block: false): it => {
    set text(font: config.raw-font)
    box(
      inset: (x: 3pt, y: 0pt),
      outset: (x: 0pt, y: 3pt),
      radius: 5pt,
      fill: config.raw-color,
      it,
    )
  }
  show raw.where(block: true): it => {
    set text(font: config.raw-font)
    set block(
      width: 100%,
      radius: 5pt,
      fill: config.raw-color,
      outset: (x: 0pt, y: 4pt),
      inset: (x: 8pt, y: 4pt),
    )
    it + fake-par
  }

  // ================================
  // 文档标题部分
  // ================================
  make-title(
    title: title,
    author: author,
    time: date,
    subtitle: subtitle,
  )

  pagebreak()

  counter(page).update(1)
  set page(numbering: "1")

  body
}
