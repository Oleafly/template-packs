#import "../lib.typ": documentclass

#let (
  twoside,
  doc,
  preface,
  mainmatter,
  appendix,
  fonts-display-page,
  cover,
  decl-page,
  abstract,
  abstract-en,
  bilingual-bibliography,
  outline-page,
  list-of-figures,
  list-of-tables,
  notation,
  acknowledgement,
  academic-achievements,
  add-blank-even-page,
) = documentclass(
  doctype: "master", // "bachelor" | "master" | "doctor",
  degree: "professional", // "academic" | "professional", 学位类型
  anonymous: false, // 是否开启盲审模式
  info: (
    title: ("基于 Typst 的", "西北工业大学学位论文"),
    title-en: "My Title in English",
    grade: "20XX",
    student-id: "1234567890",
    clc: "TP311.1", // 分类号
    author: "航小天",
    author-en: "Xiaotian Hang",
    department: "计算机学院",
    major: "计算机科学与技术",
    major-en: "Computer Science and Technology",
    supervisor: ("张三", "教授"),
    supervisor-en: "San Zhang",
    submit-date: datetime.today(),
    // 评阅人名单
    reviewers: (
      (name: "张某某", title: "教授", unit: "西北工业大学"),
      (name: "李某某", title: "教授", unit: "西安交通大学"),
      (name: "王某某", title: "教授", unit: "西安电子科技大学"),
    ),
    // 答辩委员会信息
    defence-committee: (
      date: datetime(year: 2024, month: 6, day: 1),
      members: (
        (role: "主席", name: "赵某某", title: "教授", unit: "西北工业大学"),
        (role: "委员", name: "钱某某", title: "教授", unit: "西安交通大学"),
        (role: "委员", name: "孙某某", title: "教授", unit: "西安电子科技大学"),
        (role: "委员", name: "周某某", title: "教授", unit: "西北工业大学"),
        (role: "委员", name: "吴某某", title: "副教授", unit: "西北工业大学"),
        (role: "秘书", name: "郑某某", title: "讲师", unit: "西北工业大学"),
      ),
    ),
  ),
  // 参考文献源
  bibliography: bibliography.with("ref.bib"),
)

// 文稿设置
#show: doc

// 封面页
#cover()

// 前言
#show: preface

// 中文摘要
#abstract(
  keywords: ("关键词一", "关键词二", "关键词三", "关键词四"),
)[
  中文摘要内容。中文摘要一般应说明研究工作目的、实验方法、结果和最终结论等，而重点是结果和结论。摘要中不用图、表、化学结构式、非公知公用的符号和术语。
]

// 英文摘要
#abstract-en(
  keywords: ("Keyword1", "Keyword2", "Keyword3", "Keyword4"),
)[
  English abstract content. The abstract should generally explain the purpose, experimental methods, results, and final conclusions of the research, with emphasis on the results and conclusions.
]


// 目录
#outline-page()

// 图目录
// #list-of-figures()

// 表格目录
// #list-of-tables()

// 正文
#show: mainmatter

// 符号表
// #notation[
//   / DFT: 密度泛函理论 (Density functional theory)
//   / DMRG: 密度矩阵重正化群 (Density-Matrix Reformation-Group)
// ]

= 绪论

== 研究背景

=== 研究意义

研究意义内容。

=== 研究现状

研究现状内容。

== 研究内容

研究内容概述。

== 列表测试

=== 无序列表

- 无序列表项一
- 无序列表项二
  - 无序子列表项一
  - 无序子列表项二

=== 有序列表

+ 有序列表项一
+ 有序列表项二
  + 有序子列表项一
  + 有序子列表项二

=== 术语列表

/ 术语一: 术语解释
/ 术语二: 术语解释

== 图表测试

引用@tbl:timing，引用@tbl:timing-tlt，以及@fig:test。引用图表时，表格和图片分别需要加上 `tbl:`和`fig:` 前缀才能正常显示编号。

#align(center, (
  stack(dir: ltr)[
    #figure(
      table(
        align: center + horizon,
        columns: 4,
        [t], [1], [2], [3],
        [y], [0.3s], [0.4s], [0.8s],
      ),
      caption: [常规表],
    ) <timing>
  ][
    #h(50pt)
  ][
    #figure(
      table(
        columns: 4,
        stroke: none,
        table.hline(),
        [t], [1], [2], [3],
        table.hline(stroke: .5pt),
        [y], [0.3s], [0.4s], [0.8s],
        table.hline(),
      ),
      caption: [三线表],
    ) <timing-tlt>
  ]
))

#figure(
  rect(width: 100pt, height: 50pt, fill: blue.lighten(80%), [测试图片]),
  caption: [图片测试],
) <test>


== 数学公式

可以像 Markdown 一样写行内公式 $x + y$，以及带编号的行间公式：

$ phi.alt := (1 + sqrt(5)) / 2 $ <ratio>

引用数学公式需要加上 `eqt:` 前缀，则由@eqt:ratio，我们有：

$ F_n = floor(1 / sqrt(5) phi.alt^n) $

我们也可以通过 `<->` 标签来标识该行间公式不需要编号

$ y = integral_1^2 x^2 dif x $ <->

而后续数学公式仍然能正常编号。

$ F_n = floor(1 / sqrt(5) phi.alt^n) $

== 参考文献

可以像这样引用参考文献：图书#[@蒋有绪1998]和会议#[@中国力学学会1990]。

== 代码块

代码块支持语法高亮。引用时需要加上 `lst:` @lst:code

#figure(
  ```py
  def add(x, y):
    return x + y
  ```,
  caption: [代码块],
) <code>


= 研究方法

== 方法概述

方法概述内容。

== 实验设计

实验设计内容。


// 正文结束
#heading(level: 1, numbering: none, outlined: true, [参考文献])
#bilingual-bibliography(full: true, title: none)

// 附录
#appendix[

  = 附　录

  附录内容。
]

// 致谢
#acknowledgement[
  致谢内容。感谢导师的悉心指导，感谢同学们的帮助。
]

// 学术成果页（研究生使用）
#academic-achievements[
  一、发表的学术论文

  [1] 作者. 论文标题[J]. 期刊名, 年份, 卷(期): 页码.

  二、参加的科研项目

  [1] 项目名称，项目编号，起止时间。
]

// 声明页（插入扫描件PDF）
#page(margin: 0pt)[
  #image("声明.pdf", width: 100%, height: 100%)
]
