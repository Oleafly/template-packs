#import "template.typ": *

// 设置图标, 来源: https://fontawesome.com/icons/
// 如果要修改图标颜色, 请手动修改 svg 文件中的 fill="rgb(38, 38, 125)" 属性
// 例如可以使用 VS Code 的全局文本替换功能
#let faAward = icon("icons/fa-award.svg")
#let faBuildingColumns = icon("icons/fa-building-columns.svg")
#let faCode = icon("icons/fa-code.svg")
#let faEnvelope = icon("icons/fa-envelope.svg")
#let faGithub = icon("icons/fa-github.svg")
#let faGraduationCap = icon("icons/fa-graduation-cap.svg")
#let faLinux = icon("icons/fa-linux.svg")
#let faPhone = icon("icons/fa-phone.svg")
#let faWindows = icon("icons/fa-windows.svg")
#let faWrench = icon("icons/fa-wrench.svg")
#let faWechat = icon("icons/fa-wechat.svg")
#let faLinkin = icon("icons/linkedin.png")
#let faLink = icon("icons/fa-link.svg")
#let faCertificate = icon("icons/fa-certificate.svg")
#let faScroll = icon("icons/fa-scroll.svg")
#let faUser = icon("icons/fa-user.svg")
#let faPen = icon("icons/fa-pen.svg")
#let faHouse = icon("icons/fa-house.svg")
#let faBook = icon("icons/fa-book.svg")
#let faBilibili = icon("icons/fa-bilibili.svg")
#let faYoutube = icon("icons/fa-youtube.svg")
#let faScroll_f = icon("icons/fa-scroll-flat.svg")
#let faCertificate_f = icon("icons/fa-certificate-flat.svg")


// 主题颜色 
#let themeColor = rgb(38, 38, 125)
 
// 设置简历选项与头部
#show: resume.with(
  // 字体基准大小
  size: 10pt,
  // 标题颜色
  themeColor: themeColor,
  // 控制纸张的边距
  top: 1.65cm,
  bottom: 1cm,
  left: 1cm,
  right: 1cm,
  // 如果不需要头像，则将下面的参数注释或删除
  photograph: "photo.jpg",
  backgroundImage: "CQUresumebg.jpg",
  photographWidth: 5.5em,
  gutterWidth: 2em,
)[

= 姓名

#info(
  color: themeColor,
  ( 
    icon: faPhone,
    content: "(+86)123 4567 8999"
  ),
  (
    icon: faUser,
    content: "政治面貌",
  ),
  (
    icon: faGraduationCap,
    content: "学科专业",
  ),
  (
    icon: faEnvelope,
    content: "个人邮箱地址@cqu.edu.cn",
    link: "mailto:个人邮箱地址@cqu.edu.cn"
  ),
  (
    icon: faGithub,
    content: "Github主页",
    link: "https://github.com",
  ),
  (
    icon: faWechat,
    content:"微信 ID",
  ),
  (
    icon: faLinkin,
    content:"领英账号",
    link: "https://www.linkedin.com/",
  ),
 (
    icon: faHouse,
    content:"个人主页",
    
  ),
   (
    icon: faHouse,
    content:"自定义内容",
    
  )


)
#grid(columns: (100%),
rows: (0pt),
cell(height:100%)[#h(2em)简短的个人陈述，讲述个人的学科专业、知识领域、研究兴趣、本科科研经历等。#linebreak()#h(2em)简短的个人陈述，讲述个人的学科专业、知识领域、研究兴趣、本科科研经历等。]
)

]
#show: set block(spacing: 0.5em)
#show: set par(justify: true,leading:0.45em)

== #faGraduationCap 教育背景


#grid(columns: (20%, 1fr, auto),
  rows: (5pt, auto),
  cell(height: 100%)[*重庆大学* ｜本科在读],
  cell(height: 100%)[学院名字 专业名称 GPA: x.xx/4.00 专业排名: xx/xxx],
  cell(height: 100%)[2021-至今],
  
  )

== #faCode 科研经历 
#item(
  link(
    "https://github.com/",
    [*项目研究名称*]
  ),
  [ *第十四届大学生科研训练计划（SRTP）* ],
  date[ 2022.03–2023.04 ]
)
描述项目经历与项目成果。描述项目经历与项目成果。描述项目经历与项目成果。
#linebreak()
右侧可添加证书图片/项目仓库/演示视频等链接。#box({link("https://github.com/", faCertificate_f)})

#item(
  link(
    "https://github.com/",
    [ *项目研究名称*]
  ),
  [ *2023年第一届国家级大学生创新训练项目* ],
  date[ 2023.06–2024.06 ]
)
描述项目经历与项目成果。描述项目经历与项目成果。描述项目经历与项目成果。
#linebreak()
右侧可添加证书图片/项目仓库/演示视频等链接。#box({link("https://github.com/", faAward)})

#item(
  link(
    "https://github.com/",
    [ *项目研究名称*]
  ),
  [ *2023年第一届国家级大学生创新训练项目* ],
  date[ 2023.06–2024.06 ]
)
描述项目经历与项目成果。描述项目经历与项目成果。描述项目经历与项目成果。
#linebreak()
右侧可添加证书图片/项目仓库/演示视频等链接。#box({link("https://github.com/", faScroll_f)})

== #faWrench 实习经历
#item(
  [ *实习具体部门* ],
  [*实习所在公司*],
  date[ 2023.09–2023.12 ]
)
描述实习内容描述实习内容描述实习内容。
描述实习内容描述实习内容描述实习内容。
#linebreak()
右侧可添加证书图片/项目仓库/演示视频等链接。#box({link("https://github.com/", faGithub)})

#item(
  [ *实习具体部门* ],
  [*实习所在公司*],
  date[ 2023.09–2023.12 ]
)
描述实习内容描述实习内容描述实习内容。
描述实习内容描述实习内容描述实习内容。
#linebreak()
右侧可添加证书图片/项目仓库/演示视频等链接。#box({link("https://github.com/", faYoutube)})

#item(
  [ *实习具体部门* ],
  [*实习所在公司*],
  date[ 2023.09–2023.12 ]
)
描述实习内容描述实习内容描述实习内容。
描述实习内容描述实习内容描述实习内容。
#linebreak()
右侧可添加证书图片/项目仓库/演示视频等链接。#box({link("https://github.com/", faBilibili)})

== #faBuildingColumns 校园经历
#item(
  [*职务名称*],
  [*所在单位*],
  date[ 2021.09–2024.03 ]
)
描述任职工作内容描述任职工作内容描述任职工作内容。所获荣誉称号等。
#box({link("https://github.com/", faLink)})
#item(
  [*职务名称*],
  [*所在单位*],
  date[2021.10–2024.03 ]
)描述任职工作内容描述任职工作内容描述任职工作内容。所获荣誉称号等。
#box({link("https://github.com/", faLink)})


#item(
  [*职务名称*],
  [*所在单位*],
  date[ 2022.07–2023.08]
)
描述任职工作内容描述任职工作内容描述任职工作内容。所获荣誉称号等。
#link("https://www.bilibili.com/")[《可附代表作品》]


#let rank(body) = block({
  set text(size: 5pt)
  body
})

== #faAward 荣誉奖项
+ 2024年重庆市三好学生
+ 2024年重庆市三好学生
+ 2024年重庆市三好学生
+ 2024年重庆市三好学生
+ 2024年重庆市三好学生

== #faPen 专业技能
#grid(columns: (10%, 1fr),
  //rows: (1.45em, auto),
  row-gutter:0.45em,
  cell[*编程语言*],
  cell[Python, Matlab, Java, C/C++, HTML+JavaScipt+CSS],
  cell[*技术框架*],
  cell[PyTorch, Tensorflow, Git, MySQL],
  cell[*专业工具*],
  cell[Photoshop, Premiere, Latex],
  cell[*语言能力*],
  cell[英语(CET6 XXX｜TOFEL XXX｜IELTS XXX) 普通话（XXX）],
  )

