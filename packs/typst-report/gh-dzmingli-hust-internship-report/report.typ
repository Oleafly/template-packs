
#import "@preview/cuti:0.4.0": show-cn-fakebold
#import "template.typ": *

#show: show-cn-fakebold

// 封面信息：将 none 改为 [要填写的内容]。
#show: internship-report.with(
  department: none,
  major-class: none,
  student-name: none,
  student-id: none,
  instructor: none,
  internship-organization: none,
  // 起止日期使用 datetime，封面自动格式化；同时设为 none 可留空供手写。
  start-date: datetime(year: 2026, month: 5, day: 26),
  end-date: datetime(year: 2026, month: 7, day: 17),
)

= 实习内容分析

== 实习目的

// 在此填写实习目的。
// 正文会自动使用宋体小四、两字符首行缩进、两端对齐及原报告本行距。

== 实习概况

// 在此介绍实习时间、地点、单位、岗位、组织方式和主要任务。

== 实习单位及实习岗位简介

// 在此介绍实习单位的基本情况，以及实习岗位的职责和要求。

== 实习计划

// 在此说明实习计划。
// 如需插入实习计划表，可取消下面整段的注释并修改内容。

/*
#figure(
  table(
    columns: (22mm, 42mm, 1fr),
    align: (center + horizon, left + horizon, left + horizon),
    inset: (x: 4pt, y: 4pt),
    stroke: 0.5pt,
    table.header([*日期*], [*课程/任务名称*], [*主要内容*]),
    [第1周], [基础学习], [填写主要内容],
    [第2周], [专业实践], [填写主要内容],
  ),
  caption: [实习计划],
  supplement: [表],
  numbering: "1",
)
*/

= 专题内容分析

== 实习内容介绍

// 在此系统介绍实习内容、技术背景、国内外发展概况及其价值和意义。

== 专业知识的应用

// 在此说明实习中使用的专业知识、相关课程、工具方法，
// 以及理论知识与工程实践之间的联系。

== 实习内容分析

// 可从复杂工程问题、系统性、综合性、社会影响、安全、法律、伦理、
// 可持续发展、团队合作和外文资料使用等角度展开分析。
// 技术实践的描述应以合法授权为前提；不要披露敏感系统、账号、密钥
// 或未经脱敏的真实数据。

= 在实习中的收获与体会

// 在此总结知识、技能、职业素养、团队协作、法律伦理和社会责任等方面的收获，
// 并结合具体经历说明体会。

= 意见、建议与展望
// 在此结合实习安排、教学衔接、任务难度、指导方式、团队沟通和后续学习计划，
// 提出意见、建议与展望。
