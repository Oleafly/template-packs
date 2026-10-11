// 元素

#import "colors.typ": *
#import "@preview/showybox:2.0.4": showybox
#import "@preview/mannot:0.3.1": markrect

/// 无编号公式
#let nonum(eq) = math.equation(block: true, numbering: none, eq)

/// 通用彩色盒子 - 使用预定义背景色
#let colored-box(it, color, bg-color: none, width: auto) = {
  let bg = if bg-color != none { bg-color } else { color.lighten(85%) }
  context {
    showybox(
      it,
      frame: (
        inset: (x: 0.6em, y: 0.65em),
        border-color: color,
        body-color: bg,
        radius: 0pt,
      ),
      width: width,
    )
    v(-0.1em)
  }
}

/// 蓝色盒子 - 莫兰迪蓝
#let box-blue(it, width: auto) = colored-box(it, morandi-blue, bg-color: bg-blue, width: width)

/// 绿色盒子 - 莫兰迪绿
#let box-green(it, width: auto) = colored-box(it, morandi-green, bg-color: bg-green, width: width)

/// 红色盒子 - 莫兰迪珊瑚（更温暖）
#let box-red(it, width: auto) = colored-box(it, morandi-coral, bg-color: bg-coral, width: width)

/// 紫色盒子 - 莫兰迪紫
#let box-purple(it, width: auto) = colored-box(it, morandi-purple, bg-color: bg-purple, width: width)

/// 青色盒子 - 莫兰迪青
#let box-teal(it, width: auto) = colored-box(it, morandi-teal, bg-color: bg-teal, width: width)

/// 橙色盒子 - 莫兰迪橙
#let box-orange(it, width: auto) = colored-box(it, morandi-orange, bg-color: bg-orange, width: width)

/// 黄色盒子 - 莫兰迪黄
#let box-yellow(it, width: auto) = colored-box(it, morandi-yellow, bg-color: bg-yellow, width: width)

// 保留旧名称兼容
#let box-cyan = box-teal

/// Beamer 风格块
#let beamer-block(value, color: primary) = {
  let margin = -0.3em
  v(margin)
  let mar = 0.25em
  pad(left: mar)[
    #block(
      fill: bg-card,
      inset: (x: 0.6em, y: 0.6em),
      outset: 0em,
      stroke: (left: mar + color)
    )[#value]
  ]
  v(margin)
}

/// 圆角高亮盒子
#let boxed(it, x: 0.3em) = {
  let xmar2 = x - 0.02em
  h(xmar2)
  markrect(outset: (x: x, y: 0.35em), fill: bg-yellow)[#it]
  h(xmar2)
}

/// 蓝色加粗文本
#let Blue(it) = text(fill: morandi-blue)[*#it*]

/// 绿色加粗文本
#let Green(it) = text(fill: morandi-green)[*#it*]

/// 珊瑚色加粗文本
#let Coral(it) = text(fill: morandi-coral)[*#it*]

/// 紫色加粗文本
#let Purple(it) = text(fill: morandi-purple)[*#it*]

/// 高亮文本
#let highlight-text(x, color: morandi-coral, bg: bg-yellow) = {
  highlight(fill: bg)[#text(x, fill: color)]
}

/// 蓝色编号
#let blue-num(it) = text(fill: morandi-blue)[*#it*]

/// 圆圈数字列表项
#let List(i, fill: morandi-blue) = {
  let nums = ("①", "②", "③", "④", "⑤", "⑥", "⑦", "⑧", "⑨", "⑩")
  let it = if type(i) == int { nums.at(i - 1) } else { i }
  text(fill: fill)[*#it*]
}

/// 深灰圆圈数字列表项
#let List-black(i) = List(i, fill: text-secondary)

/// 参考文献列表样式
#let ref-list(..it, size: 11.5pt) = {
  show table.cell: it => {
    set text(size: size, fill: text-primary)
    set par(spacing: 1.4em, leading: 0.9em)
    it
  }

  v(-0.4em)
  table(
    columns: (0.68cm, 1fr),
    rows: auto,
    align: (top + left, top),
    stroke: 0pt,
    inset: (x: 0pt, y: 6.5pt),
    ..it
  )
  v(-0.4em)
}

/// 表格行高辅助函数
#let row-height(margin: 0.1em) = {
  it => { v(margin); it; v(margin) }
}

/// 表格边框样式
#let frame(stroke) = {
  (x, y) => (
    left: 0pt,
    right: 0pt,
    top: if y < 2 { stroke } else { 0.5pt + border-light },
    bottom: stroke
  )
}

/// 分隔线
#let divider(color: border-light, thickness: 0.6pt) = {
  v(0.6em)
  line(length: 100%, stroke: thickness + color)
  v(0.6em)
}

/// 信息卡片
#let info-card(title, body, color: morandi-blue) = {
  let bg = if color == morandi-blue { bg-blue }
           else if color == morandi-green { bg-green }
           else if color == morandi-coral { bg-coral }
           else if color == morandi-purple { bg-purple }
           else if color == morandi-teal { bg-teal }
           else { bg-blue }

  block(
    fill: bg,
    inset: (x: 0.7em, y: 0.55em),
    stroke: 0.6pt + color.lighten(25%),
  )[
    #text(fill: color, weight: "semibold")[#title]
    #v(-0.25em)
    #text(fill: text-secondary, size: 0.95em)[#body]
  ]
}

/// 标签
#let tag(label-text, color: morandi-blue) = {
  let bg = if color == morandi-blue { bg-blue }
           else if color == morandi-green { bg-green }
           else if color == morandi-coral { bg-coral }
           else if color == morandi-purple { bg-purple }
           else if color == morandi-teal { bg-teal }
           else { bg-blue }

  box(
    fill: bg,
    inset: (x: 0.5em, y: 0.2em),
    stroke: none,
  )[#text(fill: color, size: 0.9em)[#label-text]]
}
