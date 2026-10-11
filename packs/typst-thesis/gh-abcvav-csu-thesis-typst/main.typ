#import "styles/main-text-settings.typ": main-text
#import "styles/heading-settings.typ": back-page-heading
#import "styles/bilingual-bibliography.typ": bilingual-bibliography

#import "content/abstract-zh.typ": *
#import "content/abstract-en.typ": *

// 封面页信息
#let cover-info = (
  中图分类号: "",
  学校代码: "10533",      // 中南大学学校代码=10533
  UDC: "",
  学位类别: "学术学位",    // 学术学位 | 专业学位
  学位: "硕士",
  论文名称: "学位论文中文题名",
  论文英文名称: "English Name of the Thesis",
  作者姓名: "作者姓名",
  一级学科: "一级学科名称",
  二级学科: "二级学科名称",
  研究方向: "关键词组",
  二级培养单位: "计算机学院",
  指导教师: "导师姓名",
  副指导教师: "",
  答辩日期: "",
  答辩委员会主席: "",
  年: "XXXX",
  月: "XX"
)

// 中文摘要信息
#let abstract-zh-info = (
  keywords: keywords-zh,
  classification: classification-zh,
  content: content-zh
)

// 英文摘要信息
#let abstract-en-info = (
  keywords: keywords-en,
  classification: classification-en,
  content: content-en
)


#show: main-text.with(
  cover-info: cover-info,
  abstract-info: (abstract-zh-info, abstract-en-info),
  show-notation-page: true   // 是否显示符号说明页
)

// 章节正文
#include "content/chapters.typ"


#show heading: back-page-heading

// 参考文献
#bilingual-bibliography(bibliography: bibliography.with("ref.bib"))

#set heading(numbering: it => {})

// 附录。如果不需要附录，注释掉即可
#include "content/appendix.typ"

// 攻读学位期间主要的研究成果
#include "content/research-results.typ"
// 致谢
#include "content/thanks.typ"
