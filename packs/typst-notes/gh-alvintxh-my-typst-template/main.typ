#import "lib/lib.typ": *

#show: note.with(
  title: "物理笔记",
  subtitle: "Notes on Physics",
  author: "xh",
  affiliation: "某某大学 · 物理系",
  date: datetime.today(),
  abstract: [
    这是一份 Typst 笔记模板，覆盖公式、定理环境、代码、图片和作图。
    正文各章同时也是使用说明：想知道某个东西怎么写，翻到对应章节，
    对照 `chapters/` 里的源码抄一份就行。
  ],
  // 下面这些是可选项，注释里是默认值
  // cover: true,          // 要不要封面
  // toc: true,            // 要不要目录
  // toc-depth: 2,         // 目录展开到几级
  // chapter-break: true,  // 一级标题另起一页
  // indent: true,         // 正文首行缩进两字符
  // paper: "a4",
  // bib-style: "gb-7714-2015-numeric",  // 参考文献样式，见第 5 章
)

#include "chapters/01-usage.typ"
#include "chapters/02-math.typ"
#include "chapters/03-figures.typ"
#include "chapters/04-code.typ"
#include "chapters/05-refs.typ"

// 参考文献表：只列被引用过的条目；想全列加 full: true
#bibliography("refs.bib")
