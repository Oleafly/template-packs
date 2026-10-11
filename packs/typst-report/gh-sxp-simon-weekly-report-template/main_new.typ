#import "template_auto.typ": project
#import "code-example.typ": styled-code

#show: project.with(
  title: "Weekly Report",
  authors: (
    "Helian Nuits",
    "Nanchang University",
    "Life Science School",
    "GalGame Group",
  ),
  date: none
)

// 目录标题
#align(center)[
  #box(
    inset: (y: 0.5em),
    [#text(font: "Times New Roman", weight: "bold", size: 16pt)[
      CONTENTS
    ]]
  )
]
#v(0.5em)
// 设置目录样式
#set outline(
  indent: 2em,
)
#outline()

#pagebreak()

#let sn = "ZhouBi"

// = Highlights
// #include "1-highlights.typ"

// = Learning Contents
// #include "2-content.typ"

// = Desire
// #include "3-rethink.typ"

// = Schedule
// #include "4-schedule.typ"

= Complete Typst Elements Demonstration
本节将展示Typst可以支持的各种排版元素，作为报告编写的参考。

== 标题系统展示
这里展示了各级标题的排版样式。

=== 三级标题示例
三级标题也有良好的排版。

==== 四级标题示例
甚至四级标题也被支持。

== 列表与枚举
Typst支持多种列表样式：

无序列表示例：
- 第一项内容
- 第二项内容
  - 子项1
  - 子项2
- 第三项内容

有序列表示例：
1. 第一步操作
2. 第二步操作
   1. 子步骤1
   2. 子步骤2
3. 第三步操作

== 代码块展示

=== 基础代码块
这是一个Python代码示例：

#figure(
  ```python
  def generate_fibonacci(n):
      """Generate Fibonacci sequence up to n"""
      a, b = 0, 1
      result = []
      while a < n:
          result.append(a)
          a, b = b, a + b
      return result
      
  print(generate_fibonacci(100))
  ```,
  caption: [斐波那契数列生成函数]
)

== 数学表达式展示

=== 行内公式
这是一个行内公式：$E = m c^2$，它与文本混排。另一个例子：$lambda = c/f$。

=== 显示公式
这是一个显示公式：

$ F(x) = integral_(- infinity)^x f(t) d t = 1/(sqrt(2 pi) sigma) integral_(- infinity)^x e^(-(t-mu)^2/(2sigma^2)) d t $

=== 矩阵
Typst也支持矩阵表示：

$
A = mat(
  1, 2, 3;
  4, 5, 6;
  7, 8, 9
)
$

== 表格展示

=== 基础表格
基本表格可以这样创建：

#table(
  columns: (auto, auto, auto),
  inset: 10pt,
  align: center,
  [*姓名*], [*年龄*], [*专业*],
  [张三], [20], [计算机科学],
  [李四], [22], [信息工程],
  [王五], [21], [软件工程],
)

=== 带标题的表格
也可以为表格添加标题：

#figure(
  table(
    columns: (auto, auto, auto, auto),
    inset: 8pt,
    align: center,
    [*项目*], [*第一季度*], [*第二季度*], [*同比增长*],
    [网站浏览量], [125,000], [280,000], [+124%],
    [注册用户], [8,400], [15,800], [+88%],
    [活跃用户], [5,200], [12,300], [+136%],
  ),
  caption: [实验室网站运营数据]
)

=== 合并单元格的表格
表格也可以合并单元格：

#table(
  columns: (auto, auto, auto),
  inset: 6pt,
  align: center,
  table.hline(),
  [*时间*], table.cell(colspan: 2)[*安排*],
  table.hline(),
  [上午9:00-10:30], table.cell(colspan: 2)[开题报告],
  [上午10:30-12:00], [项目讨论], [方案设计],
  [下午14:00-17:00], table.cell(colspan: 2)[系统开发],
  table.hline(),
)

== 其他格式元素

=== 引用与脚注
这里是一个脚注示例#footnote[这是脚注内容，可以用来说明额外信息。]，脚注会自动编号。

=== 特殊格式文本
Typst支持各种文本格式：
- *粗体文本* 用于强调
- _斜体文本_ 用于引用或标题
- #underline[下划线文本] 用于重点强调
- #text(fill: rgb(255, 0, 0))[彩色文本] 可以改变颜色

// REFERENCES
// #bibliography("ref.bib")
