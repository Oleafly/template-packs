// ============================================================
// 复旦大学学位论文 Typst 模板 - 使用示例
// ============================================================

#import "template/thesis.typ": thesis
#import "chapters/abstract.typ": abstract-zh, keywords-zh, abstract-en, keywords-en
#import "chapters/acknowledgements.typ": acknowledgements-content

#show: thesis.with(
  // ========== 论文基本信息 ==========
  info: (
    // 中文标题（不超过30个汉字）
    title: "复旦大学博士学位论文 Typst 模板",
    // 英文标题
    title-en: "Typst Template for Fudan University Doctoral Thesis",
    // 作者姓名
    author: "张三",
    // 学号
    student-id: "24000240000",
    // 培养单位（规范正式名称）
    school: "计算机科学技术学院",
    // 学科专业
    major: "计算机科学与技术",
    // 指导教师
    supervisor: "李四　教授",
    // 副指导教师（可选，设为 none 则不显示）
    supervisor-second: none,
    // 学位类型：bachelor / master / doctor（默认 doctor）
    degree: "doctor",
    // 学位类别："学术学位" 或 "专业学位"（可选）
    degree-category: "学术学位",
    // 密级（可选，涉密论文填写，如 "秘密五年"）
    secret-level: none,
    // 同等学力人员（默认 false）
    equivalent-education: false,
    // 英文项目（默认 false）
    english-program: false,
    // 论文提交日期（固定值便于可复现编译）
    date: datetime(year: 2026, month: 8, day: 24),
    // 中图分类号
    clc: "TP391",
  ),

  // ========== 摘要与关键词 ==========
  abstract-zh: abstract-zh,
  keywords-zh: keywords-zh,
  abstract-en: abstract-en,
  keywords-en: keywords-en,

  // ========== 编译选项 ==========
  // 盲审模式（隐藏个人信息），可通过命令行覆盖：typst compile --input blind=true main.typ
  blind: false,
  // 2026 年规范要求印刷本双面打印；电子阅读版可令为 false。
  twoside: true,
  // 目录深度
  outline-depth: 3,
  // 插图目录
  list-of-image: true,
  // 表格目录
  list-of-table: true,

  // ========== 指导小组成员（可选，扉页） ==========
  // 设为 none 则不生成扉页
  committee: ("张三　教授", "李四五　副教授", "王五　讲师"),

  // ========== 主要符号对照表（可选） ==========
  // 设为 none 则不生成；传入内容则生成符号说明页
  notation: none,
  // notation: [
  //   #table(
  //     columns: (auto, auto),
  //     stroke: none,
  //     [$alpha$], [学习率],
  //     [$beta$], [动量系数],
  //   )
  // ],

  // ========== 参考文献 ==========
  // 格式须符合 GB/T 7714—2015
  bibliography-content: bibliography(
    "ref/references.bib",
    title: "参考文献",
    style: "gb-7714-2015-numeric",
  ),

  // ========== 致谢 ==========
  acknowledgements: acknowledgements-content,

  // ========== 附录 ==========
  appendix: {
    include "chapters/appendix.typ"
  },
)

// ============================================================
// 正文章节
// ============================================================
#include "chapters/chapter1.typ"
#include "chapters/chapter2.typ"
#include "chapters/chapter3.typ"
