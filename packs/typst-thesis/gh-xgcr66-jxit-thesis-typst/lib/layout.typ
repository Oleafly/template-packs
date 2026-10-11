#let cfg = json("../layout.json")
#let body-top = calc.max(cfg.top_cm, cfg.header_cm + 0.7) * 1cm
#let body-bottom = calc.max(cfg.bottom_cm, cfg.footer_cm + 0.7) * 1cm
#let body-font = (cfg.latin_font, cfg.body_font)
#let head-font = (cfg.latin_font, cfg.heading_font)

#let page-title(title, size: 16pt, font: head-font, weight: "bold", align-to: center) = {
  block(width: 100%, above: 16pt, below: 16pt, sticky: true)[
    #align(align-to, text(size: size, font: font, weight: weight, title))
  ]
}
#let standard-page(body, numbered: true, reset: false) = {
  set page(paper: "a4", margin: (top: body-top, bottom: body-bottom, left: cfg.left_cm * 1cm, right: cfg.right_cm * 1cm),
    footer: if numbered { context align(center, text(font: cfg.body_font, size: 10.5pt, counter(page).display("1"))) } else { none },
    footer-descent: body-bottom - cfg.footer_cm * 1cm,
    background: {
      place(top + center, dy: cfg.header_cm * 1cm, text(font: cfg.body_font, size: 10.5pt, cfg.header_text))

    })
  if reset { counter(page).update(1) }
  body
}
#let prose(s) = { par(first-line-indent: (amount: 24pt, all: true), s) }
#let show-blocks(blocks, chapter-num) = {
  let section = 0
  let subsection = 0
  let figures = 0
  let tables = 0
  for b in blocks {
    if b.kind == "paragraph" { prose(b.text) }
    else if b.kind == "rich" {
      par(first-line-indent: (amount: 24pt, all: true), {
        for part in b.parts {
          if type(part) == str { part }
          else if part.kind == "citation" { super("[" + str(part.number) + "]") }
        }
      })
    } else if b.kind == "heading" {
      let num = ""
      if b.level == 2 { section += 1; subsection = 0; num = str(chapter-num) + "." + str(section) }
      else { subsection += 1; num = str(chapter-num) + "." + str(section) + "." + str(subsection) }
      heading(level: b.level, numbering: none, num + "　" + b.text)
    } else if b.kind == "figure" {
      figures += 1
      block(width: 100%, breakable: false, above: 12pt, below: 12pt)[
        #align(center, image("../" + b.path, width: calc.min(b.width, 15) * 1cm))
        #v(5pt)
        #align(center, text(size: 10.5pt, "图" + str(chapter-num) + "." + str(figures) + " " + b.caption))
      ]
    } else if b.kind == "table" {
      tables += 1
      block(width: 100%, above: 12pt, below: 5pt, sticky: true)[
        #align(center, text(size: 10.5pt, "表" + str(chapter-num) + "." + str(tables) + " " + b.caption))
      ]
      {
        set text(size: 10.5pt)
        set par(first-line-indent: 0pt, leading: 5pt)
        table(columns: b.header.map(_ => 1fr), inset: (x: 5pt, y: 6pt), stroke: none,
          table.hline(stroke: 0.8pt),
          table.header(..b.header.map(c => align(center, strong(c)))),
          table.hline(stroke: 0.5pt),
          ..b.rows.flatten().map(c => [#c]),
          table.hline(stroke: 0.8pt),
        )
      }
      v(8pt)
    } else if b.kind == "code" {
      block(width: 100%, above: 6pt, below: 6pt, breakable: true)[#text(size: 9pt, raw(b.text, block: true))]
    } else if b.kind == "pagebreak" { pagebreak() }
    else { panic("不支持的内容块：" + b.kind) }
  }
}

#let render-thesis(t) = {
  set document(title: t.meta.title, author: t.meta.author, description: "江西科技学院本科毕业论文模板")
  set text(font: body-font, size: 12pt, lang: "zh", top-edge: 0.8em, bottom-edge: 0.2em)
  set par(justify: true, leading: 8pt, spacing: 8pt, first-line-indent: (amount: 24pt, all: true))
  show heading.where(level: 1): it => {
    let refs = it.body == [参考文献]
    block(width: 100%, above: 16pt, below: 16pt, sticky: true)[#align(if refs {left} else {center}, text(font: head-font, size: if refs {14pt} else {16pt}, weight: "bold", it.body))]
  }
  show heading.where(level: 2): it => {
    block(width: 100%, above: 12pt, below: 6pt, sticky: true)[#pad(left: 24pt, text(font: head-font, size: 12pt, weight: "bold", it.body))]
  }
  show heading.where(level: 3): it => {
    block(width: 100%, above: 12pt, below: 6pt, sticky: true)[#pad(left: 24pt, text(font: body-font, size: 12pt, weight: "regular", it.body))]
  }
  // 封面不显示页眉页码。各字段仅为填写位，不预置个人资料。
  page(paper: "a4", margin: (x: 3cm, y: 2.54cm))[
    #set par(first-line-indent: 0pt, justify: false)
    #align(right)[密级：#t.meta.confidential　　学号：#t.meta.student-id]
    #v(14mm)
    #if t.meta.at("school-wordmark", default: none) != none {
      // 使用规范第七页内嵌原图，保持校徽与书法校名横排比例。
      align(center, grid(columns: (31mm, 116mm), column-gutter: 2mm, align: horizon, image("../" + t.meta.logo, width: 31mm), image("../" + t.meta.school-wordmark, width: 116mm)))
    } else {
      align(center, image("../" + t.meta.logo, width: 30mm))
      v(5mm)
      align(center, text(font: cfg.heading_font, size: 28pt, t.meta.school))
    }
    #v(17mm)
    #align(center, text(font: cfg.heading_font, size: 22pt, weight: "bold", "本科生毕业论文（设计）"))
    #v(16mm)
    #align(center, text(font: cfg.heading_font, size: 18pt, weight: "bold", t.meta.title))
    #v(20mm)
    #align(center, grid(columns: (30mm, 85mm), row-gutter: 10pt,
      [学　　院：], [#t.meta.college],
      [专　　业：], [#t.meta.major],
      [班　　级：], [#t.meta.class],
      [学　　号：], [#t.meta.student-id],
      [姓　　名：], [#t.meta.author],
      [指导教师1：], [#t.meta.supervisor],
      [指导教师2：], [#t.meta.second-supervisor],
    ))
    #v(14mm)
    #align(center, t.meta.date)
  ]
  standard-page(numbered: false)[
    #page-title("学士学位论文原创性声明")
    #prose("本人郑重申明：所呈交的论文（设计）是本人在指导老师的指导下独立进行研究，所取得的研究成果。除了文中特别加以标注引用的内容外，本论文（设计）不包含任何其他个人或集体已经发表或撰写的成果作品。对本文的研究做出重要贡献的个人和集体，均已在文中以明确方式表明。本人完全意识到本申明的法律后果由本人承担。")
    #v(12pt)
    #align(right)[学位论文作者签名（手写）：#underline[　　　　　　]\ 签字日期：　　年　　月　　日]
    #v(16pt)
    #page-title("学位论文版权使用授权书")
    #prose("本学位论文作者完全了解学校有关保留、使用学位论文的规定，同意学校保留并向国家有关部门或机构送交论文的复印件和电子版，允许论文被查阅和借阅。本人授权江西科技学院可以将本论文的全部或部分内容编入有关数据库进行检索，可以采用影印、缩印或扫描等复制手段保存和汇编本学位论文。")
    #v(10pt)
    #prose("本学位论文属于：")
    #prose("保密□，在　　　年解密后适用本授权书。")
    #prose("不保密□。")
    #prose("（请在以上相应方框内打“√”）")
    #v(14pt)
    #text(size: 10.5pt)[作者签名（手写）：#underline[　　　　]　指导教师签名（手写）：#underline[　　　　]\ 签字日期：　　年　月　日　　签字日期：　　年　月　日]
  ]
  pagebreak()
  standard-page(reset: true)[
    #page-title("摘　要")
    #for s in t.abstract-cn { prose(s) }
    #v(20pt)
    #par(first-line-indent: 0pt)[*关键词：*#t.keywords-cn.join("；")]
    #pagebreak()
    #page-title("Abstract", font: cfg.latin_font)
    #for s in t.abstract-en { prose(s) }
    #v(20pt)
    #par(first-line-indent: 0pt)[*Key words: *#t.keywords-en.join("; ")]
  ]
  pagebreak()
  standard-page(reset: true)[
    #page-title("目　录")
    #set par(first-line-indent: 0pt, leading: 5pt)
    #show outline.entry: it => {
      set text(size: if it.level == 1 {14pt} else {12pt}, weight: if it.level == 1 {"bold"} else {"regular"})
      block(width: 100%, above: if it.level == 1 {0pt} else {3.6pt}, below: if it.level == 1 {0pt} else {3.6pt}, it)
    }
    #outline(title: none, depth: 3, indent: 24pt)
  ]
  pagebreak()
  standard-page(reset: true)[
    #for (i, ch) in t.chapters.enumerate() {
      if i > 0 { pagebreak() }
      heading(level: 1, numbering: none, "第" + str(i+1) + "章　" + ch.title)
      show-blocks(ch.blocks, i+1)
    }
    #pagebreak()
    #heading(level: 1, numbering: none)[参考文献]
    #for (i, r) in t.references.enumerate() {
      par(first-line-indent: 0pt, leading: 4pt, spacing: 4pt)[[#(i+1)] #r]
    }
    #if t.appendix.len() > 0 {
      pagebreak()
      heading(level: 1, numbering: none)[附　录]
      show-blocks(t.appendix, "A")
    }
    #if t.acknowledgements.len() > 0 {
      pagebreak()
      heading(level: 1, numbering: none)[致　谢]
      set text(font: (cfg.latin_font, cfg.ack_font))
      for s in t.acknowledgements { prose(s) }
    }
  ]
}
