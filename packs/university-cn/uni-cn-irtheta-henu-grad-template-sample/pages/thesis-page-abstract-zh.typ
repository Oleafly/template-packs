// 中文摘要页模块
// 严格按照中文论文格式，提供居中标题、正文及黑体加粗关键词标签的排版

#import "../fonts/font-def.typ": *

#let page_abstract_zh(
  abstract_zh: [], 
  keywords_zh: ()
) = {
  // 使用真正的 heading，供书签、查询与其它标题相关功能识别。
  [
    #heading(level: 1, numbering: none)[摘　要] <abstract-zh>
  ]
  set text(font: songti, 12pt)
  abstract_zh
  v(11mm)
  par(first-line-indent: 0em)[
    #text(font: songti, 12pt)[
      // 关键词：黑体加粗标签，自动将数组拼接为中文顿号分隔格式
      #text(font: heiti, 12pt, weight: "bold")[关键词：]
      #keywords_zh.join("，")
    ]
  ]
  pagebreak()
}
