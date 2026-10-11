#import "font.typ": *

#let h1_size = 16pt // 一级标题字号
#let h2_size = 14pt // 二级标题字号
#let h3_size = 12pt // 三级标题字号
#let text_size = 10pt // 正文默认字号
#let course_size = 16pt // 课程名称字号
#let title_size = 24pt // 标题字号
#let info_size = 8pt // 作者信息、图表标题及内容字号
#let heading_size = 16pt // 章节标题字号

#let make-venue(
  course,
) = move(
  dy: -1cm,
  {
    box(
      rect(fill: rgb("004b71"), inset: 8pt, height: 2cm, width: 7cm)[
        #align(left + top)[#image("image/zju_logo.min.svg", width: 5cm)]
        #set text(fill: white, weight: 600, size: 13pt)
        #align(bottom + right)[Zhejiang University]
      ],
    )
    box([
      #set text(weight: 600, size: course_size)
      #pad(left: 10pt, bottom: 15pt, [#course])
    ])
  },
)

#let make-title(
  title,
  date,
  authors,
  language: "en",
  title_align: "center",
  title_en,
  abstract,
  keywords,
  abstract_zh,
  keywords_zh,
  include_toc,
) = {
  // --- Authors ---
  let author_info = none // Default to no author info
  if authors.len() > 0 {
    author_info = {
      // Use a block to scope the `set text`
      set text(info_size) // Default text size for author block
      if authors.len() == 1 {
        let author = authors.first()
        [
          #text(author.name) #h(1em)
          #if (author.id != "") { text(author.id) } #h(1em)
          #if (author.institution != none) { text(author.institution) } #h(1em)
          #if (author.mail != none) { link("mailto:" + author.mail, text(author.mail)) }
        ]
      } else {
        // More than one author
        grid(
          columns: authors.len(),
          row-gutter: 0.3em, // Vertical spacing within each author's stack
          column-gutter: 1.5em, // Horizontal spacing between author columns
          ..authors.map(author => align(center)[
            // Center the stack for this author
            #stack(
              dir: ttb, // Top-to-bottom arrangement of details
              spacing: 0.5em, // Spacing between items in the stack
              text(text_size, author.name, weight: "medium"),
              if author.id != "" { text(info_size, author.id) },
              if (author.institution != none) { text(text_size, author.institution) },
              if (author.mail != none) { link("mailto:" + author.mail, text(text_size, author.mail)) },
            )
          ])
        )
      }
    }
  }
  rect(width: 100%, stroke: none)[
    // --- Title ---
    #{
      set text(title_size, fill: rgb("004b71"), weight: "bold")
      if title_align == "left" {
        [#title]
      } else {
        align(center, title)
      }
    }
    // --- Date ---
    #if date != [] and date != none and date != "" {
      set text(size: info_size, fill: rgb("#1d2e36"), weight: "medium")
      if title_align == "left" {
        [\ #v(0.25em) #date]
      } else {
        align(center, date)
      }
    }
    #if title_align == "left" {
      [\ #v(0.25em) #author_info]
    } else {
      align(center, author_info)
    }]
  parbreak()

  v(10pt)

  // --- Abstract / Keywords / Table of Contents ---
  // 显示摘要和关键词（如果提供了内容）
  set par(spacing: 1em, justify: true)
  {
    set text(text_size, font: font_serif, lang: "zh")
    // Chinese Abstract
    if abstract_zh != [] and abstract_zh != none and abstract_zh != "" {
      {
        align(center)[#text(heading_size, fill: rgb("004b71"), weight: "bold")[*摘要*]]
        text[#h(2em) #abstract_zh#h(1fr)]
      }
    }
    // Chinese Keywords
    if keywords_zh.len() > 0 and keywords_zh != ("",) {
      v(0.5em)
      {
        [*关键词：* #keywords_zh.join(text("； "))]
      }
    }
  }

  {
    set text(text_size, lang: "en")
    // English Title
    if title_en != [] and title != none and title != "" {
      set text(title_size - 2pt, fill: rgb("004b71"), weight: "bold")
      if title_align == "center" {
        align(center, title_en)
      } else {
        [\ #v(1em) #title_en]
      }
    }

    // English Abstract
    if abstract != [] and abstract != none and abstract != "" {
      align(center)[#text(heading_size - 2pt, fill: rgb("004b71"), weight: "bold")[*Abstract*]]
      abstract
    }

    // English Keywords
    if keywords.len() > 0 and keywords != ("",) {
      v(0.5em)
      [*Keywords:* #keywords.join(text("; "))]
    }
  }
}

#let make-toc(
  include_toc: true,
  language: "en", // 语言，默认 "en"，可选 "zh"（中文）
) = {
  if include_toc {
    if language == "zh" {
      {
        set text(font: font_serif, lang: "zh") // Ensure correct font for "目录"
        outline(
          depth: 3,
          indent: 1.2em,
          title: [
            #text(heading_size + 2pt, fill: rgb("004b71"), weight: "bold")[目录]
            #v(1em)
          ],
        )
      }
    } else {
      outline(
        depth: 4,
        indent: 1.2em,
        title: [
          #text(heading_size, fill: rgb("004b71"), weight: "bold")[Table of Contents]
          #v(1em)],
      )
    }
  }
}

#let template(
  language: "en", // 语言，默认 "en"，可选 "zh"（中文）
  course: [course name], // 课程名称，即第一个页面右上角的内容，可能需要使用 `#text(size: xxpt)[course name]` 来调整大小
  title: [Article title], // 文章标题
  title_align: "center", // 标题对齐方式，"center" 或 "left"，默认居中
  date: [], // 日期，默认无，datetime.today() 为当前日期
  doi: "", // DOI，默认无
  authors: (
    (
      name: "",
      id: "",
      institution: "",
      mail: "",
    ), // 作者信息，name 为姓名，id 为学号，institution 为学院/研究所，mail 为邮箱
  ), // 可以设置多组信息；一组则横向排列，多组则纵向排列
  abstract_zh: [], // 中文摘要，默认为空
  keywords_zh: (), // 中文关键词，默认为空
  title_en: [], // 英文标题（如果中文论文需要英文标题），默认为空
  abstract: [], // 英文摘要，默认为空
  keywords: (), // 英文关键词，默认为空
  pagebreak_after_title: false, // 摘要后是否分页，默认 false
  include_toc: true, // 是否包含目录，默认为 true
  pagebreak_after_toc: true, // 目录后（确切说是正文内容前）是否分页，默认 true
  columns: 1, // 列数，默认 1，一般为 1 或 2
  make-venue: make-venue, // 设置顶部内容，无需关心
  make-title: make-title, // 设置标题内容，无需关心
  body,
) = {
  set page(
    paper: "a4",
    margin: (top: 1cm, bottom: 1in, x: 1.6cm),
    columns: columns,
    numbering: "1 / 1",
  )

  set text(
    text_size,
    font: font_serif,
    lang: language,
  )

  place(make-venue(course), top, scope: "parent", float: true)
  place(
    make-title(
      title,
      date,
      authors,
      language: language,
      title_align: title_align,
      title_en,
      abstract,
      keywords,
      abstract_zh,
      keywords_zh,
      include_toc,
    ),
    top,
    scope: "parent",
    float: true,
    dy: -2em,
  )
  if pagebreak_after_title {
    pagebreak()
  }
  place(
    make-toc(
      include_toc: include_toc,
      language: language,
    ),
    top + center,
    scope: "parent",
    float: true,
  )
  if pagebreak_after_toc {
    pagebreak()
  }

  /* Context setting begin */
  // --- 标题设置 ---
  set heading(numbering: "I.1.")
  show heading: set text(size: text_size + 1pt) // 默认，正文字号大一点
  show heading.where(level: 1): set text(fill: rgb("004b71"), size: h1_size) // 一级标题颜色和字号
  show heading.where(level: 2): set text(size: h2_size) // 二级标题字号
  show heading.where(level: 3): set text(size: h3_size) // 三级标题字号
  show heading: set block(below: 0.8em) // 默认标题下方间距
  show heading.where(level: 1): set block(below: 1.2em) // 一级标题下方间距
  // 20250127 的一次小更新中解决了这个问题 https://github.com/typst/typst/pull/5768
  /*   show heading: it => {
  // 依照下面的内容，为了中文段落能够顺利缩进两行，在标题下方添加一个“假行”
    // https://github.com/shuosc/SHU-Bachelor-Thesis-Typst/issues/12#issuecomment-1506872937
    it
    v(-1.0em)
    par(leading: 0em)[#text(size: 0em)[#h(0em)]]
  } */
  // 为了“不参与标注序号的标题”的引用
  show ref: it => {
    if it.element != none and it.element.func() == heading and it.element.numbering == none {
      it.element.body
    } else {
      it
    }
  }

  // --- 图表设置 ---
  show figure: set text(info_size + 1pt)
  show figure: align.with(center)
  show figure.caption: pad.with(x: 2.5%)
  show figure.caption: it => context [
    #strong[#it.supplement#it.counter.display(it.numbering)#it.separator]#it.body
  ]
  show figure.where(kind: table): it => {
    if it.has("scope") and it.scope == "parent" {
      place(
        top + center,
        scope: "parent",
        float: true,
        {
          if it.caption != none {
            align(center, it.caption)
          }
          it.body
        },
      )
    } else {
      stack(
        dir: ttb,
        spacing: 0.5em, // Adjust spacing as needed
        {
          if it.caption != none {
            align(center, it.caption)
          }
          align(center, it.body)
        },
      )
    }
  }
  // show figure.where(kind: table): it => {
  //   stack(
  //     dir: ttb,
  //     spacing: 0.75em, // Adjust spacing as needed
  //     align(center, it.caption), // Center the caption
  //     align(center, it.body), // Center the table body
  //   )
  // }

  set par(justify: true, first-line-indent: (amount: if language == "zh" { 2em } else { 0em }, all: true))
  show link: underline
  set list(
    indent: 0.25em,
    marker: (
      $bullet$,
      $triangle.filled.small.r$,
      $diamond.filled.small$,
      $square.filled.small$,
      $star.filled$,
    ),
  )
  /* Context setting end */
  body
}
