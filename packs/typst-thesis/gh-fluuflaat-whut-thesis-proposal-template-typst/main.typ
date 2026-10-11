// main.typ — 主入口文件
// 对应 LaTeX 版 main.tex，组装所有文档组件
//
// 【编译方法】
//   在终端中运行：typst compile main.typ
//   实时预览模式：typst watch main.typ  （保存文件后自动重新编译）
//
// 【文件结构说明】
//   config.typ        — 修改个人信息（姓名、学号、题目等）
//   template.typ      — 格式定义（一般不需要修改）
//   cover.typ         — 封面页
//   requirements.typ  — 填写要求页
//   chapters/         — 正文章节（主要编辑这里的文件）
//     background.typ  — §1 研究目的与意义
//     plan.typ        — §2 基本内容与技术方案
//     timeline.typ    — §3 时间进度安排
//   references.bib    — 参考文献数据库（BibTeX 格式）
//
// 【日常使用流程】
//   1. 先修改 config.typ 中的个人信息
//   2. 编辑 chapters/ 下的各章节文件
//   3. 在 references.bib 中添加参考文献
//   4. 运行 typst compile main.typ 生成 PDF

#import "config.typ": *
#import "template.typ": thesis-proposal, font-size, font-family, underline-field
#import "cover.typ": cover-page
#import "requirements.typ": requirements-page

// ===== 应用模板 =====
#show: thesis-proposal.with(
  student-name: student-name,
  student-id: student-id,
  advisor: advisor,
  advisor-title: advisor-title,
  school: school,
  major: major,
  class-name: class-name,
  thesis-title: thesis-title,
  thesis-english: thesis-english,
  submit-date: submit-date,
  university: university,
  degree: degree,
)

// ===== 1. 封面 =====
#cover-page()

// ===== 2. 开题报告填写要求 =====
#pagebreak()
#requirements-page()

// ===== 3. 正文开始 =====
// 重置页码计数器，正文从第 1 页开始
#pagebreak()
#counter(page).update(1)

#include "chapters/background.typ"

#pagebreak()
#include "chapters/plan.typ"

#pagebreak()
#include "chapters/timeline.typ"

// ===== 4. 参考文献 =====
#pagebreak()
#heading(level: 1)[附需阅读的参考文献（不少于15篇，其中近五年外文文献不少于3篇）]

#set text(size: font-size.wu)
#set par(leading: 0.5em) // 1.2 倍行距
#bibliography("references.bib", title: none, style: "gb-7714-2015-numeric.csl")

// ===== 5. 指导教师意见 =====
#pagebreak()
#heading(level: 1)[指导教师意见]

#v(8cm)

#set text(size: font-size.si)
#align(right)[
  指导教师（签名）：#underline-field(width: 120pt)[] \
  #v(24pt)
  #h(40pt) 年 #h(30pt) 月 #h(30pt) 日
]
