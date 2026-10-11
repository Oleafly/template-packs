// requirements.typ — 开题报告填写要求页
// 对应 LaTeX 版 main.tex 中的"开题报告填写要求"部分

#import "template.typ": font-size, font-family

/// 生成填写要求页（无页码）
#let requirements-page() = {
  set page(numbering: none)
  set par(first-line-indent: 0pt)

  // 三号黑体加粗居中标题
  align(center)[
    #text(
      font: font-family.heiti,
      size: font-size.san,
      weight: "bold",
    )[开题报告填写要求]
  ]

  v(12pt)

  // 四号正文有序列表
  set text(size: font-size.si)

  enum(
    numbering: "1．",
    indent: 0pt,
    body-indent: 0.5em,
    spacing: 1em,
    [开题报告应根据教师下发的毕业设计（论文）任务书，在教师的指导下由学生独立撰写。],
    [开题报告内容填写后，应及时打印提交指导教师审阅。],
    ["设计的目的及意义"至少800汉字，"基本内容和技术方案"至少400汉字。进度安排应尽可能详细。],
    [指导教师意见：学生的调研是否充分？基本内容和技术方案是否已明确？是否已经具备开始设计（论文）的条件？能否达到预期的目标？是否同意进入设计（论文）阶段？],
  )

  v(2cm)
}
