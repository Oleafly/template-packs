// main.typ - 清华大学学位论文 Typst 模板入口文件
// --------------------------------------------------

#import "thu-thesis.typ": conf
#import "metadata.typ": settings, other_contents

// 应用模板配置
#show: doc => conf(
  ..settings, 
  doc: doc, 
  others: other_contents
)

// --- 正文开始 ---

// 包含各章节内容
#import "chapters/intro.typ": main as intro
#intro

#import "chapters/chapter1.typ": main as chapter1
#chapter1

// --- 参考文献 ---
// 参考文献样式与数据库：参考文献样式由 `settings.参考文献格式` 控制（建议使用 GB/T 7714-2015），文献数据来源为 `ref.bib`。（见《写作指南》第3章（3.4–3.5），页20-21）
// 小技巧：如需在参考文献中使用英文标点或强制英文样式，模板在此处临时切换 `lang` 为 "en"。
#pagebreak()
#set text(lang: "en") // 参考文献通常使用英文标点规范
#bibliography(
  "ref.bib",
  title: "参考文献", 
  style: settings.参考文献格式 
)
#set text(lang: "zh")
