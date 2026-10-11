#import "../template/template.typ":*

= 一级标题
== 表格
#tbl(
  table(
    columns: (1fr,)*3,
    align: center+horizon,
    stroke: none,
    table.hline(stroke: 1.5pt),
    table.header()[标题1][标题2][标题3],
    table.hline(stroke: 0.8pt),
    [内容1],[内容2],[内容3],
    [内容4],[内容5],[内容6],
    [内容7],[内容8],[内容9],
    table.hline(stroke: 1.5pt)
  ),caption: "表标题"
)
== 图片
#img(
  image("../figures/磁力线.png",width: 60%),caption: "图片标题"
)
== 数学公式
#equation(
  $
  E = m c^2
  $
)
#equation(
  $
    cases(
      x=1,
      y=2,
    )
  $
)
== 代码块
#code(
  ```typ
  #tbl(
    table(
      columns: (1fr,)*3,
      align: center+horizon,
      stroke: none,
      table.hline(stroke: 1.5pt),
      table.header()[标题1][标题2][标题3],
      table.hline(stroke: 0.8pt),
      [内容1],[内容2],[内容3],
      table.hline(stroke: 1.5pt)
    ),caption: "表标题"
  )
  ```
  ,caption: "代码说明"
)
== 参考文献引用
#lorem(50)#cite(<wx1>)