// 南通大学本科毕业设计 / 毕业论文 Typst 模板
// 版式依据 resources/ntugraduatedesign.doc 正文样式及其批注中的检测要求。
// 适用于本科毕业论文和毕业设计。

// 默认按已安装字体选择；平台参数仅用于显式固定字体方案。
#let _platform = sys.inputs.at("ntu-platform", default: "auto")
#assert(
  _platform in ("auto", "darwin", "windows", "linux"),
  message: "ntu-platform 只能是 auto、darwin、windows 或 linux",
)
#let _latin = "Times New Roman"
#let _fonts(key, official, mac-family) = {
  let allowed = if _platform in ("auto", "darwin") { (official, mac-family) } else { (official,) }
  let selected = sys.inputs.at(key, default: none)
  if selected != none {
    assert(
      selected in allowed,
      message: "不允许的字体 " + selected + "；" + key + " 仅允许 " + allowed.join("、"),
    )
    (_latin, selected)
  } else if _platform == "auto" {
    (_latin, official, mac-family)
  } else {
    (_latin, if _platform == "darwin" { mac-family } else { official })
  }
}
#let song = _fonts("song-font", "SimSun", "Songti SC")
#let hei = _fonts("hei-font", "SimHei", "Heiti SC")
#let kai = _fonts("kai-font", "KaiTi", "Kaiti SC")

#let zh-int(n) = {
  let d = ("零", "一", "二", "三", "四", "五", "六", "七", "八", "九")
  if n <= 0 { str(n) }
  else if n < 10 { d.at(n) }
  else if n == 10 { "十" }
  else if n < 20 { "十" + d.at(calc.rem(n, 10)) }
  else if n < 100 {
    let tens = calc.quo(n, 10)
    let ones = calc.rem(n, 10)
    d.at(tens) + "十" + if ones == 0 { "" } else { d.at(ones) }
  } else { str(n) }
}

#let chapter-numbering(..nums) = {
  let pos = nums.pos()
  if pos.len() == 1 {
    [第#zh-int(pos.at(0))章]
  } else {
    numbering("1.1.1", ..pos)
  }
}

#let _document-names(kind, cover-title, header-title) = {
  let kind = sys.inputs.at("kind", default: kind)
  let noun = (design: "毕业设计", thesis: "毕业论文").at(kind, default: none)
  assert(noun != none, message: "kind 只能是 \"design\"（毕业设计）或 \"thesis\"（毕业论文）")
  (
    cover: sys.inputs.at(
      "cover-title",
      default: if cover-title == none { "本科" + noun } else { cover-title },
    ),
    header: sys.inputs.at(
      "header-title",
      default: if header-title == none { "南通大学" + noun } else { header-title },
    ),
    noun: noun,
  )
}

#let _section-defaults = (
  declaration: true,
  abstract: true,
  abstract-en: true,
  toc: true,
  references: true,
  acknowledgement: true,
  appendix: true,
)

// 源码只需布尔配置；命令行字符串的解析与覆盖集中在模板中。
#let _resolve-sections(sections) = {
  for (name, enabled) in sections {
    assert(name in _section-defaults, message: "未知的文档部分：" + name)
    assert(type(enabled) == bool, message: "sections." + name + " 须为布尔值")
  }
  let result = _section-defaults + sections
  for name in result.keys() {
    let key = "show-" + name
    let value = sys.inputs.at(key, default: none)
    if value != none {
      assert(value in ("true", "false"), message: key + " 只能是 true 或 false")
      result.at(name) = value == "true"
    }
  }
  result
}

#let _default-bib = "/references/refs.bib"
#let _bib-style = "/references/gb-t-7714-2015-numeric.csl"
// 配置生效前不构造可选部分，避免布局预计算提前读取文献文件。
#let _config = state("ntu-config", none)
#let appendix-counter = counter("ntu-appendix")
#let appendix-prefix = state("ntu-appendix-prefix", none)

// Word 模板的正文行距为 1.5 倍，文档网格为 15.6pt，即基线间距 23.4pt。
// 显式文字边界避免中英文混排改变每行高度。
#let body-line = 23.4pt
#let heading-space = 7.8pt
#let _small-text = (font: song, size: 10.5pt, top-edge: 0.8em, bottom-edge: -0.2em)
#let _small-par = (first-line-indent: 0pt, leading: 0.3em, spacing: 0.3em)
#let _running-text = (font: song, size: 9pt, top-edge: 0.8em, bottom-edge: -0.2em)
// Word 的左边距与左装订线相加；binding 本身不会额外增加装订空间。
#let _page-margins = (top: 2cm, bottom: 2cm, left: 2cm + 0.5cm, right: 2cm)
#let _header-distance = 1.2cm
#let _footer-distance = 1.5cm

// 正文中的关联内容也使用解析后的开关，避免命令行与源码配置不一致。
#let when-section(name, body, otherwise: []) = context {
  let config = _config.get()
  if config != none and config.sections.at(name) { body } else { otherwise }
}

#let _reset-chapter-counters() = {
  counter(figure.where(kind: image)).update(0)
  counter(figure.where(kind: table)).update(0)
  counter(math.equation).update(0)
}

#let _subheading(it) = {
  let second-level = it.level == 2
  let spacing = if second-level { heading-space } else { 0pt }
  set text(font: song, size: if second-level { 14pt } else { 12pt }, weight: "bold")
  set par(first-line-indent: 0pt, leading: 0pt, justify: false)
  block(
    width: 100%, above: spacing, below: spacing,
    sticky: true, breakable: false,
  )[
    #if it.numbering != none {
      context numbering(it.numbering, ..counter(heading).at(it.location()))
      h(0.5em)
    }
    #it.body
  ]
}

#let _date-text(date) = {
  if type(date) == str { date }
  else { str(date.year) + "年" + str(date.month) + "月" + str(date.day) + "日" }
}

#let _field(label, value) = {
  grid(
    columns: (3.1cm, 6.17cm),
    column-gutter: 0.35em,
    align: (left + horizon, center + horizon),
    text(font: hei, size: 18pt, weight: "bold", label),
    box(
      width: 100%,
      stroke: (bottom: 0.75pt),
      inset: (bottom: 1.5pt),
      align(center)[
        #set text(font: song, size: 16pt)
        #value
      ],
    ),
  )
  v(0.65em)
}

#let _cover(meta, names) = {
  set page(header: none, footer: none, numbering: none)
  set align(center)
  set text(top-edge: 0.8em, bottom-edge: -0.2em)
  set par(leading: 0.5em, spacing: 0.5em)
  block(width: 100%, height: 100%)[
    #v(1fr)
    #image("/resources/ntu-logo.png", width: 10.42cm, height: 3.4cm, fit: "contain")
    #v(0.15cm)
    #image("/resources/ntu-badge.png", width: 3.78cm, height: 3.78cm)
    #v(5mm)
    #text(font: hei, size: 42pt, weight: "bold")[#names.cover]
    #v(0.55cm)
    #table(
      columns: (1.2cm, 12.48cm),
      rows: (1.55cm,),
      stroke: 0.6pt,
      inset: (x: 3pt, y: 4pt),
      align(center + horizon)[
        #set text(font: hei, size: 18pt)
        #set par(leading: 0.15em, first-line-indent: 0em)
        题
        #v(0.2em, weak: true)
        目
      ],
      align(center + horizon)[
        #set text(font: hei, size: 18pt, weight: "bold")
        #set par(leading: 0.35em, first-line-indent: 0em, justify: false)
        #meta.title
        #if meta.subtitle != none [
          #linebreak()
          #text(size: 18pt, weight: "regular")[#meta.subtitle]
        ]
      ],
    )
    #v(32.5mm)
    #align(center)[
      #_field("学生姓名：", meta.author)
      #_field([专#h(2em)业：], meta.major)
      #_field("指导教师：", meta.advisor)
      #_field("完成日期：", _date-text(meta.date))
    ]
    #v(2fr)
  ]
}

#let _sign-line(label, width: 6em) = {
  label
  box(width: width, stroke: (bottom: 0.75pt))[]
}

#let _declaration(names) = {
  set page(header: none, footer: none, numbering: none)
  set text(
    font: song, size: 14pt,
    top-edge: 0.8 * 31.2pt, bottom-edge: -0.2 * 31.2pt,
  )
  set par(
    justify: true, first-line-indent: (amount: 2em, all: true),
    leading: 0pt, spacing: 0pt,
  )
  v(2em)
  align(center)[
    #text(font: song, size: 22pt, weight: "bold")[诚#h(1em)信#h(1em)承#h(1em)诺#h(1em)书]
  ]
  v(1.2em)
  [#("本人承诺：所呈交的" + names.noun + "是本人在导师指导下进行的研究成果。除了文中特别加以标注和致谢的地方外，其中不包含其他人已发表或撰写过的研究成果。参与同一工作的其他同志对本研究所做的任何贡献均已在文中作了明确的说明并表示了谢意。")]
  v(2.2em)
  align(right)[
    #set par(first-line-indent: 0em)
    #_sign-line("签  名：")
    #h(0.8em)
    #_sign-line("日期：")
    #h(1em)
  ]
  v(3.2em)
  align(center)[
    #text(font: song, size: 22pt, weight: "bold")[本论文使用授权说明]
  ]
  v(1.2em)
  [本人完全了解南通大学有关保留、使用学位论文的规定，即：学校有权保留论文及送交论文复印件，允许论文被查阅和借阅；学校可以公布论文的全部或部分内容。]
  v(0.6em)
  text(font: song, size: 14pt, weight: "bold")[（保密的论文在解密后应遵守此规定）]
  v(2.2em)
  align(left)[
    #set par(first-line-indent: 0em)
    #_sign-line("学生签名：", width: 5em)
    #h(0.6em)
    #_sign-line("指导教师签名：", width: 5em)
    #h(0.6em)
    #_sign-line("日期：", width: 5em)
  ]
}

#let _front-heading(body) = {
  heading(
    level: 1, numbering: none, supplement: none,
    outlined: true, bookmarked: true, body,
  )
}

#let _keywords-zh(keywords) = {
  v(body-line)
  set par(first-line-indent: 0em, leading: 0pt, spacing: 0pt)
  text(font: song, size: 14pt, weight: "bold")[关键词：]
  text(font: song, size: 12pt)[#keywords.join("；")]
}

#let _keywords-en(keywords) = {
  v(body-line)
  set par(first-line-indent: 0em, leading: 0pt, spacing: 0pt)
  grid(
    columns: (auto, 1fr),
    column-gutter: 0.25em,
    align(left + top, text(font: _latin, size: 14pt, weight: "bold")[Keywords:]),
    text(font: _latin, size: 12pt)[#keywords.join(", ")],
  )
}

#let _toc() = {
  // 目录标题使用三倍行距，条目仍使用 1.5 倍行距。
  heading(level: 1, numbering: none, outlined: false, bookmarked: true)[目#h(1em)录]
  set par(leading: 0pt, spacing: 0pt, first-line-indent: 0em)
  outline(title: none, depth: 3, indent: 0em)
}

#let section-number() = context {
  let prefix = appendix-prefix.get()
  if prefix != none { prefix }
  else {
    let nums = counter(heading).get()
    str(if nums.len() == 0 { 1 } else { nums.first() })
  }
}

#let fig-numbering(n) = [#section-number().#n]

// 跨章引用读取目标位置的章号，图表与公式共用解析逻辑。
#let _reference(it) = context {
  let el = it.element
  if el == none or it.form == "page" {
    it
  } else {
    let figure-ref = el.func() == figure and el.numbering == fig-numbering
    let equation-ref = el.func() == math.equation and el.numbering != none
    if not (figure-ref or equation-ref) {
      it
    } else {
      let location = el.location()
      let prefix = appendix-prefix.at(location)
      let chapter = if prefix != none { prefix } else { str(counter(heading).at(location).first()) }
      let target-counter = if figure-ref { el.counter } else { counter(math.equation) }
      let n = target-counter.at(location).first()
      let supplement = if it.supplement == auto { el.supplement }
        else if type(it.supplement) == function { it.supplement(el) }
        else { it.supplement }
      link(location)[#supplement#if figure-ref [#chapter.#n] else [（#chapter.#n）]]
    }
  }
}

#let fig(body, caption: none, label: none) = {
  set text(.._small-text)
  set par(.._small-par)
  let result = figure(
    body,
    caption: caption,
    supplement: [图],
    numbering: fig-numbering,
    kind: image,
  )
  if label != none { [#result#label] } else { result }
}

#let tbl(body, caption: none, label: none) = {
  set text(.._small-text)
  set par(.._small-par)
  let make-figure(body) = figure(body, caption: caption, supplement: [表],
    numbering: fig-numbering, kind: table)
  let table-id = counter("ntu-table-id")
  table-id.step()
  context {
    // 每张表使用独立的重复计数，不影响表序或交叉引用。
    let repeats = counter("ntu-table-repeat-" + str(table-id.get().first()))
    layout(size => {
      // 一整页放得下的表仍保持整体排版；仅超出整页高度时自动续页。
      let page-height = page.height - page.margin.top - page.margin.bottom
      let long = body.func() == table and (
        measure(make-figure(body), width: size.width).height > page-height
      )
      let content = body
      if long {
        let fields = body.fields()
        let children = fields.remove("children")
        let head = children.position(it => it.func() == table.header)
        assert(head != none, message: "长表须用 table.header(...) 声明表头，才能自动续页")
        assert(
          children.filter(it => it.func() == table.header).len() == 1,
          message: "自动续表须将全部表头行写在同一个 table.header(...) 中",
        )
        let header = children.at(head)
        assert(
          header.at("repeat", default: true),
          message: "自动续表的 table.header 不可设置 repeat: false",
        )
        let columns = fields.at("columns", default: table.columns)
        let count = if type(columns) == int { columns } else { columns.len() }
        let header-fields = header.fields()
        let header-cells = header-fields.remove("children")
        let marker = table.cell(
          colspan: count, stroke: none, fill: none, inset: 0pt,
        )[
          #repeats.step()
          #context {
            if repeats.get().first() == 1 {
              if caption != none {
                block(
                  width: 100%, above: 0pt, below: 0pt, inset: (bottom: 0.65em),
                )[
                  #set par(justify: false)
                  #align(center)[表#counter(figure.where(kind: table)).display(fig-numbering)#h(1em)#caption]
                ]
              }
            } else {
              block(width: 100%, above: 0pt, below: 0pt, inset: (bottom: 3pt),
                align(right)[续表#counter(figure.where(kind: table)).display(fig-numbering)])
            }
          }
        ]
        children.at(head) = table.header(..header-fields, marker, ..header-cells)
        content = table(..fields, ..children)
      }
      show figure.where(kind: table): set block(breakable: long)
      let finish(body) = {
        let result = make-figure(body)
        if label != none { [#result#label] } else { result }
      }
      if long {
        // 表题也放入首个表头，避免页底只留下表题、表体移至下一页。
        // 保留 figure 的 caption 元数据，标签与交叉引用仍指向同一张表。
        show figure.caption: it => []
        set figure(gap: 0pt)
        finish(content)
      } else { finish(content) }
    })
  }
}

// 跨页续表：表题省略，右上角写“续表x.y”，并重复表头。
#let table-continued(number, body) = {
  set text(.._small-text)
  set par(.._small-par)
  // 调用时另起续页，不增加表格计数；表头由调用者重复提供。
  pagebreak()
  block(width: 100%, sticky: true, above: 0pt, below: 3pt, align(right)[#("续表" + number)])
  body
}

#let references() = context {
  let config = _config.get()
  // 先检查开关再构造 bibliography，关闭时不读取 Bib 或 CSL 文件。
  if config != none and config.sections.references {
    heading(level: 1, numbering: none, supplement: none, outlined: true)[参考文献]
    set text(font: song, size: 10.5pt, top-edge: 0.8 * 19pt, bottom-edge: -0.2 * 19pt)
    set par(
      first-line-indent: 0em,
      hanging-indent: 0pt,
      leading: 0pt,
      spacing: 0pt,
      justify: false,
    )
    bibliography(config.bib, title: none, style: _bib-style)
  }
}

#let acknowledgement(body) = when-section("acknowledgement", {
  heading(level: 1, numbering: none, supplement: none, outlined: true)[致#h(1em)谢]
  body
})

#let appendix(title, body) = when-section("appendix", {
  appendix-counter.step()
  context appendix-prefix.update(numbering("A", ..appendix-counter.get()))
  _reset-chapter-counters()
  heading(level: 1, numbering: none, supplement: none, outlined: true)[附#h(1em)录]
  if title != none and title != "" {
    heading(level: 2, numbering: none, outlined: false, title)
  }
  body
})

#let ntu-bachelor(
  kind: "design",
  cover-title: none,
  header-title: none,
  sections: (:),
  title: "",
  subtitle: none,
  author: "",
  major: "",
  advisor: "",
  date: (year: 2026, month: 6, day: 1),
  abstract: [],
  keywords: (),
  abstract-en: [],
  keywords-en: (),
  bib: none,
  body,
) = {
  let names = _document-names(kind, cover-title, header-title)
  let sections = _resolve-sections(sections)
  let bib = if bib == none and sections.references { _default-bib } else { bib }
  _config.update((sections: sections, bib: bib))

  set document(title: title, author: author)
  if sections.abstract {
    assert(keywords.len() >= 3 and keywords.len() <= 5, message: "中文关键词须为 3–5 个")
  }
  if sections.abstract-en {
    assert(keywords-en.len() >= 3 and keywords-en.len() <= 5, message: "英文关键词须为 3–5 个")
  }
  if sections.abstract and sections.abstract-en {
    assert(keywords-en.len() == keywords.len(), message: "中英文关键词数量须一致")
  }
  set text(
    font: song, fallback: false, size: 12pt,
    lang: "zh", region: "cn", hyphenate: false,
    overhang: false,
    top-edge: 0.8 * body-line, bottom-edge: -0.2 * body-line,
  )
  set par(
    justify: true,
    leading: 0pt,
    spacing: 0pt,
    first-line-indent: (amount: 2em, all: true),
  )
  set heading(numbering: chapter-numbering)
  set math.equation(
    supplement: [式],
    numbering: n => text(font: song, size: 12pt)[（#section-number().#n）],
  )
  set figure(gap: 0.65em)
  set table(stroke: 0.5pt, inset: (x: 6pt, y: 4pt))
  set page(
    paper: "a4",
    binding: left,
    margin: _page-margins,
    // 页眉页脚在完整边距区域内定位；Word 的距离不是 Typst 的 ascent/descent。
    header-ascent: 0pt,
    footer-descent: 0pt,
    numbering: none,
  )

  show ref: _reference

  // 关闭文献时直接移除引用；开启时避免角标后的句号落到下一行行首。
  show cite: it => if sections.references { it + "\u{2060}" } else { [] }
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.caption: it => {
    set text(.._small-text)
    set align(center)
    set par(first-line-indent: 0em, leading: 0.3em, spacing: 0.3em, justify: false)
    context {
      let mark = if it.kind == table { "表" } else { "图" }
      [#mark#it.counter.display(it.numbering)#h(1em)#it.body]
    }
  }
  show table: set text(.._small-text)
  show table: set par(.._small-par)
  // 为默认 0.5pt 表格线的外侧留位，避免描边伸入左右页边距。
  show table: it => pad(x: 0.5pt, it)
  show raw: set text(font: song, fallback: false)

  show heading.where(level: 1): it => {
    let en = it.body == [ABSTRACT]
    let toc = it.body == [目#h(1em)录]
    set text(font: if en { (_latin,) } else { hei }, size: 15pt, weight: "bold")
    set par(first-line-indent: 0pt, leading: 0pt, justify: false)
    pagebreak(weak: true)
    if it.numbering != none {
      _reset-chapter-counters()
    }
    block(
      width: 100%, above: heading-space, below: heading-space,
      inset: if toc { (y: 11.7pt) } else { 0pt }, sticky: true, breakable: false,
    )[
      #align(center)[
        #if it.numbering != none {
          context numbering(it.numbering, ..counter(heading).at(it.location()))
          h(1em)
        }
        #it.body
      ]
    ]
  }
  show heading.where(level: 2): _subheading
  show heading.where(level: 3): _subheading
  show outline.entry: it => {
    let size = if it.level == 1 { 14pt } else { 12pt }
    let font = if it.level >= 3 { kai } else { song }
    set text(font: font, size: size)
    set par(leading: 0pt, spacing: 0pt, first-line-indent: 0pt, justify: false)
    // 官方目录二、三级分别缩进 2、4 个汉字；续行与标题文本对齐。
    pad(left: (it.level - 1) * 24pt, block(width: 100%, above: 0pt, below: 0pt)[
      #it.indented(it.prefix(), it.inner())
    ])
  }

  _cover(
    (title: title, subtitle: subtitle, author: author, major: major, advisor: advisor, date: date),
    names,
  )
  pagebreak()
  if sections.declaration {
    _declaration(names)
    pagebreak()
  }

  set page(
    numbering: "I",
    header: block(width: 100%, height: _page-margins.top, inset: (top: _header-distance))[
      #set text(.._running-text)
      #set par(first-line-indent: 0pt, leading: 0pt, spacing: 0pt)
      #align(top + left)[
        #names.header
        #v(3pt)
        #line(length: 100%, stroke: 0.75pt)
      ]
    ],
    footer: block(width: 100%, height: _page-margins.bottom, inset: (bottom: _footer-distance))[
      #set text(.._running-text)
      #set text(top-edge: "bounds", bottom-edge: "bounds")
      #set par(first-line-indent: 0pt, leading: 0pt, spacing: 0pt)
      #align(center + bottom)[#context counter(page).display()]
    ],
  )
  counter(page).update(1)

  if sections.abstract {
    _front-heading[摘#h(2em)要]
    abstract
    _keywords-zh(keywords)
  }

  if sections.abstract-en {
    _front-heading[ABSTRACT]
    set text(font: _latin, size: 12pt, lang: "en")
    set par(leading: 0pt, first-line-indent: (amount: 2em, all: true))
    abstract-en
    _keywords-en(keywords-en)
  }

  if sections.toc { _toc() }

  // 正文另起一页，从阿拉伯数字 1 开始；不插入官方未要求的空白偶数页。
  pagebreak(weak: true)
  set page(numbering: "1")
  counter(page).update(1)
  body

  // 关闭时仅解析显式提供的 Bib，使 @ 引用可解析而不显示角标和列表。
  if not sections.references and bib != none {
    show bibliography: it => []
    bibliography(bib, title: none)
  }
}
