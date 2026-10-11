// 模板
#import "utils.typ": *
#import "colors.typ": *
#import "fonts.typ": *
#import "style.typ": *
#import "elements.typ": *

#import "@preview/cuti:0.4.0": show-cn-fakebold
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.10": *

/// 移除大括号（用于公式）
#let rm-bracket(it) = {
  show "{": ""
  show "}": ""
  it
}

/// 中文引用格式
#let ref-zh(it) = {
  let EQ = math.equation
  let el = it.element
  let count

  if el != none {
    if el.func() == EQ {
      count = counter(EQ).at(el.location())
    } else if el.kind == image {
      count = counter(figure.where(kind: image)).at(el.location())
    } else if el.kind == table {
      count = counter(figure.where(kind: table)).at(el.location())
    } else if el.kind == raw {
      count = counter(figure.where(kind: raw)).at(el.location())
    }
    link(el.location(), numbering("1", ..count))
  } else {
    it
  }
}

/// 配置图片样式
#let configure-figure() = {
  set figure(numbering: it => strong[#numbering("1.1", it)])
  set figure.caption(separator: ". ")
  set figure(numbering: num => numbering("1", num))

  show figure.caption: it => {
    set par(spacing: 0.9em, leading: 0.8em)
    set text(fill: text-secondary)
    it
  }

  show figure.where(kind: image): set figure(supplement: text("图", weight: "medium"))
  show figure.where(kind: table): set figure(supplement: text("表", weight: "medium"))
  show figure.where(kind: table): set figure.caption(position: top)
}

/// 高亮标记解析
#let parse-highlight(it) = {
  let txt = it.text
  txt = txt.replace("==", "")
  highlight-text(txt)
}

/// 主模板函数
///
/// 参数:
/// - doc: 文档内容
/// - size: 基础字号（默认 12.5pt）
/// - size-config: 字号配置覆盖
/// - font-group: 字体组配置（默认使用 fonts）
/// - pagenum: 是否显示页码
/// - footer: 页脚文本
/// - header: 页眉文本
#let template(
  doc,
  size: 12.5pt,
  size-config: (:),
  font-group: fonts,
  pagenum: true,
  footer: "",
  header: ""
) = {
  // 设置字体
  let code-font = font-group.code
  let cjk-font = font-group.cjk
  // 设置字号
  let config = define-size(size, user-config: size-config)
  apply-size-config(config)

  // 基础文本颜色
  set text(fill: text-primary)

  // 列表样式
  configure-list()

  // 段落样式
  set par(spacing: 1.24em + 0.2em, leading: 1.24em)
  set par(justify: true)

  // 公式样式
  show math.equation.where(block: true): set par(spacing: 0.7em, leading: 0.8em)
  set math.equation(numbering: "(1)")

  set underline(offset: 2pt)

  // 表格样式
  configure-table()

  // 图片样式
  configure-figure()

  // 代码块样式
  show: codly-init.with()
  codly(stroke: 0.8pt + border)
  codly(display-icon: true)
  codly(languages: codly-languages)

  // 引用样式
  show ref: ref-zh

  // 章节标题重置计数器
  show heading.where(level: 1): it => {
    counter(math.equation).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: raw)).update(0)
    it
  }

  // 标题样式
  show heading: it => configure-heading(it)

  // 中文伪粗体
  show: show-cn-fakebold

  // 中文引号字体
  show regex("[\u{201C}\u{201D}]"): it => text(it, font: cjk-font)

  // 链接样式 - 莫兰迪蓝
  show link: underline
  show link: set text(fill: morandi-blue)

  // 代码字体与背景
  show raw: set text(font: code-font)
  show raw.where(block: true): it => {
    set block(fill: bg-code)
    it
  }

  // 高亮语法 ==text==
  show regex("==(\w+)=="): parse-highlight

  // 页眉页脚 - 莫兰迪配色
  if pagenum {
    set page(
      footer: context [
        #text(footer, fill: text-secondary, weight: "medium")
        #h(1fr)
        #text(fill: text-muted)[#counter(page).display("1/1", both: true)]
      ],
      header: align(right)[#text(header, fill: morandi-blue, weight: "medium")],
      numbering: "1",
    )
    doc
  } else {
    doc
  }
}
