#import "lib.typ": *
#import "avatar.typ": photo-placeholder

#show: project.with(
  title: "Resume Template",
  author: (name: "【姓名】"),
  times: [求职方向：【目标岗位】],
  contacts: (
    "电话：【手机号】",
    "邮箱：【邮箱】",
    "主页：【个人主页】",
  ),
)

// Public repositories should use the generated placeholder rather than a real photo.
#place(
  top + right,
  dy: -1.1em,
  dx: -1.5em,
  photo-placeholder(),
)

#resume-section[教育经历]

#resume-education(
  university: [*【学校名称】*],
  school: [*【专业名称】*],
  start: "【开始时间】",
  end: "【结束时间】",
)[
- #item-list("核心课程", "【课程 A】、【课程 B】、【课程 C】")
- #item-list("成绩与荣誉", "【可公开的成绩、奖项或留空】")
]

#resume-section[实习 / 工作经历]

#resume-project(
  title: "【公司或团队名称】",
  description: "【岗位名称】",
  start: "【开始时间】",
  end: "【结束时间】",
)[
- *【职责或成果 1】：* 使用【技术 / 方法】解决【问题】，产出【可验证结果】。
- *【职责或成果 2】：* 说明你的具体行动、协作方式与业务影响。
]

#resume-section[项目经历]

#resume-project(
  title: "【项目名称】",
  description: "【一句话项目介绍】",
  start: "【开始时间】",
  end: "【结束时间】",
)[
*技术栈：* 【技术 A】+ 【技术 B】+ 【技术 C】

- *【关键设计】：* 交代背景、你的方案与权衡。
- *【工程成果】：* 交代实现范围、质量保障与可验证的效果。
]

#resume-section[专业技能]

- #item-list("编程语言", "【语言与熟练程度】")
- #item-list("开发与工程化", "【框架、数据库、部署或协作工具】")
- #item-list("其他能力", "【与目标岗位相关的能力】")
