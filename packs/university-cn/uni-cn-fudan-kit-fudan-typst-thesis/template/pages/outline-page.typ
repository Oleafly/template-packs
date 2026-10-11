// ============================================================
// 复旦大学学位论文 Typst 模板 - 目录页
// ============================================================

#import "../config.typ": *

// 默认 outline 会在清单当前位置重新求值自定义编号，导致章号变成 0。
// 这里在每个图表自身的位置读取章节与图表计数器。
#let figure-outline-entry(entry, kind: image, supplement: [图]) = {
  let location = entry.element.location()
  let chapter = counter(heading).at(location).first()
  let ordinal = counter(figure.where(kind: kind)).at(location).first()
  let prefix = if appendix-mode.at(location) { numbering("A", chapter) } else { str(chapter) }
  let number-text = prefix + "-" + str(ordinal)

  link(
    location,
    entry.indented(
      [#supplement #number-text],
      {
        entry.body()
        [ ]
        text(luma(100), box(width: 1fr, repeat[.]))
        [ ]
        entry.page()
      },
    ),
  )
}

// 目录页
#let outline-page(depth: 3) = {
  set text(font: font-family.宋体, size: font-size.小四)
  set par(leading: 1.5em)

  outline(
    title: none,
    depth: depth,
    indent: auto,
  )
}

// 插图目录
#let list-of-figures-page() = {
  set text(font: font-family.宋体, size: font-size.小四)
  set par(leading: 1.5em)
  show outline.entry: it => figure-outline-entry(it, kind: image, supplement: [图])

  outline(
    title: none,
    target: figure.where(kind: image),
  )
}

// 表格目录
#let list-of-tables-page() = {
  set text(font: font-family.宋体, size: font-size.小四)
  set par(leading: 1.5em)
  show outline.entry: it => figure-outline-entry(it, kind: table, supplement: [表])

  outline(
    title: none,
    target: figure.where(kind: table),
  )
}
