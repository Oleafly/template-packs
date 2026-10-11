#import "@preview/pointless-size:0.1.2": zh

#let table_setup(doc) = {
  // 表格上下间距
  show figure.where(kind: table): set block(above: 2em, below: 1em)

  // 允许 figure 跨页打破，实现续表的必要条件
  show figure.where(kind: table): set block(breakable: true)

  // 表格标题在上方
  show figure.where(kind: table): set figure.caption(position: top)

  // 标题和表格之间的间距
  show figure.where(kind: table): set figure(gap: 0.2em)

  // 表格样式预设
  show table: set table(
    inset: 0.6em, // 单元格内边距
    align: center + horizon, // 内容中
  )

  // 自动编号
  show figure.where(kind: table): set figure(
    supplement: "表",
    numbering: n => context {
      let h1 = counter(heading).get().first()
      numbering("1-1", h1, n)
    }
  )

  // 章节切换时重置表格计数器
  show heading.where(level: 1): it => {
    counter(figure.where(kind: table)).update(0)
    it
  }

  // 设置标题样式
  show figure.caption.where(kind: table): set text(size: zh("五号"))
  show figure.caption.where(kind: table): it => {
    set align(center)
    it
  }

  doc
}

// 定义三线表预设函数
#let table-3line(
  caption: none,
  columns: none,
  headers: (),
  tab_align: center + horizon,
  stroke_thick: 1.5pt,
  stroke_thin: 0.5pt,
  ..cells
) = {
  // 计算列数和宽度预设
  let col_count = if type(columns) == int { columns } else if columns == none { headers.len() } else { columns.len() }
  let cols = if type(columns) == int { (1fr,) * columns } else if columns == none { (1fr,) * headers.len() } else { columns }

  // 使用大括号创建一个局部作用域，确保内部的 context 和样式不外泄
  {
    figure(
      caption: caption,
      kind: table,
      context {
        // 捕获当前表格起始页码
        let start_page = here().page()
        
        // 局部获取当前编号，避免使用 query 导致的跨表污染
        let h1 = counter(heading).get().first()
        let n = counter(figure.where(kind: table)).get().first()
        let fig_num = [#h1\-#n]

        table(
          columns: cols,
          stroke: none,
          align: tab_align,
          // 表头样式
          table.header(
            repeat: true,
            // 续表逻辑：利用 colspan 覆盖全行，仅在非首页显示
            table.cell(colspan: col_count, stroke: none, inset: (top: 0em, bottom: 0.6em))[
              #context {
                if here().page() > start_page {
                  set text(size: zh("五号"), weight: "regular")
                  align(right)[表 #fig_num 续表]
                }
              }
            ],
            // 顶部粗线
            table.hline(stroke: stroke_thick),
            ..headers.map(h => strong(h)),
            // 表头下方细线
            table.hline(stroke: stroke_thin)
          ),
          ..cells,
          // 底部粗线
          table.hline(stroke: stroke_thick)
        )
      }
    )
  }
}