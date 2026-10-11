// 广东工业大学论文模板 - 通用版本

#import "fonts.typ": fonts

// =================== 通用尺寸常量 ===================

#let section-title-size = 15.75pt  // 摘要/目录等居中标题字号
#let heading-size = 16pt           // 正文一级~三级标题字号
#let heading-size-4 = 14pt         // 正文四级标题字号
#let header-footer-size = 9pt      // 页眉页脚字号

// 标题样式工厂：合并 level 2/3 的重复规则
#let body-heading(size) = it => {
  v(0.5em)
  text(font: (fonts.arial, fonts.heiti), size: size, weight: "bold")[#it.body]
  v(0.5em)
}

// =================== 通用设置 ===================

#let common-settings(body) = {
  set page(
    paper: "a4",
    margin: (top: 30mm, bottom: 25mm, left: 30mm, right: 20mm),
  )
  set text(font: (fonts.times, fonts.songti), size: 12pt, lang: "zh", weight: 400)
  set par(leading: 1.5em, first-line-indent: 2em, justify: true)
  set heading(numbering: "1.1.1")

  show heading.where(level: 1): it => {
    pagebreak(weak: true)
    v(2em)
    align(center)[
      #text(font: (fonts.arial, fonts.heiti), size: heading-size, weight: "bold")[#it.body]
    ]
    v(1.5em)
  }
  show heading.where(level: 2): body-heading(heading-size)
  show heading.where(level: 3): body-heading(heading-size)
  show heading.where(level: 4): body-heading(heading-size-4)

  show strong: set text(font: (fonts.times, fonts.heiti), weight: 400)
  show emph: set text(style: "normal")
  show figure.where(kind: image): set figure(supplement: [图])
  show figure.where(kind: table): set figure(supplement: [表])
  show figure: set text(size: 10.5pt)

  body
}

// 页眉页脚设置
#let setup-header-footer(title: "", header_text: none) = {
  [
    #set page(
      numbering: "1",
      header: context [
        #set text(font: (fonts.times, fonts.songti), size: header-footer-size)
        #align(center)[
          #if header_text != none [#header_text] else [#title]
        ]
        #v(-0.3em)
        #line(length: 100%, stroke: 0.5pt)
      ],
      footer: context [
        #align(right, text(font: fonts.times, size: header-footer-size)[#counter(page).display()])
      ]
    )
    #counter(page).update(1)
  ]
}

// 导入封面模块
#import "chapters/0-thesis-cover.typ": thesis-cover
#import "chapters/0-course-report.typ": course-report-cover

// =================== 模板函数 ===================

// 本科毕业设计（论文）
#let thesis(metadata, show_cover: true, doc_body) = {
  common-settings[
    #set page(numbering: none)

    // 封面
    #if show_cover {
      thesis-cover(metadata)
    }

    // 中文摘要
    #align(center)[
      #text(font: fonts.heiti, size: section-title-size, weight: 400)[摘  要]
    ]
    #v(1em)
    #metadata.abstract_cn
    #v(1em)
    #text(font: fonts.heiti, size: 14pt, weight: 400)[关键词：]
    #metadata.keywords_cn.join("；")

    #pagebreak()

    // 英文摘要（可选）
    #if metadata.abstract_en != [] or metadata.keywords_en != () [
      #align(center)[
        #text(font: fonts.heiti, size: section-title-size, weight: 400)[Abstract]
      ]
      #v(1em)
      #metadata.abstract_en
      #v(1em)
      #text(font: fonts.heiti, size: 14pt, weight: 400)[Keywords: ]
      #metadata.keywords_en.join("; ")
      #pagebreak()
    ]

    // 目录
    #align(center)[
      #text(font: fonts.heiti, size: section-title-size, weight: 400)[目  录]
    ]
    #v(1em)
    #outline(title: none, indent: auto, depth: 3)
    #pagebreak()

    // 正文
    #setup-header-footer(title: metadata.title, header_text: metadata.header_text)

    #doc_body
  ]
}

// 程序设计课程设计报告
#let course-report(metadata, body) = {
  common-settings[
    #set page(numbering: none)

    // 封面
    #course-report-cover(metadata)

    // 正文
    #setup-header-footer(title: metadata.title, header_text: metadata.header_text)

    #body
  ]
}

// =================== 通用组件 ===================

// 代码块组件
#let code_block(content, caption: none) = {
  figure(
    rect(
      width: 100%,
      fill: luma(250),
      stroke: luma(200),
      inset: 8pt,
      radius: 4pt,
      align(left)[
        text(font: fonts.code, size: 9pt, weight: 400)[#content]
      ]
    ),
    caption: caption,
    supplement: "程序清单"
  )
}

// 公式块样式
#show math.equation.where(block: true): it => {
  block(
    width: 100%,
    inset: 1em,
    align(center)[#it.body]
  )
}
