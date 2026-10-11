#import "template.typ": *

// 初始化设置
#show: set_project

#header(
  phone: "(+86) xxx",
  email: "name@gmail.com",
  github: "github.com/luv-ray",
)[Luv-Ray]

== 教育背景
#line()
#education(
  school: "xxx大学",
  major: "计算机科学与技术",
  degree: "本科",
  date: "2021 年 - 2025 年",
)[
  GPA:xxx(100)，年级前 xxx% \
  更多介绍……
]

== 荣誉奖项
#line()
#prize(
  [比赛名称],
  grade: "奖项",
  date: "time",
)
#prize(
  [比赛名称],
  grade: "奖项",
  date: "time",
)
#prize(
  [比赛名称],
  grade: "奖项",
  date: "time",
)

== 工作经历
#line()
#experience(
  name: "xx公司",
  type: "实习",
  date: "time",
)[
  职位介绍
  - 具体描述
  - 具体描述
  - 具体描述
]

== 项目经历
#line()
#experience(
  name: "xx项目",
  type: "开源项目",
  date: "time",
)[
  项目介绍
  - 具体描述
  - 具体描述
  - 具体描述

]
#experience(
  name: "xx项目",
  type: "课程项目",
  date: "time",
)[
  项目介绍
  - 具体描述
  - 具体描述
  - 具体描述
]

== 专业技能
#line()
有序列表：
+ *粗体*#strong("示例")
+ _emphasis show case_
+ 数学模式： $x : sigma in Gamma => Gamma tack x : sigma $

== 其他
#line()
Blog: #link("https://example.com")[example.com]
