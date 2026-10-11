// template.typ
#import "utils/thm_def.typ": *
#import "utils/thm_env.typ": *

// =============================================
// 1. 定理环境创建
// =============================================
#let definition = create-thm(env_map.definition)
#let theorem = create-thm(env_map.theorem)
#let lemma = create-thm(env_map.lemma)
#let corollary = create-thm(env_map.corollary)
#let axiom = create-thm(env_map.axiom)
#let proposition = create-thm(env_map.proposition)
#let example = create-thm(env_map.example)
#let problem = create-thm(env_map.problem)
#let exercise = create-thm(env_map.exercise)
#let conclusion = create-thm(env_map.conclusion)
#let property = create-thm(env_map.property)
#let remark = create-thm(env_map.remark)
#let note = create-thm(env_map.note)
#let solution = create-thm(env_map.solution)
#let proof = create-thm(env_map.proof)


// =============================================
// 2. 主样式函数
// =============================================
#let style(doc) = {
  // -- 全局样式 --
  set page(
    paper: "a4",
    margin: (top: 2.5cm, bottom: 2.5cm, left: 2.5cm, right: 2.5cm),
    // 页脚设置：显示 "卷标-页码"
    footer: context align(right, {
      let heading_nums = counter(heading).at(here())
      // 只有在正文卷（一级标题已出现）之后才显示页码
      if heading_nums.len() > 0 and heading_nums.first() >= 1 {
        let vol_num = numbering("I", heading_nums.first())
        let page_num = counter(page).display()
        [#vol_num:#page_num]
      }
    }),
  )

  // -- 字体总设置 --
  set text(
    lang: "zh",
    region: "cn",
    size: 12pt,
  )

  // -- 段落总设置 --
  set par(
    justify: true,
    leading: 0.85em,
    spacing: 1.25em,
  )

  // -- 标题总设置 --
  set heading(numbering: "1.1.1.1")

  // -- 目录样式设置 --
  show outline.entry: it => {
    if it.level == 1 {
      // 卷标题在目录中居中、加粗、不带页码
      let numbers = counter(heading).at(it.element.location())
      let vol_num = numbering("I", numbers.at(0))
      let title = "卷" + vol_num + it.element.body
      link(it.element.location())[#align(center, block(above: 2em, below: 0.75em)[#text(1.1em, weight: "bold", title)])]
    } else {
      // 其他级别的目录条目
      let numbers = counter(heading).at(it.element.location())
      let display_num
      if it.level == 2 {
        display_num = numbering("一", numbers.at(1)) + "、 "
      } else if it.level == 3 {
        display_num = numbers.slice(1, 3).map(str).join(".") + " "
      } else {
        display_num = numbers.slice(1).map(str).join(".") + " "
      }
      let page_num = counter(page).at(it.element.location()).first()

      // 根据标题级别添加缩进
      let indent = (it.level - 2) * 1.5em

      let title = display_num + it.element.body
      block(inset: (y: 0.4em, left: indent), spacing: 0.2em)[
        #grid(
          columns: (auto, 1fr, auto),
          align: bottom,
          link(it.element.location())[#box(title)], line(length: 100%, stroke: (dash: "dotted")), str(page_num),
        )
      ]
    }
  }

  // -- 核心：自定义标题渲染规则 --
  show heading: it => {
    if it.body == [目录] {
      align(center)[
        #text(1.8em, weight: "bold", it.body)
      ]
    } else {
      set text(weight: "bold")
      let numbers = counter(heading).at(here())

      if it.level == 1 {
        // --- 卷标题 (一级) ---
        counter(page).update(1)
        let vol_num = numbers.at(0)
        let vol_prefix = "卷" + numbering("I", vol_num)
        align(center)[
          #text(font: ("Times New Roman", "SimSun"), size: 2em, vol_prefix + " " + it.body)
        ]
      } else if it.level == 2 {
        // --- 章节标题 (二级) ---
        let chap_num = numbers.at(1)
        let display_num = numbering("一", chap_num) + "、"
        block(above: 2.5em, below: 1.2em, text(1.4em, display_num + " " + it.body))
      } else if it.level == 3 {
        let display_num = numbers.slice(1, 3).map(str).join(".")
        block(above: 2em, below: 1.2em, text(1.2em, display_num + " " + it.body))
      } else if it.level == 4 {
        // --- 小节标题 (四级) ---
        let display_num = numbers.slice(1, 4).map(str).join(".")
        block(above: 1.25em, below: 1.2em, text(1.1em, display_num + " " + it.body))
      } else {
        // --- 更深层级标题 (四级及以后) ---
        let display_num = numbers.slice(1).map(str).join(".")
        block(above: 1em, below: 1.2em, ext(1em, display_num + " " + it.body))
      }
    }
  }

  doc
}
