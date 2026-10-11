///
/// 📚 O'Reilly Textbook Template
/// 独立模板，不依赖外部包
///

// ============================================================================
// 📚 书籍配置
// ============================================================================

// 🎨 主题色
#let theme-color = rgb("#894e54")

// 📖 书籍信息
#let book-title = "深度学习基础101"
#let book-subtitle = "从理论到实践的完整指南"
#let book-author = "张三"
#let book-top-text = "THE DEFINITIVE GUIDE"
#let book-publisher = "Personal Notes"

// 🔤 字体配置

// === 正文字体（优化屏显阅读）===
#let font-serif = ("FZPingXianYaSongS-R-GB", "Source Han Serif SC", "SimSun")
#let font-sans = ("Source Han Sans", "Microsoft YaHei")
#let font-mono = ("JetBrains Mono", "Iosevka", "Consolas")

// === 封面字体（强调设计感）===
// Georgia + 思源宋体：都是衬线体，风格协调且庄重
#let font-cover-title = ("Georgia", "Source Han Serif SC", "STSong")
#let font-cover-text = ("Georgia", "Source Han Serif SC", "SimSun")

// ============================================================================
// 📄 文档模板
// ============================================================================

// 引用计数器
#let ref-counter = counter("ref-counter")

#let orly-template(doc) = {
  set document(title: book-title, author: book-author)

  set page(
    paper: "a4",
    margin: (x: 2.5cm, top: 3cm, bottom: 2.5cm),
    // 页眉：显示当前章节标题（主题色 + 细线）
    header: context {
      let page-num = counter(page).get().first()
      if page-num > 1 {
        let chapter = query(selector(heading.where(level: 1)).before(here()))
        if chapter.len() > 0 {
          let title = chapter.last().body
          set text(size: 9pt)
          align(center)[
            #text(fill: theme-color, weight: "medium")[#title]
          ]
          v(3pt)
          line(length: 100%, stroke: 0.4pt + theme-color.lighten(60%))
        }
      }
    },
    // 页脚：主题色页码
    footer: context {
      let page-num = counter(page).get().first()
      if page-num > 0 {
        align(center)[
          #text(
            font: font-sans,
            size: 10pt,
            weight: "medium",
            fill: theme-color,
          )[#page-num]
        ]
      }
    },
  )

  set text(
    font: font-serif,
    size: 11pt,
    lang: "zh",
  )

  set par(
    justify: true,
    leading: 0.75em,
    first-line-indent: 2em,
  )

  // 标题样式
  set heading(numbering: "1.1")

  // 一级标题（章节自动分页）
  show heading.where(level: 1): it => {
    pagebreak(weak: true)  // 章节前分页
    v(0.5em)
    text(
      font: font-sans,
      size: 24pt,
      weight: "bold",
      fill: theme-color,
    )[#it]
    v(1em)
  }

  show heading.where(level: 2): it => {
    v(1.5em)
    text(
      font: font-sans,
      size: 16pt,
      weight: "bold",
      fill: theme-color,
    )[#it]
    v(0.5em)
  }

  show heading.where(level: 3): it => {
    v(1em)
    text(
      font: font-sans,
      size: 13pt,
      weight: "bold",
    )[#it]
    v(0.3em)
  }

  // 代码块样式
  show raw.where(block: true): it => {
    set text(font: font-mono, size: 9pt)
    block(
      fill: luma(248),
      inset: 12pt,
      radius: 4pt,
      width: 100%,
      stroke: 0.5pt + luma(220),
      it
    )
  }

  // ========== 三线表样式 ==========
  show table: it => {
    set text(size: 10pt)
    block(
      width: 100%,
      {
        set table(
          stroke: none,
          inset: (x: 8pt, y: 6pt),
        )
        // 使用 show rule 应用三线表样式
        show table.cell.where(y: 0): set text(weight: "bold")
        it
      }
    )
  }

  // 三线表边框
  set table(
    stroke: (_, y) => (
      top: if y == 0 { 1.5pt + black } else if y == 1 { 0.75pt + black } else { 0pt },
      bottom: 1.5pt + black,
    ),
    inset: (x: 10pt, y: 8pt),
  )

  // ========== 引用样式（带小圆圈） ==========
  show ref: it => {
    text(fill: theme-color)[#it]
    h(1pt)
    box(
      baseline: 0.1em,
      circle(
        radius: 2.5pt,
        stroke: 0.6pt + theme-color,
        fill: none,
      )
    )
  }

  // 链接样式
  show link: it => {
    text(fill: theme-color, it)
  }

  // ========== 脚注样式 ==========
  set footnote.entry(
    separator: line(length: 25%, stroke: 0.5pt + luma(200)),
  )

  doc
}

// ============================================================================
// 💬 Callout 系统（提示框）
// ============================================================================

#let callout(
  body,
  type: "note",
  title: auto,
) = {
  let types = (
    note: (color: rgb("#448aff"), icon: "📝", title: "Note"),
    tip: (color: rgb("#00c853"), icon: "💡", title: "Tip"),
    important: (color: rgb("#ff6d00"), icon: "⚠️", title: "Important"),
    warning: (color: rgb("#ff9100"), icon: "⚡", title: "Warning"),
    danger: (color: rgb("#ff1744"), icon: "🔥", title: "Danger"),
    example: (color: rgb("#7c4dff"), icon: "📌", title: "Example"),
    definition: (color: theme-color, icon: "📖", title: "Definition"),
    theorem: (color: theme-color.darken(20%), icon: "📐", title: "Theorem"),
    proof: (color: luma(100), icon: "✎", title: "Proof"),
  )

  let config = types.at(type, default: types.note)
  let final-title = if title != auto { title } else { config.title }

  block(
    width: 100%,
    breakable: true,
    stroke: (left: 3pt + config.color),
    fill: config.color.lighten(92%),
    inset: (left: 12pt, right: 12pt, y: 10pt),
    radius: (right: 4pt),
    above: 1.2em,
    below: 1.2em,
    {
      text(
        fill: config.color.darken(20%),
        weight: "semibold",
        size: 0.95em,
      )[#config.icon #h(0.3em) #final-title]
      v(0.5em)
      set text(size: 0.95em)
      body
    }
  )
}

// 便捷函数
#let note = callout.with(type: "note")
#let tip = callout.with(type: "tip")
#let important = callout.with(type: "important")
#let warning = callout.with(type: "warning")
#let example-box = callout.with(type: "example")
#let definition = callout.with(type: "definition")
#let theorem = callout.with(type: "theorem")
#let proof-box = callout.with(type: "proof")

// ============================================================================
// 🎨 O'Reilly 风格封面
// ============================================================================

#let make-cover(
  cover-image: none,
  image-width: 65%,
  image-align: center,
  image-offset-x: 0pt,
) = {
  set page(margin: 0pt, paper: "a4")

  let top-bar-height = 32pt
  let title-block-top = 480pt
  let title-block-height = 150pt
  let bottom-area-height = 55pt
  let side-margin = 45pt

  box(
    width: 100%,
    height: 100%,
    {
      place(top + left, rect(width: 100%, height: 100%, fill: white))

      // 顶部色带 + 标语
      place(top, rect(width: 100%, height: top-bar-height, fill: theme-color))
      place(
        top + center,
        dy: (top-bar-height - 12pt) / 2,
        text(
          font: font-cover-text,
          size: 11pt,
          style: "italic",
          fill: white,
          tracking: 0.5pt,
        )[#book-top-text]
      )

      // 标题色块
      place(
        top + left,
        dy: title-block-top,
        rect(width: 100%, height: title-block-height, fill: theme-color)
      )

      // 标题文字
      place(
        top + left,
        dy: title-block-top + 25pt,
        dx: side-margin,
        text(
          font: font-cover-title,
          size: 32pt,
          weight: "bold",
          fill: white,
        )[#book-title]
      )

      // 副标题
      place(
        top + left,
        dy: title-block-top + 75pt,
        dx: side-margin,
        text(
          font: font-cover-text,
          size: 14pt,
          weight: "medium",
          style: "italic",
          fill: white.lighten(10%),
        )[#book-subtitle]
      )

      // 底部区域
      place(bottom, rect(width: 100%, height: bottom-area-height, fill: white))

      // Publisher
      place(
        bottom + left,
        dy: -20pt,
        dx: side-margin,
        text(
          font: font-cover-text,
          size: 14pt,
          weight: "semibold",
          fill: luma(20),
        )[#book-publisher]
      )

      // Author
      place(
        bottom + right,
        dy: -20pt,
        dx: -side-margin,
        text(
          font: font-cover-text,
          size: 12pt,
          weight: "medium",
          style: "italic",
          fill: luma(40),
        )[#book-author]
      )

      // 封面图片
      if cover-image != none {
        place(
          image-align + top,
          dy: top-bar-height + 30pt,
          dx: image-offset-x,
          box(
            height: title-block-top - top-bar-height + 30pt,
            width: image-width,
            align(center + bottom, cover-image)
          )
        )
      }
    }
  )

  pagebreak()
}

// ============================================================================
// 📑 目录
// ============================================================================

#let make-outline() = {
  text(
    font: font-sans,
    size: 24pt,
    weight: "bold",
    fill: theme-color,
  )[目录]
  v(1.5em)
  outline(title: none, indent: 2em, depth: 2)
  pagebreak()
}
