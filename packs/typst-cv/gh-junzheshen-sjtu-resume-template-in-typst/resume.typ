#import "template.typ": *

// 设置图标, 来源: https://fontawesome.com/icons/
// 如果要修改图标颜色, 请手动修改 svg 文件中的 fill="rgb(38, 38, 125)" 属性
#let faAward = icon("fa-award.svg")
#let faCode = icon("fa-code.svg")
#let faGraduationCap = icon("fa-graduation-cap.svg")
#let faWrench = icon("fa-wrench.svg")
#let faCompass = icon("fa-compass.svg")

// 主题颜色
#let themeColor = rgb(23, 95, 139)

// 个人信息
#let info = (
  name: "",
  school: "",
  major: "",
  phone: "",
  email: "",
  wechat: "",
)


// 设置简历选项与头部
#show: resume.with(
  // 字体基准大小
  size: 10pt,
  // 标题颜色
  themeColor: themeColor,
  info:info,
  photo_path:none
)

== #faGraduationCap 小标题

== #faCode 小标题

== #faAward 小标题

== #faCompass 小标题
