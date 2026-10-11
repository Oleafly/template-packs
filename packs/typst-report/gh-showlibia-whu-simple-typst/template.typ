// 封面
#set text(
  font: "SimSun",
  size: 20pt
)

#set page(
  paper: "a4",
  margin: (x: 1.8cm, y: 1.5cm),
)
#set par(
  justify: true,
  leading: 0.52em,
)

#image("logo.png")

#align(center)[
  #set text(
    font: "STXingkai", 
    size: 30pt,
  )
  武汉大学国家网络安全学院
]

#align(center)[
  #set text(
    font: "SimSun", 
    size: 40pt,
  )
  课程名称
]

#align(center)[
  #image(
    "WHU.png",
    width: 35%
  )
]

#align(center)[
  #block[
    #set align(left)
    报告名称：

    专   业： 

    学   号：
  
    姓   名：
  
    任课教师：

  ]
  #align(bottom)[
     2025 年  月  日
  ]
]

// 摘要

#pagebreak()

#set page(
  header: align(right)[
    #set text(
      font: "SimSun",
      size: 14pt
    )
      header
  ],
  numbering: "1",

)

#line(length: 100%)

#align(center)[
  摘 要
]

#let indent = h(2em)

#set text(
  font: "SimSun",
  size: 18pt
)

#indent 摘要

// 目录

#set page(
  paper: "a4",
  margin: (x: 1.8cm, y: 1.5cm),
)
#line(length: 100%)
#set text(
  font: "SimSun",
  size: 18pt
)

#set par(
  justify: true,
  leading: 1em,
)

#align(center)[
  #outline(title: "目录")
]


// 正文
#set page(
  paper: "a4",
  margin: (x: 1.8cm, y: 1.5cm),
)
#line(length: 100%)

#set par(
  justify: true,
  leading: 1em,
  first-line-indent: 2em
  )

#let indent = h(2em)

#set text(
  font: "SimSun",
  size: 15pt
)

= 第一章 标题

== 1.1 标题

#indent 正文

== 1.2 标题
#indent 正文

#set page(
  paper: "a4",
  margin: (x: 1.8cm, y: 1.5cm),
)
#line(length: 100%)

#set par(
  justify: true,
  leading: 1em,
  first-line-indent: 2em
  )
#let indent = h(2em)

#set text(
  font: "SimSun",
  size: 15pt
)

= 第二章 标题
#indent 正文

#set page(
  paper: "a4",
  margin: (x: 1.8cm, y: 1.5cm),
)
#line(length: 100%)

#set par(
  justify: true,
  leading: 1em,
  first-line-indent: 2em
  )
#let indent = h(2em)

#set text(
  font: "SimSun",
  size: 15pt
)

// 可以使用BibTeX格式的参考文献
#bibliography("cite.bib", title: "参考文献")
