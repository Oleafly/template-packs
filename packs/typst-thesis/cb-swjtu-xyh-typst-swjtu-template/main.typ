// 字号
#import "lib/lib.typ": template, main-body, after-matter

#show: template

#main-body[
  #include "parts/绪论.typ"
  #include "parts/Typst语言原理.typ"
  #include "parts/基于Typst的论文排版.typ"
  #include "parts/排版实验及结果讨论.typ"
]

#after-matter[
  = 结论
  #include "parts/结论.typ"
  = 致谢
  #include "parts/致谢.typ"
  = 参考文献

  #bibliography(
    "assets/参考文献.bib",
    title: none,
    style: "gb-7714-2015-numeric",
  )

  = 附录
  #include "parts/附录.typ"
]
