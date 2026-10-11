#import "../template_for_bit_graduate_project.typ": project, bit_three_line_table

#show: project.with(
  title: "北京理工大学毕业设计排版测试",
  authors: ("张三",),
  date: "2026年4月20日",
)

= 第一章 绪论

这是第一章的第一段文字。根据修改后的模板设置，这段文字应当有两个字符的首行缩进。@vaswani2017attention

这是第一章的第二段文字。作为后续段落，它也会有缩进。我们需要确认所有段落的缩进是否一致。

== 研究背景

这是二级标题下的第一段文字。同样，这段文字也应当保持两个字符的首行缩进。

=== 具体背景

这是三级标题下的第一段文字，用于测试三级标题后的排版与段落样式。

= 第二章 关键技术

这是第二章的第一段文字，再次确认一级标题后的首段缩进是否正常。

在此处插入一个公式，测试公式编号是否正确：
$ E = m c^2 $

在此处插入一个图引用 @fig:test，测试图片编号：

#figure(
  rect[这是一个示意图],
  caption: "测试图片",
) <fig:test>

在此处插入一个表格引用 @tbl:test，测试三线表编号与样式。@knuth1984texbook

#bit_three_line_table(
  columns: 3,
  header: ([项目], [方法A], [方法B]),
  body: (
    [准确率], [90], [92],
    [召回率], [88], [91],
    [F1值], [89], [91.5],
  ),
  caption: [测试三线表],
) <tbl:test>

在此处插入一个数字列表：
+ 第一项 the first item
+ 第二项 the second item
+ 第三项 the third item

在此处插入一个项目列表：
- 第一项 the first item
- 第二项 the second item
- 第三项 the third item

== 实验结果

这是实验结果章节的第一段。

#bibliography("ref.bib")
