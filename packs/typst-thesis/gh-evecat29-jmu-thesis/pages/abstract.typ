#import "@preview/pointless-size:0.1.2": zh

#let abstract(cjk, thesis_info) = {
  let (song, hei, kai, fang) = cjk

  // 设置局部可被目录检索的隐藏标题
  show heading.where(level: 1): it => {
    set text(size: 0pt, fill: white) // 隐藏
    set block(spacing: 0pt, above: 0pt, below: 0pt) // 不占位
    it.body
  }

  // 中文摘要页
  [#heading(level: 1, numbering: none, outlined: true)[摘要]<abstract>]

  // 中文标题
  align(center)[
    #hei(text(size: zh("三号"), weight: "bold", thesis_info.title))
    #v(2.5em)
  ]

  // 中文摘要
  set par(first-line-indent: 0pt, justify: true, leading: 1.2em)
  [
    #hei(text(size: zh("四号"), "[摘要]"))
    #h(0.5em)
    #song(text(size: zh("小四"), thesis_info.abstract))
  ]

  v(1em)

  // 中文关键词
  [
    #hei(text(size: zh("四号"), "[关键词]"))
    #h(0.5em) 
    #song(text(size: zh("小四"), thesis_info.keywords.join("；" + h(1em))))
  ]

  pagebreak()




  // 英文摘要页

  [#heading(level: 1, numbering: none, outlined: true)[Abstract]<abstract_en>]

  // 英文标题
  align(center)[
    #text(font: "Arial", size: zh("小四"), weight: "bold", thesis_info.en_title)
    #v(2.5em)
  ]

  // 英文摘要
  [
    #text(font: "Arial", size: zh("小四"), "[Abstract]")
    #h(0.5em) 
    #text(font: "Arial", size: zh("五号"), thesis_info.en_abstract)
  ]

  v(1em)

  // 英文关键词
  [
    #text(font: "Arial", size: zh("小四"), "[Keywords]")
    #h(0.5em)
    #text(font: "Arial", size: zh("五号"), thesis_info.en_keywords.join(";" + h(2em)))
  ]

  pagebreak()
}