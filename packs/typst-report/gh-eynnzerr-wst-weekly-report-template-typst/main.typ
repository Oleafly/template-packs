#import "template.typ": *
#import "data.typ": reports

#show: project.with(
  title: "[XX]周报汇集概要",
  author: "XX",
  email: "XXX@hust.edu.cn",
  tasks: ([1], [YYYY.MM.DD], [XX项目], [开发中], [YYYY.MM.DD]),
  weekly_reports: reports
)