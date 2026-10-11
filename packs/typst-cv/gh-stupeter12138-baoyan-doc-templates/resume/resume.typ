// ============================================================
// 中文简历 — 内容示例
// 用法：改成本文件顶部的个人信息与下面各段经历即可
// 编译：typst compile resume.typ
// ============================================================

#import "template.typ": *
#import "@preview/fontawesome:0.6.0": *

// ==================== 个人信息（改这里） ====================
#let 姓名 = "张三"
#let 本科院校 = "XX 大学"
#let 学院 = "XX 学院"
#let 专业 = "自动化"
#let 电话 = "138-0000-0000"
#let 邮箱 = "zhangsan@example.com"
#let 主页 = "https://github.com/yourname"
#let 主页显示 = "yourname"
#let 简介 = [
  一句话自我介绍：本科专业、做过的方向、由此形成的研究兴趣，
  以及希望申请的方向与单位。
]
// 头像：把自己的照片放到本目录，改下面这行；不需要头像就留空 ""
#let 照片 = ""
#let 照片宽 = if 照片 == "" { 0em } else { 5em }

// ==================== 主题色与图标 ====================
#let theme-color = rgb("#26267d")
#let fa-award = fa-award(solid: true, fill: theme-color)
#let fa-building-columns = fa-building-columns(solid: true, fill: theme-color)
#let fa-code = fa-code(solid: true, fill: theme-color)
#let fa-envelope = fa-envelope(solid: true, fill: theme-color)
#let fa-github = fa-github(fill: theme-color)
#let fa-graduation-cap = fa-graduation-cap(solid: true, fill: theme-color)
#let fa-atom = fa-atom(solid: true, fill: theme-color)
#let fa-linux = fa-linux(solid: true, fill: theme-color)
#let fa-phone = fa-phone(solid: true, fill: theme-color)
#let fa-wrench = fa-wrench(solid: true, fill: theme-color)
#let fa-language = fa-language(solid: true, fill: theme-color)
#let fa-pen-to-square = fa-pen-to-square(fill: rgb(128, 128, 128))

// ==================== 文档头 ====================
#show: resume.with(
  size: 10pt,
  theme-color: theme-color,
  margin: (
    top: 1.5cm,
    bottom: 2cm,
    left: 2cm,
    right: 2cm,
  ),
  show-introduction: true,
  footer: [
    #fa-pen-to-square #h(0.2em) #datetime.today().display()
  ],
  // header-center: true,     // 姓名居中时不要放头像
  photograph: 照片,
  photograph-width: 照片宽,
  gutter-width: 1em,
)[
  = #姓名

  #info(
    color: theme-color,
    (
      icon: fa-phone,
      content: 电话,
    ),
    (
      icon: fa-envelope,
      content: 邮箱,
      link: "mailto:" + 邮箱,
    ),
    (
      icon: fa-github,
      content: 主页显示,
      link: 主页,
    ),
    // 需要展示院校 / 专业时，把下面两条取消注释
    // (
    //   icon: fa-building-columns,
    //   content: 本科院校,
    // ),
    // (
    //   icon: fa-graduation-cap,
    //   content: 专业,
    // ),
  )
][
  #set par(first-line-indent: 2em)
  #简介
]

// ==================== 教育背景 ====================
== #fa-graduation-cap 教育背景

#sidebar(with-line: true, side-width: 10%)[
  现在

  2022.09
][
  *#本科院校* · #学院 · #专业

  学分平均绩点: X.XX / 4.0 · 排名: X / XXX（前六学期）
]

// ==================== 科研经历 ====================
== #fa-atom 科研经历

- #text[
    *会议 / 期刊名称（等级）* 论文标题 _作者1, 作者2, *本人姓名*, ..._ #link("https://example.com")[[paper]]

    一句话说明研究问题、你负责的部分、以及成果与结论。写清"你做了什么"比罗列项目背景更有说服力。
  ]

- #text[
    *会议 / 期刊名称（等级）* 论文标题 _作者1, 作者2, *本人姓名*, ..._ #link("https://example.com")[[paper]]

    一句话说明研究问题与你的贡献。
  ]

// ==================== 竞赛与项目经历 ====================
== #fa-code 竞赛与项目经历

#sidebar(with-line: true, side-width: 10%)[
  2024.05

  2024.03
][
  *竞赛 / 项目名称一*

  一两句概述项目目标与整体技术方案。

  - 你独立负责的模块，用什么方法，达到什么效果（尽量写量化指标）
  - 第二个亮点，避免与上一条重复
]

#sidebar(with-line: true, side-width: 10%)[
  2023.11

  2023.09
][
  *竞赛 / 项目名称二*

  一两句概述项目目标与整体技术方案。

  - 负责的模块与具体做法
]

// 不用的条目直接注释掉即可，模板会跳过
// #sidebar(with-line: true, side-width: 10%)[
//   2023.06
//
//   2023.03
// ][
//   *竞赛 / 项目名称三*
//
//   概述
// ]

// ==================== 社会实践 / 学生工作 ====================
== #fa-building-columns 社会实践

#sidebar(with-line: true, side-width: 10%)[
  至今

  2024.07
][
  *组织 / 社团名称*

  担任角色，做了什么事情，服务了多少人，产生了什么影响。
]

// ==================== 获奖情况 ====================
== #fa-award 获奖情况

#item(
  [ *校级奖学金* ],
  [],
  date[ 2023，2024 ],
)

#item(
  [ *竞赛名称一* ],
  [ *国家级一等奖* ],
  date[ 2024 ],
)

#item(
  [ *竞赛名称二* ],
  [ *省级二等奖* ],
  date[ 2023 ],
)

// ==================== 技能与语言 ====================
== #fa-wrench 技能和语言

#sidebar(with-line: false, side-width: 10%)[
  *研究方向*

  *编程*

  *工程能力*

  *语言*
][
  具身智能 · 机器人技术（按自己方向改）

  Python, C/C++, MATLAB, PyTorch

  #fa-linux Linux, ROS2, STM32, Git

  CET-6（分数 / 读写听说水平）
]
