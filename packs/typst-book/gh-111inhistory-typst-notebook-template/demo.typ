#import "lib.typ": notebook-theme1, frames, frame-style, notebook-frame-style
#import "utils/typing-utils.typ": *

#import "@preview/physica:0.9.8": *
#import "@preview/marginalia:0.3.1": note, notefigure, wideblock

#let frame-definitions = (
  definition: ("定义", rgb("#4f86a8")),
  example: ("例", rgb("#6d9674")),
  remark: ("注", rgb("#b58a48")),
)
#let (definition, example, remark) = frames(..frame-definitions)

#show: notebook-theme1
#show: frame-style(notebook-frame-style, ..frame-definitions)

#set page(numbering: "I")
#outline()

#pagebreak()

#outline(title: "图表目录", target: figure)

#set page(numbering: "1")
#counter(page).update(1)

= 笔记模板演示

这份文档只展示当前模板已经接线并实际生效的能力，便于回归检查。
正文覆盖中文与 Latin 混排、标题编号、链接、脚注、列表、代码、图表、
块级公式、行内公式与章节级计数重置。

== 正文排版

这一段用于观察正文的首行缩进、两端对齐、自动断字、中文与 English 混排、
字重配置与基线协调。这里顺带放入 *强调文本*、#strong[强强调文本]、
#underline[下划线文本]、`inline code` 与
#link("https://typst.app/docs")[Typst 文档链接]。

字符替换规则当前也已经接线，因此正文里的 `->`、`=>`、`<-`、`<=`、`!=`
与 `<=>` 会被自动替换成对应符号。这里给出一段连续示例：
状态 A -> 状态 B，约束 P => Q，关系 u <=> v，且 x != y。

这一段同时用于交叉引用测试。后文会出现 @eq-energy、@eq-wave、
@fig-layout 与 @tbl-style，用于核对编号与引用文本是否正常。

== 边注与框环境

这一段用于测试边注栏。#note[边注适合放补充说明、术语来源、
  阅读提醒或简短推导，不打断正文主线。]<note-margin-demo>
正文继续排版时，边注应保持在右侧注栏内，并避免与相邻边注重叠。
这里引用刚才的边注 @note-margin-demo，用于确认边注标签引用正常。

#definition[群][代数结构][
  群是一个集合与一个二元运算组成的结构。该运算满足结合律，
  并且存在单位元与每个元素对应的逆元。
]

#example[整数加法][基础例子][
  整数集合 $ZZ$ 在加法下构成群。单位元是 $0$，
  任意整数 $a$ 的逆元是 $-a$。
]

#remark[][排版观察][
  框环境用于定义、例题、提示和局部结论。标题栏使用低饱和色，
  正文区域保留浅色背景，便于在屏幕阅读时快速扫视。
]

=== 脚注

脚注计数会在一级标题处清零。这里先放一个普通脚注#footnote[
  脚注内容用于确认编号、字号、间距与脚注区布局。
]，再放一个包含 `inline code`、链接
#link("https://typst.app/universe")[Universe] 与 *强调文本* 的脚注#footnote[
  脚注内部继续测试混排、样式继承和行距表现。
]。

== 列表系统

=== 无序列表

- 一级项目用于测试自定义项目符号与缩进。
- 这一项包含较长内容，用于观察换行后的悬挂缩进是否稳定，同时确认连接线位置与正文列对齐。
  - 二级项目用于观察第二层标记形状。
  - 二级项目继续补充一段说明，并包含一个链接
    #link("https://github.com/typst/typst")[Typst 仓库]。
- 这一项带一个行内公式 $a^2 + b^2 = c^2$。

=== 有序列表

+ 第一步：读取输入并完成基本校验。
+ 第二步：构建元素树与上下文。
+ 第三步：执行渲染并输出结果。
  + 子步骤：记录耗时。
  + 子步骤：检查边界条件。
+ 第四步：写入日志并返回状态。

=== 松散列表

- 这一项包含两个段落。

  第二段用于验证松散列表下的段间距、缩进与连接线是否仍然稳定。

- 另一项同样拆成两段。

  这种结构在技术笔记、课程讲义和会议记录中都很常见，因此值得单独回归。

== 引文与代码

=== 引文

#quote(block: true, attribution: [排版检查记录])[
  页面级样式只有在正文、标题、代码、图表与公式能够协同工作时，才具有长期可维护性。
]

=== 代码

下面的代码块用于验证 `zebraw` 渲染、边框、背景色、注释颜色与语言标签。

```typ
#let square(x) = x * x

#for n in range(1, 5) [
  第 #n 项的平方是 #square(n)。
]
```

```python
def normalize_title(raw: str) -> str:
    value = raw.strip()
    if not value:
        raise ValueError("title cannot be empty")
    return value.replace("_", " ").title()
```

== 公式与数学

=== 行内数学

行内公式需要与中文基线保持协调，例如
$sum_(i = 1)^n i = n(n + 1) / 2$。

当前模板已经接线了分数重写钩子，因此下面两个例子可直接用于观察不同嵌套结构的分数排版：
$a / b$，以及 $1 / (1 + 1 / (1 + x / y))$。

物理输入辅助函数也可直接使用，例如
$vt(E) = -grad phi - pdv(vt(A), t)$，
$vb(B) = curl vt(A)$，
$Arg z = theta$，
$ddot(x) + omega^2 x = 0$。

=== 块级公式

带标签的块级公式会显示编号：

$
  E = m c^2
$ <eq-energy>

多行公式用于验证对齐、间距与编号：

$
  f(x) & = integral_0^x (2 t + 1) dif t \
       & = x^2 + x
$ <eq-integral>

无标签的块级公式当前会保留公式内容，但不显示编号：

$
  Psi(vt(r), t)
  = 1 / (2 pi hbar)^(3 / 2)
  exp(i / hbar (vt(p) dot vt(r) - E t))
$

再补一个带标签的波动方程，便于交叉引用：

$
  laplacian Psi(vt(r), t) - 1 / c^2 pdv(Psi(vt(r), t), t, [2]) = 0
$ <eq-wave>

引用检查：@eq-energy、@eq-integral 与 @eq-wave。

== 图与表

#figure(
  kind: "image",
  rect(
    width: 100%,
    height: 5cm,
    radius: 6pt,
    fill: rgb("#f2efe8"),
    stroke: (paint: luma(75%), thickness: 0.8pt),
  ),
  caption: [版式占位图，用于检查图片题注、编号与引用。],
) <fig-layout>

正文中引用图片为 @fig-layout。

#figure(
  kind: "table",
  table(
    columns: (1fr, 1fr, 2fr),
    align: center + horizon,
    stroke: (paint: luma(70%), thickness: 0.6pt),
    table.header([能力], [状态], [说明]),
    [正文排版], [已启用], [包含首行缩进、两端对齐与 CJK-Latin 间距处理],
    [列表系统], [已启用], [支持自定义标记、分层编号与松散列表连接线],
    [数学钩子], [已启用], [块级公式按标签决定是否编号，分数样式已重写],
    [代码展示], [已启用], [块级代码使用盒状边框与语法高亮],
  ),
  caption: [当前模板能力摘要表。],
) <tbl-style>

表格引用检查见 @tbl-style。

== 综合段落

这一段用于把多种元素放在同一上下文里。这里同时包含
*强调*、#strong[强强调]、#underline[下划线]、`inline code`、
链接 #link("https://typst.app/universe")[Universe]、脚注#footnote[
  综合段落里的脚注用于观察正文与脚注之间的切换。
]、以及公式 $rho = m / V$。

如果页面在这里发生分页，就可以顺带观察页眉横线、页码、段间距和脚注区的协同行为。

= 章节级计数重置

这一章用于验证一级标题切换后，脚注、公式、图和表的计数是否从头开始。
这里先放一个新脚注#footnote[
  如果脚注编号重新从 1 开始，说明章节级计数清零规则已经生效。
]。

$
  vt(a) times vt(b) = epsilon_(i j k) a_i b_j vt(e_k)
$ <eq-cross>

#figure(
  kind: "image",
  rect(
    width: 100%,
    height: 4.2cm,
    radius: 6pt,
    fill: rgb("#f6f1e8"),
    stroke: (paint: luma(75%), thickness: 0.8pt),
  ),
  caption: [第二章图片占位图，用于确认图号重置。],
) <fig-cross>

#figure(
  kind: "table",
  table(
    columns: (1fr, 1fr),
    align: center + horizon,
    stroke: (paint: luma(70%), thickness: 0.6pt),
    table.header([项目], [观察点]),
    [公式编号], [应从本章重新开始],
    [图表编号], [应从本章重新开始],
  ),
  caption: [第二章表格占位，用于确认表号重置。],
) <tbl-cross>

本章引用检查：@eq-cross、@fig-cross 与 @tbl-cross。
