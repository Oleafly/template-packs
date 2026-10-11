#import "../template/template.typ": *

#show: template

#let theme_color = rgb("#184dcb")
#init(
  name: "你的姓名",
  pic_path: "../img/avatar.jpg",
)

#info(
  color: rgb("#2c216e"),
  (
    content: [出生年月｜所在地]
  )
)

#align(
  center,
  info(
    color: theme-color,
    (
      icon: fa-phone,
      content: [手机号（可选：同微信）]
    ),
    (
      icon: fa_email,
      content: "your_email@example.com"
    ),
  )
)

#v(-1em)
#resume_section([#fa-graduation-cap 教育背景])

#ed-item(
  [*学校名称（可填写层次/标签）*],
  [*专业名称（可填写方向/排名）*],
  date[起止时间],
)
#ed-item(
  [*GPA: X.XX / 4.00（可选）*],
  [*专业排名 X / XX（可选）*],
  [],
)

#v(-1em)
#resume_section([#fa-code 项目经历])

#item(
  [#fa-proj *项目名称 1*],
  [*你的角色*],
  date[起止时间],
)
#resume_desc(
  "项目介绍",
  [
    用 1-2 句话概述项目背景、目标与价值。
    - *关键点 1*：描述你做了什么、用了什么技术、解决了什么问题。
    - *关键点 2*：描述核心方案或系统设计亮点。
    - *关键点 3*：描述性能优化、工程化实践或难点突破。
    - *项目结果*：量化结果（如准确率、时延、吞吐、排名、用户量等）。
  ],
)

#v(-0.3em)
#item(
  [#fa-proj *项目名称 2*],
  [*你的角色*],
  date[起止时间],
)
#resume_desc(
  "项目介绍",
  [
    说明项目场景与技术路线。
    - *模块设计*：说明核心模块与职责划分。
    - *技术实现*：说明后端/前端/数据/模型的关键实现。
    - *工程实践*：说明部署、监控、测试、可维护性设计等。
    - *项目结果*：尽量用可衡量指标表达产出。
  ],
)

#resume_section([#fa-research 科研经历])
#item(
  [#fa-proj *科研项目名称*],
  [*你的角色（如负责人/核心成员）*],
  date[起止时间],
)

#resume_desc("研究内容", "用 1 句话说明研究方向、核心问题与研究目标。")
#resume_desc(
  "负责工作",
  [
    - *方法设计*：描述你提出或改造的关键方法，以及要解决的问题。
    - *技术实现*：说明具体实现路径（模型/算法/系统/实验流程）。
    - *优化迭代*：说明你如何定位瓶颈并进行性能或效果优化。
    - *协作与产出*：说明你在团队中的职责与可交付成果。
  ]
)
#resume_desc(
  [成果],
  [用可量化指标填写：如准确率提升 X%、推理时延下降 X%、发表/获奖/落地情况等。]
)

#v(-0.7em)
#resume_section([#fa-trophy 竞赛获奖])

#item(
  [#fa-proj *竞赛名称 1*],
  [*奖项等级（如国家级/省级）*],
  date[时间],
)
#resume_desc(
  "竞赛内容",
  [
    说明赛题方向与你负责的部分，可突出建模、实现、分析或答辩贡献。
  ],
)

#v(-0.6em)
#item(
  [#fa-proj *竞赛名称 2*],
  [*奖项等级*],
  date[时间],
)

#fa-proj *其他经历与荣誉*：奖学金示例；荣誉称号示例；证书示例；

#v(-0.5em)
#resume_section([#fa-paper 专业技能])

- 编程语言：熟悉 `Python / C++ / Java`（按实际保留）。
- 算法与数据：掌握数据结构、算法基础与常见建模方法。
- 工程能力：熟悉 `Linux`、`Git`、`Docker`，具备项目部署经验。
- 后端与数据库：熟悉 `FastAPI / Spring Boot`，了解 `MySQL / PostgreSQL / Redis`。
- AI 相关（可选）：熟悉 `PyTorch`、向量检索或 RAG 流程（按实际填写）。
