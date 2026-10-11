// 河大硕士论文模板主入口
// 集成所有页面模块与排版配置，通过 project() 函数提供统一调用接口
// 调用方式：在正文文件中 #import "master-template.typ": * 后接 #show: project.with(...)

#import "@preview/cuti:0.4.0": show-cn-fakebold
#import "@preview/lovelace:0.2.0": *
#import "fonts/font-def.typ": *
#import "utilities/indent-funcs.typ": *
#import "utilities/bib-cite.typ": *
#import "utilities/three-line-table.typ": *
#import "utilities/set-heading.typ": _set_heading
#import "utilities/set-figure.typ": _set_figure
#import "utilities/set-numbering.typ": _set_numbering
#import "utilities/numbering-override.typ": *
#import "pages/thesis-page-settings.typ": *
#import "utilities/fix-bibliography.typ": fix_bibliography
#import "variable/master-page-cover-zh.typ": page_cover_zh
#import "pages/thesis-page-cover-en.typ": page_cover_en
#import "pages/thesis-page-abstract-zh.typ": page_abstract_zh
#import "pages/thesis-page-abstract-en.typ": page_abstract_en
#import "pages/thesis-page-outline.typ": page_outline
#import "pages/thesis-page-references.typ": _set_references
#import "pages/thesis-page-appendix.typ": page_appendix
#import "pages/thesis-page-acknowledgement.typ": page_acknowledgement

#let project(
  anonymous: false, 
  unit_code: "", 
  id: "", 
  category_code: "", 
  title_zh: "", 
  college_name: "", 
  discipline_major: "", 
  research_area: "", 
  applied_degree_zh: "", 
  applicant_zh: "", 
  supervisor_zh: "", 
  date_zh: ("二〇二六", "四"), 
  title_en: "", 
  applied_degree_en: "", 
  applicant_en: "", 
  supervisor_en: "",
  date_en: ("2026", "Apr"), 
  abstract_zh: [], 
  keywords_zh: (),
  abstract_en: [], 
  keywords_en: (), 
  body
) = {
  // 全局排版引擎注入：标题、图表题注、编号、参考文献、缩进修复、版心、伪粗体
  show: _set_heading
  show: _set_figure
  show: _set_numbering
  show: _set_references
  show: _fix_indent
  show: _set_page_size
  show: show-cn-fakebold

  // 第一部分：封面页（中英文各一页）
  page_cover_zh(
    anonymous: anonymous, 
    unit_code: unit_code, 
    id: id, 
    category_code: category_code, 
    title_zh: title_zh, 
    college_name: college_name, 
    discipline_major: discipline_major, 
    research_area: research_area, 
    applied_degree_zh: applied_degree_zh, 
    applicant_zh: applicant_zh, 
    supervisor_zh: supervisor_zh, 
    date_zh: date_zh
  )
  page_cover_en(
    anonymous: anonymous,
    applied_degree_en: applied_degree_en,  
    title_en: title_en, 
    applicant_en: applicant_en, 
    supervisor_en: supervisor_en, 
    date_en: date_en
  )

  // 第二部分：前置部分（摘要、目录），页码重置并切换为罗马数字
  counter(page).update(1)
  show: _set_page_footer_pre
  show: _set_page_par
  page_abstract_zh(
    abstract_zh: abstract_zh, 
    keywords_zh: keywords_zh
  )
  page_abstract_en(
    abstract_en: abstract_en, 
    keywords_en: keywords_en, 
  )
  page_outline()

  // 第三部分：正文主体，页眉切换为章节名，页码切换为阿拉伯数字
  show: _set_page_header.with(anonymous: anonymous, title: title_zh)
  show:_set_page_footer_main
  counter(page).update(1)

  // 正文内容
  body

  let appendix_tbl = "appendix_tbl"
  let appendix_img = "appendix_img"
  let appendix_eqt = "appendix_eqt"
}
