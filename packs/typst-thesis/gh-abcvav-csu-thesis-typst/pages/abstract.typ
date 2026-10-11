#import "../styles/font-settings.typ": font, font-size, global-font

#let _display-words(words, semicolon: "；") = {
  for word in words {
    if word == words.last() {
      [#word]
    }
    else {
      [#word#semicolon ]
    }
  }
}

#let _header(font: font.黑体, body) = [#h(-2em)#text(font: font, weight: "bold", body)]

#let abstract-zh-page(title: none, keywords: none, classification: none, body) = [
  #set page(margin: (top: 114pt))
  #align(center)[
    #set text(font: font.Times + font.黑体, size: font-size.三号, weight: "bold")
    #title
  ]

  #v(26pt)

  #set text(font: global-font, size: font-size.四号)

  #set par(leading: 0.7em)

  #_header("摘要：")#body

  #""

  #let pic-num = context query(figure.where(kind: image)).dedup().len()
  #let table-num = context query(figure.where(kind: table)).dedup().len()
  #let bib-num = context query(ref.where(element: none)).dedup().len()

  #h(-2em)图#(pic-num)幅，表#(table-num)个，参考文献#(bib-num)篇

  #""

  #_header("关键词：")#_display-words(keywords)

  #_header("分类号：")#_display-words(classification)

  #pagebreak()
]

#let abstract-en-page(title: none, keywords: none, classification: none, body) = [
  #set page(margin: (top: 114pt))

  // FIXME 如何才能不要两端对齐？
  #align(center)[
    #set text(font: font.Times, size: font-size.三号, weight: "bold")
    #title
  ]

  #v(26pt)

  #let en_header = _header.with(font: font.Times)

  #set text(font: global-font, size: font-size.四号)

  #set par(leading: 11.5pt)

  #en_header("Abstract:")#body

  #""

  #en_header("Keywords: ")#_display-words(keywords, semicolon: ";")

  #en_header("Classification: ")#_display-words(classification, semicolon: ";")

  #pagebreak()
]
