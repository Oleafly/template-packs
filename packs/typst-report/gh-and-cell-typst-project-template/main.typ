// 双斜杠开头的行是注释，编译时会被忽略
// ========================= 全局变量 =========================
#let SongTi = ("Times New Roman", "Source Han Serif SC")
#let KaiTi = ("Times New Roman", "KaiTi")
#let FZXBSong = ("FZXiaoBiaoSong-B05S")
// ===========================================================


// ======================== 基础配置 ========================
#import "@preview/pointless-size:0.1.2": zh
#set text(
  region: "CN", lang: "zh",
  font: ("Times New Roman", "SimSun"),  // 西文使用 Times New Roman，中文使用 宋体
  size: zh(-4)  // 字号为小四
)
#import "@preview/cuti:0.4.0": show-cn-fakebold
#show: show-cn-fakebold  // 伪粗体，为宋体等只有一个字重的字体实现粗体效果。如果使用的字体有多个字重，可以注释掉这两行，避免影响本身粗体字体的显示效果。

#set par(
  first-line-indent: (amount: 2em, all: true),  // 首行缩进2字符
  justify: true  // 两端对齐
)
#import "@preview/cjk-unbreak:0.2.2": remove-cjk-break-space
#show: remove-cjk-break-space  // 去掉单个换行产生的空格
// ===========================================================


// ===================== 公式图表样式和编号 =======================
#show figure.where(kind: table): set figure.caption(position: top)  // 表格的标题放在表格上方
#show figure: set block(breakable: true)  // 表格可以跨页
#show figure.where(kind: image): set block(sticky: true)

#show figure.caption: set text(font: KaiTi, size: zh(5))

#import "@preview/i-figured:0.2.4"
#show figure.where(kind: table): it => i-figured.show-figure(it, numbering: "1-1")
#show figure.where(kind: image): it => i-figured.show-figure(it, numbering: "1-1")
#show figure.where(kind: raw): it => i-figured.show-figure(it, numbering: "1-1")
#show math.equation: it => i-figured.show-equation(it, numbering: "(1-1)")
#show heading: i-figured.reset-counters

// #import "@preview/mitex:0.2.6": *  // LaTeX 格式转换
// ===========================================================


// ===================== 标题样式和编号 =======================
#set heading(numbering: "1.1 ")  // 简单的标题编号
/* 复杂的标题编号
#import "@preview/numbly:0.1.0": numbly  
#set heading(numbering: numbly(
  "{1:一}、",
  "{1:1}.{2:1}",
  "{1:1}.{2:1}.{3:1}",
  "{1:1}.{2:1}.{3:1}.{4:1}",
  "({5:1})",
  "{6:①}"
))
*/
#let heading_kwargs = (above: 1em, below: 1em, sticky: true)
#show heading.where(level: 1): it => block(
    text(size: zh(3), font: SongTi, weight: "black", it),
    ..heading_kwargs
)
#show heading.where(level: 2): it => block(
    text(size: zh(4), font: SongTi, weight: "black", it),
    ..heading_kwargs
)
// ===========================================================


// ========================= 绘图 ============================
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge, shapes
#import "@preview/lilaq:0.5.0" as lq
// ===========================================================


// ========================= 表格 ============================
#import "@preview/tablex:0.0.9": tablex, rowspanx, colspanx
// ===========================================================


// ======================= 代码样式 ===========================
#show raw: set text(font: "Maple Mono NF")
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#show: codly-init.with()
#codly(languages: codly-languages)

#show raw.where(block: false): it => box(
  fill: rgb("#eeeeee"),
  inset: 2pt,
  radius: 2pt,
  baseline: 15%,
  text(it.text)
)
// ===========================================================


