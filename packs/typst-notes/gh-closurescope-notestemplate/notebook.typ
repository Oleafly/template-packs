#set text(lang: "zh", region: "cn")
#import "template.typ": *
#set text(font: (font-en, font-song))
#show strong: set text(font: (font-en, font-hei), weight: "regular")
#show emph: text.with(font: (font-en, font-kai), style: "normal")
#show: frame-style(styles.hint)
#show: ilm.with(
  title: [课程标题],
  author: "Closure",
  figure-index: (enabled: true),
  raw-text: (
    custom-font: (font-code, font-hei),
  ),
)

= 第一章
== 第一节

在这里开始写笔记。

#definition[定义][
  这是一个定义框的示例。
]
