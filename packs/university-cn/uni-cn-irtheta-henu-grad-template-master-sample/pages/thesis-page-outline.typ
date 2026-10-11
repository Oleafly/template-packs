// 论文目录页生成模块
// 依据河大论文模板要求，自动构建结构清晰、层级严密的目录索引

#import "../fonts/font-def.typ": *

#let page_outline() = {
  // 开发者配置：列出不应出现在目录中的标题标签。
  // 摘要页面仍使用真正的 heading；如需调整排除项，只维护此数组即可，
  // 不向论文作者暴露额外的 project() 参数。标签匹配不受标题文字或样式变化影响。
  let excluded_headings = (<abstract-zh>, <abstract-en>)

  // 居中输出目录标题，黑体 18pt
  align(center)[
    #text(font: heiti, size: 18pt, "目　录")
  ]

  // 全局排版设定：采用宋体 12pt，行距紧凑以适应长目录内容
  set text(font: songti, size: 12pt)
  set par(leading: 0.8em, first-line-indent: 0pt)

  context {
    // 检索文档中的可目录化标题，再应用上方的开发者排除规则。
    let elements = query(heading.where(outlined: true))

    for el in elements {
      // 排除指定标题，且目录只显示三级标题及以内。
      if el.has("label") and el.label in excluded_headings { continue }
      if el.level > 3 { continue }

      // 可入目录的标题均位于正文及其后，页码采用正文的阿拉伯数字计数。
      let page_num = counter(page).at(el.location()).first()

      // 阶梯缩进控制：二级标题缩进 4.5mm，三级标题缩进 7.8mm，一级标题顶格
      if el.level == 2 { h(4.5mm) }
      if el.level == 3 { h(7.8mm) }

      // 核心渲染块：生成左侧带页码链接的索引条目
      link(el.location())[#{
        let vals = counter(heading).at(el.location())
        // 编号生成：一级标题适配“第X章”格式，其它层级沿用原本的 numbering
        let chapt_num = if el.numbering != none {
          if el.level == 1 {
            numbering("第1章", vals.first())
          } else {
            numbering(el.numbering, ..vals)
          }
        } else {none}

        // 一级标题加粗
        if el.level == 1 {
          set text(weight: "bold")
        }

        // 拼接输出：编号 + 空格 + 标题正文
        if chapt_num != none {
          chapt_num
          " "
        }
        el.body
      }]

      // 引导点线填充：左侧文本与右侧页码之间自动插入密集的虚线
      box(width: 1fr, h(0em) + box(width: 1fr, repeat[.]) + h(0em))
      // 输出右侧页码并换行
      [#page_num]
      linebreak()
    }
  }
}
