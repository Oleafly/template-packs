#import "config.typ": thesis
#import "style/base.typ": *
// 注意：不要用 * 导入 theorem.typ——theorion 的内置环境名（如 conclusion）会遮蔽 base.typ 的同名函数
#import "style/theorem.typ": show-theorion, set-theorion-numbering, set-inherited-levels, theorem

#set document(
  title: thesis.title,
  author: thesis.author,
)

#show: base
#show: show-theorion
// 定理按章编号（状态更新需在文档流中执行）
#set-theorion-numbering("1-1")
#set-inherited-levels(1)

// 封面。学位类别、作者、导师等信息在 config.typ 中配置。
#include "cover/master.typ"
#pagebreak()

// 英文内封（如需要可添加）
// #include "cover/english_cover.typ"
// #pagebreak()

// 提名页（如需要可添加）
// #include "cover/nomination.typ"
// #pagebreak()

// 原创性声明和版权使用授权书
#include "cover/originality_copyright.typ"
#pagebreak()

// 前置部分：罗马数字页码。
#show: preliminary

// 中英文摘要
#include "chapters/abstract.typ"
#pagebreak()

// 目录
#include "chapters/outline.typ"
#pagebreak()

// 主体部分：阿拉伯数字页码，正文页眉启用。
#show: main_body

// 绪论
#include "chapters/chapter1.typ"

// 正文章节
#include "chapters/chapter2.typ"
#include "chapters/chapter3.typ"

// 结论（不带章号）
#show: conclusion
#include "chapters/conclusion.typ"

// 后置部分：章节不编号，页码继续。
#show: back_matter

// 参考文献
#include "chapters/references.typ"
#pagebreak()

// 攻读学位期间取得的研究成果
#include "chapters/achievements.typ"
#pagebreak()

// 致谢
#include "chapters/acknowledgements.typ"
