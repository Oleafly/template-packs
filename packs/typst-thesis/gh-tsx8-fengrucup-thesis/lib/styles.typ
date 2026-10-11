// lib/styles.typ - 样式规则
// 页眉页脚、heading、figure、ref 等 show/set 规则

#import "config.typ": (
  appendixcounter, chaptercounter, equationcounter, footnotecounter, imagecounter, partcounter, rawcounter,
  tablecounter, 字体, 字号, 引用记号,
)
#import "utils.typ": chinesenumbering

// 从 heading 提取元数据（从 supplement 中的 metadata 获取）
#let get-heading-meta(it) = {
  if it.supplement != none and it.supplement.func() == metadata {
    it.supplement.value
  } else {
    (:)
  }
}

// 生成页眉内容
#let make-header(cheader: none) = context {
  let part = partcounter.at(here()).first()

  // 查找当前页面之后的第一个 heading（用于处理页眉在 heading 之前渲染的情况）
  let headings-after = query(selector(heading.where(level: 1)).after(here()))
  let headings-before = query(selector(heading.where(level: 1)).before(here()))
  let current-physical-page = here().page()

  // 检查当前页面是否有 heading
  let current-page-heading = if headings-after.len() > 0 {
    let next-heading = headings-after.first()
    if next-heading.location().page() == current-physical-page {
      next-heading
    } else {
      none
    }
  } else {
    none
  }

  // 检查当前页面是否是前置部分第一页（摘要页，会将 part 更新为 1）
  let is-front-first-page = if current-page-heading != none {
    let meta = get-heading-meta(current-page-heading)
    meta.at("part", default: none) == 1
  } else {
    false
  }

  // 检查当前页面是否是正文第一页（包含第一个带编号的一级标题）
  let is-body-first-page = (
    current-page-heading != none and current-page-heading.numbering != none and part < 2
  )

  // 封面区域无页眉（但如果当前页是前置部分第一页则显示）
  if part == 0 and not is-front-first-page { return }

  // 确定使用哪个 heading
  let el = if current-page-heading != none {
    current-page-heading
  } else if headings-before.len() > 0 {
    headings-before.last()
  } else {
    return
  }

  // 检查是否显示页眉
  let meta = get-heading-meta(el)
  if not meta.at("show-header", default: true) { return }

  let header-gap = 3pt

  set text(字号.页眉)
  set par(spacing: 0pt)
  set align(center)

  // 对应 Word 模板中页眉上边距
  place(top + center, dy: 1.323cm)[
    #block(width: 100%)[
      #stack(
        dir: ttb,
        spacing: 4pt,
        cheader,
        line(stroke: 0.5pt, length: 100%),
      )
    ]
  ]
}

// 生成页脚内容
#let make-footer() = context {
  let part = partcounter.at(here()).first()

  // 封面区域无页脚
  if part == 0 { return }

  set text(字号.页码)
  set align(center)

  let page-num = counter(page).at(here()).first()

  place(bottom + center)[
    #set align(bottom)
    #if part == 1 {
      numbering("i", page-num)
    } else {
      str(page-num)
    }
    // 对应 Word 模板中页脚下边距
    #v(1.75cm)
  ]

  counter(footnote).update(0)
}

// heading 尺寸计算
// 注意：一级标题直接使用 字号.一级标题，在 heading-show-rule 中处理
#let get-heading-size(level) = {
  if level == 1 {
    字号.章标题
  } else if level == 2 {
    字号.节标题
  } else if level == 3 {
    字号.条标题
  } else {
    字号.小四
  }
}

// heading 样式规则
#let heading-show-rule(it) = {
  if it.level == 1 {
    let meta = get-heading-meta(it)
    let target-part = meta.at("part", default: none)
    let should-reset-page = meta.at("reset-page", default: false)

    // 2. 状态更新
    context {
      let current-part = partcounter.at(here()).first()

      if target-part != none {
        // 显式指定 part
        partcounter.update(target-part)
      } else if it.numbering != none and current-part < 2 {
        // 第一个带编号章节自动进入正文
        partcounter.update(2)
      }

      // 重置页码
      if should-reset-page or (it.numbering != none and current-part < 2) {
        counter(page).update(1)
      }
    }

    // 3. 计数器重置（仅正文章节）
    if it.numbering != none {
      chaptercounter.step()
    }
  }

  // 4. 渲染
  set align(if it.level == 1 { center } else { left })
  set text(size: get-heading-size(it.level), font: 字体.黑体, weight: "regular")
  set block(below: 0.7em, above: 1.2em)
  it
}

// figure 样式规则
#let figure-show-rule(it, supplements: 引用记号) = [
  #set align(center)
  #if not it.has("kind") {
    it
  } else if it.kind == image {
    it.body
    [
      #set text(字号.图题, font: 字体.宋体, weight: "bold")
      #context {
        (
          supplements.图 + it.counter.display(it.numbering) + "  "
        )
        if it.caption != none {
          it.caption.body
        }
      }
    ]
  } else if it.kind == table {
    [
      #set text(字号.表题, font: 字体.宋体, weight: "bold")
      #context {
        (
          supplements.表 + it.counter.display(it.numbering) + "  "
        )
        if it.caption != none {
          it.caption.body
        }
      }
    ]
    it.body
  } else if it.kind == "code" {
    [
      #set text(字号.五号, font: 字体.宋体, weight: "bold")
      #context { supplements.代码 + it.counter.display(it.numbering) + "   " }
      #it.caption.body
    ]
    it.body
  } else {
    // 未知类型的 figure 保持原样
    it
  }
]

// ref 样式规则
#let ref-show-rule(it, supplements: 引用记号) = {
  if it.element == none {
    // 参考文献引用保持原样
    it
  } else {
    // 移除前后空白
    h(0em, weak: true)

    let el = it.element
    let el_loc = el.location()
    if el.func() == math.equation {
      // 公式引用
      if appendixcounter.at(here()).first() < 10 {
        link(el_loc, [
          #supplements.公式
          (#str(equationcounter.at(el_loc).first()))
        ])
      } else {
        link(el_loc, [
          #supplements.公式
          #numbering("A", chaptercounter.at(here()).first()).#str(equationcounter.at(el_loc).first())
        ])
      }
      h(0.25em, weak: true)
    } else if el.func() == figure {
      // 图表引用
      let prefix = if el.kind == image {
        supplements.图
      } else if el.kind == table {
        supplements.表
      } else if el.kind == "code" {
        supplements.代码
      } else {
        supplements.图表
      }
      let maybe_number = {
        prefix
        if appendixcounter.at(here()).first() < 10 {
          ""
        } else {
          numbering("A", chaptercounter.at(here()).first()) + "."
        }
        str(el.counter.at(el_loc).first())
      }
      link(el_loc, maybe_number)
    } else if el.func() == heading {
      // 章节引用
      let res = (
        "第"
          + if appendixcounter.at(here()).first() < 10 { str(counter(heading).at(el_loc).at(0)) } else {
            numbering("A", chaptercounter.at(here()).first())
          }
      )
      let arr = ("章", "节", "条")
      for (idx, val) in counter(heading).at(el_loc).enumerate() {
        if idx == 0 {
          continue
        }
        res += "." + str(val)
      }
      if el.level <= 3 {
        res += arr.at(el.level - 1)
      }
      link(el_loc, res)
    } else {
      it
    }

    h(0em, weak: true)
  }
}
