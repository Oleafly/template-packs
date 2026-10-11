#import "template/bupt-thesis.typ": thesis
#import "frontmatter/nomenclature.typ": nomenclature
#import "backmatter/experience.typ": experience

// 论文元数据集中填写于此。示例值均为占位内容，不包含真实个人信息。
#let info = (
  title_zh: (
    [研究生学位论文],
    [题目第二行],
  ),
  title_en: (
    [Graduate Thesis],
    [Title],
  ),
  student_id: "0000000000",
  author_zh: "请填写姓名",
  author_en: "Author Name",
  major_zh: "请填写学科专业",
  major_en: "Subject or Major",
  supervisor_zh: "请填写导师姓名及职称",
  supervisor_en: "Supervisor Name",
  institute_zh: "请填写学院",
  institute_en: "School or Institute",
  degree: "master", // "master" 或 "doctor"
  degree_type: "academic", // "academic" 或 "professional"
  study_mode: "full-time", // "full-time" 或 "part-time"
  confidentiality: "公开",
  confidentiality_en: "Public",
  date: (year: 2027, month: 6, day: 1),
  defense_date: (year: 2027, month: 5, day: 20),
)

#let committee = (
  (role: [主席], name: [], title: [], affiliation: []),
  (role: [委员], name: [], title: [], affiliation: []),
  (role: [委员], name: [], title: [], affiliation: []),
  (role: [委员], name: [], title: [], affiliation: []),
  (role: [委员], name: [], title: [], affiliation: []),
  (role: [秘书], name: [], title: [], affiliation: []),
)

#let settings = (
  // 默认生成连续电子版；也可用 --input print-mode=true 临时生成双面打印版。
  print_mode: sys.inputs.at("print-mode", default: "false") == "true",
  show_english_cover: true,
  show_committee: true,
  show_statement: true,
  show_nomenclature: true,
  toc_depth: 3,
  body_line_spacing: 20pt,
)

#show: thesis.with(
  info: info,
  committee: committee,
  settings: settings,
  abstract_zh: (
    body: include "frontmatter/abstract-zh.typ",
    keywords: ("Typst", "学位论文", "北京邮电大学", "模板"),
  ),
  abstract_en: (
    body: include "frontmatter/abstract-en.typ",
    keywords: ("Typst", "graduate thesis", "BUPT", "template"),
  ),
  nomenclature: nomenclature,
  references: bibliography(
    "bibliography/references.bib",
    style: "gb-7714-2015-numeric",
    title: none,
  ),
  appendix: include "backmatter/appendix.typ",
  acknowledgement: include "backmatter/acknowledgement.typ",
  achievements: include "backmatter/achievements.typ",
  experience: experience,
)

#include "chapters/chapter1.typ"
#include "chapters/chapter2.typ"
