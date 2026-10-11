#let create_report(
  date: "",
  overview: [],
  details: [],
  plans: [],
) = (
  date: date,
  overview: overview,
  details: details,
  plans: plans,
)

#let show_report(report) = {
  heading(
    depth: 1, 
    text(fill: color.rgb(58,94,34), report.date)
  )
  text(color.rgb(36,143,134), "【填写说明】Y 后面写年份、W 后面写周次、后续是本周日期范围，从周一到周日")
  heading(
    depth: 2, 
    text(fill: color.rgb(197,94,15), "1.任务概述")
  )
  report.overview
  heading(
    depth: 2, 
    text(fill: color.rgb(197,94,15), "2.任务详述")
  )
  report.details
  heading(
    depth: 2, 
    text(fill: color.rgb(197,94,15), "3.下周计划")
  )
  report.plans
}