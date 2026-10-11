#let setup(title: "调研报告", doc) = {
  set document(title: title)
  set page(numbering: "1", number-align: center)
  set heading(numbering: "1.")

  align(center)[
    #block(text(weight: 700, 1.75em, title))
  ]

  set par(justify: true)

  // 代码块：浅灰底 + 顶部高亮条 + 圆角（仿 GitHub）
  show raw.where(block: true): block.with(
    fill: rgb("#f6f8fa"),
    inset: (x: 1em, y: 0.7em),
    radius: 0.35em,
    stroke: (top: 0.25em + rgb("#4c8bf5")),
  )
  // 行内代码：浅色底衬 + 圆角
  show raw.where(block: false): box.with(
    fill: rgb("#f6f8fa"),
    inset: (x: 0.5em, y: 0.3em),
    radius: 0.2em,
  )

  // 代码型图（figure.kind 为 raw）使用“代码”作为编号前缀
  show figure.where(kind: raw): set figure(supplement: "代码")

  set outline(title: "目录")

  doc
}

