// ============================================================
//  作图
//    cetz       —— 通用矢量绘图（受力图、光路图、几何示意）
//    cetz-plot  —— 函数图 / 数据图
//    fletcher   —— 节点-箭头图（流程图、能级图、交换图）
// ============================================================

#import "@preview/cetz:0.4.2"
#import "@preview/cetz-plot:0.1.2"
#import "@preview/fletcher:0.5.8"

// fletcher 最常用的三个直接放出来
#import "@preview/fletcher:0.5.8": diagram, edge, node

#import "theme.typ": fonts, palette

// 画布：统一了字体和线宽，画出来的图跟正文风格一致。
// 用法：
//   #canvas({
//     import cetz.draw: *
//     line((0,0), (2,1), mark: (end: "stealth"))
//   })
#let canvas(body, length: 1cm, ..args) = {
  set text(font: fonts.serif, size: 9pt)
  cetz.canvas(length: length, ..args, body)
}

// 画个坐标轴，省得每次重写。
// 用法：#canvas({ import cetz.draw: *; axes(x: 3, y: 2) })
#let axes(x: 3, y: 2, xlabel: $x$, ylabel: $y$, origin: (0, 0)) = {
  import cetz.draw: content, line
  let (ox, oy) = origin
  line((ox, oy), (ox + x, oy), mark: (end: "stealth", fill: black, scale: 0.6))
  line((ox, oy), (ox, oy + y), mark: (end: "stealth", fill: black, scale: 0.6))
  content((ox + x + 0.25, oy), xlabel)
  content((ox, oy + y + 0.25), ylabel)
}

// cetz 里画箭头（矢量）的常用配置
#let arrow-style = (end: "stealth", fill: black, scale: 0.6)
