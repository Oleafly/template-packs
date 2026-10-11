// lib/components.typ - UI 组件
// 中文目录

#import "config.typ": (
  appendixcounter, chaptercounter, front-heading, partcounter, 字号, 引用记号,
)
#import "utils.typ": chinesenumbering

// 中文目录
// 使用 Typst 原生 outline + show rule 实现
#let chineseoutline(title: "目录", depth: none, indent: false) = {
  front-heading(title)

  // Word 模板中目录的行距为 20pt
  set par(leading: 10.5pt, spacing: 10.5pt, justify: true)

  show outline.entry: it => context {
    let el = it.element
    let el_loc = el.location()

    // 前置部分（part < 2）的无编号章节不出现在目录中
    if partcounter.at(el_loc).first() < 2 and el.numbering == none {
      return
    }

    // 格式化编号
    let maybe_number = if el.numbering != none {
      if el.numbering == chinesenumbering {
        chinesenumbering(
          ..counter(heading).at(el_loc),
          location: el_loc,
        )
      } else {
        numbering(el.numbering, ..counter(heading).at(el_loc))
      }
      h(1em)
    }

    // 缩进
    if indent {
      h(1em * (el.level - 1))
    }

    // Word 模板中目录中一级标题的段前间距为 6pt
    if el.level == 1 {
      v(6pt)
    }

    // 编号
    if maybe_number != none {
      link(el_loc, if el.level == 1 {
        strong(maybe_number)
      } else {
        maybe_number
      })
    }

    // 标题文本
    link(el_loc, if el.level == 1 {
      strong(el.body)
    } else {
      el.body
    })

    // 填充点
    box(width: 1fr, [#h(2pt) #box(width: 1fr, repeat[.]) #h(2pt)])

    // 页码处理：
    // - 正文第一章（counter(heading) == 1 且不是附录）会重置页码为 1
    // - 此时 outline.entry.page() 返回的是重置前的值，需要手动返回 "1"
    // - 附录第一章虽然 counter(heading) 也是 (1,)，但不会重置页码
    // - 其他章节直接使用 outline.entry.page()
    let heading_counter = counter(heading).at(el_loc)
    let is-appendix = appendixcounter.at(el_loc).first() >= 10
    let is-first-body-chapter = (
      el.level == 1
        and el.numbering != none
        and heading_counter == (1,)
        and not is-appendix
    )

    // 页码可点击跳转
    link(el_loc, if is-first-body-chapter {
      // 正文第一章，页码固定为 1
      "1"
    } else {
      it.page()
    })

    linebreak()
  }

  outline(title: none, target: heading.where(outlined: true), depth: depth)
}
