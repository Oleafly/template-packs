// 样式

#import "colors.typ": *

/// 设置紧凑段落
#let par-compact(it, spacing: 1.24em, leading: 1em) = {
  set par(spacing: spacing, leading: leading)
  it
}

/// 标题样式配置
#let configure-heading(it) = {
  // 一级标题：莫兰迪蓝，较大间距
  show heading.where(level: 1): it => {
    set text(fill: primary, weight: "medium")
    set par(leading: 1.0em, spacing: 1.24em)
    show "、": [、#h(0.2em)]
    show "，": [，#h(0.2em)]
    v(0.55em)
    it.body
    v(0.15em)
  }

  // 二级标题：深灰，加粗
  show heading.where(level: 2): it => {
    set text(fill: text-primary, weight: "semibold")
    it
    v(0.3em)
  }

  // 三级标题：次要色
  show heading.where(level: 3): it => {
    set text(fill: text-secondary, weight: "medium")
    it
    v(0.2em)
  }

  // 四级及以下标题
  show heading.where(level: 4): it => {
    set text(fill: text-secondary, weight: "regular")
    it
    v(0.15em)
  }

  show heading.where(level: 5): it => {
    set text(fill: text-muted, weight: "regular")
    it
    v(0.1em)
  }
  it
}

/// 列表样式配置
#let configure-list() = {
  set list(indent: 1em)
  show list: it => {
    let space = -0.12em
    v(space)
    it
    v(space)
  }
}

/// 表格样式配置
#let configure-table() = {
  let frame(stroke) = (x, y) => (
    left: 0pt,
    right: 0pt,
    top: if y < 2 { 0.8pt + stroke } else { 0.5pt + border-light },
    bottom: 0.8pt + stroke,
  )

  set table(
    stroke: frame(border),
    align: (x, y) => if x > 0 { center } else { left }
  )
}

/// 设置表格字号
#let set-table-fontsize(it, size: 10.5pt) = {
  show table.cell: it => {
    set text(size: size, weight: "regular")
    set par(spacing: 0.7em, leading: 0.5em)
    it
  }
  it
}

/// 表格注释样式
#let table-note(it) = {
  v(-0.35em)
  set text(size: 11pt, fill: text-secondary)
  set par(spacing: 1.0em, leading: 0.8em)
  it
}

/// 显示表格中的数学公式（带字号控制）
#let show-table-math(it, size: 10pt) = {
  show table.cell.where(y: 0): it => {
    set text(size: 11.5pt, fill: text-primary)
    it
  }

  show table: it => {
    set text(size: 11pt)
    set par(spacing: 0.8em, leading: 0.75em)
    it
  }

  show math.equation: set text(size: 10.5pt)
  set text(size: size)
  it
}

/// 引用块样式
#let configure-quote() = {
  show quote: it => {
    set text(fill: text-secondary, style: "italic")
    block(
      fill: bg-light,
      inset: (x: 0.8em, y: 0.5em),
      stroke: (left: 3pt + morandi-teal),
    )[#it]
  }
}
