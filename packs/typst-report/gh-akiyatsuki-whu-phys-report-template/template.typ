// ==================== 配置区 ====================

// 自己填自己的信息在这里，最好另存为自己的模板
#let major = "物理学"
#let name = "姓名"
#let stuid = "学号"
#let Name = "NAME"
#let loc = "None"
#let course = "普通物理实验三"
#let grades = "100"
#let newtitle = "实验名"
#let engtitle = "Name of the Exp"
#let exptype = "None"

// ====================页面设置======================
#set page(
  paper: "a4",
  margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
  header: context {
    let page-num = counter(page).get().first()
    if page-num > 1 {
      align(center)[
        #newtitle
        #h(1fr)
        #page-num
        #line(length: 100%, stroke: 1.2pt)
        #v(0.5em)
      ]
    }
  },
  header-ascent: 0.7em,

  numbering: "1",
  columns: 2,

  footer: context {
    // 页脚无文本
  }
)

#set text(font: ("Charter","Songti SC"))
#set heading(numbering: "1.1")
// ===========
#place(
  top + center,
  float: true,
  scope: "parent",
  clearance: 1.5em,
)[
  //中文标题
  #text(size: 18pt, weight: "bold")[#newtitle]
  #v(0.5em)

  //作者
  #text(size: 14pt, font: "Kaiti SC")[
    #name (#stuid)
  ]

  //单位
  #text(size: 10.5pt, font: "Kaiti SC")[
    武汉大学物理科学与技术学院，湖北省，武汉市，430072
  ]
  #v(1.2em)
]

// ==== 中文摘要 ====
#place(
  top,
  float: true,
  scope: "parent"
)[
  #par(justify: true, first-line-indent: 0em)[
    *摘要:*
    #lorem(80)
  ]
  #text(weight: "bold" )[关键词: ]
  关键词1，2，3...
  #v(0.5em)
]


#place(
  top + center,
  float: true,
  scope: "parent",
  clearance: 1.5em,
)[
  //中文标题
  #text(size: 18pt, weight: "bold")[#engtitle]
  #v(0.3em)

  //作者
  #text(size: 14pt, font: "Times New Roman")[
    #Name (#stuid)
  ]

  //单位
  #text(size: 10.5pt, font: "Times New Roman")[
    School of physical science and technology, Wuhan University, Wuhan, 430072, China
  ]
  #v(0.3em)
]

// ==== 英文摘要 ====
#place(
top,
float: true,
scope: "parent",
clearance: 1.5em,
)[
  *Abstract: *
  #lorem(70)
  \
  *Keywords: *keywords...

]
#v(1em)
// ====== 接下来的内容就交给你了！替换#lorem为你的文章吧！ =====

= 实验目的
#lorem(100)@snowflakes
= 主要实验仪器
#lorem(100)@notebook //文献引用格式
= 实验原理
#lorem(100)
= 实验内容与步骤
#lorem(100)
= 数据处理与表达
#align(center + top)[
  #image("glacier.jpg", width: 60%)

  *Glaciers form an important
  part of the earth's climate
  system.*
]
= 实验结果分析
#v(10em)

#bibliography(
  title: "参考文献",
  "ref.bib"
)
