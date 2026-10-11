// template.typ - FengruCup Thesis 模板入口
// 这是一个 facade，将所有模块功能组合并导出给用户

#import "@preview/tablem:0.3.0": tablem
#import "@preview/mitex:0.2.6": *
#import "@preview/metalogo:1.2.0": LaTeX

#import "lib/config.typ": appendix
#import "lib/components.typ": booktab, code-preview, codeblock

// 使用 noindent() 手动缩进
#let noindent() = h(-2em)

// 主配置函数
#let conf(
  year: 2026,
  cheader: none,
  ctitle: "“冯如杯”竞赛项目论文模板",
  csubtitle: "基于Typst的论文模板",
  cabstract: [],
  ckeywords: (),
  eabstract: [],
  ekeywords: (),
  outlinedepth: 3,
  listofimage: false,
  listoftable: false,
  listofcode: false,
  preview: true,
  codly-args: (:),
  supplements: (:),
  bibcontent: none,
  doc,
) = {
  import "@preview/itemize:0.2.0" as itemize
  import "@preview/cuti:0.4.0": show-cn-fakebold
  import "@preview/codly:1.3.0": *
  import "@preview/codly-languages:0.1.10": *
  import "@preview/gb7714-bilingual:0.2.0": *

  import "lib/config.typ": 字体, 字号, 引用记号
  import "lib/utils.typ": chinesenumber, chinesenumbering
  import "lib/components.typ": chineseoutline, listoffigures

  import "lib/config.typ": (
    appendixcounter, chaptercounter, equationcounter, footnotecounter, imagecounter, partcounter, rawcounter,
    tablecounter,
  )

  import "lib/pages.typ"
  import "lib/styles.typ"

  let _parse-bool(value, default) = {
    if value == none { default } else if value == "true" or value == "1" {
      true
    } else if value == "false" or value == "0" { false } else { default }
  }

  let _cli-preview = _parse-bool(sys.inputs.at("preview", default: none), none)

  let preview = if _cli-preview != none { _cli-preview } else { preview }

  // 合并用户自定义引用记号与默认值
  let merged-supplements = 引用记号
  for (key, value) in supplements {
    merged-supplements.insert(key, value)
  }

  // 智能分页函数
  let smartpagebreak = () => pagebreak(weak: true)

  let header = if cheader != none { cheader } else {
    (
      "北京航空航天大学第" + chinesenumber(year - 2025 + 35) + "届“冯如杯”竞赛主赛道参赛作品"
    )
  }

  // ========== 页面设置 ==========
  set page(
    "a4",
    margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 2cm),
    header: styles.make-header(cheader: header),
    footer: styles.make-footer(),
  )

  // ========== 全局样式 ==========
  set text(字号.正文, font: 字体.宋体, lang: "zh", top-edge: 0.91em, bottom-edge: -0.09em)
  set par(leading: .95em, spacing: .95em)
  set heading(numbering: chinesenumbering)
  show figure.where(kind: image): set figure(
    numbering: (..nums) => context {
      if appendixcounter.at(here()).first() < 10 {
        numbering("1", imagecounter.at(here()).first())
      } else {
        numbering("A.1", chaptercounter.at(here()).first(), ..nums)
      }
    },
  )
  show figure.where(kind: table): set figure(
    numbering: (..nums) => context {
      if appendixcounter.at(here()).first() < 10 {
        numbering("1", tablecounter.at(here()).first())
      } else {
        numbering("A.1", chaptercounter.at(here()).first(), ..nums)
      }
    },
  )
  show figure.where(kind: "code"): set figure(
    numbering: (..nums) => context {
      if appendixcounter.at(here()).first() < 10 {
        numbering("1", rawcounter.at(here()).first())
      } else {
        numbering("A.1", chaptercounter.at(here()).first(), ..nums)
      }
    },
  )
  set math.equation(
    numbering: (..nums) => context {
      set text(font: 字体.宋体)
      if appendixcounter.at(here()).first() < 10 {
        numbering("(1)", equationcounter.at(here()).first())
      } else {
        numbering("A.1", chaptercounter.at(here()).first(), ..nums)
      }
    },
  )
  set footnote(numbering: "①")
  show footnote.entry: it => {
    set text(字号.脚注, font: 字体.宋体)
    let loc = it.note.location()
    numbering(it.note.numbering, footnotecounter.at(here()).first())
    h(0.5em)
    it.note.body
  }

  show: itemize.default-enum-list.with(
    indent: (2em, 0.5em),
    label-baseline: "center", // 让 itemize 处理 marker 与文本的对齐
  )

  show emph: it => text(font: 字体.楷体, style: "italic", it.body)
  show raw: set text(font: 字体.代码, size: 字号.五号, top-edge: "ascender")
  show: codly-init.with()
  codly(languages: codly-languages, ..codly-args)
  show link: it => if type(it.dest) == str and preview {
    text(fill: blue)[#it]
  } else { it }

  // 应用 show 规则
  show heading: it => styles.heading-show-rule(it)
  show figure: set block(breakable: true)
  show figure: it => styles.figure-show-rule(
    it,
    supplements: merged-supplements,
  )
  show ref: it => styles.ref-show-rule(it, supplements: merged-supplements)
  set super(size: 0.67em)
  set underline(offset: 0.2em)

  show: show-cn-fakebold

  // ========== 封面页 ==========
  pages.cover-page-normal(
    ctitle: ctitle,
    csubtitle: csubtitle,
  )

  smartpagebreak()

  // ========== 中文摘要 ==========
  pages.abstract-page-zh(
    ckeywords: ckeywords,
  )[#cabstract]

  smartpagebreak()

  // ========== 英文摘要 ==========
  pages.abstract-page-en(
    ekeywords: ekeywords,
  )[#eabstract]

  smartpagebreak()

  // ========== 目录和列表 ==========
  chineseoutline(
    title: "目录",
    depth: outlinedepth,
    indent: true,
  )

  smartpagebreak()

  if listofimage {
    context {
      if (
        query(figure.where(kind: image)).filter(el => el.caption != none).len() > 0
      ) {
        listoffigures(
          title: merged-supplements.插图列表,
          supplements: merged-supplements,
        )
      }
    }
  }

  if listoftable {
    context {
      if (
        query(figure.where(kind: table)).filter(el => el.caption != none).len() > 0
      ) {
        listoffigures(
          title: merged-supplements.表格列表,
          kind: table,
          supplements: merged-supplements,
        )
      }
    }
  }

  if listofcode {
    context {
      if (
        query(figure.where(kind: "code")).filter(el => el.caption != none).len() > 0
      ) {
        listoffigures(
          title: merged-supplements.代码列表,
          kind: "code",
          supplements: merged-supplements,
        )
      }
    }
  }

  // ========== 正文 ==========
  set align(left + top)
  set par(
    justify: true,
    first-line-indent: (amount: 2em, all: true),
  )

  smartpagebreak()
  // see https://github.com/pku-typst/pkuthss-typst/issues/35
  show bibliography: _ => []

  init-gb7714.with(
    bibcontent,
    style: "numeric",
    version: "2015",
  )(doc)
  context {
    if query(cite).len() > 0 {
      smartpagebreak()
      gb7714-bibliography(
        title: heading(numbering: none)[参考文献],
        full-control: entries => {
          set text(字号.正文)
          let extra-spacing = 1pt
          set par(
            leading: 6.5pt + extra-spacing,
            spacing: 6.5pt + 3pt + extra-spacing,
            hanging-indent: 1.66em,
            first-line-indent: 0em,
            justify: true,
            justification-limits: (
              spacing: (min: 95%, max: 105%),
              tracking: (min: -0.75pt, max: 0.75pt),
            ),
          )
          // gb7714-bilingual 当前渲染结果是纯字符串，无法直接对“题名”字段加样式。
          // 这里根据条目语言（e.lang）把 rendered 里首次出现的 title 子串替换为斜体内容。
          let render-bib-entry(e) = {
            let rendered = e.rendered
            let title = e.fields.at("title", default: "")

            if e.lang == "en" and title != "" {
              let m = rendered.match(title)
              if m != none {
                let start = m.start
                let end = m.end
                let before = rendered.slice(0, start)
                let mid = rendered.slice(start, end)
                let after = rendered.slice(end)
                return [#before#emph(mid)#after#e.ref-label]
              }
            }

            [#rendered #e.ref-label]
          }
          for e in entries [
            [#e.order]
            #render-bib-entry(e)
            #parbreak()
          ]
        },
      )
    }
  }
}
