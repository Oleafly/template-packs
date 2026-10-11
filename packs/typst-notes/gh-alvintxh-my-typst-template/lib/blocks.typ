// ============================================================
//  各类环境框：定理类 + 提示类
//  定理类基于 ctheorems，共用一个计数器（定理 1.1、定义 1.2 …），
//  并且支持交叉引用：写 `<thm:xx>`，引用处写 `@thm:xx`。
// ============================================================

#import "@preview/ctheorems:1.1.3": thmenv, thmrules
#import "theme.typ": fonts, palette, tint, L

// ---------- 定理类环境的外观 ----------
// 左侧色条 + 浅色底，标题行用无衬线字体。
#let _boxed(color) = (name, number, body, title: none, ..rest) => block(
  width: 100%,
  breakable: true,
  fill: tint(color),
  stroke: (left: 2.5pt + color),
  radius: (right: 3pt),
  inset: (x: 1em, y: 0.9em),
  above: 1.3em,
  below: 1.3em,
)[
  #set par(first-line-indent: 0em)
  #block(below: 0.6em)[
    #text(font: fonts.sans, fill: color, weight: 700, size: 0.95em)[#name #number]
    #if title != none {
      text(font: fonts.sans, fill: color.darken(8%), weight: 600, size: 0.95em)[· #title]
    }
  ]
  #body
]

// 无底色的「行内」外观：用于证明、解答这类不需要突出的段落。
#let _plain(color) = (name, number, body, title: none, ..rest) => block(
  width: 100%,
  breakable: true,
  above: 1.1em,
  below: 1.1em,
  inset: (left: 0.9em),
  stroke: (left: 1pt + palette.line),
)[
  #set par(first-line-indent: 0em)
  #text(font: fonts.sans, fill: color, weight: 600, size: 0.95em)[#name#if number != none [ #number]]
  #if title != none { text(font: fonts.sans, fill: color, size: 0.95em)[（#title）] }
  #h(0.6em)
  #body
  #h(1fr) #box(baseline: 0.1em, square(size: 0.55em, fill: none, stroke: 0.8pt + palette.muted))
]

// 造一个带编号的环境。所有环境共用 "env" 这个计数器，按章重置。
#let _numbered(name, color) = thmenv("env", "heading", 1, _boxed(color)).with(
  name,
  numbering: "1.1",
  supplement: name,
)

// 造一个不带编号的环境。
#let _unnumbered(name, color) = thmenv(none, none, none, _plain(color)).with(
  name,
  numbering: none,
)

// ---------- 定理类 ----------
#let theorem = _numbered(L.theorem, palette.theorem)
#let definition = _numbered(L.definition, palette.definition)
#let lemma = _numbered(L.lemma, palette.lemma)
#let corollary = _numbered(L.corollary, palette.corollary)
#let proposition = _numbered(L.proposition, palette.proposition)
#let law = _numbered(L.law, palette.law)
#let example = _numbered(L.example, palette.example)
#let remark = _numbered(L.remark, palette.remark)
#let exercise = _numbered(L.exercise, palette.exercise)

// ---------- 证明 / 解答（不编号）----------
#let proof = _unnumbered(L.proof, palette.muted)
#let solution = _unnumbered(L.solution, palette.muted)

// ---------- 提示类（不编号，也不参与引用）----------
#let _admonition(name, color) = (title: none, body) => block(
  width: 100%,
  breakable: true,
  fill: tint(color, amount: 94%),
  stroke: (left: 2.5pt + color),
  radius: (right: 3pt),
  inset: (x: 1em, y: 0.85em),
  above: 1.2em,
  below: 1.2em,
)[
  #set par(first-line-indent: 0em)
  #block(below: 0.55em)[
    #text(font: fonts.sans, fill: color, weight: 700, size: 0.9em, tracking: 0.04em)[#upper(name)]
    #if title != none {
      text(font: fonts.sans, fill: color.darken(8%), weight: 600, size: 0.9em)[· #title]
    }
  ]
  #body
]

#let info = _admonition(L.info, palette.info)
#let tip = _admonition(L.tip, palette.tip)
#let warning = _admonition(L.warning, palette.warning)
#let danger = _admonition(L.danger, palette.danger)
#let idea = _admonition(L.idea, palette.idea)

// ---------- 几个零碎的小工具 ----------

// 行内高亮，默认用主色
#let hl(body, color: palette.primary) = text(fill: color, weight: 600, body)

// 术语首次出现时的标记
#let term(body) = text(style: "italic", fill: palette.primary, weight: 600, body)

// 键盘按键
#let kbd(key) = box(
  inset: (x: 0.35em, y: 0.15em),
  outset: (y: 0.2em),
  radius: 2pt,
  fill: rgb("#f4f5f7"),
  stroke: 0.5pt + palette.line,
  text(font: fonts.mono, size: 0.85em, key),
)

// 右侧旁注（不占正文宽度）
#let margin-note(body) = place(
  right,
  dx: 100% + 1em,
  block(width: 6em, text(font: fonts.kai, size: 0.85em, fill: palette.muted, body)),
)

// 并排放几张图 / 几个块，等宽
#let side-by-side(..items, gutter: 1em) = grid(
  columns: items.pos().len() * (1fr,),
  column-gutter: gutter,
  ..items.pos(),
)
