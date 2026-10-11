#import "@preview/pointless-size:0.1.2": zh

// 目录
#let outline_with_sizes(depth: 3, font_sizes: ()) = {
  assert(depth == font_sizes.len(), message: "字体大小数组长度必须与目录深度相等")

  show outline.entry: it => {
    if it.level <= depth and it.level <= font_sizes.len() {
      let size = font_sizes.at(it.level - 1)
      let weight = if it.level == 1 { "bold" } else { "regular" }
      let stroke = if it.level == 1 { 0.01em } else { none }
      v(0.4em)
      text(font: "SimHei", size: size, weight: weight, it, stroke: stroke)
    } else {
      it
    }
  }

  align(center, text(font: "SimHei", zh(2), stroke: 0.02em)[目 ~ 录])

  v(-1em)

  align(center, box(
    outline(
      title: none,
      indent: auto,
      depth: depth,
    ),
  ))
  pagebreak()
}
