// ============================================================================
// Tufte Textbook Template
// 纯 Typst 版本 - 基于 test1/tufte 模板
// ============================================================================

#import "@preview/drafting:0.2.2": *

// ============================================================================
// 辅助函数
// ============================================================================

// 转换 content 为字符串
#let to-string(content) = {
  if type(content) == str {
    content
  } else if content.has("text") {
    content.text
  } else if content.has("children") {
    content.children.map(to-string).join("")
  } else if content.has("body") {
    to-string(content.body)
  } else if content == [ ] {
    " "
  } else {
    ""
  }
}

// 首字母着色
#let colorize-first-chars(content, color) = {
  let text-str = to-string(content)

  if text-str.len() == 0 { return [] }

  let bytes = bytes(text-str)
  let first-len = if bytes.at(0) < 128 { 1 }
    else if bytes.at(0) < 224 { 2 }
    else if bytes.at(0) < 240 { 3 }
    else { 4 }

  let first = text-str.slice(0, first-len)
  let rest = text-str.slice(first-len)

  [#text(fill: color)[#first]#rest]
}

// 宽块（跨越主文本和边栏）
#let wideblock(content) = block(width: 100% + 2.5in, content)

// ============================================================================
// Callout 系统（Obsidian 风格）
// ============================================================================

// Callout 函数
#let callout(
  body,
  type: "note",
  title: auto,
  icon: auto,
  color: auto,
) = {
  // 预定义的 callout 类型
  let types = (
    note: (
      color: rgb("#448aff"),
      icon: "📝",
      title: "Note",
    ),
    tip: (
      color: rgb("#00c853"),
      icon: "💡",
      title: "Tip",
    ),
    important: (
      color: rgb("#ff6d00"),
      icon: "⚠️",
      title: "Important",
    ),
    warning: (
      color: rgb("#ff9100"),
      icon: "⚡",
      title: "Warning",
    ),
    danger: (
      color: rgb("#ff1744"),
      icon: "🔥",
      title: "Danger",
    ),
    success: (
      color: rgb("#00e676"),
      icon: "✅",
      title: "Success",
    ),
    question: (
      color: rgb("#64dd17"),
      icon: "❓",
      title: "Question",
    ),
    example: (
      color: rgb("#7c4dff"),
      icon: "📌",
      title: "Example",
    ),
    quote: (
      color: rgb("#9e9e9e"),
      icon: "💬",
      title: "Quote",
    ),
    info: (
      color: rgb("#00b8d4"),
      icon: "ℹ️",
      title: "Info",
    ),
  )

  // 获取配置
  let config = types.at(type, default: types.note)
  let final-color = if color != auto { color } else { config.color }
  let final-icon = if icon != auto { icon } else { config.icon }
  let final-title = if title != auto { title } else { config.title }

  // 渲染 callout - 使用 stack 确保完全对齐
  block(
    width: 100%,
    breakable: true,
    stroke: (
      left: 3pt + final-color,
      top: 0.5pt + final-color.lighten(50%),
      right: 0.5pt + final-color.lighten(50%),
      bottom: 0.5pt + final-color.lighten(50%),
    ),
    radius: 4pt,
    inset: 0pt,
    spacing: 0pt,
    above: 1.2em,  // 上方间距
    below: 1.2em,  // 下方间距
    {
      stack(
        spacing: 0pt,
        // 顶部标题栏
        block(
          width: 100%,
          fill: final-color.lighten(85%),
          inset: (x: 10pt, y: 8pt),
          radius: (top: 3pt),
          spacing: 0pt,
          {
            text(
              fill: final-color.darken(20%),
              weight: "semibold",
              size: 0.95em,
              [#final-icon #h(0.3em) #final-title]
            )
          }
        ),
        // 内容区域
        block(
          width: 100%,
          fill: final-color.lighten(95%),
          inset: (x: 10pt, y: 8pt),
          spacing: 0pt,
          {
            set par(justify: true, first-line-indent: 0em)
            set text(size: 0.95em)
            body
          }
        ),
      )
    }
  )
}

// ============================================================================
// 边注系统
// ============================================================================

#let notecounter = counter("notecounter")

// 边注函数
#let note(dy: -2em, numbered: true, theme-color: rgb("#1B255A"), sansfont: "Noto Sans", content) = context {
  if numbered {
    notecounter.step()
    // 正文标记 - 真正的上标样式
    super(
      text(
        fill: theme-color,
        size: 0.65em,
        weight: "semibold",
        notecounter.display()
      )
    )
  }

  // 侧边栏部分
  text(
    size: 9pt,
    font: sansfont,
    margin-note(
      if numbered {
        text(
          size: 9pt,
          fill: theme-color,
          {
            super(
              box(
                height: 3pt,
                circle(radius: 0.9pt, stroke: 0.6pt + theme-color)
              )
            )
            h(1pt)
            notecounter.display()+"."
            h(1pt)
          }
        )
        content
      } else {
        content
      },
      dy: dy,
    ),
  )
}

// 边注引用
#let notecite(dy: -2em, supplement: none, key) = (
  context {
    let elems = query(bibliography)
    if elems.len() > 0 {
      if type(key) == label {
        cite(key)
      } else {
        let (key-val, supp, form, style) = key.fields()
        cite(key-val, supplement: supplement, style: "ieee")
        note(
          cite(key-val, form: "full"),
          dy: dy,
          numbered: false,
        )
      }
    }
  }
)

// ============================================================================
// 主模板函数
// ============================================================================

#let tufte-textbook(
  // 基本信息
  title: none,
  subtitle: none,
  shorttitle: none,
  authors: none,
  date: datetime.today(),
  abstract: none,
  logo: none,  // 添加 logo 参数

  // 布局
  margin: (left: 1in, right: 3.5in, y: 1.5in),
  paper: "a4",

  // 字体
  font: ("Linux Libertine", "Source Han Serif SC", "Noto Serif CJK SC", "SimSun"),
  sansfont: ("Noto Sans", "Source Han Sans SC", "Noto Sans CJK SC", "SimHei"),
  codefont: ("JetBrains Mono", "Fira Code", "Cascadia Code", "Consolas"),
  fontsize: 10pt,

  // 其他选项
  lang: "zh",
  region: "cn",
  sectionnumbering: "1.",
  toc: false,
  toc-title: "目录",
  toc-depth: 2,
  theme-color: rgb("#1B255A"),
  external-link-circle: true,

  // 参考文献
  bibliography-file: none,
  bibliography-title: "参考文献",
  bibliography-style: "ieee",

  // 文档主体
  doc,
) = {

  // ============================================================================
  // 文档元数据
  // ============================================================================

  if authors != none {
    set document(
      title: title,
      author: authors.map(author => to-string(author.name)),
    )
  } else {
    set document(title: title)
  }

  // ============================================================================
  // 基础文本设置
  // ============================================================================

  set text(
    fill: luma(30),
    historical-ligatures: true,
    tracking: 0.3pt
  )

  set block(spacing: 1.1em)
  set par(
    leading: 1.0em,
    justify: true,
    first-line-indent: 0em  // 不使用首行缩进
  )

  // ============================================================================
  // 图表设置
  // ============================================================================

  show figure: set figure.caption(separator: [.#h(0.3em)])
  show figure.caption: set align(left)
  show figure.caption: set text(
    font: sansfont,
    size: 8.5pt,
    style: "italic",
    fill: luma(50)
  )

  // ============================================================================
  // 表格设置（三线表）
  // ============================================================================

  // 三线表样式：顶线（粗）、表头下线（粗）、底线（粗）
  set table(
    stroke: none,
    align: center,
    inset: (x: 8pt, y: 6pt)
  )

  show table: it => {
    set text(11pt)
    block(
      width: 100%,
      {
        // 顶部粗线
        line(length: 100%, stroke: 1.2pt + luma(40))
        v(-0.5em)
        it
        v(-0.5em)
        // 底部粗线
        line(length: 100%, stroke: 1.2pt + luma(40))
      }
    )
  }

  // 表头加粗，并在下方添加粗线
  show table.cell.where(y: 0): it => {
    set text(weight: "bold")
    block(
      width: 100%,
      {
        it
        v(0.3em)
        place(bottom, line(length: 100%, stroke: 1.2pt + luma(40)))
        v(0.3em)
      }
    )
  }

  // ============================================================================
  // 代码设置
  // ============================================================================

  show raw: set text(
    font: codefont,
    size: 9pt,
    ligatures: false
  )

  show raw.where(block: true): it => {
    block(
      fill: luma(245),
      inset: 8pt,
      radius: 2pt,
      width: 100%,
      it
    )
  }

  // ============================================================================
  // 数学公式
  // ============================================================================

  set math.equation(numbering: "(1)")
  show math.equation: set block(spacing: 0.5em)

  // ============================================================================
  // 链接样式
  // ============================================================================

  show link: it => {
    it
    if external-link-circle and type(it.dest) != label  {
      sym.wj
      h(1.6pt)
      sym.wj
      super(box(height: 3.8pt, circle(radius: 1.2pt, stroke: 0.7pt + theme-color)))
    }
  }

  // ============================================================================
  // 列表设置
  // ============================================================================

  set enum(
    indent: 0.8em,
    body-indent: 0.8em,
  )
  set list(
    indent: 0.8em,
    body-indent: 0.8em,
  )

  show list: set par(justify: false)

  // ============================================================================
  // 标题设置
  // ============================================================================

  show heading: set text()
  set heading(numbering: sectionnumbering)

  show heading.where(level: 1): it => {
    v(1.5em)
    text(
      size: 16pt,
      weight: "bold",
      tracking: 0.6pt,
      font: sansfont
    )[#colorize-first-chars(it, theme-color)]
    v(1em)
  }

  show heading.where(level: 2): it => {
    block(
      width: 100%,
      {
        v(1.2em)
        text(
          size: 14pt,
          weight: "medium",
          style: "italic",
          tracking: 0.3pt
        )[#colorize-first-chars(it, theme-color)]
        v(0.8em)
      }
    )
  }

  show heading.where(level: 3): it => {
    block(
      width: 100%,
      {
        v(0.8em)
        text(
          size: 11pt,
          style: "italic",
          weight: "medium"
        )[#colorize-first-chars(it, theme-color)]
        v(0.5em)
      }
    )
  }

  // ============================================================================
  // 页面设置
  // ============================================================================

  set page(
    paper: paper,
    margin: (
      left: 1in,
      right: 3.5in,
      top: 1.5in,
      bottom: 1.5in,
    ),
    header: context {
      if counter(page).get().first() > 1 {
        block(
          width: 100% + 3.5in - 1in,
          inset: (y: 8pt),
          {
            grid(
              columns: (1fr, auto),
              gutter: 1em,
              {
                let title-text = if shorttitle != none { shorttitle } else { title }
                text(
                  font: sansfont,
                  size: 9.5pt,
                  weight: "medium",
                  tracking: 0.3pt,
                )[#colorize-first-chars(title-text, theme-color)]
              },
              {
                text(
                  font: sansfont,
                  size: 8.5pt,
                  fill: rgb(100,100,100)
                )[#counter(page).display()]
              }
            )
          }
        )
      }
    },
    footer: context {
      set text(font: sansfont, size: 8pt, fill: luma(100))
      block(
        width: 100% + 3.5in - 1in,
        align(right)[#counter(page).display()]
      )
    }
  )

  // ============================================================================
  // 封面
  // ============================================================================

  // Logo（如果提供）
  if logo != none {
    wideblock({
      align(center)[
        #v(1em)
        #logo
        #v(1em)
      ]
    })
  }

  if title != none {
    wideblock({
      set text(
        hyphenate: false,
        size: 20pt,
        font: sansfont,
        weight: "bold"
      )
      set par(
        justify: false,
        leading: 0.35em,
        first-line-indent: 0pt,
      )
      colorize-first-chars(title, theme-color)

      if subtitle != none {
        set text(size: fontsize)
        v(-0.65em)
        colorize-first-chars(subtitle, theme-color)
      }
    })
  }

  // 作者
  if authors != none {
    wideblock({
      set text(font: sansfont, size: 10pt)
      v(1em)
      for i in range(calc.ceil(authors.len() / 3)) {
        let end = calc.min((i + 1) * 3, authors.len())
        let is-last = authors.len() == end
        let slice = authors.slice(i * 3, end)
        grid(
          columns: slice.len() * (1fr,),
          gutter: fontsize,
          ..slice.map(author => align(
            left,
            {
              colorize-first-chars(author.name, theme-color)
              if "university" in author [
                \ #author.university
              ]
              if "email" in author [
                \ #to-string(author.email)
              ]
            }
          ))
        )

        if not is-last {
          v(16pt, weak: true)
        }
      }
    })
  }

  // 日期
  if date != none {
    wideblock({
      set text(font: sansfont, size: 10pt)
      v(1em)

      let formatted-date = if type(date) == datetime {
        // 中文日期格式
        if lang == "zh" {
          [#date.year() 年 #date.month() 月 #date.day() 日]
        } else {
          date.display("[month repr:long] [day], [year]")
        }
      } else {
        date
      }

      colorize-first-chars(formatted-date, theme-color)
    })
  }

  // 摘要
  if abstract != none {
    wideblock({
      set text(font: sansfont)
      colorize-first-chars(abstract, theme-color)
    })
  }

  // 目录
  if toc {
    wideblock({
      v(1em)
      set text(font: sansfont)
      outline(indent: 1em, title: none, depth: toc-depth)
    })
  }

  // ============================================================================
  // 设置 drafting 包的边注参数
  // ============================================================================

  set-page-properties()
  set-margin-note-defaults(
    stroke: none,
    side: right,
    margin-right: 2.35in,
    margin-left: 1.35in,
  )

  // ============================================================================
  // 正文设置
  // ============================================================================

  set text(
    lang: lang,
    region: region,
    font: font,
    style: "normal",
    weight: "regular",
    hyphenate: true,
    size: fontsize,
  )

  // 重置页码
  counter(page).update(1)

  // ============================================================================
  // 正文内容
  // ============================================================================

  doc

  // ============================================================================
  // 参考文献
  // ============================================================================

  if bibliography-file != none {
    pagebreak()

    wideblock({
      heading(numbering: none)[#bibliography-title]

      set text(font: sansfont)
      set par(justify: false)

      bibliography(
        bibliography-file,
        title: none,
        style: bibliography-style,
      )
    })
  }
}
