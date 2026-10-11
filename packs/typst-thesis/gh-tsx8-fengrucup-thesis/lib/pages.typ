// lib/pages.typ - 页面生成器
// 封面、摘要等页面

#import "config.typ": front-heading, 字体, 字号

// 封面页
#let cover-page-normal(
  ctitle: none,
  csubtitle: none,
) = {
  align(left, image("../images/beihang-emblem.png"))
  v(43pt)
  align(center, image(
    "../images/beihang-wordmark.png",
    height: 2.25cm,
    width: 12.78cm,
  ))
  v(38pt)
  align(center, text(字号.二号, font: 字体.中宋, ctitle))
  v(2pt)
  align(right, text(
    字号.三号,
    font: 字体.新魏,
    "——" + csubtitle,
  ))
}

// 中文摘要页
#let abstract-page-zh(
  ckeywords: (),
  cabstract,
) = {
  front-heading("摘要", enter-front: true)
  set par(justify: true, first-line-indent: (amount: 2em, all: true))
  cabstract
  [

    *关键词：*]
  ckeywords.join("，")
}

// 英文摘要页
#let abstract-page-en(
  ekeywords: (),
  eabstract,
) = {
  set text(font: "Times New Roman")
  front-heading([*Abstract*])
  set par(first-line-indent: (amount: 2em, all: true), justify: true)
  eabstract
  [

    *Keywords: *]
  ekeywords.join(", ")
}
