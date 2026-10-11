#import "../utils/style.typ": 字号, 字体

// 目录页
#let outline-page(
  fonts: (:),
  depth: 2,
) = {
  // 合并字体
  fonts = 字体 + fonts

  // 不可见标题（供 outline 检测用）
  let invisible-heading(..args) = {
    set text(size: 0pt, fill: white)
    heading(numbering: none, ..args)
  }

  // 新页（无页码）
  pagebreak(weak: true)
  set page(numbering: none)

  // 目录标题：黑体、三号、居中、加粗
  {
    set align(center)
    text(font: fonts.黑体, size: 字号.三号, weight: "bold", [目　　录])
    invisible-heading(level: 1, outlined: false, [目　　录])
  }

  // 目录缩进：一级 0pt，二级 2em
  set outline(indent: 2em)

  // 目录条目样式
  show outline.entry: entry => block(
    above: if entry.level == 1 { 25pt } else { 14pt },
    link(
      entry.element.location(),
      entry.indented(
        none,
        {
          text(
            font: if entry.level == 1 { fonts.黑体 } else { fonts.宋体 },
            size: if entry.level == 1 { 字号.四号 } else { 字号.小四 },
            {
              entry.body()
            },
          )
          box(
            width: 1fr,
            inset: (x: 0.25em),
            repeat([.], gap: 0.15em),
          )
          text(
            font: fonts.宋体,
            entry.page(),
          )
        },
      ),
    ),
  )

  // 渲染目录
  outline(title: none, depth: depth)
}
