// --- 全局配置 ---
#set page(
  paper: "a4",
  margin: (x: 1.5cm, y: 1.5cm),
)
#set text(
  font: ("New Computer Modern", "STZhongsong"), // 中英文字体
  size: 12pt,
  lang: "zh"
)
#set par(justify: true)

// --- 宏定义：标题样式 ---
#let section(title) = {
  v(3pt)
  block(width: 100%, stroke: (bottom: 0.5pt + black), inset: (bottom: 3pt))[
    #text(size: 12pt, weight: "bold")[#title]
  ]
}

#let item(title, subtitle, date, location) = {
  v(1pt)
  grid(
    columns: (1fr, auto),
    row-gutter: 4pt,
    text(weight: "bold")[#title], [#date],
    text(style: "italic")[#subtitle], [#location]
  )
}

// --- 个人信息 ---
#align(center)[
  #text(size: 18pt, weight: "bold")[Your name] \
  #v(2pt)
  #text(size: 11pt)[
    your phone | your email |
   personal website
  ]
]
#v(1.5em)
// --- 意向岗位 ---
#section(text(size:14pt)[意向岗位])
- 
- 


// --- 实习与项目经历 ---
#section(text(size:14pt)[实践项目])

#item(
  "Title",
  "your role",
  "time period",
  "project category"
)
- details
- details
#item(
  "Title",
  "your role",
  "time period",
  "project category"
)
- details
- details
#item(
  "Title",
  "your role",
  "time period",
  "project category"
)
- details
- details





// --- 教育背景 ---
#section(text(size:14pt)[*教育背景*])
#item(
  "Wild Chick University",
  "Major", 
  "Admission Time - Graduate Time",
  "Location"
)
- *core courses*: 
- *Cumulative GPA*: 

// --- 成绩单表格 ---
#v(5pt)
#figure(
    table(columns: 6,
    stroke: 0.5pt + gray,
  fill: (x, y) => if y == 0 { silver },
  [课程名称], [课程学分], [成绩], [课程名称], [课程学分], [成绩], 
  [], [], [], [], [], [], 
  [], [], [], [], [], [], 
  [], [], [], [], [], [], 
  [], [], [], [], [], [], 
  
),
caption: [已修课程成绩单]
)


// --- 技能与其它 ---
#section(text(size:14pt)[附加信息])
- *编程语言*: 
- *软件/工具*: 
