// =============================================================================
// ElegantPaper (Typst) — 中文演示
// elegantpaper-cn.typ
// =============================================================================

#import "elegantpaper.typ": *

#show: elegantpaper.with(
  title:    [ElegantPaper：一个优美的 Typst 工作论文模板],
  authors:  (
    (name: "作者1", institute: "某某大学/机构"),
    (name: "作者2", institute: "某某大学/机构"),
  ),
  date:     "2026 年 6 月",
  version:  "1.0",
  abstract: [
    本文为 #link("https://github.com/Iorest/ElegantPaper-Typst")[ElegantPaper (Typst)] 的说明文档。此模板基于 Typst 构建，专为工作论文写作而设计，排版风格借鉴自 #link("https://github.com/ElegantLaTeX/ElegantPaper")[ElegantPaper]（LaTeX 原版）。设计这个模板的初衷是让作者不用关心工作论文的格式，专心写作，从而有更加舒心的写作体验。如果你有其他问题、建议或者报告 bug，可以在 #link("https://github.com/Iorest/ElegantPaper-Typst/issues")[GitHub Issues] 留言。
  ],
  keywords: [ElegantPaper，工作论文，Typst 模板],
  lang:     "cn",
)

= 模板使用须知

本模板自 2026 年起基于 Typst 重新构建，排版风格借鉴自 ElegantPaper（LaTeX 原版）。

== 模板介绍

此模板基于 Typst 原生构建，默认编码为 UTF-8。适用于工作论文、学术报告等场景，具有简洁优雅的排版风格。

资源链接：
- GitHub：#link("https://github.com/Iorest/ElegantPaper-Typst")[https://github.com/Iorest/ElegantPaper-Typst]
- 下载：#link("https://github.com/Iorest/ElegantPaper-Typst/releases")[正式发行版]

== 编译方式

使用 Typst CLI 编译文档：

```bash
typst compile elegantpaper-cn.typ
typst watch elegantpaper-cn.typ   # 实时预览
```

也可以通过 #link("https://typst.app/")[Typst Web App] 在线使用，无需本地安装。

== 全局选项

此模板定义了一个语言选项 `lang`，可以选择英文模式 `lang: "en"`（默认）或者中文模式 `lang: "cn"`。当选择中文模式时，图表的标题引导词以及参考文献、定理引导词等信息会变成中文：

```typst
#show: elegantpaper.with(lang: "cn")
```

== 作者信息

`authors` 参数接受一个数组，每个元素可以是字符串或包含 `name` 和 `institute` 字段的字典：

```typst
#show: elegantpaper.with(
  authors: (
    (name: "作者1", institute: "某某大学"),
    (name: "作者2", institute: "某某机构"),
  ),
)
```

== 摘要与关键词

摘要通过 `abstract` 参数传入，关键词通过 `keywords` 参数传入：

```typst
#show: elegantpaper.with(
  abstract: [摘要内容。],
  keywords: [关键词1，关键词2],
)
```

== 自定义命令

本模板提供以下额外命令：

+ `#email("xxx@example.com")`：创建邮箱地址的链接，比如 #email("xxx@outlook.com")；
+ `#figref(<label>)`：在插图标题前添加 *图 n*；
+ `#tabref(<label>)`：在表格标题前添加 *表 n*；
+ `#proof(lang: "cn")[...]`：证明环境，末尾自动添加 □。

== 参考文献

本模板使用 Typst 内置的参考文献支持，使用 `@key` 语法引用文献。例如，`@cn1` 产生 @cn1，`@cn2` 产生 @cn2。

在文档末尾添加：

```typst
#bibliography("reference.bib", style: "ieee")
```

= 数学环境

本模板提供了以下定理类环境，编号按节（section）自动递增。

== 定理类环境

定理、引理、命题共享同一计数器，按节编号：

```typst
#theorem(name: "拉格朗日定理", lang: "cn")[
  定理内容。
]
```

#theorem(name: "拉格朗日定理", lang: "cn")[
  设 $G$ 是有限群，$H$ 是 $G$ 的子群，则 $H$ 的阶整除 $G$ 的阶。
]

#lemma(lang: "cn")[
  设 $z$ 是 $x H inter y H$ 中的某个元素，则 $x H = y H$。
]

#proposition(name: "左陪集的大小", lang: "cn")[
  设 $H$ 是群 $G$ 的有限子群，则 $H$ 在 $G$ 中的每个左陪集与 $H$ 的元素个数相同。
]

#corollary(lang: "cn")[
  有限群 $G$ 的子群 $H$ 的阶整除 $|G|$。
]

#proof(lang: "cn")[
  设 $z$ 是 $x H inter y H$ 中的某个元素。则 $z = x a$（$a in H$），$z = y b$（$b in H$）。因此 $x H = z H$，类似地 $y H = z H$，故 $x H = y H$，证毕。
]

== 定义与猜想

定义和猜想各有独立计数器，按节编号：

#definition(name: "左陪集", lang: "cn")[
  设 $H$ 是群 $G$ 的子群。$H$ 在 $G$ 中的一个_左陪集_是形如 $x H$ 的子集，其中 $x in G$，$x H = { x h : h in H }$。
]

#conjecture(lang: "cn")[
  对任意正整数 $n$，方程 $x^n + y^n = z^n$ 在正整数范围内无解（$n > 2$）。
]

== 例题与注记

#example(lang: "cn")[
  求证：$sqrt(2)$ 是无理数。
]

#remark(lang: "cn")[
  上述例题的证明方法是反证法，这是数学中常用的证明技巧。
]

#note(lang: "cn")[
  注意，群 $G$ 的子群 $H$ 本身就是 $H$ 在 $G$ 中的一个左陪集。
]

= 图表与公式

== 数学公式

行内公式：$integral_0^1 f(x) dif x$，以及显示公式：

$
  sum_(i=1)^n x_i equiv x_1 + x_2 + dots.c + x_n
$

连字符示例（newtx 字体问题在 Typst 中不存在）：

$
  integral_(RR^q) f(x, y) dif y
$

== 图表

#figure(
  image("image/founder.png", width: 70%),
  caption: [方正字体示例],
) <fig-founder>

回归分析是一种强大的统计方法，可以用来研究两个或多个变量之间的关系 @cn1。尽管回归分析有多种类型，但其核心都是研究一个或多个自变量对因变量的影响 @cn2 @cn3。

#figure(
  table(
    columns: (auto, auto, auto),
    align: (left, center, center),
    table.header([], [(1)], [(2)]),
    [mpg],    [-238.90\*\*\*], [-49.51],
    [],       [(53.08)],       [(86.16)],
    [weight], [],              [1.75\*\*\*],
    [],       [],              [(0.641)],
    [常数项], [11,253\*\*\*],  [1,946],
    [],       [(1,171)],       [(3,597)],
    [观测值], [74],            [74],
    [$R^2$],  [0.220],         [0.293],
    table.cell(colspan: 3, align: left)[#text(size: 8pt)[括号内为标准误]],
    table.cell(colspan: 3, align: left)[#text(size: 8pt)[\*\*\* $p < 0.01$，\*\* $p < 0.05$，\* $p < 0.1$]],
  ),
  caption: [汽车油耗与价格],
) <tab-auto>

= 常见问题 FAQ

+ _如何删除版本信息？_\
  在 `elegantpaper.with(...)` 中不传 `version` 参数即可。

+ _如何删除日期？_\
  在 `elegantpaper.with(...)` 中不传 `date` 参数即可。

+ _如何添加多个作者？_\
  `authors` 参数接受数组，可以传入多个作者字典。

+ _如何添加中英文双语摘要？_\
  可以在 `abstract` 参数中手动排版，或在正文中另起一节。

+ _应该使用哪个编辑器？_\
  推荐使用 VS Code 配合 #link("https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist")[Tinymist] 插件，或使用官方 #link("https://typst.app/")[Typst Web App]。

= 致谢

特别感谢 ElegantLaTeX 项目组设计的原版 ElegantPaper（LaTeX 版本），本模板的排版风格借鉴自该项目。

如果你喜欢本模板，欢迎在 #link("https://github.com/Iorest/ElegantPaper-Typst")[GitHub] 上给我们 Star。

// ---- 参考文献 ----
#set heading(numbering: none)
#bibliography("reference.bib", style: "ieee", title: "参考文献")

// ---- 附录 ----
#show: appendix.with(lang: "cn")

= 数学工具

本附录介绍一些基础数学知识。

== 求和算子

*求和算子*是用于表示数字求和的缩写。若 ${x_i : i = 1, 2, dots, n}$ 是 $n$ 个数的序列，则：

$
  sum_(i=1)^n x_i equiv x_1 + x_2 + dots.c + x_n
$
