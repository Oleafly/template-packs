// Fudan SDS thesis Typst style module.

#let song-fonts = ("SimSun", "Noto Serif CJK SC", "NSimSun")
#let hei-fonts = ("SimHei", "Microsoft YaHei", "STXihei")
#let latin-fonts = ("Times New Roman",)
#let body-fonts = latin-fonts + song-fonts

#let xiaosi = 12pt
#let xiaowu = 9pt
#let sihao = 14pt
#let sanhao = 16pt
#let cover-label-text-width = 4.4em
#let cover-label-width = cover-label-text-width + 0.9em

#let today-date() = {
  let date = datetime.today()
  str(date.year()) + "年" + str(date.month()) + "月" + str(date.day()) + "日"
}

#let cover-label(label, first-column: false) = {
  let chars = label.clusters()
  let display-chars = if first-column and chars.len() == 2 {
    (chars.first(), [], [], chars.last())
  } else {
    chars
  }
  box(width: cover-label-width)[
    #box(width: cover-label-text-width)[
      #grid(
        columns: display-chars.map(_ => 1fr),
        ..display-chars.map(ch => align(center, ch)),
      )
    ]：
  ]
}

#let cover-value(body) = align(left + horizon, body)
#let cover-student-id-value(body) = align(left + horizon, move(dy: 0.12em, body))

#let abstract-meta(label, body) = block(width: 100%, above: 0pt, below: 0.2em)[
  #set par(first-line-indent: 0pt)
  #align(left)[#text(font: hei-fonts, weight: "bold", label)#h(0.25em)#body]
]

#let subimage(label, body, label-position: bottom, label-dx: 0pt) = {
  let label-body = align(center, move(dx: label-dx, text(font: latin-fonts, )[(#label)]))
  let parts = if label-position == top {
    (label-body, body)
  } else {
    (body, label-body)
  }
  stack(dir: ttb, spacing: 0.3em, ..parts)
}

#let chinese-number(n) = {
  let nums = (
    "零", "一", "二", "三", "四", "五", "六", "七", "八", "九",
    "十", "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十",
  )
  if n >= 0 and n < nums.len() {
    nums.at(n)
  } else {
    str(n)
  }
}

#let thesis-numbering(..nums) = {
  let nums = nums.pos()
  if nums.len() == 1 {
    "第" + chinese-number(nums.at(0)) + "章"
  } else {
    nums.map(n => str(n)).join(".")
  }
}

#let chaptered-figure-numbering(n) = context {
  let nums = counter(heading).get()
  if nums.len() == 0 {
    str(n)
  } else {
    let chapter = nums.first()
    if chapter == 0 {
      str(n)
    } else {
      str(chapter) + "." + str(n)
    }
  }
}

#let header-text(body) = text(font: hei-fonts, size: xiaowu, weight: "bold", fill: black, body)
#let footer-text(body) = text(font: hei-fonts, size: xiaowu, weight: "bold", fill: black, body)
#let enum-numbering(n) = move(dy: 0.12em, numbering("(1)", n))

#let centered-footer(fmt) = align(center, footer-text(context counter(page).display(fmt)))
#let centered-front-footer(fmt) = align(
  center,
  text(font: latin-fonts, size: xiaowu, fill: black, context counter(page).display(fmt)),
)

#let current-level-one-at(physical-page) = {
  let chapters = query(selector(heading.where(level: 1))).filter(ch => ch.location().page() <= physical-page)
  if chapters.len() == 0 {
    none
  } else {
    chapters.last()
  }
}

#let chapter-first-page-at(physical-page) = {
  let current = current-level-one-at(physical-page)
  current != none and current.location().page() == physical-page
}

#let page-has-content-at(physical-page) = {
  let on-page(elements) = elements.filter(it => it.location().page() == physical-page)
  let has-heading = on-page(query(selector(heading))).len() > 0
  let has-par = on-page(query(selector(par))).len() > 0
  let has-figure = on-page(query(selector(figure))).len() > 0
  let has-equation = on-page(query(selector(math.equation))).len() > 0
  has-heading or has-par or has-figure or has-equation
}

#let thesis-header(header-title: [复旦大学大数据学院]) = context {
  let physical-page = here().page()
  if not page-has-content-at(physical-page) or chapter-first-page-at(physical-page) {
    none
  } else {
    let arabic-page = counter(page).get().first()
    let current = current-level-one-at(physical-page)
    let title = if current == none {
      []
    } else {
      let nums = counter(heading).at(current.location())
      let prefix = if current.numbering == none {
        []
      } else {
        let numbering = current.numbering
        numbering(nums.first())
      }
      prefix + h(1em) + current.body
    }
    let center-title = if calc.odd(arabic-page) { title } else { header-title }

    stack(
      dir: ttb,
      spacing: 2pt,
      grid(
        columns: (1fr, 2fr, 1fr),
        align(left, if calc.even(arabic-page) { header-text(counter(page).display("1")) } else { [] }),
        align(center, header-text(center-title)),
        align(right, if calc.odd(arabic-page) { header-text(counter(page).display("1")) } else { [] }),
      ),
      line(length: 100%, stroke: 0.5pt),
    )
  }
}

#let thesis-footer = context {
  let physical-page = here().page()
  if not page-has-content-at(physical-page) {
    none
  } else if chapter-first-page-at(physical-page) {
    centered-footer("1")
  } else {
    none
  }
}

#let numbered-chapter-pagebreak() = {
  pagebreak(to: "odd", weak: true)
}

#let thesis(
  body,
  info: (
    title: "中文标题",
    english-title: "English Title",
    author: "匿名",
    student-id: "XXXXXXXXXX",
    faculty: "大数据学院",
    major: "统计学",
    supervisor: "某某教授",
    supervisor-title: "教授",
    supervisor-faculty: "复旦大学大数据学院",
    header-title: [复旦大学大数据学院],
    date: today-date(),
    blind-review: true,
  ),
  link-fill: black,
  page-margin: (top: 30mm, bottom: 25mm, left: 26mm, right: 26mm),
) = {
  set document(
    title: info.title,
    author: if info.blind-review { "匿名" } else { info.author },
  )
  set page(
    paper: "a4",
    margin: page-margin,
    header-ascent: 5mm,
    header: none,
    footer-descent: 7.5mm,
    footer: none,
  )
  set text(font: body-fonts, size: xiaosi, fill: black, lang: "zh")
  set par(justify: true, first-line-indent: (amount: 2em, all: true), leading: 8pt)
  set heading(numbering: thesis-numbering)
  set figure(numbering: chaptered-figure-numbering)
  set enum(numbering: enum-numbering, spacing: 0.8em, number-align: end + top)
  set list(spacing: 0.8em)
  show enum: set text(top-edge: "ascender", bottom-edge: "descender")
  show table.cell: set text(top-edge: "ascender", bottom-edge: "descender")
  show link: set text(fill: link-fill)
  show ref: set text(fill: link-fill)
  show outline.entry: it => {
    let prefix = it.prefix()
    let body = it.body()
    let left = if it.level == 1 {
      let gap = if prefix == none { [] } else { h(0.5em) }
      text(font: hei-fonts, weight: "bold", prefix + gap + body)
    } else {
      body
    }
    let page = text(font: latin-fonts, weight: "regular", it.page())
    let inner = left + h(0.35em) + box(width: 1fr, it.fill) + h(0.35em) + page
    block(
      width: 100%,
      above: 1.25em,
      below: 0.25em,
      link(it.element.location(), if it.level == 1 { inner } else { it.indented(prefix, inner) }),
    )
  }
  show heading.where(level: 1): it => {
    if it.numbering == none {
      pagebreak(to: "odd", weak: true)
    } else {
      numbered-chapter-pagebreak()
    }
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: table)).update(0)
    block(
      width: 100%,
      above: 30pt,
      below: 24pt,
      align(center, text(font: hei-fonts, size: sanhao, weight: "bold", fill: black, it)),
    )
  }
  show heading.where(level: 2): it => block(
    width: 100%,
    above: 30pt,
    below: 16pt,
    text(font: hei-fonts, size: sihao, weight: "bold", fill: black, it),
  )
  show heading.where(level: 3): it => block(
    width: 100%,
    above: 18pt,
    below: 14pt,
    text(font: hei-fonts, size: xiaosi, weight: "bold", fill: black, it),
  )
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.caption: set text(size: xiaosi, fill: black)
  show math.equation: set text(size: 12pt, fill: black)

  body
}

#let make-cover(info) = {
  set page(header: none, footer: none)
  set par(first-line-indent: 0pt)

  // v(18mm)
  align(center, image("../figs/FudanLOGO.pdf", width: 52%))
  v(12mm)
  align(center, text(font: hei-fonts, size: 44pt, weight: "bold")[本科毕业论文])
  // v(14mm)
  align(center, image("../figs/fudan.jpg", width: 38%))
  // v(28mm)

  align(center)[
    #grid(
      columns: (cover-label-width, 1fr, cover-label-width, 1fr),
      column-gutter: 0.7em,
      row-gutter: 1.0em,
      align: horizon,
      cover-label("论文题目", first-column: true),
      grid.cell(colspan: 3, cover-value(info.title)),
      text(font: song-fonts, cover-label("姓名", first-column: true)), cover-value(info.author),
      text(font: song-fonts, cover-label("学号")), cover-student-id-value(info.student-id),
      text(font: song-fonts, cover-label("院系", first-column: true)), cover-value(info.faculty), [], [],
      text(font: song-fonts, cover-label("专业", first-column: true)), cover-value(info.major), [], [],
      text(font: song-fonts, cover-label("指导教师", first-column: true)), cover-value(info.supervisor),
      text(font: song-fonts, cover-label("职称")), cover-value(info.supervisor-title),
      text(font: song-fonts, cover-label("单位", first-column: true)), 
      grid.cell(colspan: 3, cover-value(info.supervisor-faculty)),
      text(font: song-fonts, cover-label("完成日期", first-column: true)), cover-value(today-date()), [], [],
    )
  ]
  pagebreak(to: "odd")
}

#let preliminary(body) = {
  set page(header: none, footer: none)
  body
}

#let frontmatter(body) = {
  pagebreak(to: "odd", weak: true)
  counter(page).update(1)
  set page(numbering: "i", header: none, footer: centered-front-footer("i"))
  body
}

#let mainmatter(body, header-title: [复旦大学大数据学院]) = {
  pagebreak(to: "odd", weak: true)
  counter(page).update(1)
  set page(numbering: "1", header: thesis-header(header-title: header-title), footer: thesis-footer)
  body
}

#let backmatter(body, header-title: [复旦大学大数据学院]) = {
  pagebreak(to: "odd", weak: true)
  set page(numbering: "1", header: thesis-header(header-title: header-title), footer: thesis-footer)
  body
}

#let noheadfoot(body) = {
  pagebreak(to: "odd", weak: true)
  set page(header: none, footer: none)
  body
}

#let front-chapter(title, body) = {
  heading(level: 1, numbering: none, title)
  body
}

#let originality-statement() = [
  #heading(level: 1, numbering: none)[学位论文独创性声明]

  本人郑重声明：所呈交的学位论文，是本人在导师指导下，独立进行研究工作所取得的成果。
  除文中已经注明引用的内容外，本论文不包含任何其他个人或集体已经发表或撰写过的作品成果。
  对本文的研究做出重要贡献的个人和集体，均已在文中以明确方式标明。
  本人完全意识到本声明的法律结果由本人承担。

  #v(28mm)
  #align(right)[
    作者签名：#box(width: 8em, line(length: 8em)) \
    日期：#box(width: 8em, line(length: 8em))
  ]
]

#let authorization-statement() = [
  #heading(level: 1, numbering: none)[学位论文使用授权声明]

  本人完全了解学校有关保留、使用学位论文的规定，同意学校保留并向国家有关部门或机构送交论文的复印件和电子版，
  允许论文被查阅和借阅。本人授权学校可以将本学位论文的全部或部分内容编入有关数据库进行检索，
  可以采用影印、缩印或扫描等复制手段保存和汇编本学位论文。

  #v(28mm)
  #align(right)[
    作者签名：#box(width: 8em, line(length: 8em)) \
    导师签名：#box(width: 8em, line(length: 8em)) \
    日期：#box(width: 8em, line(length: 8em))
  ]
]

#let statement-section(title) = {
  v(0.8em)
  text(font: hei-fonts, weight: "bold", title)
}

#let statement-line(body) = block(width: 100%, above: 0.25em, below: 0pt)[
  #set par(first-line-indent: 0pt)
  #body
]

#let statement-form-line(body) = block(width: 100%, above: 1.05em, below: 0.05em)[
  #set par(first-line-indent: 0pt, leading: 0.75em)
  #body
]

#let checkbox = box(
  width: 1em,
  height: 0.85em,
  baseline: 0.12em,
  align(center + horizon
  , rect(width: 0.75em, height: 0.75em, stroke: 0.6pt)),
)
#let fill-line(width) = box(width: width, line(length: 100%))

#let ai-use-commitment-statement() = [
  #pagebreak(to: "odd", weak: true)
  #set page(
    margin: (top: 30mm, bottom: 25mm, left: 26mm, right: 26mm),
    header: none,
    footer: none,
  )
  #set text(size: sihao)
  #set par(justify: true, first-line-indent: (amount: 2em, all: true), leading: 0.75em)

  #v(25mm)
  #align(center, text(font: hei-fonts, size: sanhao, weight: "bold")[
    毕业论文（设计）撰写与人工智能使用承诺书
  ])

  // #v(8mm)
  本毕业论文是本人在导师指导下独立完成的，内容真实、可靠。本人在撰写毕业论文过程中不存在请人代写、抄袭或者剽窃他人作品、伪造或者篡改数据以及其他学位论文作假行为。

  本人就本次毕业论文（设计）中人工智能工具的使用情况，作如下声明：

  #statement-section[一、使用情况概述]

  本人在本次完成过程中 #checkbox 使用 / #checkbox 未使用人工智能工具。如选择“使用”，具体如下：

  #statement-form-line[（1）使用工具名称及版本：#fill-line(15em)]
  #statement-form-line[（2）使用平台：#fill-line(18em)]
  #statement-form-line[（3）使用环节（可多选）：]
  #statement-form-line[#h(2em)#checkbox 语法与语言表达润色 #h(3em)#checkbox 文本结构梳理与标题建议]
  #statement-form-line[#h(2em)#checkbox 图表或可视化初步生成 #h(2em)#checkbox 代码调试思路与错误分析]
  #statement-form-line[#h(2em)#checkbox 文献整理与检索建议 #h(3em)#checkbox 其他：#fill-line(10em)]

  #v(8mm)

  #statement-section[二、人工智能未参与环节]

  本人确认，下列核心创造性工作由本人独立完成，人工智能工具未参与：选题与研究问题界定；理论框架与研究设计；数据采集与实质性分析；关键论证、结论与政策建议撰写；其他由课程/导师明确要求独立完成的环节。

  #statement-section[三、辅助使用方式说明]

  本人已对人工智能工具输出内容进行必要核查与实质性修改，未将工具输出直接作为最终成果提交。主要核查与修改方式包括但不限于：对事实性内容与引用文献，与原文或权威资料逐一核对；对语言与结构性建议，结合课程要求和本人表达进行取舍与重写；对存在明显错误、偏见或不当内容的输出，予以删除或更正。

  #statement-section[四、学术诚信与责任承担]

  本人已认真阅读并理解学校关于学术规范和人工智能使用的相关规定，清楚知道学位论文作假行为将会导致行为人受到不授予或撤销学位、开除学籍等处理（处分）。本人郑重承诺：上述人工智能使用说明真实、完整，无隐瞒；本成果不存在抄袭、捏造数据、买卖论文、由他人或人工智能代写等学术不端行为；如经查实存在不当使用人工智能或其他学术不端情形，本人愿按学校有关规定承担相应责任。

  #v(2em)
  #statement-line[
    #grid(
      columns: (1fr, 0.9fr),
      column-gutter: 1em,
      [承诺人（签名）：#fill-line(8em)],
      [日期：#fill-line(2em) 年 #fill-line(2em) 月 #fill-line(2em) 日],
    )
  ]
]
