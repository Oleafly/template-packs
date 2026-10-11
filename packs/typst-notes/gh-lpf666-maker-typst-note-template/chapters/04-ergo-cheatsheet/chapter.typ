#import "@preview/ergo:0.2.0": *
#import "../../notebook.typ" as nb

#show: nb.notebook.with(
  title: "Ergo 0.2.0 全功能速查表",
  author: "Your Name",
  short-title: [Chapter 4 · Ergo 0.2.0 Cheat Sheet],
  colors: ergo-colors.bootstrap,
  styles: ergo-styles.sidebar1,
)

#let chapter-content = [
#counter(heading).update(3)
#nb.chapter(
  [Ergo 0.2.0 全功能速查表],
  subtitle: [覆盖安装、调用约定、全部预设环境、主题样式、局部参数、附加宏与自定义扩展。],
  key: "ch-ergo-cheatsheet",
)

== 60 秒开始 / Quick Start

```typ
#import "@preview/ergo:0.2.0": *

#show: ergo-init.with(
  colors: ergo-colors.bootstrap,
  styles: ergo-styles.sidebar1,
  breakable: true,
  inline-qed: true,
  prob-nums: true,
)

#defn[Group][A group consists of a set and an operation.]
#thm[Result][Statement.][Proof.]
```

多文件笔记只需让总入口导入各章的 `chapter-content`；Ergo 不限制文档如何拆分。

```text
template/
├── main.typ
├── notebook.typ
└── chapters/
    ├── 01-learning/chapter.typ
    ├── 02-mathematics/chapter.typ
    └── ...
```

```typ
// main.typ
#import "chapters/01-learning/chapter.typ" as learning
#learning.chapter-content
```

#note[版本要求][
  本示例固定使用 `@preview/ergo:0.2.0`。官方元数据给出的最低 Typst 版本是
  `0.13.0`。
]

== 调用约定 / Calling Convention

#table(
  columns: (1.05fr, 1.5fr, 1.5fr),
  inset: 5pt,
  stroke: 0.4pt + luma(78%),
  table.header([*类型*], [*无名称*], [*有名称*]),
  [Statement], [`#defn[body]`], [`#defn[name][body]`],
  [Solution], [`#thm[statement][proof]`], [`#thm[name][statement][proof]`],
)

- `name` 是可选的第一个位置参数。
- Solution 类的最后一个内容块是证明或解答；写成 `[]` 表示暂不提供。
- `problem` 在没有显式名称且 `prob-nums: true` 时自动编号。

== 全部预设环境 / All Presets

=== Statement 类：1-2 个位置参数

#grid(
  columns: (1fr, 1fr),
  gutter: 7pt,
  defn[Definition / `definition` / `defn`],
  rmk[Remark / `remark` / `rem` / `rmk`],
  notn[Notation / `notation` / `notn`],
  ex[Example / `example` / `ex`],
  conc[Concept / `concept` / `conc`],
  comp-prob[Computational Problem / `computational-problem` / `comp-prob`],
  algo[Algorithm / `algorithm` / `algo`],
  runtime[Runtime Analysis / `runtime`],
  note[Note / `note`],
)

=== Solution 类：2-3 个位置参数

#thm[Theorem / `theorem` / `thm`][这是定理陈述。][这是证明。]
#lem[Lemma / `lemma` / `lem`][这是引理陈述。][这是证明。]
#cor[Corollary / `corollary` / `cor`][这是推论陈述。][这是证明。]
#prop[Proposition / `proposition` / `prop`][这是命题陈述；此处省略证明。][]
#prob[这是一个自动编号的问题。][这是解答。]
#excs[Exercise / `exercise` / `excs`][这是练习。][这是解答或证明。]

== 全局配置与局部覆盖 / Configuration

#table(
  columns: (1.1fr, 0.9fr, 2.5fr),
  inset: 5pt,
  stroke: 0.4pt + luma(78%),
  table.header([*参数*], [*默认值*], [*作用*]),
  [`colors`], [`ergo-colors.bootstrap`], [色板字典；可全局设置，也可对单个环境覆盖。],
  [`styles`], [`ergo-styles.tab1`], [环境布局样式。],
  [`breakable`], [`false`], [环境是否可跨页；全局与局部都可用。],
  [`inline-qed`], [`false`], [Solution 类证明的 Q.E.D. 方块是否行内。],
  [`prob-nums`], [`true`], [`problem` 是否自动编号。],
  [`width`], [`100%`], [所有环境的局部宽度。],
  [`height`], [`auto`], [所有环境的局部高度。],
)

#example(
  width: 82%,
  height: auto,
  colors: ergo-colors.terracotta,
  styles: ergo-styles.tab1,
  breakable: false,
)[Local override][
  这一块只改变自身的宽度、色板、样式和分页行为，不影响后续内容。
]

=== 内置色板 / Color Palettes

#table(
  columns: (1.65fr, 0.55fr, 1.65fr, 0.55fr),
  inset: 4pt,
  stroke: 0.35pt + luma(82%),
  table.header([*字段名*], [*模式*], [*字段名*], [*模式*]),
  [`bootstrap`], [light], [`bw`], [light],
  [`equilibrium-gray-light`], [light], [`penumbra-light`], [light],
  [`primer-light`], [light], [`measured-light`], [light],
  [`terracotta`], [light], [`dracula`], [dark],
  [`gruvbox-dark-medium`], [dark], [`eighties`], [dark],
  [`lime`], [dark], [`woodland`], [dark],
)

调用格式为 `ergo-colors.<字段名>`。暗色色板还会通过 `ergo-init` 改变页面底色和正文颜色，
因此通常应作为*全局*主题使用。

=== 内置样式 / Styles

#table(
  columns: (0.8fr, 2.8fr),
  inset: 5pt,
  stroke: 0.4pt + luma(80%),
  table.header([*字段*], [*特点*]),
  [`tab1`], [默认圆角标签样式。],
  [`sidebar1`], [直角、留白较少的侧边栏样式。],
  [`tab2`], [`tab1` 外观，但证明/解答放在独立的侧边块中。],
  [`sidebar2`], [`sidebar1` 外观，但证明/解答放在独立的侧边块中。],
  [`basic`], [接近数学教材的极简样式。],
  [`classic`], [Ergo 原始的圆角样式。],
)

== 附加宏 / Extras

#bookmark[Lecture 07][2026-08-03 · 09:00]

`#correction[body]`：#correction[这是一条需要醒目标出的订正。]

`#equation-box[...]` 与别名 `#eqbox[...]`：

#eqbox[$
  sum_(k=0)^n k = (n(n+1))/2
$]

独立的 `proof`/`pf` 和 `solution`/`sol` 也会被导出，适合在普通段落中使用：

#pf(inline-qed: true)[若 $n$ 为偶数，则 $n=2k$，所以 $n^2=4k^2$ 仍为偶数。]

#sol[把目标拆成更小的子问题，再按依赖顺序求解。]

`ergo-title-selector` 可以只选择环境标题；下面把一个局部标题放大：

#block[
  #show ergo-title-selector: set text(size: 12.5pt)
  #note[Title selector demo][只有本块标题采用这个局部 show rule。]
]

== 自定义环境与色板 / Custom Environments

官方暴露了底层构造器 `ergo-statement` 与 `ergo-solution`。新 `id` 必须在色板中提供
对应颜色；本项目的 `custom-colors.json` 在完整基础色板后增加了两个自定义 ID。

#let custom-colors = json("../../custom-colors.json")
#let insight = ergo-statement.with([洞见 / Insight], "custom-statement")
#let claim = ergo-solution.with([主张 / Claim], "custom-proof", true)

#insight(colors: custom-colors)[
  A custom statement needs `bgcolor`, `strokecolor`, and `type: "statement"`.
]

#claim(colors: custom-colors)[Bilingual preset][
  复用构造器可以把英文固定标题换成双语标题，同时保留 Ergo 的布局逻辑。
][
  A custom proof ID supplies two background colors, two stroke colors, and
  `type: "proof"`.
]

自定义色板的最小新增字段形状如下；完整字典仍须含有 Ergo 所有标准环境的颜色：

```json
"custom-proof": {
  "type": "proof",
  "bgcolor1": "#e8f3ff",
  "bgcolor2": "#cbe5ff",
  "strokecolor1": "#174f83",
  "strokecolor2": "#2878b5"
},
"custom-statement": {
  "type": "statement",
  "bgcolor": "#fff2cc",
  "strokecolor": "#8a6500"
}
```

#pagebreak()

== 自定义样式 / Custom Styles

样式字典必须且只能有 `solution` 与 `statement` 两个函数。每个函数接收内容、颜色字典
和 `..argv`；实际项目可参考 Ergo 源码的 `src/style/templates/`。

#let compact-statement(title, statement-body, colors, ..argv) = {
  let args = argv.named()
  let heading = if title == [] { args.preheader } else { [#args.preheader: #title] }
  block(
    width: args.width,
    height: args.height,
    breakable: args.breakable,
    inset: 8pt,
    fill: rgb(colors.env.bgcolor),
    stroke: (left: 3pt + rgb(colors.env.strokecolor)),
    [#strong(heading) #h(0.5em) #statement-body],
  )
}

#let compact-solution(title, statement-body, proof-body, colors, ..argv) = {
  let args = argv.named()
  let heading = if title == [] { args.preheader } else { [#args.preheader: #title] }
  let proof-part = if proof-body == [] { [] } else {
    [#linebreak() #emph[Proof / Solution.] #h(0.4em) #proof-body]
  }
  block(
    width: args.width,
    height: args.height,
    breakable: args.breakable,
    inset: 8pt,
    fill: rgb(colors.env.bgcolor1),
    stroke: (left: 3pt + rgb(colors.env.strokecolor1)),
    [#strong(heading) #h(0.5em) #statement-body #proof-part],
  )
}

#let compact-styles = (
  solution: compact-solution,
  statement: compact-statement,
)

#definition(styles: compact-styles)[Custom style demo][
  此块使用本文件定义的极简样式字典；下一块会自动回到全局 `sidebar1`。
]

#note[Back to global style][局部 `styles:` 参数不会泄漏到后续环境。]

== 模板层自动编号 / Template Numbering

Ergo 的原始 Definition、Theorem 等预设不会统一编号。本模板在 `notebook.typ` 中提供了
同参数形式的计数包装器；通过命名空间调用可以与原始 Ergo API 同时使用：

```typ
#import "../../notebook.typ" as nb

#nb.definition[Vector space][Definition body.]
#nb.theorem[Dimension][Statement body.][Proof body.]
```

每种类型的全局开关位于 `numbering-config.typ`；单条可写成
`#nb.definition(numbered: false)[Title][Body]`，且不会推进计数器。
#nb.definition[First numbered definition][Definition 与其他类型使用各自独立的计数器。]
#nb.definition[Second numbered definition][同一章中的下一个 Definition 编号递增。]
#nb.theorem[Independent theorem counter][Theorem 从本章自己的 4.1 开始。][]

公式编号由 `notebook` 的全局规则自动产生；只需在块级公式后添加唯一标签：

$ dim(V + W) = dim V + dim W - dim(V ∩ W) $ <eq:ch4-dimension>

使用 `#nb.eqref(<eq:ch4-dimension>)` 即可得到自动更新的引用，例如：
由 #nb.eqref(<eq:ch4-dimension>) 可知。

== 常见坑 / Pitfalls

- `#show: ergo-init...` 应在任何正文渲染之前调用；一个总入口调用一次即可。
- `colors:` 要传色板字典（如 `ergo-colors.bootstrap`），`styles:` 要传样式字典
  （如 `ergo-styles.tab1`），不要把两者写反。
- 名称是*位置参数*，不是 `name:` 关键字参数。
- `breakable: false` 的长块可能整体挪到下一页；长笔记通常全局设为 `true`。
- 中英混排由 Typst 的字体回退完成，不是 Ergo 特性；请选包含中文字形的字体。
- 固定包版本可保证可复现；升级版本时先阅读变更并重新编译检查。
- 需要章节编号时使用 `#nb.definition`、`#nb.theorem` 等包装器；直接调用 Ergo 原始
  `#definition`、`#theorem` 不会经过模板计数器。
]

#chapter-content
