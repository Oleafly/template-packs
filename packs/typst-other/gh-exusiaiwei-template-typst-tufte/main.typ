#import "template.typ": *

#show: tufte-textbook.with(
  title: "机器学习基础教程",
  subtitle: "从理论到实践",
  authors: (
    (
      name: "张三",
      university: "某某大学",
      email: "zhangsan@example.com"
    ),
  ),
  date: datetime.today(),

  abstract: [
    本教科书系统地介绍了机器学习的基本概念、核心算法和实际应用。内容涵盖监督学习、无监督学习、深度学习等主题，适合计算机科学专业的本科生和研究生，以及对机器学习感兴趣的工程师和研究人员。
  ],

  // 可选：添加机构Logo（取消注释并提供图片路径）
  // logo: image("logo.png", width: 3cm),

  // 可选：自定义字体（默认值如下，可根据系统字体修改）
  // font: ("Linux Libertine", "Source Han Serif SC", "Noto Serif CJK SC", "SimSun"),
  // sansfont: ("Noto Sans", "Source Han Sans SC", "Noto Sans CJK SC", "SimHei"),
  // codefont: ("JetBrains Mono", "Fira Code", "Cascadia Code", "Consolas"),
  // fontsize: 10pt,

  toc: true,
  toc-depth: 2,

  theme-color: rgb("#1B255A"),

  bibliography-file: "references.bib",
  bibliography-title: "参考文献",
)

// 引入章节
#include "chapters/chapter01.typ"
#include "chapters/chapter02.typ"
#include "chapters/chapter03.typ"
