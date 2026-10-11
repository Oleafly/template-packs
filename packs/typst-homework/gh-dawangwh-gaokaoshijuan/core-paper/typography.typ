#import "config.typ": *

// =============================================================================
// 🌟 1. 初始化全局状态机 (State Engine)
// =============================================================================
#let paper-config-state = state("paper-config", config-default)

// 深合并：默认配置打底，卷配置覆盖；字典递归合并，数组/其他类型整体替换
#let _merge-config(base, extra) = {
  let out = (: ..base)
  for (k, v) in extra {
    if type(v) == dictionary and type(out.at(k, default: (:))) == dictionary {
      out.insert(k, _merge-config(out.at(k), v))
    } else {
      out.insert(k, v)
    }
  }
  out
}

#let set-paper-config(updates) = paper-config-state.update(old => _merge-config(old, updates))

// =============================================================================
// 2. Document setup (文档初始化)
// =============================================================================
#let apply-paper-config(doc) = context {
    let config = paper-config-state.get()
  set page(
    paper: config.page.paper,
    flipped: config.page.flipped,
    margin: config.page.margin,
    footer: if config.footer.autofooter != false {
      // 自动页脚：页码用实际生成的页数，subject/间距来自 config.footer
      context {
        let cur = counter(page).get().first()
        let total = counter(page).final().first()
        let footer-config = paper-config-state.get().footer
        align(center + horizon)[
          #text(size: footer-config.size)[#(footer-config.subject) 试题第 #cur 页（共 #total 页）]
        ]
      }
    } else { none },
    footer-descent: config.footer.bottom-gap,
  )
  set text(font: config.typography.fonts, size: config.typography.size)
  doc
}


// =============================================================================
// 3. Layout primitives (基础排版组件)
// =============================================================================
#let spread-layout(left, right) = layout(size => context {
  let config = paper-config-state.get()
  let half-gutter = config.page.spread-gutter / 2
  grid(
    columns: (1fr, auto, 1fr),
    column-gutter: (half-gutter, half-gutter),
    block(height: size.height)[#left],
    box(width: config.page.spread-line-stroke, height: size.height)[
      #place(center + horizon)[
        #line(length: size.height, angle: 90deg, stroke: config.page.spread-line-stroke)
      ]
    ],
    block(height: size.height)[#right],
  )
})

#let _hanging-row(label, gap-width: auto, gutter: 0em, body) = context {
  let config = paper-config-state.get()
  let final-width = if gap-width == auto { config.typography.label-width } else { gap-width }
  grid(
    columns: (final-width, 1fr),
    column-gutter: gutter,
    [#label], [#body],
  )
}

#let _cn-paragraph(body, size: auto, leading: auto) = context {
  let config = paper-config-state.get()
  let final-size = if size == auto { config.typography.size } else { size }
  let final-leading = if leading == auto { config.typography.leading } else { leading }

  set text(size: final-size)
  set par(
    leading: final-leading,
    spacing: final-leading,
    justify: true,
    first-line-indent: (amount: config.typography.first-line-indent, all: true),
  )
  body
}

#let _styled-block(
  body,
  above: auto,
  below: auto,
  inset: auto,
  size: auto,
  leading: auto,
  justify: true,
) = context {
  let config = paper-config-state.get()
  let final-above = if above == auto { 0pt } else { above }
  let final-below = if below == auto { 0pt } else { below }
  let final-inset = if inset == auto { 0pt } else { inset }
  let final-size = if size == auto { config.typography.size } else { size }
  let final-leading = if leading == auto { config.typography.leading } else { leading }

  block(above: final-above, below: final-below, inset: final-inset)[
    #set text(size: final-size)
    #set par(leading: final-leading, spacing: final-leading, justify: justify)
    #body
  ]
}

#let _question-stem(
  label,
  body,
  above: auto,
  width: auto,
  leading: auto,
) = context {
  let config = paper-config-state.get()

  // 老老实实地进行参数兜底检查
  let final-above = if above == auto { config.typography.item-above } else { above }
  let final-width = if width == auto { config.typography.label-width } else { width }
  let final-leading = if leading == auto { config.typography.leading } else { leading }

  // 调用底层的 _styled-block 和 _hanging-row 组件
  _styled-block(
    above: final-above,
    leading: final-leading,
  )[
    #_hanging-row(label, body, gap-width: final-width)
  ]
}

#let _option-columns(cols) = {
  if cols == 2 { (1fr, 1fr) } else if cols == 4 { (1fr, 1fr, 1fr, 1fr) } else { cols }
}


// =============================================================================
// 4. Header & notes (头部与注意事项)
// =============================================================================
#let paper-header(secret-label: auto, exam-title: auto, subject-title: auto, title-above: auto) = context {
  let config = paper-config-state.get()

  let label   = if secret-label  == auto { config.header.secret-label }   else { secret-label }
  let title   = if exam-title    == auto { config.header.exam-title }      else { exam-title }
  let subject = if subject-title == auto { config.header.subject-title }   else { subject-title }
  let above   = if title-above   == auto { config.header.title-above-gap } else { title-above }


  block()[
    #if label != [] [#block()[#align(left)[#strong[#label]]]]
    #if title != [] [#block(above: above)[#box(width: 100%)[#align(center)[#text(size: config.header.title-size)[#title]]]]]
    #if subject != [] [#block(above: above)[#box(width: 100%)[#align(center)[#text(size: config.header.subject-size, weight: "bold")[#subject]]]]]
  ]
}

#let notice(body, font-size: auto, leading: auto) = context {
  let config = paper-config-state.get()
  let final-size = if font-size == auto { config.notice.size } else { font-size }
  let final-leading = if leading == auto { config.typography.leading } else { leading }

  block(above: config.typography.item-above)[
    #set text(size: final-size)
    #set par(leading: final-leading, spacing: 0pt, justify: false)
    #body
  ]
}

#let notice-title(body) = context {
  let config = paper-config-state.get()
  let weight = config.notice.weight
  text(weight: weight)[#body]
}

#let notice-item(n, body, above: auto, width: auto) = context {
  let config = paper-config-state.get()
  let final-above = if above == auto { config.typography.item-above } else { above }
  let final-width = if width == auto { config.typography.label-width } else { width }
  let final-weight = config.notice.weight

  block(above: final-above)[
    #set text(weight: final-weight)
    #_hanging-row(str(n) + ".", gap-width: final-width, body)
  ]
}

// 卷首区（本试卷共… / 使用范围… 等自由文本块）：参考注意事项排版
// 字号沿用 config.notice.size，字重由 config.cover.weight 控制（默认 bold）
#let cover-meta(body, font-size: auto, weight: auto, leading: auto, spacing: auto) = context {
  let config = paper-config-state.get()
  let final-size = if font-size == auto { config.notice.size } else { font-size }
  let final-weight = if weight == auto { config.cover.weight } else { weight }
  let final-leading = if leading == auto {
    if config.cover.leading == auto { config.typography.leading } else { config.cover.leading }
  } else { leading }
  let final-spacing = if spacing == auto {
    if config.cover.spacing == auto { final-leading } else { config.cover.spacing }
  } else { spacing }

  block(above: config.typography.item-above)[
    #set text(size: final-size, weight: final-weight)
    #set par(leading: final-leading, spacing: final-spacing, justify: false)
    #body
  ]
}

// 附图网格（多图多行多列）：间距从 config.figure 读取，禁止装配现场硬编码
// cells 为内容数组，每个元素是 grid 的一个单元格；
// columns：整数 = 等宽 N 列（缺省一行排完）；比例列表 = 自定义列宽（如 (1fr, 2fr, 2fr, 1fr) 居中 2 图）
#let figure-grid(cells, columns: auto, above: auto, column-gutter: auto, row-gap: auto) = context {
  let config = paper-config-state.get()
  let final-above = if above == auto { config.figure.above } else { above }
  let final-gutter = if column-gutter == auto {
    config.figure.column-gutter
  } else { column-gutter }
  let final-row-gap = if row-gap == auto {
    config.figure.row-gap
  } else { row-gap }
  let final-cols = if columns == auto {
    (1fr,) * cells.len()
  } else if type(columns) == int {
    (1fr,) * columns
  } else {
    columns
  }

  block(above: final-above)[
    #grid(
      ..cells,
      columns: final-cols,
      column-gutter: final-gutter,
      row-gutter: final-row-gap,
    )
  ]
}


// =============================================================================
// Sections (章节标题)
// =============================================================================
#let Q-section(title, above: auto) = context {
  let config = paper-config-state.get()
  let final-above = if above == auto { config.typography.par-above } else { above }

  block(above: final-above)[
    #set par(leading: config.typography.leading)
    #strong(title)
  ]
}

// =============================================================================
// Choice questions (选择题)
// =============================================================================

// 选择题题干：直接复用 _question-stem
#let Q-choice(n, body) = _question-stem(str(n) + ".", body)

// 选择题选项网格
#let Q-options(
  cols,
  body,
  above: auto,
  leading: auto,
  column-gap: auto,
  row-gap: auto,
) = context {
  let config = paper-config-state.get()

  // 局部参数优先，否则从 state 中读取
  let final-above = if above == auto { config.typography.item-above } else { above }
  let final-leading = if leading == auto { config.typography.leading } else { leading }
  let final-col-gap = if column-gap == auto { config.options.column-gap } else { column-gap }
  let final-row-gap = if row-gap == auto { config.options.row-gap } else { row-gap }

  _styled-block(
    above: final-above,
    inset: (left: config.typography.label-width), // 选项左侧缩进，与题号对齐
    leading: final-leading,
    justify: false,
  )[
    #grid(
      columns: _option-columns(cols),
      gutter: (final-col-gap, final-row-gap),
      ..body, // 注意：这里假设 body 传入的是数组，所以可以用 ..body 展开
    )
  ]
}

// 表格归一化：统一 1fr 等宽列、表头加粗；默认参数写死（不读 config），单表可覆盖
// header 缺省空 = 无表头；rows 为内容数组的数组
#let Q-table(
  rows: (),
  header: (),
  columns: auto,   // 缺省 auto = 按内容列宽（表格收缩）；传 1fr 等宽或比例列表可覆盖
  inset: auto,    // 单元格内边距，缺省 (x: 8pt, y: 5pt)
  stroke: auto,   // 边框，缺省 0.5pt
  above: auto,    // 块上边距，缺省 = 全局 config.typography.item-above
  below: auto,    // 块下边距，缺省 1.5em
  indent: auto,   // 左侧缩进，缺省 2em
  leading: auto,  // 行距，缺省 1.2em
) = context {
  let config = paper-config-state.get()
  let ncols = calc.max(header.len(), ..rows.map(r => r.len()))
  let final-cols = if columns == auto {
    (auto,) * ncols
  } else if type(columns) == array {
    columns
  } else {
    (columns,) * ncols
  }
  let final-inset = if inset == auto { (x: 8pt, y: 5pt) } else { inset }
  let final-stroke = if stroke == auto { 0.5pt } else { stroke }
  let final-above = if above == auto { config.typography.item-above } else { above }
  let final-below = if below == auto { 1.5em } else { below }
  let final-indent = if indent == auto { 2em } else { indent }
  let final-leading = if leading == auto { 1.2em } else { leading }

  block(
    above: final-above,
    below: final-below,
    inset: (left: final-indent),
  )[
    #set par(leading: final-leading)
    #table(
      columns: final-cols,
      inset: final-inset,
      stroke: final-stroke,
      ..(if header.len() > 0 { (table.header(..header),) } else { () }),
      ..rows.flatten(),
    )
  ]
}

// =============================================================================
// Fill-in questions (填空题)
// =============================================================================

// 填空题题干：同样复用 _question-stem
#let Q-fill-blank(n, body) = _question-stem(str(n) + ".", body)

// 填空下划线：从 state 中读取宽度
#let Q-blank-line(width: auto) = context {
  let config = paper-config-state.get()
  let final-width = if width == auto { config.blank-width } else { width }

  box(width: final-width, line(length: 100%))
}

// =============================================================================
// Solution questions (解答题)
// =============================================================================
// 整题容器：标题 + 正文一体；正文直接纯文本分段（first-line-indent all:true 自动缩进），表格内联
#let Q-answer(n, score, body, above: auto, width: auto) = context {
  let config = paper-config-state.get()
  let final-above = if above == auto { config.typography.par-above } else { above }
  let final-width = if width == auto { config.typography.label-width } else { width }

  _styled-block(above: final-above)[
    #_hanging-row(str(n) + ".", [（#str(score) 分）], gap-width: final-width)
    #block(above: config.typography.item-above)[
      #_cn-paragraph(body)
    ]
  ]
}

// 通用带图排版：任意题型（选择题/填空题/解答题）的内容都可作为 content 传入，图默认右对齐在右侧
#let Q-with-figure(
  content,
  figure,
  above: auto,
  columns: auto,
  figure-inset: auto,
) = context {
  let config = paper-config-state.get()
  let final-above = if above == auto { config.typography.item-above } else { above }
  let final-cols = if columns == auto { (1.4fr, 0.6fr) } else { columns }
  let final-inset = if figure-inset == auto { 0pt } else { figure-inset }

  block(above: final-above)[
    #grid(
      columns: final-cols,
      content,
      block(width: 100%, inset: final-inset)[#align(right)[#figure]]
    )
  ]
}

// =============================================================================
// 不确定 / 错误标记
// =============================================================================
// kind ∈ ("公式", "文字", "结构", "图")；severity ∈ ("error", "uncertain")
// error → 红字"XX待校对"（不能交付，必须修复或人工确认）
// uncertain → 黄字"XX待确认"（可交付，但需人工过目）
#let uncertain(kind, severity: "uncertain", body: []) = [
  #text(
    fill: if severity == "error" { red } else { yellow.darken(30%) },
    weight: "bold",
  )[#kind#(if severity == "error" { "待校对" } else { "待确认" })]
  #if body != [] [#h(0.3em)#body]
]

// =============================================================================
// Footer (页脚)
// =============================================================================
#let paper-footer(page-num, subject: auto, total: auto) = context {
  let config = paper-config-state.get()
  let final-subject = if subject == auto { config.footer.subject } else { subject }
  let final-total = if total == auto { config.footer.total-pages } else { total }

  [
    #v(1fr)
    #align(center)[#final-subject 试题第 #page-num 页（共 #final-total 页）]
  ]
}
