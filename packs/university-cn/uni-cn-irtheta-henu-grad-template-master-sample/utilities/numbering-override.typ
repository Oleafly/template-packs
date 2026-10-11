// 附录专用：生成带编号的图片
#import "../fonts/font-def.typ": *

#let appendix_img(path, caption_text, prefix: "A", width: auto, height: auto) = context {
  let num = counter("appendix-img-counter").get().first() + 1
  counter("appendix-img-counter").update(num)
  let numbering = (prefix, "-", str(num)).join("")
  let content = align(center)[
    #image(path, width: width, height: height)
    #v(4pt)
    #text(font: heiti, 12pt, weight: "regular")[
      图 #numbering #caption_text
    ]
  ]
  [#figure(content)]
}

// 附录专用：生成带编号的表格
#let appendix_tbl(tbl_content, caption_text, prefix: "A") = context {
  let num = counter("appendix-tbl-counter").get().first() + 1
  counter("appendix-tbl-counter").update(num)
  let numbering = (prefix, "-", str(num)).join("")
  let content = align(center)[
    #v(4pt)
    #text(font: heiti, 12pt, weight: "regular")[
      表 #numbering #caption_text
    ]
    #tbl_content
  ]
  [#figure(content)]
}

// 附录专用：生成带编号的公式
#let appendix_eq(eq_body, prefix: "A") = context {
  let num = counter("appendix-eqt-counter").get().first() + 1
  counter("appendix-eqt-counter").update(num)
  let numbering = (prefix, "-", str(num)).join("")
  align(center)[
    // 使用 Grid 网格三列布局：[左占位] [公式本体] [右对齐编号]
    #grid(
      columns: (1fr, auto, 1fr), // 左右1fr均分空间，中间自适应，实现完美居中
      align: center + horizon,
      [], // 左列占位
      scale(130%, reflow: true)[#eq_body], 
      align(right)[(#numbering)] // 右列：强制右对齐编号
    )
  ]
}

// 附录编号重置规则：遇到二级标题（如"== 附录A"）时清空图表计数器
#let appendix_numbering_rule(body) = {
  show heading.where(level: 2): it => {
    counter("appendix-img-counter").update(0)
    counter("appendix-tbl-counter").update(0)
    counter("appendix-eqt-counter").update(0)
    it
  }
  body
}