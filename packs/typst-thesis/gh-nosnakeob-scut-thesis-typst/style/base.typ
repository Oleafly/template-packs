#import "font.typ": *
#import "../config.typ": thesis
#import "@preview/cuti:0.3.0": show-cn-fakebold
#import "@preview/hydra:0.6.3": hydra

// 基础文档设置
#let base(doc) = {
  // 页面边距上下左右各为25mm
  set page(margin: 25mm)

  // 中文文档语言：影响断字、参考文献本地化（如“等”替代“et al.”）与 theorion 环境名
  set text(lang: "zh")

  // 实现中文假粗体
  show: show-cn-fakebold

  // 脚注格式：小五号宋体
  set footnote.entry(
    separator: line(length: 30%, stroke: 0.5pt),
    clearance: 0.5em,
    gap: 0.5em,
  )
  show footnote.entry: set text(font: font.宋体, size: font_size.小五)

  doc
}

// 前置部分（摘要、目录等）
#let preliminary(doc) = {
  set par(first-line-indent: (all: true, amount: 2em), leading: 0.9em)
  set text(font: font.宋体, size: font_size.小四)

  // 页码从 I 开始，五号宋体，底部居中
  counter(page).update(1)
  set page(numbering: "I", footer: context {
    set text(font: font.宋体, size: font_size.五号)
    set align(center)
    counter(page).display("I")
  })

  doc
}

// 主体部分（绪论、正文、结论）
#let main_body(doc) = {
  set par(first-line-indent: (all: true, amount: 2em), leading: 0.9em) // 行距对齐 LaTeX 版 1.682 行距的视觉效果
  set text(font: font.宋体, size: font_size.小四)

  counter(page).update(1)
  counter(heading).update(0)

  // 页眉页脚设置
  set page(
    numbering: "1",
    footer: context {
      set text(font: font.宋体, size: font_size.五号)
      set align(center)
      counter(page).display("1")
    },
    header: context {
      set text(font: font.宋体, size: font_size.五号)
      let page_num = counter(page).get().first()

      // 页眉内容
      let header_text = if calc.odd(page_num) {
        // 奇数页：当前章（hydra，章起始页显示本章，无编号标题只显示标题）
        hydra(1, skip-starting: false)
      } else {
        // 偶数页：华南理工大学硕士学位论文
        [#("华南理工大学" + thesis.degree + "学位论文")]
      }

      // 显示页眉和下划线
      align(center)[
        #header_text
        #v(-0.5em)
        #line(length: 100%, stroke: 1.5pt)
      ]
    }
  )

  // 标题层次：章（第一章）、节（1.1）、条（1.1.1）
  set heading(numbering: "1.1")
  show heading.where(level: 1): set heading(numbering: "第一章")

  // 图表与公式按章编号：图2-1、表2-1、(2-1)，交叉引用为“图 2-1”“表 2-1”“式 (2-1)”
  // 注：i-figured 0.2.4 与 typst 0.15 引用机制不兼容（引用丢章号），故保留手写实现
  set figure(numbering: nums => context {
    let chapter = counter(heading).get().first()
    numbering("1-1", chapter, nums)
  })
  set math.equation(numbering: it => context {
    let chapter = counter(heading).get().first()
    let eq_num = counter(math.equation).get().first()
    [(#str(chapter)-#str(eq_num))]
  }, supplement: [式])
  // 中文 supplement（注意不要 set figure(kind:)，那会改写所有图表的类型）
  show figure.where(kind: image): set figure(supplement: [图])
  show figure.where(kind: table): set figure(supplement: [表])

  show heading: it => {
    // 章、节、条标题单倍行距，段前段后各0.5行
    set block(above: 0.65em, below: 0.65em)
    set par(leading: 0em, first-line-indent: 0em)

    // 根据标题级别设置对齐和字号
    let (al, f_size) = if it.level == 1 {
      (center, font_size.小二)
    } else if it.level == 2 {
      (left, font_size.小三)
    } else if it.level == 3 {
      (left, font_size.四号)
    } else {
      (left, font_size.小四)
    }

    // 一级标题另起一页，图表公式计数器按章重置
    if it.level == 1 {
      pagebreak(weak: true)
      counter(figure.where(kind: image)).update(0)
      counter(figure.where(kind: table)).update(0)
      counter(math.equation).update(0)
    }

    set align(al)
    set text(f_size, font: font.黑体)

    // 显示标题
    if it.numbering != none {
      block[#counter(heading).display(it.numbering)#h(1em)#it.body]
    } else {
      block[#it.body]
    }
  }

  // 图表题注：五号宋体居中；图题在下、表题在上
  // 用 figure 原生题注定位，图表与题注作为整体排版，不会被分页拆开
  show figure.where(kind: image): set figure.caption(position: bottom)
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.caption: set text(font: font.宋体, size: font_size.五号)
  show figure.caption: set align(center)
  set figure.caption(separator: h(0.5em))

  // 代码块样式
  show raw.where(block: true): it => {
    set text(font: font.等宽, size: font_size.小五)
    block(
      width: 100%,
      fill: rgb("#f5f5f5"),
      inset: 10pt,
      radius: 4pt,
      breakable: true,
      it
    )
  }

  // 行内代码样式
  show raw.where(block: false): it => {
    set text(font: font.等宽, size: font_size.小四)
    box(
      fill: rgb("#f5f5f5"),
      inset: (x: 3pt, y: 0pt),
      outset: (y: 3pt),
      radius: 2pt,
      it
    )
  }

  doc
}

// 结论部分（不带章号）
#let conclusion(doc) = {
  show heading.where(level: 1): set heading(numbering: none)
  doc
}

// 后置部分（参考文献、致谢等，不带章号）
#let back_matter(doc) = {
  show heading.where(level: 1): set heading(numbering: none)
  set page(
    header: context {
      set text(font: font.宋体, size: font_size.五号)
      let page_num = counter(page).get().first()
      let header_text = if calc.odd(page_num) {
        // 奇数页：当前不带章号的标题（参考文献、致谢等）
        hydra(1, skip-starting: false)
      } else {
        [#("华南理工大学" + thesis.degree + "学位论文")]
      }
      align(center)[
        #header_text
        #v(-0.5em)
        #line(length: 100%, stroke: 1.5pt)
      ]
    }
  )
  doc
}
