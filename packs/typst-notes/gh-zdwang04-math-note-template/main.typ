#import "@preview/theorion:0.6.0": *
#import cosmos.fancy: *
#import "utils/utils.typ": note-cover
#show: show-theorion

// 配置
//// 标题标号
#set heading(numbering: "1.1")
//// 中文字体
#show regex("\\p{Han}+"): it => text(font: "LXGW WenKai Mono", it)
#set text(lang: "zh")

// #set par(first-line-indent: 1em, justify: true) // 自然段空格
//// 数学公式居中
#show math.equation.where(block: true): eq => block(
  width: 100%,
  align(center, eq),
)

// 使用QED符号
#set-qed-symbol[#math.qed]

// 笔记内容
//// 封面
#note-cover(
  title: "XXX笔记",
  subtitle: "XXX",
  author: "zdWang04",
  // date: [2026年9月17日],
)

//// 目录
#outline(title: "目录")
#pagebreak()

//// 正文
#include "contents/chapters/chapter01.typ"


//// 附录
#include "contents/appendix/appendixA.typ"
#include "contents/appendix/appendixB.typ"
