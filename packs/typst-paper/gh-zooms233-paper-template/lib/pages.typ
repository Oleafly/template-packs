// lib/pages.typ - 页面生成器
// 摘要页面

#import "@preview/cuti:0.4.0": show-cn-fakebold
#import "config.typ": 字体, 字号

// 英文题目实词首字母大写（title case）
#let small-words = ("a", "an", "the", "and", "or", "but", "nor", "for", "so", "yet", "at", "by", "in", "of", "on", "to", "up", "as", "is", "if", "via", "from", "with", "into", "onto", "upon")
#let title-case(text) = {
  let words = lower(text).split(" ")
  let result = ()
  for (i, word) in words.enumerate() {
    if word == "" {
      result.push(word)
    } else {
      result.push(upper(word.at(0)) + word.slice(1))
    }
  }
  result.join(" ")
}

// 中文摘要页
#let abstract-page-zh(
  ctitle: none,
  ckeywords: (),
  first-line-indent: 2em,
  cabstract,
) = {
  set align(left + top)

  // 中文题目：居中显示，黑体三号
  v(1.5em)
  set text(字号.三号, font: 字体.黑体)
  set par(leading: 22pt, spacing: 0pt)
  align(center)[#ctitle]
  v(1.5em)

  // 中文摘要：标题与正文同段显示，首行缩进 2 字符，黑体标题 + 宋体正文，小四，22pt 最小值行距
  set text(字号.小四, font: 字体.宋体)
  set par(leading: 22pt, spacing: 0pt, first-line-indent: first-line-indent, justify: true)
  [
    #text(font: 字体.黑体)[摘　要：]
    #h(0.5em)
    #cabstract
  ]

  // 关键词：与摘要内容空一行，首行缩进2字符，黑体小四(12pt)，后跟中文冒号
  v(22pt)
  set text(字号.小四, font: 字体.黑体)
  set par(leading: 22pt, spacing: 0pt, first-line-indent: first-line-indent)
  [关键词：]
  // 关键词列表：中文宋体，西文/数字Times New Roman，小四(12pt)，用"; "分隔
  set text(字号.小四, font: 字体.宋体)
  ckeywords.join("; ")
}

// 英文摘要页
#let abstract-page-en(
  etitle: none,
  ekeywords: (),
  eabstract,
  first-line-indent: 2em,
) = {
  set align(left + top)

  // 英文题目：居中显示，每个单词首字母大写
  v(1.5em)
  set text(字号.三号, font: "Times New Roman")
  set par(leading: 22pt, spacing: 0pt)
  align(center)[#title-case(etitle)]
  v(1.5em)

  // 英文摘要：标题与正文同段显示，首行缩进 2 字符，标题粗体，小四，正文 1.5 倍行距
  set text(字号.小四, font: "Times New Roman")
  set par(leading: 1.5em, spacing: 0pt, first-line-indent: first-line-indent, justify: true)
  [
    #text(font: "Times New Roman", weight: "bold")[Abstract:]
    #h(0.5em)
    #eabstract
  ]

  // 关键词：与摘要内容空一行，Times New Roman 小四(12pt)加粗 "Keywords:"，用 "; " 分隔
  v(18pt)
  set text(字号.小四, font: "Times New Roman", weight: "bold")
  set par(leading: 1.15em, spacing: 0pt, first-line-indent: first-line-indent)
  [Keywords:]
  set text(字号.小四, font: "Times New Roman", weight: "regular")
  h(0.5em)
  ekeywords.join("; ")
}
