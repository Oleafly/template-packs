#import "../template/bupt-thesis.typ": thesis-figure, thesis-table, academic-table, caption-note

= 模板使用示例

本章展示论文正文中的常用结构。标题会自动编号，正文默认采用小四号字、20 磅固定行距和首行缩进，无需在章节文件中重复设置。

== 标题与正文

作者通常只需要使用 Typst 的标题语法组织内容。正文中的中英文、数字和标点会按照模板设置自动选择字体并完成两端对齐。

=== 三级标题

三级标题采用小四号黑体。目录默认收录到三级，深度可在 `main.typ` 中修改。

==== 四级标题

四级标题采用小四号宋体，建议避免过深的层级。

== 图、表与公式

图、表和公式会按章编号。图 @fig:logo、表 @tab:example 和公式 @eq:example 均可使用标签交叉引用。

#thesis-figure(
  image("../assets/img/logo.png", width: 36mm),
  [北京邮电大学校徽示例],
  caption_en: [Example of the BUPT emblem],
  label: <fig:logo>,
)

#caption-note[注：图片仅用于展示模板中的图题、编号和交叉引用。]

#thesis-table(
  academic-table(
    (1fr, 1.4fr, 1fr),
    ([项目], [说明], [示例值]),
    (
      (table.cell(rowspan: 2)[正文], [字号], [12 pt]),
      ([固定行距], [20 pt]),
      (table.cell(colspan: 2)[页边距（左右）], [31.7 mm]),
    ),
  ),
  [模板主要排版参数],
  caption_en: [Main typesetting parameters],
  label: <tab:example>,
)

#caption-note[数据来源：根据所附官方 Word 模板和 LaTeX 参考模板整理。]

公式使用 Typst 原生数学语法，显示公式会自动编号：

$ y = sum_(i=1)^n x_i / n $ <eq:example>

== 引用与参考文献

正文使用 `@标签` 引用文献，例如参考文献著录可遵循国家标准 @gbt7714。参考文献列表由 `main.typ` 统一生成。
