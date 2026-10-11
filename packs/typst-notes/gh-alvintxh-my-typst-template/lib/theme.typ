// ============================================================
//  主题配置：字体、配色、尺寸
//  想换风格，改这个文件就够了，其他文件都从这里取值。
// ============================================================

// ---------- 字体 ----------
// 列表里第一个是拉丁字形，后面的作为 CJK 回退。
// 用 `typst fonts` 可以看本机装了哪些字体。
#let fonts = (
  serif: ("Times New Roman", "Songti SC"), // 正文：西文 Times，中文宋体
  // 标题：西文 Times，中文黑体。用 PingFang SC 而不是 Heiti SC，
  // 因为前者有 Semibold 字重，标题加粗才是真的粗体而不是描边模拟。
  sans: ("Times New Roman", "PingFang SC"),
  // 代码：Maple Mono NF。这个家族名下同时装了 NF 和 NF-CN 两套文件，
  // Typst 取到的多半是含中文的 CN 版，取不到的字重再回退宋体。
  mono: ("Maple Mono NF", "Songti SC"),
  math: ("STIX Two Math", "Songti SC"), // 公式：STIX Two 是 Times 系的数学字体
  kai: ("Times New Roman", "Kaiti SC"), // 引文、旁注：中文楷体
)

// ---------- 尺寸 ----------
#let sizes = (
  body: 10.5pt, // 正文字号（五号）
  leading: 0.85em, // 行内间距，中文建议 0.8~1.0em
  par-spacing: 1.1em, // 段间距
  indent: 2em, // 首行缩进（中文习惯 2 字符）
)

// ---------- 配色 ----------
// 整体是「墨色正文 + 单一主色点缀」，环境框各自有低饱和度的色相。
#let palette = (
  ink: rgb("#1c1e21"), // 正文
  muted: rgb("#6b7280"), // 次要信息：页码、图注、注释
  line: rgb("#dfe3e8"), // 分隔线
  primary: rgb("#2f6690"), // 主色（标题、链接、强调）
  // 各类环境框的色相
  theorem: rgb("#2f6690"), // 定理     — 蓝
  definition: rgb("#0f766e"), // 定义     — 青
  lemma: rgb("#4c5578"), // 引理     — 靛
  corollary: rgb("#4c5578"), // 推论     — 靛
  proposition: rgb("#6d5192"), // 命题     — 紫
  law: rgb("#9a3412"), // 定律/原理 — 赭
  example: rgb("#b45309"), // 例题     — 琥珀
  remark: rgb("#6b7280"), // 注记     — 灰
  exercise: rgb("#166534"), // 习题     — 绿
  // 提示框
  info: rgb("#2563eb"), // 说明     — 蓝
  tip: rgb("#15803d"), // 技巧     — 绿
  warning: rgb("#b45309"), // 注意     — 橙
  danger: rgb("#b91c1c"), // 易错     — 红
  idea: rgb("#7c3aed"), // 想法     — 紫
)

// 取某个色的浅色底：用于框内填充
#let tint(c, amount: 95%) = c.lighten(amount)

// ---------- 语言 ----------
// 改成 "en" 就把「定理 / 图 / 目录」等全部换成英文。
#let lang = "zh"

// ---------- 多语言标签 ----------
// 想单独改某个名字（比如把「定律」改成「原理」），直接改下面的字符串。
#let labels = (
  zh: (
    chapter: (n) => [第 #n 章],
    chapter-ref: (n) => [第 #n 章], // 交叉引用一级标题时的说法
    section-ref: (n) => [第 #n 节], // 交叉引用二级及以下标题时的说法
    toc: "目录",
    bibliography: "参考文献",
    theorem: "定理",
    definition: "定义",
    lemma: "引理",
    corollary: "推论",
    proposition: "命题",
    law: "定律",
    example: "例",
    remark: "注",
    exercise: "习题",
    proof: "证明",
    solution: "解",
    info: "说明",
    tip: "技巧",
    warning: "注意",
    danger: "易错",
    idea: "想法",
    figure: "图",
    table: "表",
    listing: "代码",
    equation: "式",
  ),
  en: (
    chapter: (n) => [Chapter #n],
    chapter-ref: (n) => [Chapter #n],
    section-ref: (n) => [Section #n],
    toc: "Contents",
    bibliography: "References",
    theorem: "Theorem",
    definition: "Definition",
    lemma: "Lemma",
    corollary: "Corollary",
    proposition: "Proposition",
    law: "Law",
    example: "Example",
    remark: "Remark",
    exercise: "Exercise",
    proof: "Proof",
    solution: "Solution",
    info: "Note",
    tip: "Tip",
    warning: "Warning",
    danger: "Pitfall",
    idea: "Idea",
    figure: "Figure",
    table: "Table",
    listing: "Listing",
    equation: "Eq.",
  ),
)

// 当前语言的标签表，其他文件用 `L.theorem` 这样取。
#let L = labels.at(lang)
