// 三线表排版模块
// 提供 full（等宽列，适应跨页）和 small（自动列宽）两种三线表模板，符合学术论文表格规范

#import "../fonts/font-def.typ": *

#let three_line_table_full(values) = {
  let n-cols = values.at(0).len()
  let header-row = values.at(0)
  let data-rows = values.slice(1)

  table(
    columns: (1fr,) * n-cols, // 平均分配列宽，默认100%铺满
    stroke: none,
    align: center + horizon,
    
    // ★ 重点修复：这里必须使用 table.header() 函数，而不是 header: 命名参数
    table.header(
      // 顶部横线（使用0高度的block，压住页面顶边，跨页时自动复制，绝无重叠）
      table.cell(colspan: n-cols, inset: 0pt)[
        #block(width: 100%, stroke: (top: 1.5pt), height: 0pt, inset: 0pt)
      ],
      // 表头内容
      ..header-row,
      // 表头下的细线
      table.hline(stroke: 0.75pt)
    ),
    
    // 所有数据行（自动处理跨页断行，无需额外设置）
    ..data-rows.map(row => row).flatten(),
    
    // 表格最底部的粗线
    table.hline(stroke: 1.5pt)
  )
}

#let three_line_table_small(values) = {
  let n-cols = values.at(0).len()
  let header-row = values.at(0)
  let data-rows = values.slice(1)

  table(
    columns: (auto,) * n-cols,          // 自动适应列宽
    stroke: none,                       // 去除自带的细边框，用 hline 精确控制
    align: center + horizon,            // 表内文字水平垂直居中
    
    // 使用 table.header 包裹表头，保证跨页时表头自动在下一页顶部重复出现
    table.header(
      table.hline(stroke: 1.5pt),       // 表格最上方的粗线
      ..header-row,                     // 表头内容
      table.hline(stroke: 0.75pt)       // 表头下方的细线
    ),

    // 渲染所有数据行（使用 .flatten() 展开成平铺的参数）
    ..data-rows.map(row => row).flatten(),

    // 表格最下方的粗线
    table.hline(stroke: 1.5pt)
  )
}
