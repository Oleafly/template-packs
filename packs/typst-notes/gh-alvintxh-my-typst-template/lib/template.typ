// ============================================================
//  模板主体：页面、字体、标题、图表编号、代码样式
//  用法见 main.typ
// ============================================================

#import "theme.typ": fonts, L, lang, palette, sizes
#import "@preview/ctheorems:1.1.3": thmrules
#import "@preview/codly:1.3.0": codly, codly-init
#import "@preview/codly-languages:0.1.8": codly-languages

// 把日期渲染成字符串；传 none 就不显示，传字符串就原样用。
#let _fmt-date(d) = {
  if d == none { return none }
  if type(d) == str { return d }
  if lang == "zh" { d.display("[year] 年 [month repr:numerical] 月 [day] 日") } else {
    d.display("[month repr:long] [day], [year]")
  }
}

// 「1.2」这种带章号的编号：图、表、代码块用它。
//
// 注意：这里不能再套一层 `context`。编号函数本身已经在元素自己的上下文里求值，
// 多包一层 context 会让它在「显示的地方」而不是「元素所在的地方」求值 ——
// 结果就是跨章引用时章号取成了引用处的章号。
#let _chapter-numbering(..n) = {
  let h = counter(heading).get()
  if h.len() > 0 and h.first() > 0 {
    numbering("1.1", h.first(), ..n.pos())
  } else {
    numbering("1", ..n.pos())
  }
}

// 公式号带括号：(1.2)
#let _equation-numbering(..n) = {
  let h = counter(heading).get()
  if h.len() > 0 and h.first() > 0 {
    numbering("(1.1)", h.first(), ..n.pos())
  } else {
    numbering("(1)", ..n.pos())
  }
}

#let note(
  title: none,
  subtitle: none,
  author: none,
  affiliation: none,
  date: datetime.today(),
  abstract: none,
  cover: true, // 是否要封面
  toc: true, // 是否要目录
  toc-depth: 2, // 目录展开到几级标题
  chapter-break: true, // 一级标题是否另起一页
  indent: true, // 正文是否首行缩进两字符
  paper: "a4",
  // 参考文献样式。国标：gb-7714-2015-numeric（顺序编码）、
  // gb-7714-2015-author-date（著者-出版年）；也可以填 "ieee"、"apa" 等。
  bib-style: "gb-7714-2015-numeric",
  body,
) = {
  // ---------------- 文档元信息 ----------------
  set document(title: title, author: if author == none { () } else { author })

  // ---------------- 正文文字 ----------------
  set text(
    font: fonts.serif,
    size: sizes.body,
    fill: palette.ink,
    lang: lang,
    region: if lang == "zh" { "cn" } else { "us" },
  )
  set par(
    leading: sizes.leading,
    spacing: sizes.par-spacing,
    justify: true,
    first-line-indent: if indent { (amount: sizes.indent, all: true) } else { 0em },
  )
  show math.equation: set text(font: fonts.math)
  show raw: set text(font: fonts.mono, size: 0.92em)

  // ---------------- 标题 ----------------
  set heading(numbering: "1.1")
  show heading: set text(font: fonts.sans, fill: palette.ink)
  show heading: set par(first-line-indent: 0em, justify: false)

  // 一级标题 = 一章：另起一页，章号单独一行，下面压一条主色粗线
  show heading.where(level: 1): it => {
    // 每章重置公式、图、表、代码块和定理的编号
    counter(math.equation).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
    counter("env").update(0)

    if chapter-break { pagebreak(weak: true) }
    block(above: 0.5em, below: 1.6em, width: 100%)[
      #if it.numbering != none [
        #text(size: 9.5pt, weight: 600, fill: palette.primary, tracking: 0.08em)[
          #(L.chapter)(counter(heading).display("1"))
        ]
        #v(0.35em, weak: true)
      ]
      #text(size: 1.9em, weight: 800)[#it.body]
      #v(0.5em, weak: true)
      #line(length: 100%, stroke: 2pt + palette.primary)
    ]
  }

  show heading.where(level: 2): it => block(above: 1.8em, below: 0.9em)[
    #text(fill: palette.primary, weight: 700, size: 1.25em)[#counter(heading).display()]
    #h(0.45em)
    #text(weight: 700, size: 1.25em)[#it.body]
  ]

  show heading.where(level: 3): it => block(above: 1.4em, below: 0.7em)[
    #text(fill: palette.primary.darken(10%), weight: 600, size: 1.08em)[#counter(heading).display()]
    #h(0.4em)
    #text(weight: 600, size: 1.08em)[#it.body]
  ]

  // 四级及以下：行内小标题
  show heading.where(level: 4): it => block(above: 1.1em, below: 0.5em)[
    #text(weight: 600, size: 1em, fill: palette.ink)[#it.body]
  ]

  // ---------------- 编号 ----------------
  set math.equation(numbering: n => _equation-numbering(n), supplement: L.equation)
  set figure(numbering: _chapter-numbering)
  show figure.where(kind: image): set figure(supplement: L.figure)
  show figure.where(kind: table): set figure(supplement: L.table)
  show figure.where(kind: raw): set figure(supplement: L.listing)
  // 表格的题注按惯例放在上方
  show figure.where(kind: table): set figure.caption(position: top)

  // 图注：编号加粗，正文用小一号的灰字
  show figure.caption: it => block(width: 90%)[
    #set par(first-line-indent: 0em, leading: 0.6em, justify: false)
    #set text(size: 0.9em, fill: palette.muted, font: fonts.sans)
    #text(weight: 700, fill: palette.ink)[#it.supplement #context it.counter.display(it.numbering)]
    #h(0.4em)
    #it.body
  ]
  show figure: set block(above: 1.4em, below: 1.4em)

  // ---------------- 引用 ----------------
  // 引用用主色，和正文区分开
  show ref: set text(fill: palette.primary)
  show link: set text(fill: palette.primary)

  // 引用标题时补上「第 X 章 / 第 X.Y 节」，光一个数字读起来不知道指什么。
  show ref: it => {
    let el = it.element
    // 文献引用（it.element 为 none）和别的元素走默认逻辑
    if el == none or el.func() != heading or el.numbering == none {
      return it
    }
    let num = context numbering(el.numbering, ..counter(heading).at(el.location()))
    link(el.location(), if el.level == 1 { (L.chapter-ref)(num) } else { (L.section-ref)(num) })
  }

  // ---------------- 参考文献 ----------------
  set bibliography(style: bib-style, title: L.bibliography)

  // ---------------- 列表 ----------------
  set list(indent: 0.6em, spacing: 0.85em, marker: ([•], [◦], [–]))
  set enum(indent: 0.6em, spacing: 0.85em, numbering: "1.a.i.")
  show list: set par(first-line-indent: 0em)
  show enum: set par(first-line-indent: 0em)

  // ---------------- 表格 ----------------
  set table(
    inset: (x: 0.7em, y: 0.5em),
    stroke: (_, y) => (
      bottom: if y == 0 { 0.9pt + palette.ink } else { 0.4pt + palette.line },
    ),
  )
  show table.cell.where(y: 0): set text(weight: 700, font: fonts.sans, size: 0.95em)

  // ---------------- 引文 ----------------
  set quote(block: true)
  show quote: it => block(
    width: 100%,
    inset: (left: 1em, y: 0.4em),
    stroke: (left: 2pt + palette.line),
  )[
    #set text(font: fonts.kai, fill: palette.ink.lighten(15%))
    #it.body
    #if it.attribution != none [
      #v(0.3em, weak: true)
      #align(right, text(size: 0.9em, fill: palette.muted)[—— #it.attribution])
    ]
  ]

  // ---------------- 行内代码 ----------------
  show raw.where(block: false): it => box(
    inset: (x: 0.35em),
    outset: (y: 0.25em),
    radius: 2pt,
    fill: rgb("#f3f4f6"),
    text(fill: rgb("#b02a37"), it),
  )

  // ---------------- 定理环境 & 代码块 ----------------
  show: thmrules
  show: codly-init
  codly(
    languages: codly-languages,
    zebra-fill: none,
    fill: rgb("#fbfcfd"),
    stroke: 0.6pt + palette.line,
    radius: 3pt,
    inset: 0.34em,
    number-format: n => text(fill: palette.muted, size: 0.8em, font: fonts.mono, str(n)),
  )

  // ---------------- 封面 ----------------
  if cover {
    page(
      paper: paper,
      margin: (x: 2.6cm, top: 3.2cm, bottom: 2.6cm),
      header: none,
      footer: none,
      numbering: none,
    )[
      #set par(first-line-indent: 0em, justify: false)
      #v(4em)
      #rect(width: 3.4cm, height: 4pt, fill: palette.primary, stroke: none)
      #v(1.4em)
      #text(font: fonts.sans, size: 30pt, weight: 800)[#title]
      #if subtitle != none [
        #v(0.7em)
        #text(font: fonts.sans, size: 14pt, weight: 400, fill: palette.muted)[#subtitle]
      ]
      #if abstract != none [
        #v(2.2em)
        #block(width: 82%)[
          #set text(size: 10pt, fill: palette.ink.lighten(12%))
          #set par(leading: 0.9em, justify: true)
          #abstract
        ]
      ]
      #place(bottom + left, dx: 0pt, dy: 0pt)[
        #line(length: 100%, stroke: 0.6pt + palette.line)
        #v(0.9em)
        #grid(
          columns: (1fr, auto),
          align: (left, right),
          [
            #if author != none [
              #text(font: fonts.sans, size: 11pt, weight: 600)[#author] \
            ]
            #if affiliation != none [
              #text(size: 9.5pt, fill: palette.muted)[#affiliation]
            ]
          ],
          text(size: 9.5pt, fill: palette.muted)[#_fmt-date(date)],
        )
      ]
    ]
  }

  // ---------------- 目录 ----------------
  // 单独占页，不编页码，正文才从第 1 页开始。
  if toc {
    page(
      paper: paper,
      margin: (x: 2.4cm, top: 2.6cm, bottom: 2.4cm),
      header: none,
      footer: none,
      numbering: none,
    )[
      #set par(first-line-indent: 0em, justify: false)
      #text(font: fonts.sans, size: 1.9em, weight: 800)[#L.toc]
      #v(0.5em)
      #line(length: 100%, stroke: 2pt + palette.primary)
      #v(1.4em)
      #show outline.entry.where(level: 1): it => {
        v(1.1em, weak: true)
        text(font: fonts.sans, weight: 700, fill: palette.ink, it)
      }
      #show outline.entry.where(level: 2): it => text(fill: palette.ink.lighten(10%), it)
      #show outline.entry.where(level: 3): it => text(size: 0.95em, fill: palette.muted, it)
      #outline(title: none, depth: toc-depth, indent: 1.2em)
    ]
  }

  // ---------------- 正文页面 ----------------
  set page(
    paper: paper,
    margin: (x: 2.4cm, top: 2.6cm, bottom: 2.4cm),
    numbering: "1",
    header: context {
      let cur-page = here().page()
      let chapters = query(heading.where(level: 1))
      // 章首页不画页眉
      if chapters.any(c => c.location().page() == cur-page) { return }
      let before = chapters.filter(c => c.location().page() < cur-page)
      if before.len() == 0 { return }
      let cur = before.last()
      set text(size: 8.5pt, font: fonts.sans, fill: palette.muted)
      block(width: 100%, inset: (bottom: 0.45em), stroke: (bottom: 0.5pt + palette.line))[
        #(L.chapter)(counter(heading).at(cur.location()).first())
        #h(0.6em)
        #cur.body
        #h(1fr)
        #if title != none { title }
      ]
    },
    footer: context align(
      center,
      text(size: 9pt, font: fonts.sans, fill: palette.muted, counter(page).display("1")),
    ),
  )
  counter(page).update(1)

  body
}
