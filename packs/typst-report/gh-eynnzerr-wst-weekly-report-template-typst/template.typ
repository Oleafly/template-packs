#import "utils.typ": show_report

#let project(
  title: "[XX]周报汇集概要", 
  author: "XX",
  email: "XXX@hust.edu.cn",
  tasks: (), // 项目情况数组，依次包含各任务的序号、发起日期、任务简述、当前状态、预期结束
  weekly_reports: (), // 周报数组，每个item是一个字典，包含日期、任务概述块、任务详述块、下周计划块
  body
) = {
  set document(author: author, title: title)
  set page(numbering: "1", number-align: center)
  set text(font: ("Libertinus Serif", "Noto Sans CJK SC"), lang: "zh")

  heading(
    depth: 1, 
    text(fill: color.rgb(58,94,34), title)
  )

  heading(
    depth: 2, 
    text(fill: color.rgb(197,94,15), "基本信息")
  )

  text("姓名：" + author)
  parbreak()
  text("电邮：" + email)

  heading(
    depth: 2, 
    text(fill: color.rgb(197,94,15), "项目情况")
  )

  text(color.rgb(36,143,134), "【填写说明】逆序填写项目名称、发起任务日期、目前状态（调研、设计、开发、测试、完成等）、预期结束日期")

  table(
    columns: 5,
    table.header([*序号*], [*发起日期*], [*任务简述*], [*当前状态*], [*预期结束*]),
    ..tasks,
  )

  set par(justify: true)
  
  for report in weekly_reports {
    pagebreak()
    show_report(report)
  }
}