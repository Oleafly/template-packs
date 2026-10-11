#import "../lib.typ": event, info, item

// 信息
#show: info.with(
  name: "Hobr",
  email: "mail@hobr.site",
  phone: "114514",
  github: "github.com/Hobr",
  photo: "photo.jpg",
  desc: [你好],
)

= 技能

#show: item(title: "常用语言", content: ("Python", "JavaScript", "C++"))

= 项目

#show: event(
  title: "名称",
  type: "类型",
  start: "开始时间",
  end: "结束时间",
  desc: [项目描述],
  link: "项目链接",
)

= 经历

#show: event(
  title: "项目名称",
  type: "项目类型",
  start: "开始时间",
  end: "结束时间",
  desc: [项目描述],
  link: "项目链接",
)

= 教育

#show: event(
  title: "名称",
  type: "类型",
  start: "开始时间",
  end: "结束时间",
  desc: [项目描述],
  link: "项目链接",
)
