// 英文摘要页模块

#import "../fonts/font-def.typ": *

#let page_abstract_en(
  abstract_en: [], 
  keywords_en: ()
) = {
  // 与中文摘要一致，保留完整的 heading 语义。
  [
    #heading(level: 1, numbering: none)[Abstract] <abstract-en>
  ]
  set text(font: songti, 11pt)
  // 英文摘要排版：行距和段落间距加宽至 7.5mm，符合独立英文摘要规范。
  // 如果觉得底部留白太多，是间距太大了剩余空间不够，这是比较合理的视觉。
  // 如果想要减少底部留白，可以适当缩小下面两个参数。(行距和段间距)
  set par(leading: 7.5mm, spacing: 7.5mm)
  abstract_en
  v(11mm)
  par(first-line-indent: 0em)[
    #text(font: songti, 11pt)[
      #text(font: heiti, 11pt, weight: "bold")[KEY WORDS: ]
      // 关键词数组自动以英文逗号和空格拼接
      #keywords_en.join(", ")
    ]
  ]
  pagebreak()
}
