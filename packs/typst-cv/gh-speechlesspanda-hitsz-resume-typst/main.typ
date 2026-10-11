#import "settings.typ": *

// ====================== 模板说明 ======================
// 这是可提交的简历模板文件，不填写真实个人信息。
// 本地私有版本请使用 main.local.typ，并确保它已加入 .gitignore。

// ====================== 基本信息 ======================
// 学院信息
#let school = [学院名称 | Faculty Name]

// 联系方式:邮箱、手机号、GitHub
#let contact-info = contact("your.email@example.com", "000-0000-0000", "github.com/yourname")

#show: resume-page.with(school: school, contact-info: contact-info)

// ====================== 个人信息 ======================
// 证件照框用 place 浮于右上,不占正文流高度
#place(top + right, dy: -17pt)[#photo-box[#text(size: 8pt)[证件照]]]
#section("address-card", below: 6pt)[个人信息]
#block(width: 429pt)[
  #grid(
    columns: (2.15cm, 1fr, 2.15cm, 1fr),
    inset: (x: 6pt, y: 0pt),
    row-gutter: 9.8pt,
    info-label[姓#h(1.4em)名：], [姓名], info-label[性#h(1.4em)别：], [性别],
    info-label[出生年月：], [YYYY年MM月], info-label[政治面貌：], [政治面貌],
  )
]

// ====================== 教育背景 ======================
#section("graduation-cap", above: 35pt, below: 12pt)[教育背景]
#grid(
  columns: (1fr, 1fr, 150pt),
  inset: (x: 6pt, y: 0pt),
  row-gutter: 9.8pt,
  [学校名称], [专业名称], [YYYY年~–~YYYY年],
  [*学分绩: XX.XX/100.00*], [*学分绩排名: X/XXX*], [],
)

// ====================== 项目经历 ======================
#section("chalkboard-user", above: 27pt, below: 7pt)[项目经历]
#[
  #set par(spacing: 14.4pt)
  #text(size: 12pt, weight: "bold")[项目名称一] #h(1fr) 技术方向 / 项目角色 \
  项目简介，说明目标、职责、关键技术、实现方法与结果。

  #text(size: 12pt, weight: "bold")[项目名称二] #h(1fr) 技术方向 / 项目角色 \
  项目简介，说明目标、职责、关键技术、实现方法与结果。

  #text(size: 12pt, weight: "bold")[项目名称三] #h(1fr) 技术方向 / 项目角色 \
  项目简介，说明目标、职责、关键技术、实现方法与结果。
]

// ====================== 竞赛经历 ======================
#section("trophy", above: 22pt, below: 7pt)[竞赛经历]
#grid(
  columns: (1fr, 100pt, 89pt, 85pt),
  inset: (x: 6pt, y: 0pt),
  [*竞赛名称*], [个人/团队], [奖项等级], grid.cell(inset: (left: 6pt, right: 0pt, y: 0pt))[YYYY年MM月],
)

// ====================== 技能特长 ======================
#section("wrench", above: 12pt, below: 7pt)[技能特长]
- 编程语言：填写熟悉的编程语言、框架与工具
- 系统与工程：填写系统基础、工程实践、开发工具或部署经验
- 专业方向：填写研究方向、课程基础、项目技术栈或领域能力
- 数据与实验：填写数据处理、实验分析、评估指标或相关工具
- 综合能力：填写算法基础、协作经验、文档能力或其他优势

// ====================== 所获荣誉 ======================
#section("star", above: 16.5pt, below: 4pt)[所获荣誉]
- YYYY-YYYY学年荣誉名称

// ====================== 社会工作与兴趣 ======================
#section("user-group", above: 16.5pt, below: 4pt)[社会工作与兴趣]
- 社会工作：填写职务、组织活动、志愿服务时长等
- 兴趣爱好：填写兴趣爱好
