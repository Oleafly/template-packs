// 三线表模块
// 支持跨页，表头自动重复，续表标签自动显示

#let three-line-table(
  columns: (),
  inset: 10pt,
  top-stroke: 1.5pt,
  header-stroke: 0.75pt,
  header: (),
  caption: none,
  continued-label: none, // none 或 string（续表标签文本，如 "表 4-1 实验结果"）
  ..body,
) = {
  let n-cols = if type(columns) == array { columns.len() } else { 1 }

  if continued-label == none {
    // 原有逻辑：无续表标签
    table(
      columns: columns,
      inset: inset,
      stroke: none,
      table.hline(stroke: top-stroke),
      table.header(
        ..header,
        table.hline(stroke: header-stroke),
      ),
      ..body.pos().flatten(),
      table.hline(stroke: top-stroke),
    )
  } else {
    // 续表逻辑：将续标签集成到 table.header，利用 header 自动重复机制
    let st = state("tlt-cont-" + continued-label, false)
    table(
      columns: columns,
      inset: inset,
      stroke: none,
      table.header(
        // 续表标签行：首页 v(-0.9em) 折叠隐藏，续页右对齐显示
        table.cell(colspan: n-cols, {
          context {
            if st.get() {
              set text(font: ("Times New Roman", "SimSun"), size: 10.5pt, weight: "bold")
              align(right, strong[#continued-label（续）])
            } else {
              v(-0.9em)
              st.update(true)
            }
          }
        }),
        // 顶线（移入 header 保持在每页重复）
        table.hline(stroke: top-stroke),
        // 实际表头
        ..header,
        table.hline(stroke: header-stroke),
      ),
      ..body.pos().flatten(),
      table.hline(stroke: top-stroke),
    )
  }
}

// 续表标签（已弃用，请使用 three-line-table 的 continued-label 参数）
// 保留此函数仅为向后兼容。新代码推荐：
//   #three-line-table(..., continued-label: "表 X-X 标题")
// 注意：此函数使用全局状态，同一文档同时只有一个表格可使用
#let continuable(label) = {
  let st = state("continuable-page", 0)
  context {
    let cur = here().page()
    let start = st.get()
    if start == 0 {
      st.update(cur)
      []
    } else if cur != start {
      block(above: 0pt, below: 6pt, inset: (x: 0pt))[
        #set text(font: ("Times New Roman", "SimSun"), size: 10.5pt, weight: "bold")
        #align(center, strong[#label（续）])
      ]
    } else {
      []
    }
  }
}
