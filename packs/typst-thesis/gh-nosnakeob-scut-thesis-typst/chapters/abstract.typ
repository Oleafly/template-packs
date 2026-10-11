#import "../config.typ": thesis
#import "@preview/zh-kit:0.1.0": *
#import "../style/font.typ": *
#import "../utils.typ": *

#set text(font_size.小四, font: font.宋体)
#show heading: set align(center)
#show heading: set text(font_size.小二, font: font.黑体)

// 中文摘要
= 摘#h(1em)要

#v(1em)

#zhlorem(300)

#v(1em)

// 关键词
#grid(
  columns: (auto, 1fr),
  gutter: 1em,
  [*关键词：*], 
  [#thesis.keywords-zh],
)

#pagebreak()

// 英文摘要
#show heading: set text(font: font.宋体)

= Abstract

#v(1.5em)

#lorem(300)

#v(1em)

// Keywords
#grid(
  columns: (auto, 1fr),
  gutter: 1em,
  [*Keywords:*], 
  [#thesis.keywords-en],
)
