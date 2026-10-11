#import "../template.typ": *
#import "@preview/finite:0.5.1": automaton

#show: sdu-assignment.with(
  title: "山东大学课程作业模板示例",
  course: "操作系统",
  college: "计算机科学与技术学院",
  major: "计算机科学与技术",
  student-id: "2026000000",
  author: "张三",
  instructor: "李四",
)

#let flow-node(body, fill: rgb("#e8f0fe")) = box(
  width: 2.2cm,
  height: 1cm,
  fill: fill,
  stroke: 0.6pt + rgb("#003366"),
  radius: 3pt,
)[
  #align(center + horizon)[#body]
]

= 引言

这是一个最小但完整的示例文档，用于展示封面、目录、页眉页脚、按章编号、表格、公式、自动机图、代码块、提示框和参考文献等能力。正文默认使用中文排版参数，并支持行内代码 `typst compile`。

可以在正文中引用参考文献，例如 @silberschatz2018 和 @tanenbaum2015。

== 表格与公式

#figure(
  align(center)[
    #grid(
      columns: (auto, 1cm, auto, 1cm, auto),
      align: center + horizon,
      flow-node[输入],
      $arrow.r$,
      flow-node(fill: rgb("#eef8f0"))[处理],
      $arrow.r$,
      flow-node(fill: rgb("#fff4e6"))[输出],
    )
  ],
  caption: [简单流程图示例],
) <fig:flow>

#figure(
  table(
    columns: (1fr, 1fr, 1fr),
    [项目], [说明], [状态],
    [封面], [课程作业信息], [已启用],
    [目录], [三级标题深度], [已启用],
    [编号], [图表公式按章编号], [已启用],
  ),
  caption: [第一章示例表],
) <tab:first>

公式有两种常用写法：行内公式适合嵌入正文，例如 $E = m c^2$、$a_i$ 和 $O(n log n)$；展示公式适合单独呈现重要推导或结论。

展示公式放在单独段落中，模板会按当前一级标题编号：

$ E = m c^2 $ <eq:energy>

正文中可以通过标签引用公式，例如 @eq:energy。

常见数学符号可以直接在公式中组合使用。上标、下标和分式示例：

$ x^(n+1) + a_(i+1) = frac(p, q) $

求和、根号和希腊字母示例：

$ sum_(i=1)^n i = frac(n(n + 1), 2), quad sqrt(x^2 + y^2) = r, quad alpha + beta = gamma $

矩阵可以用 `mat(...)` 表示，分号分隔行，逗号分隔列：

$ A = mat(1, 2; 3, 4) $

较长推导可以写成多行公式，并用 `&` 对齐等号：

$
  (a + b)^2
    &= (a + b)(a + b) \
    &= a^2 + 2 a b + b^2
$

最终结论或关键公式可以使用公式展示框突出显示：

#boxed-equation(title: "能量-质量关系")[
  $ E = m c^2 $ <eq:boxed-energy>
]

如果不需要标题，也可以直接使用 `#boxed-equation[...]`。建议只给少量关键公式加框，普通推导保持默认展示公式，页面层次会更清楚。

== 自动机图

下面的自动机图使用 Typst Universe 的 `finite` 包绘制，不需要额外安装 Graphviz：

#figure(
  automaton(
    (
      q0: (q1: [0], q0: [1]),
      q1: (q2: [1], q1: [0]),
      q2: (q1: [1], q2: [0]),
    ),
    initial: "q0",
    final: ("q1",),
  ),
  caption: [一个 DFA 示例],
) <fig:dfa>

== 定理环境

#definition(name: "示例定义")[
  模板把定义、定理、引理、命题、推论、例和注封装为统一的彩色块。
]

#theorem(name: "示例定理")[
  这是第一章的第一个定理。
]

#proof[
  这里写证明过程。
]

== 代码与终端

```python
def hello(name: str) -> str:
    return f"Hello, {name}"

print(hello("Typst"))
```

#terminal(
  ("typst compile --root . examples/main.typ examples/main.pdf", "writing examples/main.pdf"),
  "typst --version",
)

#tip-box[
  如果编译时字体回退不理想，可以先运行 `typst fonts` 检查本机字体。
]

= 第二章

第二章重新开始图、表、公式和定理类环境的章内计数。

$ a^2 + b^2 = c^2 $ <eq:pythagoras>

#theorem[
  这是第二章的第一个定理。
]

#note-box[
  参考文献文件位于仓库根目录的 `refs.bib`。
]

#bibliography("../refs.bib")
