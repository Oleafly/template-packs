// ============================================================
//  tutorial.typ —— 自包含中文教程模板（彩色定理框 / 自动编号）
//  用法见同目录 demo.typ。零外部依赖，配本机 typst 单文件即可。
//  编译： typst compile --font-path ./typ_fonts demo.typ
// ============================================================

// ---------- 调色板（可在 tutorial(...) 里覆盖）----------
#let THEME = (
  accent:  rgb("#2E6B6B"),   // 主色：标题 / 页眉
  def:     rgb("#2E8B7C"),   // 定义  青绿
  thm:     rgb("#7C3AED"),   // 定理  紫
  prop:    rgb("#2C7FB8"),   // 命题  蓝
  lemma:   rgb("#0E7490"),   // 引理  青
  example: rgb("#B45309"),   // 例    橙棕
  tip:     rgb("#2E8B57"),   // 提示  绿
  note:    rgb("#2C7FB8"),   // 注    蓝
  warning: rgb("#C2410C"),   // 警告  橙红
  exercise:rgb("#B45309"),   // 练习  橙棕
  pitfall: rgb("#C0392B"),   // 误区  红
  proofc:  rgb("#C2410C"),   // 证明 引导字
  code:    rgb("#B4451E"),   // 行内代码
)

// 取一个颜色的极浅底色
#let _bg(c) = c.lighten(90%)

// ---------- 共享计数器：定义/定理/命题… 同一节内连号 ----------
#let _thmctr = counter("tutorial-thm")

// ---------- 核心：带圆角标题标签 + 右下角收尾符的盒子 ----------
#let tabbox(title, body, color: black, tail: none) = block(
  width: 100%, fill: _bg(color), stroke: 0.9pt + color, radius: 3pt,
  inset: (x: 11pt, top: 13pt, bottom: 9pt), above: 1.15em, below: 1.15em,
  breakable: true,
)[
  #place(top + left, dx: -3pt, dy: -21pt,
    box(fill: color, radius: 2.5pt, inset: (x: 7pt, y: 3pt))[
      #text(fill: white, weight: "bold", size: 9.5pt)[#title]
    ])
  #body
  #if tail != none {
    place(bottom + right, dx: 2pt, dy: 4pt, text(fill: color, size: 1.25em)[#tail])
  }
]

// ---------- 带编号的数学类环境（定义/定理/…）----------
// 调用： #definition[正文]   或   #definition[名字][正文]
#let _numbered(kind, color, tail, ..args) = {
  let pos = args.pos()
  let name = if pos.len() >= 2 { pos.at(0) } else { none }
  let body = pos.last()
  _thmctr.step()
  context {
    let sec = counter(heading).get().at(0, default: 0)
    let n = _thmctr.get().first()
    let label = [#kind #(str(sec) + "." + str(n))]
    let title = if name == none { label } else { [#label（#name）] }
    tabbox(title, body, color: color, tail: tail)
  }
}

#let definition(..a)  = _numbered("定义", THEME.def,     [♣], ..a)
#let theorem(..a)     = _numbered("定理", THEME.thm,     [♠], ..a)
#let proposition(..a) = _numbered("命题", THEME.prop,    [♠], ..a)
#let lemma(..a)       = _numbered("引理", THEME.lemma,   [♦], ..a)
#let corollary(..a)   = _numbered("推论", THEME.lemma,   [♦], ..a)
#let example(..a)     = _numbered("例",   THEME.example, none, ..a)

// ---------- 不编号的提示框（提示/注/警告/练习/误区）----------
#let _callout(kind, color, ..args) = {
  let pos = args.pos()
  let name = if pos.len() >= 2 { pos.at(0) } else { none }
  let body = pos.last()
  let title = if name == none { [#kind] } else { [#kind：#name] }
  tabbox(title, body, color: color)
}
#let tip(..a)      = _callout("提示", THEME.tip, ..a)
#let note(..a)     = _callout("注", THEME.note, ..a)
#let warning(..a)  = _callout("警告", THEME.warning, ..a)
#let exercise(..a) = _callout("练习", THEME.exercise, ..a)
#let pitfall(..a)  = _callout("概念误区", THEME.pitfall, ..a)

// ---------- 证明：行内引导字 + 末尾 QED □ ----------
#let proof(body) = block(above: 0.7em, below: 1em, {
  text(fill: THEME.proofc, weight: "bold")[证明]
  h(0.5em)
  body
  h(1fr)
  text(fill: THEME.proofc)[□]
})

// ---------- 键盘按键 ----------
#let kbd(k) = box(
  fill: luma(245), stroke: 0.5pt + luma(180), radius: 3pt,
  inset: (x: 5pt, y: 1pt), outset: (y: 2pt),
)[#text(size: 0.85em, font: "DejaVu Sans Mono")[#k]]

// ============================================================
//  文档模板：  #show: tutorial.with(title: "...", ...)
// ============================================================
#let tutorial(
  title: none, subtitle: none, author: none, date: none,
  lang: "zh", toc: false, theme: THEME,
  cjk-font: "FandolSong", latin-font: "New Computer Modern", mono-font: "DejaVu Sans Mono",
  body,
) = {
  set document(title: if title == none { "" } else { title }, author: if author == none { "" } else { author })
  set text(font: (latin-font, cjk-font), lang: lang, size: 11pt)
  set par(justify: true, leading: 0.72em, spacing: 1em, first-line-indent: 0pt)
  set raw(tab-size: 2)

  // 页面 + 页眉（显示当前章节）+ 页脚（页码）
  set page(
    paper: "a4", margin: (left: 2.4cm, right: 2.4cm, top: 2.5cm, bottom: 2.2cm),
    header: context {
      let hs = query(selector(heading).before(here()))
      set text(9pt, fill: theme.accent)
      if hs.len() > 0 {
        let hd = hs.last()
        let num = counter(heading).at(hd.location()).map(str).join(".")
        align(right)[#strong[#num]#h(.5em)#hd.body#h(.45em)#box(baseline: 25%, rect(width: 1.6pt, height: 12pt, fill: theme.accent, stroke: none))]
      }
      v(-6pt); line(length: 100%, stroke: .7pt + theme.accent.lighten(45%))
      v(-8.5pt); line(length: 100%, stroke: .3pt + theme.accent.lighten(45%))
    },
    footer: context align(center)[#text(9pt, fill: theme.accent)[#counter(page).display("1")]],
  )

  // 标题编号 + 样式
  set heading(numbering: "1.1")
  show heading.where(level: 1): it => {
    _thmctr.update(0)
    counter(math.equation).update(0)
    block(above: 1.5em, below: 0.75em)[
      #set text(size: 16pt, weight: "bold", fill: theme.accent)
      #it
      #v(3pt)
      #line(length: 100%, stroke: 0.8pt + theme.accent.lighten(35%))
    ]
  }
  show heading.where(level: 2): it => block(above: 1.1em, below: 0.5em)[
    #set text(size: 13pt, weight: "bold", fill: theme.accent.darken(5%)); #it
  ]
  show heading.where(level: 3): it => block(above: 0.9em, below: 0.4em)[
    #set text(size: 11.5pt, weight: "bold", fill: luma(40)); #it
  ]

  // 公式编号：按节  (1.1)(1.2)…
  set math.equation(numbering: n => {
    let s = counter(heading).get().at(0, default: 0)
    "(" + str(s) + "." + str(n) + ")"
  })
  show math.equation.where(block: true): set block(spacing: 0.9em)

  // 代码块 / 行内代码
  show raw.where(block: true): it => block(
    width: 100%, breakable: true, fill: rgb("#F6F8FA"),
    inset: (x: 11pt, y: 9pt), radius: 4pt,
    stroke: (left: 2.5pt + theme.accent.lighten(10%), rest: 0.5pt + luma(225)),
  )[#set text(size: 9.5pt, font: mono-font); #it]
  show raw.where(block: false): it => box(
    fill: luma(240), inset: (x: 3.5pt), outset: (y: 3pt), radius: 2.5pt,
  )[#text(size: 0.92em, fill: theme.code, font: mono-font)[#it]]

  // 链接 / 列表 / 表格 / 图表标题
  show link: set text(fill: theme.note)
  set enum(indent: 0.6em, spacing: 0.7em)
  set list(indent: 0.6em, marker: text(fill: theme.accent)[▪])
  set table(stroke: 0.5pt + luma(200), inset: 6pt)
  show figure.caption: set text(size: 9.5pt, fill: luma(80))

  // ---------- 封面 ----------
  if title != none {
    page(header: none, footer: none, {
      v(5cm)
      align(center)[
        #block(text(size: 28pt, weight: "bold", fill: theme.accent)[#title])
        #if subtitle != none { v(4pt); block(text(size: 15pt, fill: theme.accent.darken(8%))[#subtitle]) }
        #v(0.8cm)
        #line(length: 38%, stroke: 1.2pt + theme.accent)
        #v(0.8cm)
        #if author != none { block(text(size: 12.5pt)[#author]) }
        #if date != none { block(text(size: 11pt, fill: luma(110))[#date]) }
      ]
    })
    counter(page).update(1)
  }

  // ---------- 目录 ----------
  if toc {
    show outline.entry.where(level: 1): it => { v(4pt, weak: true); strong(it) }
    outline(title: [目录], indent: auto, depth: 3)
    pagebreak()
  }

  body
}
