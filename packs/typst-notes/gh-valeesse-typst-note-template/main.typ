// main.typ

#import "@preview/zh-kit:0.1.0": *
// =============================================
// 1. 导入
// =============================================
// 导入模板中定义的所有内容 (函数、样式等)
#import "template.typ": *
#import datetime: today

#show: doc => setup-base-fonts(
  doc,
  cjk-serif-family: ("LXGW WenKai", "Source Han Serif SC", "SimSun"), // 优先使用霞鹜文楷 SC
  first-line-indent: 2em, // 设置首行缩进为2个字符宽度
)
// =============================================
// 2. 封面
// =============================================
// 封面内容独立于正文样式之外
#set document(title: "公考核心笔记", author: "你的名字")

#align(center)[
  #text(size: 2em, weight: "bold")[核心笔记]
  #v(2em)
  #text(size: 1.2em)[你的名字]
  #v(1em)
  #today().display("[year]年[month]月[day]日")
]

#pagebreak()

// =============================================
// 3. 目录与正文
// =============================================
// 使用 style() 函数将所有样式精确地应用到正文内容上
#style[
  // 生成目录。
  #outline(title: "目录", depth: 4)
  #pagebreak()

  // 引入笔记内容
  #include "content/01-shenlun.typ"
  #pagebreak()

  #include "content/02-yanyu.typ"
  #pagebreak()

  #include "content/03-panduan.typ"
  #pagebreak()

  #include "content/04-shuliang.typ"
  #pagebreak()

  #include "content/05-ziliao.typ"
]
