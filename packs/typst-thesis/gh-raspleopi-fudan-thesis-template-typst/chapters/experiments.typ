= 实验设计与结果分析

== 实验设计

本章用于说明实验设置、数据来源、评价指标和对比方法。实验设计部分应尽量写清楚可复现信息，包括数据规模、参数设置、评价标准以及实验环境。

== 表格示例

表格建议使用三线表风格。模板已经设置表注位于表格上方，图注位于图片下方。

#figure(
  table(
    stroke: none,
    columns: (auto, auto, auto),
    table.hline(stroke: 0.8pt),
    table.header([方法], [指标一], [指标二]),
    table.hline(stroke: 0.5pt),
    align: (x, y) => if x > 0 and y > 0 { right + horizon } else { center + horizon },
    [方法 A], [0.812], [12.35],
    [方法 B], [0.856], [10.42],
    [方法 C], [0.901], [8.76],
    table.hline(stroke: 0.8pt),
  ),
  caption: [实验结果表格示例],
)<result_table>

如 @result_table 所示，数值列可以通过 `align` 参数右对齐。实际论文中应在表格后给出必要分析，而不仅仅展示数值。

== 结果分析

结果分析部分建议围绕研究问题展开，而不是逐项复述表格内容。可以按照以下顺序组织：

+ 先说明总体趋势。
+ 再解释关键指标的变化原因。
+ 最后讨论结果与研究假设之间的关系。

若需要在正文中连续引用多篇文献，可以写作 @golub2013-matrix-computations @vaswani2017-attention-is-all-you-need，参考文献样式会统一处理。

== 本章小结

本章展示了图、表和实验结果分析的基本写法。正式写作时，请将示例内容替换为自己的实验设计和结果。

