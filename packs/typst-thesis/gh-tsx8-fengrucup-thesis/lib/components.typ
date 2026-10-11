// lib/components.typ - UI 组件
// 目录、图表列表、代码块、三线表等可复用组件

#import "config.typ": appendixcounter, chaptercounter, front-heading, partcounter, 字体, 字号, 引用记号
#import "utils.typ": chinesenumbering
#import "@preview/tablem:0.3.0": three-line-table

// 中文目录
// 使用 Typst 原生 outline + show rule 实现
#let chineseoutline(title: "目录", depth: none, indent: false) = {
  front-heading(title)

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
      h(.5em)
    }

    // 缩进
    if indent {
      h(2em * (el.level - 1))
    }

    // Word 模板中目录中一级标题的段前间距为 6pt
    if el.level == 1 {
      v(6pt)
    }

    // 编号
    if maybe_number != none {
      link(el_loc, maybe_number)
    }

    // 标题文本
    link(el_loc, el.body)

    // 填充点
    box(width: 1fr, [#h(.5em) #box(width: 1fr, repeat(gap: .5em)[.]) #h(1em)])

    // 页码处理：
    // - 正文第一章（counter(heading) == 1 且不是附录）会重置页码为 1
    // - 此时 outline.entry.page() 返回的是重置前的值，需要手动返回 "1"
    // - 附录第一章虽然 counter(heading) 也是 (1,)，但不会重置页码
    // - 其他章节直接使用 outline.entry.page()
    let heading_counter = counter(heading).at(el_loc)
    let is-appendix = appendixcounter.at(el_loc).first() >= 10
    let is-first-body-chapter = (
      el.level == 1 and el.numbering != none and heading_counter == (1,) and not is-appendix
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

// 图表列表（插图、表格、代码）
// 使用 Typst 原生 outline + show rule 实现
#let listoffigures(title: "插图", kind: image, supplements: 引用记号) = {
  front-heading(title)

  show outline.entry: it => context {
    let el = it.element
    let el_loc = el.location()

    // 格式化编号（带前缀：图/表/代码）
    let prefix = if kind == image {
      supplements.图
    } else if kind == table {
      supplements.表
    } else if kind == "code" {
      supplements.代码
    } else {
      ""
    }
    let maybe_number = {
      prefix
      if appendixcounter.at(el_loc).first() < 10 {
        ""
      } else {
        numbering("A", chaptercounter.at(el_loc).first()) + "."
      }
      str(counter(figure.where(kind: kind)).at(el_loc).first())
      "  "
    }

    // 编号
    link(el_loc, maybe_number)

    // Caption 文本
    link(el_loc, el.caption.body)

    // 填充点
    box(width: 1fr, [#h(.5em) #box(width: 1fr, repeat(gap: .5em)[.]) #h(1em)])

    // 页码：使用 outline.entry.page() 获取正确的格式化页码
    link(el_loc, it.page())

    linebreak()
    v(-0.2em)
  }

  outline(title: none, target: figure.where(kind: kind))
}

// 代码块组件
// 用法: #codeblock(```python ... ```, caption: "示例代码")
#let codeblock(raw, caption: none) = {
  figure(
    {
      set align(left)
      raw
    },
    caption: caption,
    kind: "code",
    supplement: "",
  )
}

// 三线表组件
#let booktab(width: auto, caption: none, outlined: true, ..args, body) = {
  set text(字号.表文, top-edge: "ascender")

  let the-table = block(
    width: width,
    breakable: true,
    three-line-table(..args, body),
  )

  if outlined {
    figure(the-table, caption: caption, kind: table)
  } else {
    the-table
  }
}

#let code-preview(code, body) = {
  set par(first-line-indent: 0em)
  booktab(
    columns: (1fr, 1fr),
    align: (left + top, left + top),
    outlined: false,
  )[
    |#align(center)[*代码*]|#align(center)[*渲染结果*]|
    |-|-|
    |#code|#body|
  ]
}
