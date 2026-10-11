#import "../config.typ": *
#import "../utils.typ": font_size
#import "@preview/cuti:0.4.0": show-fakebold
#show: show-fakebold
#set document(
  author: author,
  date: date,
  title: title,
)
#set align(center)
#set page(margin: (top: 2.54cm, bottom: 2.54cm, left: 3.18cm, right: 3.18cm))
#set par(spacing: 0.2em)
#set text(top-edge: "ascender", bottom-edge: "descender")
#let 黑体 = ("SimHei",)

#v(35pt)
#image(
  "signage.jpg",
  width: 45%,
)
#text(
  "本科毕业论文（设计）",
  font: 黑体,
  size: 35pt,
)
#image("badge.jpg")

#set par(spacing: 1em)
#v(88pt)
#align(center)[
  #block(width: 400pt)[
    #set text(font: 黑体, size: font_size.小三)
    #set par(first-line-indent: 0.75em)

    #grid(
      columns: (1.25fr, 1fr),
      row-gutter: 1.05em,
      align: left,

      grid.cell(colspan: 2)[论文题目：#text(title, size: font_size.小三, weight: "bold")],
      grid.cell(colspan: 2)[],
      grid.cell(colspan: 2)[],

      [姓　　名：#author], [学　　号：#student_id],
      grid.cell(colspan: 2)[院　　系：#school],
      grid.cell(colspan: 2)[专　　业：#major],
      [指导教师：#instructor], [职　　称：#instructor_type],
      grid.cell(colspan: 2)[单　　位：#orginazition],
      grid.cell(
        colspan: 2,
      )[完成日期：　　　　#date.display("[year] 年 [month padding:none] 月 [day padding:none] 日")],
    )
  ]
]

#page()[]
