#import "resume-template.typ": *

#let (resume-header, resume-entry) = setup-styles(
  font-size: 11pt,
  element-spaciness: 1.35,
  accent-color: rgb("#3b82b6"),
  serif-font: ("SimSun", "STSong", "STZhongsong"),
  sans-serif-font: ("Source Han Sans SC", "Microsoft YaHei", "SimHei"),
  alt-font: ("Source Han Sans SC", "Microsoft YaHei", "SimHei"),
)

#show: resume-header.with(
  author: "你的姓名",
  basic-info: ("目标岗位",),
  telephone: "138-0000-0000",
  email: "your@email.com",
)

= 教育背景

#resume-entry(
  title: "学校名称（985/211）",
  subtitle: "专业名称 · 学历",
  date: "20XX.09 - 至今",
)[
  - 在校荣誉或奖学金（如有）
]

= 相关经历

#resume-entry(
  title: "经历标题",
  subtitle: "所在组织或项目名称",
  date: "20XX.XX - 20XX.XX",
)[
  - *S*：背景与情境
  - *T*：你的任务与职责
  - *A*：
    - 采取的行动 1
    - 采取的行动 2
    - 采取的行动 3
  - *R*：取得的成果与量化数据
]

#resume-entry(
  title: "另一段经历",
  date: "20XX.XX - 20XX.XX",
)[
  - *S*：背景与情境
  - *T*：你的任务与职责
  - *A*：
    - 采取的行动 1
    - 采取的行动 2
  - *R*：取得的成果
]

= 其他经历

#resume-entry(
  title: "志愿活动或社团经历",
  date: "20XX.XX",
)[
  - 简要描述参与内容与收获
]

#resume-entry(
  title: "培训或项目经历",
  date: "20XX.XX",
)[
  - 简要描述参与内容与收获
]

#resume-entry(
  title: "持续性活动或创作",
  date: "20XX.XX 至今",
)[
  - 简要描述参与内容与成果数据
]

= 技能与特质

- *技能领域 1*：具体能力描述
- *技能领域 2*：具体能力描述
- *技能领域 3*：具体能力描述
- *个人特质*：你的优势或特点
