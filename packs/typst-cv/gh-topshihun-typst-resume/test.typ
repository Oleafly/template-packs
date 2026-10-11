#import "resume.typ": resume
#import "resume.typ": title
#import "resume.typ": subtitle

#show: doc => resume(
  name: [帅气的名称],
  contact_information: (
    "(+86)10086",
    link("mailto:MyEmail@god.com")[帅气的邮箱 #footnote("下划线为可点击的链接")],
    link("https://xxxxxx.com/xxx")[xxxx.com/xxx],
  ),
  doc,
)

#title("教育经历")

#subtitle(
  main_title: "家里蹲大学",
  sub_title: ("计算机软件学院", "计算机科学与技术"),
  description: "1999.9--2999.6",
)

== 在校奖项

名字很长的证书

名字很长的竞赛

成绩优秀，GPA或者排名前5%

#lorem(15)

= 技术能力 #footnote("第二个脚注")

- *语言*: 编程不受特定语言限制。常用Rust,Python,C；熟悉 C++, JavaScript, Lua；了解Java, TypeScript。
- *工作流*: Linux, Shell, (Neo)Vim/VScode, Git, GitHub, CMake/XMake.
- *其他*: #lorem(20)

= 项目经历

#subtitle(
  main_title: "xxx编译器",
  sub_title: ("编译xxx到xxx",),
)
- 词法分析如何如何
- 改善语法分析算法如何如何
- 中间优化可以达到xxx的水平

#subtitle(
  main_title: "很牛的项目名称",
  sub_title: ("很牛的描述",),
  description: "很长的时间或者其他",
)
- 很牛的特点
- 很长很长很长很长很长很长很长很长很长很长很长很长的句子，很长很长很长很长很长很长很长很长很长很长很长很长的句子
- 创新点
- #lorem(30)
- 牛牛牛

= 实习经历

#lorem(50)

#title("自我介绍")
- 成绩优秀
- 自我驱动力强
- 英语能力，自主阅读，四六级等
- 积极向上，乐观开朗，校园活动等
- #lorem(60)