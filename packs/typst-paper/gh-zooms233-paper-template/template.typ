// template.typ - 简化版论文模板（无封面/声明/致谢）
// 适用于课程论文、实验报告等场景

#let _parse-bool(value, default) = {
  if value == none { default } else if value == "true" or value == "1" {
    true
  } else if value == "false" or value == "0" { false } else { default }
}

#let _cli-preview = _parse-bool(sys.inputs.at("preview", default: none), none)
#let _cli-alwaysstartodd = _parse-bool(
  sys.inputs.at("alwaysstartodd", default: none),
  none,
)

#import "@preview/itemize:0.2.0" as itemize
#import "@preview/cuti:0.4.0": show-cn-fakebold
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.10": *
#import "@preview/gb7714-bilingual:0.2.3": *

#import "lib/config.typ": appendix, 字体, 字号, 引用记号
#import "lib/utils.typ": chinesenumbering
#import "lib/components.typ": chineseoutline
#import "lib/styles.typ": (
  sym-bullet, sym-square-filled, sym-square-filled-rotated,
)
#import "lib/config.typ": (
  appendixcounter, chaptercounter, partcounter, skippedstate,
)

#import "lib/pages.typ"
#import "lib/styles.typ"

#let conf(
  ctitle: "论文标题",
  etitle: "English Title",
  cheader: "论文标题",
  cabstract: [],
  ckeywords: (),
  eabstract: none,
  ekeywords: (),
  first-line-indent: 2em,
  outlinedepth: 3,
  alwaysstartodd: true,
  preview: true,
  codly-args: (:),
  supplements: (:),
  override-bib: false,
  bibcontent: none,
  bibstyle: "numeric",
  bibversion: "2015",
  bib-cn-first: true,
  bib-pinyin-override: (:),
  doc,
) = {
  let preview = if _cli-preview != none { _cli-preview } else { preview }
  let alwaysstartodd = if _cli-alwaysstartodd != none {
    _cli-alwaysstartodd
  } else { alwaysstartodd }

  let merged-supplements = 引用记号
  for (key, value) in supplements {
    merged-supplements.insert(key, value)
  }

  let smartpagebreak = () => {
    if alwaysstartodd {
      skippedstate.update(false)
      pagebreak(weak: true)
      skippedstate.update(true)
      pagebreak(to: "odd", weak: true)
      skippedstate.update(false)
    } else {
      pagebreak(weak: true)
    }
  }

  // ========== 页面设置 ==========
  set page(
    "a4",
    margin: (top: 3cm, bottom: 2.5cm, left: 2.6cm, right: 2.6cm),
    header: styles.make-header(cheader: cheader),
    footer: styles.make-footer(),
  )

  // ========== 全局样式 ==========
  set text(字号.正文, font: 字体.宋体, lang: "zh")
  set align(center + horizon)
  set heading(numbering: chinesenumbering)
  set figure(
    numbering: (..nums) => context {
      if appendixcounter.at(here()).first() < 10 {
        numbering("1.1", chaptercounter.at(here()).first(), ..nums)
      } else {
        numbering("A.1", chaptercounter.at(here()).first(), ..nums)
      }
    },
  )
  set math.equation(
    numbering: (..nums) => context {
      set text(font: 字体.宋体)
      if appendixcounter.at(here()).first() < 10 {
        numbering("(1.1)", chaptercounter.at(here()).first(), ..nums)
      } else {
        numbering("(A.1)", chaptercounter.at(here()).first(), ..nums)
      }
    },
  )
  set footnote(numbering: "①")
  show footnote.entry: it => {
    let loc = it.note.location()
    numbering(it.note.numbering, ..counter(footnote).at(loc))
    h(0.5em)
    it.note.body
  }

  show: itemize.default-enum-list.with(
    indent: (first-line-indent, 0.5em),
    label-baseline: "center",
    list-config: (
      label-format: it => [#(
        sym-bullet(6pt),
        sym-square-filled(6pt),
        sym-square-filled-rotated(6pt),
      ).at(calc.rem(it.level - 1, 3))],
    ),
  )
  show strong: it => text(font: 字体.黑体, weight: "bold", it.body)
  show emph: it => text(font: 字体.楷体, style: "italic", it.body)
  show raw: set text(font: 字体.代码, size: 字号.五号, top-edge: "ascender")
  show: codly-init.with()
  codly(languages: codly-languages, ..codly-args)
  show link: it => if type(it.dest) == str and preview {
    text(fill: blue)[#it]
  } else { it }

  show heading: it => styles.heading-show-rule(it, smartpagebreak)
  show figure: set block(breakable: true)
  show figure: it => styles.figure-show-rule(
    it,
    supplements: merged-supplements,
  )
  show ref: it => styles.ref-show-rule(it, supplements: merged-supplements)

  // ========== 中文摘要 ==========
  pages.abstract-page-zh(
    ctitle: ctitle,
    ckeywords: ckeywords,
    first-line-indent: first-line-indent,
  )[#cabstract]

  // ========== 英文摘要 ==========
  // eabstract 为 none 时不生成英文摘要页
  if eabstract != none {
    smartpagebreak()
    pages.abstract-page-en(
      etitle: etitle,
      ekeywords: ekeywords,
      first-line-indent: first-line-indent,
    )[#eabstract]
  }

  // ========== 目录 ==========
  chineseoutline(
    title: "目录",
    depth: outlinedepth,
    indent: true,
  )

  // ========== 正文 ==========
  set align(left + top)
  set par(
    justify: true,
    first-line-indent: (amount: first-line-indent, all: true),
    leading: 10.5pt,
    spacing: 10.5pt,
  )

  let use-gb7714 = not override-bib and bibcontent != none
  if use-gb7714 {
    let make-bib = () => gb7714-bibliography(
      title: heading(numbering: none)[References],
      full-control: entries => {
        set text(字号.五号)
        let extra-spacing = if bibversion == "2015" { 1pt } else { 0pt }
        set par(
          leading: 6.5pt + extra-spacing,
          spacing: 6.5pt + 3pt + extra-spacing,
          hanging-indent: 1.66em,
          first-line-indent: 0em,
          justify: true,
        )
        if bibstyle == "author-date" {
          for e in entries [
            #e.labeled-rendered
            #parbreak()
          ]
        } else if bibstyle == "numeric" {
          for e in entries [
            [#e.order]
            #e.labeled-rendered
            #parbreak()
          ]
        }
      },
    )
    show metadata.where(value: "pkuthss-appendix"): _ => make-bib()
    init-gb7714.with(
      bibcontent,
      style: bibstyle,
      version: bibversion,
      cn-first: bib-cn-first,
      pinyin-override: bib-pinyin-override,
    )(doc)
    context {
      if query(metadata.where(value: "pkuthss-appendix")).len() == 0 {
        make-bib()
      }
    }
  } else {
    doc
  }
}
