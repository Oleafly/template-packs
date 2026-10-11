// =============================================================================
// ElegantBook (Typst) — 中文演示
// elegantbook-cn.typ
// =============================================================================

#import "elegantbook.typ": *

// 选择颜色主题（blue / green / cyan / gray / black）
#let theme = theme-cyan

#show: elegantbook.with(
  title:     [ElegantBook：优美的 Typst 书籍模板],
  subtitle:  [ElegantBook 经典之作],
  author:    "ElegantBook Contributors",
  institute: "ElegantBook Project",
  date:      "2026 年 6 月",
  version:   "5.0",
  bioinfo:   ("自定义", "信息"),
  extrainfo: [#text(fill: rgb(31,186,190), weight: "bold")[本模板排版风格借鉴自 ElegantBook（LaTeX 原版），使用 Typst 重新构建。]],
  cover:     "figure/cover.jpg",
  logo:      "figure/logo-blue.png",
  color:     "cyan",
  lang:      "cn",
)

// ---- 目录 ----
#outline(
  title: "目录",
  indent: 1.5em,
  depth: 2,
)

// ---- 正文 ----

= ElegantBook 模板介绍

这是一个美观、优雅、简便的 Typst 书籍模板，排版风格借鉴自 #link("https://github.com/ElegantLaTeX/ElegantBook")[ElegantBook]（LaTeX 原版）。适用于排版书籍、笔记和学术文档，具有现代简洁的视觉风格。

本文将介绍本模板的一些设置内容以及基本使用方法。如果您有其他问题、建议或者意见，欢迎在 GitHub 上提交 #link("https://github.com/Iorest/ElegantBook-Typst/issues")[issues]。

资源链接：
- GitHub：#link("https://github.com/Iorest/ElegantBook-Typst")[https://github.com/Iorest/ElegantBook-Typst]
- 下载：#link("https://github.com/Iorest/ElegantBook-Typst/releases")[正式发行版]

== 模板安装与使用

=== 在线使用

你可以通过 #link("https://typst.app/")[Typst Web App] 在线使用本模板，无需本地安装。将 `elegantbook.typ` 和你的文档文件上传即可随时随地开始写作。

=== 本地使用

本地使用方法：从 GitHub 下载最新版，将 `elegantbook.typ` 放在你的工作目录下，然后在文档顶部导入：

```typst
#import "elegantbook.typ": *
```

=== 编译命令

使用 Typst CLI 编译文档：

```bash
typst compile elegantbook-cn.typ
typst watch elegantbook-cn.typ   # 实时预览
```

= ElegantBook 设置说明

本模板基于 Typst 原生构建，默认编码为 UTF-8。

== 语言模式

本模板内含两套基础语言环境 `lang: "cn"`、`lang: "en"`（默认）。改变语言环境会改变图表标题的引导词（图、表）、文章结构词（目录、参考文献等），以及定理环境中的引导词（定理、引理等）。

```typst
#show: elegantbook.with(lang: "cn")
```

所有定理环境也接受 `lang` 参数：

```typst
#definition(name: "左陪集", theme: theme, lang: "cn")[
  定义内容。
]
```

除模板自带的两套语言设定之外，欢迎社区贡献其他语言翻译。

#remark(lang: "cn")[
  只有在 `lang: "cn"` 模式下才建议输入中文内容。
]

== 设备选项

你可以通过修改页面设置来适配不同设备：

```typst
// A4 纸张（默认）
#show: elegantbook.with(...)

// 更紧凑的布局可通过 set page 调整纸张大小
```

== 颜色主题

本模板内置 5 组颜色主题，分别为 `green`、`cyan`、`blue`（默认）、`gray`、`black`。调用颜色主题 `green` 的方法为：

```typst
#show: elegantbook.with(color: "green")
```

#figure(
  table(
    columns: (auto, auto, auto, auto, auto, auto, auto),
    align: center,
    table.header(
      [], [green], [cyan], [blue], [gray], [black], [主要使用的环境]
    ),
    [structure],
    rect(fill: rgb(0,120,2), width: 1cm, height: 1cm),
    rect(fill: rgb(31,186,190), width: 1cm, height: 1cm),
    rect(fill: rgb(60,113,183), width: 1cm, height: 1cm),
    rect(fill: rgb(150,150,150), width: 1cm, height: 1cm),
    rect(fill: rgb(0,0,0), width: 1cm, height: 1cm),
    [章节标题],
    [main],
    rect(fill: rgb(0,120,2), width: 1cm, height: 1cm),
    rect(fill: rgb(59,180,5), width: 1cm, height: 1cm),
    rect(fill: rgb(0,166,82), width: 1cm, height: 1cm),
    rect(fill: rgb(150,150,150), width: 1cm, height: 1cm),
    rect(fill: rgb(0,0,0), width: 1cm, height: 1cm),
    [定义 / 练习],
    [second],
    rect(fill: rgb(230,90,7), width: 1cm, height: 1cm),
    rect(fill: rgb(175,153,8), width: 1cm, height: 1cm),
    rect(fill: rgb(255,134,24), width: 1cm, height: 1cm),
    rect(fill: rgb(150,150,150), width: 1cm, height: 1cm),
    rect(fill: rgb(0,0,0), width: 1cm, height: 1cm),
    [定理 / 引理],
    [third],
    rect(fill: rgb(0,160,152), width: 1cm, height: 1cm),
    rect(fill: rgb(244,105,102), width: 1cm, height: 1cm),
    rect(fill: rgb(0,174,247), width: 1cm, height: 1cm),
    rect(fill: rgb(150,150,150), width: 1cm, height: 1cm),
    rect(fill: rgb(0,0,0), width: 1cm, height: 1cm),
    [命题],
  ),
  caption: [ElegantBook 颜色主题],
)

如果需要自定义颜色，可以定义自己的主题字典：

```typst
#let my-theme = (
  structure: rgb(60, 113, 183),
  main:      rgb(0, 166, 82),
  second:    rgb(255, 134, 24),
  third:     rgb(0, 174, 247),
)
```

== 封面

=== 封面个性化

封面支持以下可选元素，所有元素均可为空：

- `title`（标题）
- `subtitle`（副标题）
- `author`（作者）
- `institute`（机构）
- `date`（日期）
- `version`（版本）
- `extrainfo`（额外信息）
- `cover`（封面图片路径）
- `logo`（Logo 图片路径）

此外，`bioinfo` 参数接受两个选项——标签和内容。例如，若要显示"用户名：111520"，只需：

```typst
bioinfo: ("用户名", "115520"),
```

=== 封面图片

本模板使用的封面图片来自 #link("https://pixabay.com/")[pixabay.com]，完全免费，可在任何情况下使用。封面图片尺寸为 $1280 times 1024$。

== 章节标题样式

本模板默认使用单行章节标题样式，章节编号和标题以主题的 structure 颜色显示。

== 数学环境介绍

我们定义了带彩色边框的定理类环境（fancy 样式）。本模板定义了四种不同的定理类环境：

- *定理类环境*，包含标题和内容，编号对应章节。根据格式分为三类：
  - #text(fill: theme.main)[*定义*] 环境，颜色为 #text(fill: theme.main)[main]；
  - #text(fill: theme.second)[*定理、引理、推论、公理、公设*] 环境，颜色为 #text(fill: theme.second)[second]；
  - #text(fill: theme.third)[*命题*] 环境，颜色为 #text(fill: theme.third)[third]。
- *例题类环境*，包含*例题、练习、问题*环境，按章节自动编号。
- *证明类环境*，包含*证明、笔记*环境，分别含有结束符号和引导符号。
- *结论类环境*，包含*结论、假设、性质、注、解*环境，均以加粗引导词开头。

=== 定理类环境

使用方法如下：

```typst
// 带名称
#definition(name: "左陪集", theme: theme, lang: "cn")[
  定义内容。
]

// 不带名称
#theorem(theme: theme, lang: "cn")[
  定理内容。
]
```

=== 其他自定义环境

其他数学环境可以直接调用：

```typst
#example(theme: theme, lang: "cn")[
  这是例题环境的内容。
]
```

效果如下：

#example(theme: theme, lang: "cn")[
  这是例题环境的内容。
]

各环境的细微差别：

- 例题、练习、问题环境按章节编号；
- 笔记环境以引导符号开头，证明环境以结束符号结尾；
- 结论等环境为普通段落环境，以加粗引导词开头。

== 列表环境

Typst 内置列表环境，效果如下：

#grid(
  columns: (1fr, 1fr),
  gutter: 1em,
  [
    - 无序列表第一项；
    - 无序列表第二项；
      - 嵌套第一项；
      - 嵌套第二项；
        - 三级嵌套第一项；
        - 三级嵌套第二项。
  ],
  [
    + 有序列表第一项；
    + 有序列表第二项；
      + 嵌套第一项；
      + 嵌套第二项；
        + 三级嵌套第一项；
        + 三级嵌套第二项。
  ]
)

== 参考文献

本模板使用 Typst 内置的参考文献支持，使用 `@key` 语法引用文献。例如，`@cn1` 产生 @cn1，`@cn2` 产生 @cn2。

在文档末尾添加：

```typst
#bibliography("reference.bib", style: "ieee")
```

== 前言

如果需要在第一章之前添加前言且不影响章节编号，请按如下方式添加：

```typst
= 前言 <chapter-intro>
#counter(heading).update(0)

前言内容。
```

== 目录深度

使用 Typst 内置的 `#outline()` 函数：

```typst
#outline(
  title: "目录",
  indent: 1.5em,
  depth: 2,
)
```

== 内容提要环境

我们创建了内容提要环境，用于在章节开头展示本章结构。基本用法如下：

```typst
#introduction(theme: theme, lang: "cn", (
  [定理的定义],
  [求助方法],
  [优化问题],
  [柯西级数的性质],
  [角的度量],
))
```

效果如下：

#introduction(theme: theme, lang: "cn", (
  [定理的定义],
  [求助方法],
  [优化问题],
  [柯西级数的性质],
  [角的度量],
))

`problemset` 环境用于在每章末尾展示对应的练习题：

```typst
#problemset(theme: theme, lang: "cn", (
  [练习 1],
  [练习 2],
  [练习 3],
))
```

效果如下：

#problemset(theme: theme, lang: "cn", (
  [练习 1],
  [练习 2],
  [练习 3],
  [数学公式测试：$a^2 + b^2 = c^2$],
))

#remark(lang: "cn")[
  如果需要自定义 `problemset` 的标题，请修改可选参数。
]

#solution(lang: "cn")[
  如果需要自定义 `problemset` 的标题，请参考 introduction 环境的用法修改可选参数。
]

= ElegantBook 写作示例

#introduction(theme: theme, lang: "cn", (
  [定理类环境],
  [交叉引用],
  [数学环境],
  [列表环境],
  [图表示例],
  [$a^2 + b^2 = c^2$],
))

我们将分三步定义可测函数的积分。首先，定义非负简单函数的积分。设 $E$ 为 $cal(R)^N$ 中的可测集。

== 写作示例

#definition(name: "左陪集", theme: theme, lang: "cn")[
  设 $H$ 是群 $G$ 的子群。$H$ 在 $G$ 中的一个_左陪集_是 $G$ 的一个子集，形如 $x H$，其中 $x in G$，$x H = { x h : h in H }$。类似地，$H$ 在 $G$ 中的一个_右陪集_是形如 $H x$ 的子集，其中 $H x = { h x : h in H }$。
]

#note(lang: "cn")[
  注意，群 $G$ 的子群 $H$ 本身就是 $H$ 在 $G$ 中的一个左陪集。
]

#theorem(name: "拉格朗日定理", theme: theme, lang: "cn")[
  设 $G$ 是有限群，$H$ 是 $G$ 的子群，则 $H$ 的阶整除 $G$ 的阶。
]

#theorem(name: "命名定理示例", theme: theme, lang: "cn")[
  这是一个带名称的定理内容示例。
]

#proposition(name: "左陪集的大小", theme: theme, lang: "cn")[
  设 $H$ 是群 $G$ 的有限子群，则 $H$ 在 $G$ 中的每个左陪集与 $H$ 的元素个数相同。
]

#proof(lang: "cn")[
  设 $z$ 是 $x H inter y H$ 中的某个元素。则 $z = x a$（$a in H$），$z = y b$（$b in H$）。若 $h$ 是 $H$ 中任意元素，则 $a h in H$ 且 $a^(-1) h in H$，因为 $H$ 是 $G$ 的子群。但对所有 $h in H$，有 $z h = x(a h)$ 且 $x h = z(a^(-1) h)$。因此 $z H subset x H$ 且 $x H subset z H$，从而 $x H = z H$。类似地 $y H = z H$，故 $x H = y H$，证毕。
]

#figure(
  image("image/scatter.jpg", width: 60%),
  caption: [散点图示例],
)

回归分析是一种强大的统计方法，可以用来研究两个或多个变量之间的关系 @cn1。尽管回归分析有多种类型，但其核心都是研究一个或多个自变量对因变量的影响 @cn2 @cn3。

== 第二节

#figure(
  table(
    columns: (auto, auto, auto),
    align: (left, center, center),
    table.header([], [(1)], [(2)]),
    [mpg],    [-238.90\*\*\*], [-49.51],
    [],       [(53.08)],       [(86.16)],
    [weight], [],              [1.75\*\*\*],
    [],       [],              [(0.641)],
    [常数项], [11,253\*\*\*], [1,946],
    [],         [(1,171)],      [(3,597)],
    [观测值],    [74],            [74],
    [$R^2$],  [0.220],         [0.293],
    table.cell(colspan: 3, align: left)[#text(size: 8pt)[括号内为标准误]],
    table.cell(colspan: 3, align: left)[#text(size: 8pt)[\*\*\* $p < 0.01$，\*\* $p < 0.05$，\* $p < 0.1$]],
  ),
  caption: [汽车油耗与价格],
)

- 路由与资源发现；
  - 语言模型
  - 向量空间模型
- 弹性可扩展的计算机网络；
- 分布式存储与搜索。

#problemset(theme: theme, lang: "cn", (
  [求解方程 $5(-3x - 2) - (x - 3) = -4(4x + 5) + 13$。],
  [求点 $(-4, -5)$ 与 $(-1, -1)$ 之间的距离。],
  [求直线 $5x - 5y = 7$ 的斜率。],
))

= 常见问题

以下列出一些常见问题供用户参考：

+ #question[计数器为什么会意外重置？]
  请确保定理环境放置在章节标题之后。计数器与 `heading.where(level: 1)` 绑定。

+ #question[我想自定义字体和背景颜色。]
  请使用 `set page(fill: ...)` 修改背景颜色，使用 `set text(fill: ...)` 自定义字体颜色。

+ #question[应该选择哪个版本？]
  请通过 GitHub 使用#link("https://github.com/Iorest/ElegantBook-Typst/releases")[最新正式版]。

+ #question[应该使用哪个编辑器？]
  推荐使用 VS Code 配合 #link("https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist")[Tinymist] 插件，或使用官方 #link("https://typst.app/")[Typst Web App]。

+ #question[你好，我们想用 ElegantBook 写一本关于机器学习的书，需要授权吗？]
  欢迎使用我们的模板，注明版权即可。其他问题请参考 MIT 许可证。

+ #question[什么是交叉引用？]
  本模板面向有一定 Typst 基础的用户。请先学习 Typst 基础知识再使用本模板。

+ #question[代码高亮的语言是否可选？]
    是的，Typst 内置的代码块支持语言高亮。使用三个反引号加语言名称（如 `python`）即可启用语法高亮。

+ #question[什么时候会有演示文稿模板（ElegantSlide）？]
  由于已有优秀的 Typst 演示包 #link("https://typst.app/universe/package/touying")[Touying]，暂无单独制作幻灯片主题的计划。

= 版本历史

本节展示 ElegantBook (Typst) 的版本历史。

#datechange("2026/06/10", "v5.0 发布 — " + text(fill: rgb(31,186,190), weight: "bold")[Typst 重构版], (
  [使用 Typst 完全重构，排版风格借鉴自 ElegantBook（LaTeX 原版）。],
  [支持 5 种颜色主题：blue、green、cyan、gray、black。],
  [完整的中英文双语支持。],
  [丰富的定理类环境，带彩色边框。],
  [自定义封面页，支持图片、Logo 和元数据。],
))

// ---- 附录 ----
#counter(heading).update(0)
#set heading(numbering: "A.1")

= 数学工具

本附录介绍计量经济学中使用的一些基础数学知识，包括求和算子的性质、线性与非线性方程的性质，以及比率和百分比的回顾。

== 求和算子与描述统计

*求和算子*是用于表示数字求和的缩写，在统计学和计量经济学分析中起着重要作用。若 ${x_i : i = 1, 2, dots, n}$ 是 $n$ 个数的序列，则这 $n$ 个数的求和为：

$
  sum_(i=1)^n x_i equiv x_1 + x_2 + dots.c + x_n
$

// ---- 参考文献 ----
#set heading(numbering: none)
#bibliography("reference.bib", style: "ieee", title: "参考文献")
