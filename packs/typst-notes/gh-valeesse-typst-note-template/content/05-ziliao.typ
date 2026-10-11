#import "../template.typ": *
#import "@preview/tablex:0.0.9": cellx, colspanx, hlinex, rowspanx, tablex
= 资料分析

== 表格 (tablex v0.0.9)

#figure(
  tablex(
    columns: (auto, 1fr, 1fr, 1fr),
    align: center,
    // 表格主标题
    header: cellx(colspan: 4, fill: silver.lighten(80%))[
      #text(weight: "bold")[2023年上半年A、B两市经济数据对比]
    ],

    // 直接将所有单元格作为 tablex 的参数，它会自动根据 columns 参数进行布局

    // 表头行
    [#text(weight: "bold")[指标]],
    [#text(weight: "bold")[A市]],
    [#text(weight: "bold")[B市]],
    [#text(weight: "bold")[同比增长]],

    // 数据行1 (GDP)
    cellx(rowspan: 2, align: center + horizon)[#text(weight: "bold")[GDP]],
    [第一季度],
    [1000亿],
    [+5.2%],

    // 数据行2 (GDP) - 此行只有3个单元格
    [第二季度],
    [1200亿],
    [+6.0%],

    // 水平分隔线
    hlinex(),

    // 数据行3 (投资)
    [#text(weight: "bold")[固定资产投资]],
    [500亿],
    [450亿],
    [+8.1%],
  ),
  caption: [一个使用 `tablex:0.0.9` 创建的复杂表格。],
)

#note[
  - `tablex` 函数直接接收平铺的单元格序列作为其内容。
  - `tablex` 会根据其 `columns` 参数自动将单元格排列成网格。
  - `cellx(...)` 用于创建具有特殊属性（如 `rowspan`, `colspan`）的单元格。
  - `hlinex()` 作为独立的参数，用于创建横跨整个表格的水平线。
]
