#import "../style/font.typ": *

#set text(font: font.宋体, size: font_size.小四)
#show heading: set align(center)
#show heading: set text(font_size.小二, font: font.黑体)

= 目#h(1em)录

#v(1em)

// 目录样式设置
#show outline.entry.where(level: 1): it => {
  v(0.5em, weak: true)
  set text(font: font.黑体, size: font_size.小四)
  it
}

#show outline.entry.where(level: 2): it => {
  set text(font: font.宋体, size: font_size.小四)
  it
}

#show outline.entry.where(level: 3): it => {
  set text(font: font.宋体, size: font_size.小四)
  it
}

// 生成目录
#outline(
  title: none,
  depth: 3,
  indent: 1em,
)
